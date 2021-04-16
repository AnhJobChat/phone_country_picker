import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'phone_country.dart';

class PhoneCountryModel extends PhoneCountry {
  static const String countryCodePath = 'assets/phone_country/data/country_codes.json';

  PhoneCountryModel({
    @required String name,
    @required String dialCode,
    @required String code,
  }) : super(name: name, dialCode: dialCode, code: code);

  static Future<List<PhoneCountry>> get values async {
    final String jsonString = await rootBundle.loadString(countryCodePath);
    List<dynamic> jsonObjects = json.decode(jsonString);
    final phoneCountries = jsonObjects
        .map((json) => json as Map<String, dynamic>)
        .map((json) => PhoneCountryModel.fromJson(json))
        .toList();
    return phoneCountries;
  }

  static PhoneCountry get defaultPhoneCountry {
    return PhoneCountry(name: "Vietnam", dialCode: "+84", code: "VN");
  }

  factory PhoneCountryModel.fromJson(Map<String, dynamic> json) {
    return PhoneCountryModel(
      name: json['name'],
      dialCode: json['dial_code'],
      code: json['code'],
    );
  }
}
