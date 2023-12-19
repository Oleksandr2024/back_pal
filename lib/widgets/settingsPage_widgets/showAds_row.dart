import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';

class ShowAdsRow extends StatefulWidget {
  final bool isEnabled; // To control the state

  const ShowAdsRow({Key? key, required this.isEnabled}) : super(key: key);

  @override
  _ShowAdsRowState createState() => _ShowAdsRowState();
}

class _ShowAdsRowState extends State<ShowAdsRow> {
  bool showAds = true; // Default value

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LanguageService.getTranslation('app_settingsPro_showAds') ?? 'Show ads',
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        Container(
          height: 30.0, // Adj
          width: 55.0,// ust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0), // Adjust the border radius
            color: showAds ? Colors.green : Colors.grey[400], // Customize the background color
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0), // Adjust the padding
          child: Switch(
            value: showAds,
            onChanged: widget.isEnabled
                ? (bool newValue) {
              setState(() {
                showAds = newValue;
              });
            }
                : null, // Disable if not enabled
            activeColor: Colors.transparent,
            activeTrackColor: Colors.transparent,
            inactiveThumbColor: Colors.transparent,
            inactiveTrackColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
