import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization_intl/locale/app_localization.dart';
import 'package:localization_intl/screens/home_screen.dart';
// import 'package:localization/localization.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'AR'),
      ],
      //The delegates collectively define all of the localized resources for this application's [Localizations] widget.
      // make sure that the localization data for the proper language is loaded.
      localizationsDelegates: [
        // automatically translate basic texts to  many different languages.
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //Return a local which which will be used by the app.
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.languageCode) {
            return supportedLocale;
          }
          //if the  locale in the device is not supported , use the first one from the list (English: in our case).
          return supportedLocales.first;
        }
      },
    );
  }
}
