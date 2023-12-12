import 'package:flutter/material.dart';

class DailyEndTimeRow extends StatefulWidget {
  @override
  _DailyEndTimeRowState createState() => _DailyEndTimeRowState();
}

class _DailyEndTimeRowState extends State<DailyEndTimeRow> {
  int _selectedHours = 6;
  int _selectedMinutes = 0;
  String _selectedAmPm = 'p.m.';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Daily end time',
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
        _buildAmPmDropdown(),
      ],
    );
  }

  Widget _buildHoursDropdown() {
    return DropdownButton<int>(
      value: _selectedHours,
      items: List.generate(12, (index) => index + 1).map((int value) {
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
          _selectedMinutes = newValue!;
        });
      },
      dropdownColor: Colors.grey[850],
    );
  }

  Widget _buildAmPmDropdown() {
    return DropdownButton<String>(
      value: _selectedAmPm,
      items: ['a.m.', 'p.m.']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        );
      })
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedAmPm = newValue!;
        });
      },
      dropdownColor: Colors.grey[850],
    );
  }
}