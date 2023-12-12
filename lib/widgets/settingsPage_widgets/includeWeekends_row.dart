import 'package:flutter/material.dart';

class IncludeWeekendsRow extends StatefulWidget {
  @override
  _IncludeWeekendsRowState createState() => _IncludeWeekendsRowState();
}

class _IncludeWeekendsRowState extends State<IncludeWeekendsRow> {
  bool _includeWeekends = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Include weekends',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        Switch(
          value: _includeWeekends,
          onChanged: (bool newValue) {
            setState(() {
              _includeWeekends = newValue;
            });
          },
          activeColor: Colors.green,
        ),
      ],
    );
  }
}