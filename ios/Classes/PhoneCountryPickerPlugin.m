#import "PhoneCountryPickerPlugin.h"
#if __has_include(<phone_country_picker/phone_country_picker-Swift.h>)
#import <phone_country_picker/phone_country_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "phone_country_picker-Swift.h"
#endif

@implementation PhoneCountryPickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPhoneCountryPickerPlugin registerWithRegistrar:registrar];
}
@end
