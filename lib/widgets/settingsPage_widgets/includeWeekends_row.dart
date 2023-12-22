import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:back_pal/services/user_preferences_manager.dart';
import 'package:back_pal/services/notification_service.dart';

class IncludeWeekendsRow extends StatefulWidget {
  final NotificationService notificationService;
  final bool isRunning;

  const IncludeWeekendsRow({super.key,
    required this.notificationService,
    required this.isRunning,
  });

  @override
  _IncludeWeekendsRowState createState() => _IncludeWeekendsRowState();
}

class _IncludeWeekendsRowState extends State<IncludeWeekendsRow> {
  bool _includeWeekends = false;

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

  void _onIncludeWeekendsChanged() async {
    await UserPreferencesManager.saveIncludeWeekends(_includeWeekends);
    if(widget.isRunning){
          widget.notificationService.cancelAllNotifications();
          widget.notificationService.startScheduledNotifications();
    }
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
          onChanged: (bool? newValue){
            setState(() {
              if(newValue !=null){
                _includeWeekends = newValue;
                _onIncludeWeekendsChanged();
              }
            });
          } ,
          activeColor: Colors.green,
        ),
      ],
    );
  }
}