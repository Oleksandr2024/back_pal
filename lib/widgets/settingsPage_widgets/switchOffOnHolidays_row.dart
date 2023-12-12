import 'package:flutter/material.dart';

class SwitchOffOnHolidays extends StatefulWidget {
  final bool isEnabled; // To control the state

  const SwitchOffOnHolidays({Key? key, required this.isEnabled}) : super(key: key);

  @override
  _SwitchOffOnHolidaysState createState() => _SwitchOffOnHolidaysState();
}

class _SwitchOffOnHolidaysState extends State<SwitchOffOnHolidays> {
  bool switchOffOnHolidays = false; // Default value

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Switch off on holidays',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        Container(
          height: 30.0, // Adj
          width: 55.0,// ust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0), // Adjust the border radius
            color: switchOffOnHolidays ? Colors.green : Colors.grey[400], // Customize the background color
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0), // Adjust the padding
          child: Switch(
            value: switchOffOnHolidays,
            onChanged: widget.isEnabled
                ? (bool newValue) {
              setState(() {
                switchOffOnHolidays = newValue;
              });
            }
                : null, // Disable if not enabled
            activeColor: Colors.transparent,
            activeTrackColor: Colors.transparent,
            inactiveThumbColor: Colors.transparent,
            inactiveTrackColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}