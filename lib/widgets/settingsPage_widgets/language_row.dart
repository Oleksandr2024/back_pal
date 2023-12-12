import 'package:flutter/material.dart';

class LanguageRow extends StatefulWidget {
  @override
  _LanguageRowState createState() => _LanguageRowState();
}

class _LanguageRowState extends State<LanguageRow> {
  String selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Language',
          style: TextStyle(
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
    List<String> languages = ['English', 'Українська', 'Deutsch', 'Español', 'Français', 'العربية', '中文', '日本語'];

    return DropdownButton<String>(
      value: selectedLanguage,
      style: const TextStyle(
        fontSize: 18.0,
        fontFamily: 'Montserrat',
        color: Colors.white,
      ),
      dropdownColor: Colors.grey[800],
      items: languages.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
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
          // Handle language change
          setState(() {
            selectedLanguage = newValue;
          });
          // You can implement logic to update the app's language here
          // For now, let's just print the selected language
          print('Selected Language: $selectedLanguage');
        }
      },
    );
  }
}


