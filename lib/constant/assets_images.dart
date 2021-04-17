import 'package:flutter/foundation.dart';

class AssetsImage {
  //Mapping country code (VN, US..) with svg
  static String countryFlag({@required String countryCode}) {
    return 'assets/phone_country/images/' + countryCode + '.svg';
  }
}
