//PreferencesManager handles general app settings like selected language and other app-wide preferences.
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal(); //It's a common pattern for creating a singleton class, ensuring that there's only one instance of the class throughout the app

  factory PreferencesManager() {
    return _instance;
  }

  PreferencesManager._internal(); //This is a private constructor. It's called by _instance to create the initial instance of PreferencesManager. This ensures that the class can only be instantiated from within itself, controlling how instances are created.

  static const String _selectedLanguageKey = 'selectedLanguage'; //This is a key that will be used to store and retrieve a specific piece of data in shared preferences.
  static const String _intervalKey = 'interval';
  // Add more keys for other preferences

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> loadPreferences() async {
    await loadSelectedLanguage();
    await loadInterval();
    // Load other preferences as needed
  }

  String loadSelectedLanguage() {
    // print(_prefs.getString(_selectedLanguageKey)); //shows "uk" if I set it and reload
    return _prefs.getString(_selectedLanguageKey) ?? 'en'; //not issue
  }

  Future<void> loadInterval() async {
    int? interval = _prefs.getInt(_intervalKey);
    // Do something with the loaded interval value
  }

  Future<void> saveSelectedLanguage(String language) async {
    //print('here saveSelectedLanguage to: ');
    //print(language); //works properly
    await _prefs.setString(_selectedLanguageKey, language);
  }

  Future<void> saveInterval(int interval) async {
    await _prefs.setInt(_intervalKey, interval);
  }

  // Future<void> saveStartTime(int hour, int minute) async {
  //   await _prefs.setInt('startHour', hour);
  //   await _prefs.setInt('startMinute', minute);
  // }

  int getStartHour() {
    return _prefs.getInt('startHour') ?? 9; // Default start hour
  }

  int getStartMinute() {
    return _prefs.getInt('startMinute') ?? 0; // Default start minute
  }
// Add more methods for other preferences
}

