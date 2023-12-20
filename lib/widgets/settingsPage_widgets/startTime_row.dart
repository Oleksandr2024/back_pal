import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:back_pal/services/notification_service.dart';
import 'package:back_pal/utilities/dailyTimeChangeHandler.dart'; //added
import 'package:back_pal/services/user_preferences_manager.dart';


class DailyStartTimeRow extends StatefulWidget {
  final TimeChangeHandler timeChangeHandler;
  final NotificationService notificationService;
  final bool isRunning;

  DailyStartTimeRow({
    required this.timeChangeHandler,
    required this.notificationService,
    required this.isRunning,
  });

  @override
  _DailyStartTimeRowState createState() => _DailyStartTimeRowState();
}

class _DailyStartTimeRowState extends State<DailyStartTimeRow> {
  int _selectedHours = 9;
  int _selectedMinutes = 0;

  void _onStartTimeChanged() async {
    await UserPreferencesManager.saveStartTime(_selectedHours, _selectedMinutes);

    if (widget.isRunning) {
      widget.notificationService.cancelAllNotifications();
      widget.notificationService.startScheduledNotifications();
    }

    widget.timeChangeHandler.onStartTimeChanged(_selectedHours, _selectedMinutes);
  }

  @override //added
  void initState() {
    super.initState();
    _selectedHours = UserPreferencesManager.getStartHour();
    _selectedMinutes = UserPreferencesManager.getStartMinute();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          //'Daily start time',
          LanguageService.getTranslation('app_settings_startTime') ?? 'Daily start time',
          style: TextStyle(
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
        //_buildAmPmDropdown(),
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
        setState(() {
          if (newValue != null) {
            _selectedHours = newValue;
            _onStartTimeChanged(); // Call this method to save and handle the change
          }
        });
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
        setState(() {
          if (newValue != null) {
            _selectedMinutes = newValue;
            _onStartTimeChanged(); // Call this method to save and handle the change
          }
        });
      },
      dropdownColor: Colors.grey[850],
    );
  }
}
