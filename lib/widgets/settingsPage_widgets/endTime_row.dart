import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; //added
import 'package:back_pal/utilities/dailyTimeChangeHandler.dart'; //added
import 'package:back_pal/services/preferences_manager.dart'; //added

class DailyEndTimeRow extends StatefulWidget {
  final TimeChangeHandler timeChangeHandler; //added
  DailyEndTimeRow({required this.timeChangeHandler});  //added

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
  _retrieveStartTime(); // Load start time on widget initialization
  }

  void _onEndTimeChanged() async {
    await _retrieveStartTime(); // Ensure this is called and completed before comparison

    if (_selectedHours < startHour || (_selectedHours == startHour && _selectedMinutes < startMinute)) {
      _showErrorMessage();
    } else {
      widget.timeChangeHandler.onEndTimeChanged(_selectedHours, _selectedMinutes);
    }
  }

  Future<void> _retrieveStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    startHour = prefs.getInt('startHour') ?? 9;
    startMinute = prefs.getInt('startMinute') ?? 0;
  }


  // void _onEndTimeChanged() async { // added 3
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int startHour = prefs.getInt('startHour') ?? 9; // Default value if not set
  //   int startMinute = prefs.getInt('startMinute') ?? 0; // Default value if not set
  //
  //   if (_selectedHours < startHour || (_selectedHours == startHour && _selectedMinutes < startMinute)) {
  //     _showErrorMessage();
  //   } else {
  //     // If the time is valid, save the end time
  //     widget.timeChangeHandler.onEndTimeChanged(_selectedHours, _selectedMinutes);
  //   }
  // }

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