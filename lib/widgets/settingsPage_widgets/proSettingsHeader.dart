import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';

class ProSettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
          LanguageService.getTranslation('app_settingsPro_title') ?? 'Pro settings',
        style: const TextStyle(
          fontSize: 24.0,
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}