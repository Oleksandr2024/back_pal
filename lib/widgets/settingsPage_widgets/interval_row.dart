import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntervalReminderRow extends StatefulWidget {
  @override
  _IntervalReminderRowState createState() => _IntervalReminderRowState();
}

class _IntervalReminderRowState extends State<IntervalReminderRow> {
  int _selectedHours = 0;
  int _selectedMinutes = 30;

  //save interval to shared preferences
  Future<void> _saveIntervalSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intervalInSeconds = _selectedHours * 3600 + _selectedMinutes * 60;
    await prefs.setInt('notificationInterval', intervalInSeconds);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LanguageService.getTranslation('app_settings_intervalReminder') ?? 'Interval reminder',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        _buildIntervalOptions(),
      ],
    );
  }

  Widget _buildIntervalOptions() {
    return Row(
      children: [
        _buildHoursDropdown(),
        SizedBox(width: 5),
        Text(':', style: TextStyle(color: Colors.white)),
        SizedBox(width: 5),
        _buildMinutesDropdown(),
      ],
    );
  }

  Widget _buildHoursDropdown() {
    return DropdownButton<int>(
      value: _selectedHours,
      items: List.generate(5, (index) => index).map((int value) {
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
          _selectedHours = newValue!;
        });
        _saveIntervalSetting(); //comment if you want to test
      },
      // onChanged: (int? newValue) {
      //   setState(() {
      //     _selectedHours = newValue!;
      //   });
      // },
      dropdownColor: Colors.grey[850], // Set background color
    );
  }

  Widget _buildMinutesDropdown() {
    return DropdownButton<int>(
      value: _selectedMinutes,
      items: List.generate(11, (index) => (index + 1) * 5).map((int value) {
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
          _selectedMinutes = newValue!;
        });
        _saveIntervalSetting(); //comment if you want to test
      },
      // onChanged: (int? newValue) {
      //   setState(() {
      //     _selectedMinutes = newValue!;
      //   });
      // },
      dropdownColor: Colors.grey[850], // Set background color
    );
  }
}