library phone_country_picker;

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phone_country_picker/country_code.dart';
import 'package:phone_country_picker/country_codes.dart';
import 'package:phone_country_picker/selection_dialog.dart';

export 'country_code.dart';

class PhoneCountryPicker extends StatefulWidget {
  final ValueChanged<CountryCode> onChanged;
  final ValueChanged<CountryCode> onInit;
  final String initialSelection;
  final List<String> favorite;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final TextStyle dialogTextStyle;
  final WidgetBuilder emptySearchBuilder;
  final Function(CountryCode) builder;
  final bool enabled;
  final TextOverflow textOverflow;
  final Icon closeIcon;

  /// Barrier color of ModalBottomSheet
  final Color barrierColor;

  /// Background color of ModalBottomSheet
  final Color backgroundColor;

  /// BoxDecoration for dialog
  final BoxDecoration boxDecoration;

  /// the size of the selection dialog
  final Size dialogSize;

  /// Background color of selection dialog
  final Color dialogBackgroundColor;

  /// used to customize the country list
  final List<String> countryFilter;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyCountryWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially useful in combination with [showOnlyCountryWhenClosed],
  /// because longer country names are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showFlag;

  final bool hideMainText;

  final bool showFlagMain;

  final bool showFlagDialog;

  /// Width of the flag images
  final double flagWidth;

  /// Use this property to change the order of the options
  final Comparator<CountryCode> comparator;

  /// Set to true if you want to hide the search part
  final bool hideSearch;

  /// Set to true if you want to show drop down button
  final bool showDropDownButton;

  /// scroll bar thickness
  final double thickness;

  /// scroll bar radius
  final Radius radius;

  PhoneCountryPicker({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showCountryOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.showFlag = true,
    this.showFlagDialog,
    this.hideMainText = false,
    this.showFlagMain,
    this.builder,
    this.flagWidth = 32.0,
    this.enabled = true,
    this.textOverflow = TextOverflow.ellipsis,
    this.barrierColor,
    this.backgroundColor,
    this.boxDecoration,
    this.comparator,
    this.countryFilter,
    this.hideSearch = false,
    this.showDropDownButton = false,
    this.dialogSize,
    this.dialogBackgroundColor,
    this.closeIcon = const Icon(Icons.close),
    this.thickness = 5,
    this.radius = const Radius.circular(20),
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CountryCode> elements = jsonList.map((json) => CountryCode.fromJson(json)).toList();

    if (comparator != null) {
      elements.sort(comparator);
    }

    if (countryFilter != null && countryFilter.isNotEmpty) {
      final uppercaseCustomList = countryFilter.map((c) => c.toUpperCase()).toList();
      elements = elements
          .where((c) =>
              uppercaseCustomList.contains(c.code) ||
              uppercaseCustomList.contains(c.name) ||
              uppercaseCustomList.contains(c.dialCode))
          .toList();
    }

    return PhoneCountryPickerState(elements);
  }
}

class PhoneCountryPickerState extends State<PhoneCountryPicker> {
  CountryCode selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];

  PhoneCountryPickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (widget.builder != null)
      _widget = InkWell(
        radius: 5.0,
        onTap: showCountryCodePickerDialog,
        child: widget.builder(selectedItem),
      );
    else {
      _widget = FlatButton(
        padding: widget.padding,
        onPressed: widget.enabled ? showCountryCodePickerDialog : null,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.showFlagMain != null ? widget.showFlagMain : widget.showFlag)
              Flexible(
                flex: widget.alignLeft ? 0 : 1,
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Padding(
                  padding: widget.alignLeft
                      ? const EdgeInsets.only(right: 16.0, left: 8.0)
                      : const EdgeInsets.only(right: 2.0),
                  child: Image.asset(
                    selectedItem.flagUri,
                    package: 'phone_country_picker',
                    width: widget.flagWidth,
                  ),
                ),
              ),
            if (!widget.hideMainText)
              Flexible(
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Text(
                  widget.showOnlyCountryWhenClosed ? selectedItem.toCountryStringOnly() : selectedItem.toString(),
                  style: widget.textStyle ?? Theme.of(context).textTheme.button,
                  overflow: widget.textOverflow,
                ),
              ),
            if (widget.showDropDownButton)
              Flexible(
                flex: widget.alignLeft ? 0 : 1,
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: widget.flagWidth,
                ),
              ),
          ],
        ),
      );
    }
    return _widget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.elements = elements.map((e) => e.localize(context)).toList();
    _onInit(selectedItem);
  }

  @override
  void didUpdateWidget(PhoneCountryPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements.firstWhere(
            (e) =>
                (e.code.toUpperCase() == widget.initialSelection.toUpperCase()) ||
                (e.dialCode == widget.initialSelection) ||
                (e.name.toUpperCase() == widget.initialSelection.toUpperCase()),
            orElse: () => elements[0]);
      } else {
        selectedItem = elements[0];
      }
      _onInit(selectedItem);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code.toUpperCase() == widget.initialSelection.toUpperCase()) ||
              (e.dialCode == widget.initialSelection) ||
              (e.name.toUpperCase() == widget.initialSelection.toUpperCase()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    favoriteElements = elements
        .where((e) =>
            widget.favorite.firstWhere(
                (f) =>
                    e.code.toUpperCase() == f.toUpperCase() ||
                    e.dialCode == f ||
                    e.name.toUpperCase() == f.toUpperCase(),
                orElse: () => null) !=
            null)
        .toList();
  }

  void showCountryCodePickerDialog() {
    showMaterialModalBottomSheet(
      barrierColor: widget.barrierColor ?? Colors.grey.withOpacity(0.5),
      backgroundColor: widget.backgroundColor ?? Colors.transparent,
      context: context,
      builder: (context) => Center(
        child: SelectionDialog(
          elements,
          favoriteElements,
          showCountryOnly: widget.showCountryOnly,
          emptySearchBuilder: widget.emptySearchBuilder,
          searchDecoration: widget.searchDecoration,
          searchStyle: widget.searchStyle,
          textStyle: widget.dialogTextStyle,
          boxDecoration: widget.boxDecoration,
          showFlag: widget.showFlagDialog != null ? widget.showFlagDialog : widget.showFlag,
          flagWidth: widget.flagWidth,
          size: widget.dialogSize,
          backgroundColor: widget.dialogBackgroundColor,
          barrierColor: widget.barrierColor,
          hideSearch: widget.hideSearch,
          closeIcon: widget.closeIcon,
          thickness: widget.thickness,
          radius: widget.radius,
        ),
      ),
    ).then((countrySelected) {
      if (countrySelected != null) {
        setState(() {
          selectedItem = countrySelected;
        });

        _publishSelection(countrySelected);
      }
    });
  }

  void _publishSelection(CountryCode countryCode) {
    if (widget.onChanged != null) {
      widget.onChanged(countryCode);
    }
  }

  void _onInit(CountryCode countryCode) {
    if (widget.onInit != null) {
      widget.onInit(countryCode);
    }
  }
}
