import 'package:shared_preferences/shared_preferences.dart';

class TimeChangeHandler {
  Future<void> onStartTimeChanged(int selectedHours, int selectedMinutes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startHour', selectedHours);
    await prefs.setInt('startMinute', selectedMinutes);
  }

  Future<void> onEndTimeChanged(int selectedHours, int selectedMinutes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('endHour', selectedHours);
    await prefs.setInt('endMinute', selectedMinutes);
  }
}