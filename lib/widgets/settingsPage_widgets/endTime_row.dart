import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_pal/services/user_preferences_manager.dart';
import 'package:back_pal/services/notification_service.dart';

class DailyEndTimeRow extends StatefulWidget {
     final NotificationService notificationService;
     final bool isRunning;

  const DailyEndTimeRow({
    required this.notificationService,
    required this.isRunning
  });

  @override
  _DailyEndTimeRowState createState() => _DailyEndTimeRowState();
}

class _DailyEndTimeRowState extends State<DailyEndTimeRow> {
  int _selectedHours = 18;
  int _selectedMinutes = 0;
  int startHour = 0; // Declare startHour here
  int startMinute = 0; // Declare startMinute here

  @override
  void initState() {
    super.initState();
    _selectedHours = UserPreferencesManager.getEndHour();
    _selectedMinutes = UserPreferencesManager.getEndMinute();
    _retrieveStartTime();
  }

  // void _onEndTimeChanged() async {
  //   print('end time changed: $_selectedHours $_selectedMinutes');
  //   await _retrieveStartTime(); // Ensure this is called and completed before comparison
  //
  //   if (_selectedHours < startHour || (_selectedHours == startHour && _selectedMinutes < startMinute)) {
  //     _showErrorMessage();
  //   } else {
  //     await UserPreferencesManager.saveEndTime(_selectedHours, _selectedMinutes); // Save new end time
  //
  //     if (widget.isRunning) {
  //       print('endTime changed, case is running:');
  //       widget.notificationService.cancelAllNotifications();
  //       widget.notificationService.startScheduledNotifications();
  //     }
  //   }
  // }

  void _onEndTimeChanged() async {
    await _retrieveStartTime(); // Ensure start time is retrieved for comparison

    if (_selectedHours < startHour || (_selectedHours == startHour && _selectedMinutes < startMinute)) {
      _showErrorMessage(); // Show error message if end time is invalid
      // Revert to previous valid end time in UI
      setState(() {
        _selectedHours = UserPreferencesManager.getEndHour();
        _selectedMinutes = UserPreferencesManager.getEndMinute();
      });
    } else {
      // Save new end time if it's valid
      await UserPreferencesManager.saveEndTime(_selectedHours, _selectedMinutes);
      if (widget.isRunning) {
        // Restart notifications
        print('endTime changed, case is running:');
        widget.notificationService.cancelAllNotifications();
        widget.notificationService.startScheduledNotifications();
      }
    }
  }

  Future<void> _retrieveStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    startHour = prefs.getInt('startHour') ?? 9;
    startMinute = prefs.getInt('startMinute') ?? 0;
  }

  void _showErrorMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            LanguageService.getTranslation('app_settings_endTime_alert_title') ?? 'Invalid End Time',
          ),
          content: Text(
              LanguageService.getTranslation('app_settings_endTime_alert_body') ?? 'End time cannot be earlier than start time',
          style: const TextStyle(
            fontSize: 20.0
          ),),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(
                fontSize: 21.0
              ),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LanguageService.getTranslation('app_settings_endTime') ?? 'Daily end time',
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        _buildTimeOptions(),
      ],
    );
  }

  Widget _buildTimeOptions() {
    return Row(
      children: [
        _buildHoursDropdown(),
        SizedBox(width: 5),
        Text(':', style: TextStyle(color: Colors.white)),
        SizedBox(width: 5),
        _buildMinutesDropdown(),
        SizedBox(width: 5),
      ],
    );
  }

  Widget _buildHoursDropdown() {
    return DropdownButton<int>(
      value: _selectedHours,
      items: List.generate(24, (index) => index).map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
      onChanged: (int? newValue) {
        if (newValue != null) { // Check if newValue is not null
          setState(() {
            _selectedHours = newValue; // Safe to assign now
            _onEndTimeChanged();
          });
        }
      },
      dropdownColor: Colors.grey[850],
    );
  }

  Widget _buildMinutesDropdown() {
    return DropdownButton<int>(
      value: _selectedMinutes,
      items: List.generate(12, (index) => index * 5).map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
      onChanged: (int? newValue) {
        if (newValue != null) { // Check if newValue is not null
          setState(() {
            _selectedMinutes = newValue; // Safe to assign now
            _onEndTimeChanged();
          });
        }
      },

      dropdownColor: Colors.grey[850],
    );
  }
}