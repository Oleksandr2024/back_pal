import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';

class SelectCountryRow extends StatefulWidget {
  final bool isEnabled; // To control the state

  const SelectCountryRow({Key? key, required this.isEnabled}) : super(key: key);

  @override
  _SelectCountryRowState createState() => _SelectCountryRowState();
}

class _SelectCountryRowState extends State<SelectCountryRow> {
  String selectedCountry = 'USA'; // Default country

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LanguageService.getTranslation('app_settingsPro_country') ?? 'Select country',
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        Flexible( // Use Flexible with FlexFit.tight
          child: DropdownButton<String>(
            dropdownColor: Colors.grey[800],
            value: selectedCountry,
            onChanged: widget.isEnabled
                ? (String? newValue) {
              setState(() {
                selectedCountry = newValue!;
              });
            }
                : null, // Disable if not enabled
            items: const [
              'USA',
              'United Kingdom',
              'Canada',
              'Ukraine',
              'France',
              'Spain',
              'Germany',
              'China',
              'Japan',
              'India',
              'Saudi Arabia',
              'UAE',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}


