<h1 align="center">Phone Country Picker</h1>
<h2 align="center">https://pub.dev/packages/phone_country_picker</h2>

<p align="center">A flutter package for showing a phone country selector. In addition it gives the possibility to select a list of favorites countries, as well as to search using a simple searchbox and it's supports i18n for 2 languages are english and vietnamese.
</p><br>

<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
      alt="Platform" />
  </a>
  <a href="https://pub.dartlang.org/packages/animated_text_kit">
    <img src="https://img.shields.io/pub/v/animated_text_kit.svg"
      alt="Pub Package" />
  </a>
  <a href="https://github.com/aagarwal1012/Animated-Text-Kit/actions?query=workflow%3ACI">
    <img src="https://img.shields.io/github/workflow/status/aagarwal1012/Animated-Text-Kit/CI?logo=github"
      alt="Build Status" />
  </a>
  </br>
  <a href="https://pub.green/packages/animated_text_kit#channel-stable">
    <img src="https://img.shields.io/endpoint?url=https://pub.green/packages/animated_text_kit/badge?channel=stable&style=flat"
      alt="Latest compatibility result for Stable channel" />
  </a>
  <a href="https://pub.green/packages/animated_text_kit#channel-beta">
    <img src="https://img.shields.io/endpoint?url=https://pub.green/packages/animated_text_kit/badge?channel=beta&style=flat"
      alt="Latest compatibility result for Beta channel" />
  </a>
  <a href="https://pub.green/packages/animated_text_kit#channel-dev">
    <img src="https://img.shields.io/endpoint?url=https://pub.green/packages/animated_text_kit/badge?channel=dev&style=flat"
      alt="Latest compatibility result for Dev channel" />
  </a>
</p><br>

<a href="https://flutter.dev/docs/development/packages-and-plugins/favorites">
  <img height="150" align="right" src="https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/display/flutter-favorite-badge.png?raw=true">
</a>

# Table of contents

- [Installing](#installing)
- [Usage](#usage)
  - [New with Version 1.0.3](#new-with-version-1.0.3)
- [Function](#function)
  - [onChanged](#onChanged)
  - [onInit](#onInit)
  - [initialSelection](#initialSelection)
  - [favorite](#favorite)
  - [textStyle](#textStyle)
  - [padding](#padding)
  - [showCountryOnly](#showCountryOnly)
  - [searchDecoration](#searchDecoration)
  - [searchStyle](#searchStyle)
  - [emptySearchBuilder](#emptySearchBuilder)
  - [builder](#builder)
- [Bugs or Requests](#bugs-or-requests)
- [Donate](#donate)
- [Contributors](#contributors)

# Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
    phone_country_picker: ^1.0.2
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```
$ pub get
```

with `Flutter`:

```
$ flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:phone_country_picker/country_code_picker.dart';
```

# Usage

```dart

@override
 Widget build(BuildContext context) => new Scaffold(
     body: Center(
       child: CountryCodePicker(
         onChanged: print,
         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
         initialSelection: 'IT',
         favorite: ['+39','FR'],
         // optional. Shows only country name and flag
         showCountryOnly: false,
         // optional. Shows only country name and flag when popup is closed.
         showOnlyCountryWhenClosed: false,
         // optional. aligns the flag and the Text left
         alignLeft: false,
       ),
     ),
 );

```

Example:

```dart

void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected phone country here
    print("New Country selected: " + countryCode.toString());
  }

```

### i18n

Just add the `CountryLocalizations.delegate` in the list of your app delegates

```dart
 return new MaterialApp(
      supportedLocales: [
        Locale("en"),
        Locale("vi"),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
```

## Customization

Here is a list of properties available to customize your widget:

| Name | Type | Description |
|-----|-----|------|
|onChanged| ValueChanged<CountryCode> | callback invoked when the selection changes |
|onInit| ValueChanged<CountryCode> | callback invoked during initialization of the widget |
|initialSelection| String | used to set the initial selected value |
|favorite| List<String> | used to populate the favorite country list |
|textStyle| TextStyle | TextStyle applied to the widget button |
|padding| EdgeInsetsGeometry | the padding applied to the button |
|showCountryOnly| bool | true if you want to see only the countries in the selection dialog |
|searchDecoration| InputDecoration | decoration applied to the TextField search widget |
|searchStyle| TextStyle | style applied to the TextField search widget text |
|emptySearchBuilder| WidgetBuilder | use this to customize the widget used when the search returns 0 elements |
|builder| Function(CountryCode) | use this to build a custom widget instead of the default FlatButton |
|enabled| bool | set to false to disable the widget |
|textOverflow| TextOverflow | the button text overflow behaviour |
|dialogSize| Size | the size of the selection dialog |
|countryFilter| List<String> | uses a list of strings to filter a sublist of countries |
|showOnlyCountryWhenClosed| bool | if true it'll show only the country |
|alignLeft| bool | aligns the flag and the Text to the left |
|showFlag| bool | shows the flag everywhere |
|showFlagMain| bool | shows the flag only when closed |
|showFlagDialog| bool | shows the flag only in dialog |
|flagWidth| double | the width of the flags |
|flagDecoration| Decoration | used for styling the flags |
|comparator| Comparator<CountryCode> | use this to sort the countries in the selection dialog |
|hideSearch| bool | if true the search feature will be disabled |

## Contributions

Contributions of any kind are more than welcome! Feel free to fork and improve phone_country_picker in any way you want, make a pull request, or open an issue.
