import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:back_pal/services/user_preferences_manager.dart';

class SwitchOffOnHolidays extends StatefulWidget {
  final bool isEnabled; // To control the state

  const SwitchOffOnHolidays({Key? key, required this.isEnabled}) : super(key: key);

  @override
  _SwitchOffOnHolidaysState createState() => _SwitchOffOnHolidaysState();
}

class _SwitchOffOnHolidaysState extends State<SwitchOffOnHolidays> {
  bool switchOffOnHolidays = true; // Default value

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    switchOffOnHolidays = await UserPreferencesManager.getIncludeWeekends();
    setState(() {});
  }

  Future<void> _savePreference(bool value) async {
    await UserPreferencesManager.saveIncludeWeekends(value);
  }

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
              ? (bool newValue) async {
            setState(() => switchOffOnHolidays = newValue);
            await _savePreference(newValue);
          }
              : null, // Disable if not enabled
          activeColor: Colors.green,
        ),
        // Switch(
        //   value: switchOffOnHolidays,
        //   onChanged: widget.isEnabled
        //       ? (bool newValue) {
        //     setState(() {
        //       switchOffOnHolidays = newValue;
        //     });
        //   }
        //       : null, // Disable if not enabled
        //   activeColor: Colors.green,
        // ),
      ],
    );
  }
}
