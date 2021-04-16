import 'package:flutter/foundation.dart';
import 'package:phone_country_picker/constant/assets_images.dart';

class PhoneCountry {
  /// the name of the country
  final String name;

  /// the country code (VN, US..)
  final String dialCode;

  /// the dial code (+39,+93..)
  final String code;

  get imageUrl => AssetsImage.countryFlag(countryCode: code);

  PhoneCountry({
    @required this.name,
    @required this.dialCode,
    @required this.code,
  });
}
