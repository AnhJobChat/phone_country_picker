import 'package:phone_country_picker/country_code_picker.dart';
import 'package:phone_country_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('CountryPicker Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PhoneCountryPicker(
                onChanged: print,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'IT',
                favorite: ['+39', 'FR'],
                countryFilter: ['IT', 'FR'],
                showFlagDialog: false,
                comparator: (a, b) => b.name.compareTo(a.name),
                //Get the country information relevant to the initial selection
                onInit: (code) => print("on init ${code.name} ${code.dialCode} ${code.name}"),
              ),
              SizedBox(
                width: 400,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhoneCountryPicker(
                    onChanged: print,
                    hideMainText: true,
                    showFlagMain: true,
                    showFlag: false,
                    initialSelection: 'TF',
                    hideSearch: true,
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: true,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhoneCountryPicker(
                    onChanged: (e) => print(e.toLongString()),
                    initialSelection: 'TF',
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    favorite: ['+39', 'FR'],
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhoneCountryPicker(
                    enabled: false,
                    onChanged: (c) => c.name,
                    initialSelection: 'TF',
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    favorite: ['+39', 'FR'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
