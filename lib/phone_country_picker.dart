import 'dart:async';
import 'package:flutter/services.dart';

class PhoneCountryPicker {
  static const MethodChannel _channel =
      const MethodChannel('phone_country_picker');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
