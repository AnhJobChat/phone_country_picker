import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constant/app_colors.dart';
import 'image_description_item.dart';
import 'model/phone_country.dart';
import 'model/phone_country_model.dart';
import 'resource/app_localizations.dart';
import 'utils/screen_utils.dart';

class TextFieldWithPhoneCountry extends StatefulWidget {
  final String phoneNumber;
  final Function(String phoneNumber) onChangePhoneNumber;
  final Function(PhoneCountry phoneCountry) onSelectedPhoneCountry;

  TextFieldWithPhoneCountry({
    Key key,
    this.phoneNumber,
    this.onChangePhoneNumber,
    this.onSelectedPhoneCountry,
  }) : super(key: key);

  @override
  _TextFieldWithPhoneCountryState createState() => _TextFieldWithPhoneCountryState();
}

class _TextFieldWithPhoneCountryState extends State<TextFieldWithPhoneCountry> {
  List<PhoneCountry> _phoneCountries;
  PhoneCountry _selectedPhoneCountry;
  TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _phoneNumberController.addListener(() {
      widget.onChangePhoneNumber(_phoneNumberController.text);
    });
    _selectedPhoneCountry = PhoneCountryModel.defaultPhoneCountry;
    loadPhoneCountries();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void loadPhoneCountries() async {
    _phoneCountries = await PhoneCountryModel.values;
  }

  @override
  Widget build(BuildContext context) {
    widget.onSelectedPhoneCountry(_selectedPhoneCountry);
    return _inputPhoneCountry(context);
  }

  Widget _inputPhoneCountry(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                _selectedPhoneCountry.dialCode,
                style: TextStyle(fontSize: 14),
              ),
              Container(
                width: 1,
                margin: EdgeInsets.all(10),
                color: AppColors.background,
              ),
              Flexible(
                child: TextField(
                  controller: _phoneNumberController,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.shared.yourPhoneNumber,
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(_selectedPhoneCountry.imageUrl),
                onPressed: () {
                  _onTapPhoneCountry();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onTapPhoneCountry() {
    _showPickerPhoneCountryDialog(
      context: context,
      selectedPhoneCountry: _selectedPhoneCountry,
      phoneCountries: _phoneCountries,
      onTap: (phoneCountry) {
        Navigator.of(context).pop();
        if (_selectedPhoneCountry.code != phoneCountry.code) {
          setState(() {
            _selectedPhoneCountry = phoneCountry;
            widget.onSelectedPhoneCountry(_selectedPhoneCountry);
          });
        }
      },
    );
  }

  void _showPickerPhoneCountryDialog({
    @required BuildContext context,
    @required PhoneCountry selectedPhoneCountry,
    @required List<PhoneCountry> phoneCountries,
    @required Function(PhoneCountry phoneCountry) onTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          title: Column(
            children: <Widget>[
              _phoneCountryItem(selectedPhoneCountry ?? phoneCountries.first),
              Container(
                height: 1,
                color: AppColors.background,
              )
            ],
          ),
          titlePadding: EdgeInsets.all(0),
          content: Container(
            height: ScreenUtils.screenHeight(context, percent: 40),
            width: double.minPositive,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: phoneCountries.length,
                itemBuilder: (context, index) {
                  return _phoneCountryItem(
                    phoneCountries[index],
                    onTap: onTap,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _phoneCountryItem(PhoneCountry phoneCountry, {Function(PhoneCountry phoneCountry) onTap}) {
    return ImageDescriptionItem(
      imageUrl: phoneCountry.imageUrl,
      imageWidth: 24,
      description: phoneCountry.name,
      trailingDescription: phoneCountry.dialCode,
      onTap: () {
        onTap(phoneCountry);
      },
    );
  }
}
