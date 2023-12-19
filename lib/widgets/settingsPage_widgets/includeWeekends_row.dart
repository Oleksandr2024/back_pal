import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';

class IncludeWeekendsRow extends StatefulWidget {
  const IncludeWeekendsRow({super.key});

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
        Text(
          LanguageService.getTranslation('app_settings_inclWeekends') ?? 'Include weekends',
          style: const TextStyle(
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