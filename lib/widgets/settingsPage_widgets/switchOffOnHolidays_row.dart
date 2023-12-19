import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';

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
        Text(
          LanguageService.getTranslation('app_settingsPro_holidays') ?? 'Switch off on holidays',
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        Switch(
          value: switchOffOnHolidays,
          onChanged: widget.isEnabled
              ? (bool newValue) {
            setState(() {
              switchOffOnHolidays = newValue;
            });
          }
              : null, // Disable if not enabled
          activeColor: Colors.green,
        ),
      ],
    );
  }
}
