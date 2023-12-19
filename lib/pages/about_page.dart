import 'package:flutter/material.dart';
import 'package:back_pal/services/language_service.dart';

class AboutPage extends StatelessWidget {
  final String aboutText = LanguageService.getTranslation('app_about_1par') ?? 'Welcome to the \'BackPal\' app – your digital backbone buddy! We\'ve all played hide-and-seek with our posture, but here\'s your chance to be the posture champion. BackPal is more than just an app; it\'s your backstage pass to a healthier back. Say goodbye to slouching, and hello to a posture that even your grandma would be proud of. Let BackPal be your back\'s BFF.';

  final String additionalText = LanguageService.getTranslation('app_about_2par') ?? 'The goal of BackPal is to send you regular reminders to straighten your back. You can adjust the interval of notifications in the settings page, as well as the starting and ending hours of notifications during the day. The default interval of notifications is 30 minutes every day from 9 a.m. to 6 p.m., except weekends. This period is set because the majority of people are working at the office or sitting in front of their computer, often without paying attention to their posture. The most important thing is that every time you get a notification, you must follow it, ideally not forgetting to keep your back straight until the next notification.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          LanguageService.getTranslation('app_about') ?? 'About',
          style: TextStyle(
            fontSize: 26.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[850],
          padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  aboutText,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  additionalText,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}