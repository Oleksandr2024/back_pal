import 'package:flutter/material.dart';
import 'package:back_pal/pages/loading_page.dart';
import 'package:back_pal/pages/home_page.dart';
import 'package:back_pal/pages/about_page.dart';
import 'package:back_pal/pages/proFeatures_page.dart';
import 'package:back_pal/services/language_manager.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:back_pal/services/preferences_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  await LanguageManager().init(PreferencesManager());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) {
      state.setLocale(newLocale);
    }
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _appLocale = Locale('en', 'US');
  final LanguageManager _languageManager = LanguageManager();

  // Add this line to initialize PreferencesManager
  final PreferencesManager _preferencesManager = PreferencesManager();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    await _preferencesManager.loadPreferences();
    String selectedLanguage = _preferencesManager.loadSelectedLanguage();
    _languageManager.setLanguage(selectedLanguage);
    // Set the initial locale based on saved preferences
    setState(() {
      _appLocale = Locale(selectedLanguage);
    });

    // Load translations for the initial locale
    await LanguageService.loadTranslations(_appLocale);
  }

  void setLocale(Locale newLocale) async {
    setState(() {
      _appLocale = newLocale;
      _languageManager.setLanguage(newLocale.languageCode);
    });

    await LanguageService.loadTranslations(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    LanguageService.loadTranslations(_appLocale);

    return MaterialApp(
      title: 'Posture Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        //'/settings': (context) => SettingsPage(),
        '/pro': (context) => ProFeaturesPage(),
      },
      locale: _appLocale,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('uk', 'UA'),
        Locale('de', 'DE'),
        Locale('fr', 'FR'),
        Locale('nl', 'NL'),
        Locale('es', 'ES'),
        Locale('it', 'IT'),
        Locale('ar', 'AR'),
        Locale('zh', 'CN'),
        Locale('ja', 'JP'),
        Locale('ko', 'KR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}