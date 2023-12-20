import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:back_pal/services/user_preferences_manager.dart';

class IncludeWeekendsRow extends StatefulWidget {
  const IncludeWeekendsRow({super.key});

  @override
  _IncludeWeekendsRowState createState() => _IncludeWeekendsRowState();
}

class _IncludeWeekendsRowState extends State<IncludeWeekendsRow> {
  bool _includeWeekends = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadIncludeWeekendsPreference();
  // }
  //
  // Future<void> _loadIncludeWeekendsPreference() async {
  //   _includeWeekends = UserPreferencesManager.getIncludeWeekends();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    _initializePreference();
  }

  Future<void> _initializePreference() async {
    bool currentSetting = UserPreferencesManager.getIncludeWeekends();
    setState(() {
      _includeWeekends = currentSetting;
    });
  }

  void _onIncludeWeekendsChanged(bool newValue) async {
    setState(() {
      _includeWeekends = newValue;
    });
    await UserPreferencesManager.saveIncludeWeekends(newValue);
  }

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
          onChanged:  _onIncludeWeekendsChanged,
          activeColor: Colors.green,
        ),
      ],
    );
  }
}