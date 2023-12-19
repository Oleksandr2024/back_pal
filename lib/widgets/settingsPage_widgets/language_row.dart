import 'package:flutter/material.dart';
import 'package:back_pal/services/language_manager.dart';
import 'package:back_pal/services/language_service.dart';
import '../../main.dart';

class LanguageRow extends StatefulWidget {
  static final GlobalKey<_LanguageRowState> languageRowKey =
  GlobalKey<_LanguageRowState>();

  @override
  _LanguageRowState createState() => _LanguageRowState();
}

class _LanguageRowState extends State<LanguageRow> {
  late LanguageManager _languageManager;
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _languageManager = LanguageManager();
    _selectedLanguage = _languageManager.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          LanguageService.getTranslation('app_settings_language') ?? 'Language',
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        _buildLanguageOptions(),
      ],
    );
  }

  Widget _buildLanguageOptions() {
    List<String> languages = [
      'English',
      'Українська',
      'Deutsch',
      'Español',
      'Français',
      'Nederlands',
      'Italiano',
      'العربية',
      '中文',
      '日本語',
      '한국어'
    ];

    return DropdownButton<String>(
      key: LanguageRow.languageRowKey,
      value: _selectedLanguage,
      style: const TextStyle(
        fontSize: 18.0,
        fontFamily: 'Montserrat',
        color: Colors.white,
      ),
      dropdownColor: Colors.grey[800],
      items: languages.map((String value) {
        return DropdownMenuItem<String>(
          value: _languageManager.languageCodeMapping[value],
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _languageManager.setLanguage(newValue);
            _selectedLanguage = newValue;
          });
          print('Selected Language: $newValue');

          MyApp.setLocale(context, Locale(newValue.toLowerCase()));
        }
      },
    );
  }
}
