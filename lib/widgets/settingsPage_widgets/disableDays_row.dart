import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DisableDaysRow extends StatefulWidget {
  @override
  _DisableDaysRowState createState() => _DisableDaysRowState();
}

class _DisableDaysRowState extends State<DisableDaysRow> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _calendarVisible = false; // Track calendar visibility

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Disable Certain Days',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Toggle calendar visibility on "Select" click
                  setState(() {
                    _calendarVisible = !_calendarVisible;
                  });
                },
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Montserrat',
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Visibility(
            visible: _calendarVisible,
            child: TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              selectedDayPredicate: (day) {
                // Add your logic to disable specific days here
                return false;
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.lightBlue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.transparent, // Set to transparent for consistency
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false, // Hide days outside the current month
                weekendTextStyle: TextStyle( // Use weekendTextStyle instead of weekendStyle
                  color: Colors.white, // Set weekend text color
                ),
                weekNumberTextStyle: TextStyle( // Use weekdayTextStyle instead of weekdayStyle
                  color: Colors.white, // Set weekday text color
                ),
                todayTextStyle: TextStyle( // Use todayTextStyle instead of todayStyle
                  color: Colors.white, // Set today text color
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  color: Colors.white, // Set month and year text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

