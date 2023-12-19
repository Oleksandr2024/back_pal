import 'package:back_pal/services/preferences_manager.dart';

class LanguageManager {
  static final LanguageManager _instance = LanguageManager._internal();
  String _selectedLanguage = 'English'; // private field

  factory LanguageManager() {
    return _instance;
  }

  LanguageManager._internal();

  late PreferencesManager _preferencesManager;

  String get selectedLanguage => _selectedLanguage;

  Future<void> init(PreferencesManager preferencesManager) async {
    _preferencesManager = preferencesManager;
    _selectedLanguage = await _preferencesManager.loadSelectedLanguage(); //Uses 'await' on an instance of 'String', which is not a subtype of 'Future'.
    //print(_selectedLanguage); //works properly
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    //print(_selectedLanguage); // works properly "uk" after reload if I changed to that
    _preferencesManager.saveSelectedLanguage(language);
  }

  Map<String, String> get languageCodeMapping => {
    'English': 'en',
    'Українська': 'uk',
    'Deutsch': 'de',
    'Español': 'es',
    'Français': 'fr',
    'Nederlands': 'nl',
    'Italiano': 'it',
    'العربية': 'ar',
    '中文': 'zh',  // Chinese
    '日本語': 'ja', // Japanese
    '한국어': 'ko', // Korean
    // Add mappings for other languages
  };
}




















// class LanguageManager {
//   static final LanguageManager _instance = LanguageManager._internal();
//   String _selectedLanguage = 'English'; // private field
//
//   factory LanguageManager() {
//     return _instance;
//   }
//
//   LanguageManager._internal();
//
//   late PreferencesManager _preferencesManager;
//
//   String get selectedLanguage => _selectedLanguage;
//
//   Future<void> init(PreferencesManager preferencesManager) async {
//     _preferencesManager = preferencesManager;
//     selectedLanguage = _preferencesManager.getSelectedLanguageCode(); //The method 'getSelectedLanguageCode' isn't defined for the type 'PreferencesManager'.
//   }
//
//
//   // void init(PreferencesManager preferencesManager) {
//   //   _preferencesManager = preferencesManager;
//   // }
//   void set selectedLanguage(String language) {
//     _selectedLanguage = language;
//   }
//
//   String get selectedLanguage { //The name 'selectedLanguage' is already defined. (Documentation) The first definition of this name (language_manager.dart:16).
//     return _preferencesManager.loadSelectedLanguage();
//   }
//
//   void setLanguage(String language) {
//     _preferencesManager.saveSelectedLanguage(language);
//   }
//
//   Map<String, String> get languageCodeMapping => {
//     'English': 'en',
//     'Українська': 'uk',
//     'Deutsch': 'de',
//     // Add mappings for other languages
//   };
// }