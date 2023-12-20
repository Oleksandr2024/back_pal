//UserPreferencesManager deals specifically with user preferences related to notifications, such as start time, end time, intervals, and weekend inclusion.
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesManager {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Start Time
  static Future<void> saveStartTime(int hour, int minute) async {
    await _prefs?.setInt('startHour', hour);
    await _prefs?.setInt('startMinute', minute);
  }

  static int getStartHour() => _prefs?.getInt('startHour') ?? 9; // Default start hour
  static int getStartMinute() => _prefs?.getInt('startMinute') ?? 0; // Default start minute

  // End Time
  static Future<void> saveEndTime(int hour, int minute) async {
    await _prefs?.setInt('endHour', hour);
    await _prefs?.setInt('endMinute', minute);
  }

  static int getEndHour() => _prefs?.getInt('endHour') ?? 18; // Default end hour
  static int getEndMinute() => _prefs?.getInt('endMinute') ?? 0; // Default end minute

  // Interval
  static Future<void> saveInterval(int minutes) async {
    await _prefs?.setInt('intervalMinutes', minutes);
  }

  static int getInterval() => _prefs?.getInt('intervalMinutes') ?? 30; // Default interval in minutes

  // Include Weekends
  static Future<void> saveIncludeWeekends(bool include) async {
    await _prefs?.setBool('includeWeekends', include);
  }

  static bool getIncludeWeekends() => _prefs?.getBool('includeWeekends') ?? false; // Default to not include weekends
}