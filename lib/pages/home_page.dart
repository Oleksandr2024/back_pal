import 'package:back_pal/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:back_pal/services/notification_service.dart';
import 'package:back_pal/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_pal/utilities/dailyTimeChangeHandler.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRunning = false; // State to track whether the process is running
  final NotificationService notificationService = NotificationService();
  final TimeChangeHandler timeChangeHandler = TimeChangeHandler();
  Timer? timer;

  // Method to update isRunning state
  void updateIsRunning(bool value) {
    setState(() {
      isRunning = value;
    });
  }

  Future<bool> _isEndTimeValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int startHour = prefs.getInt('startHour') ?? 9;
    int startMinute = prefs.getInt('startMinute') ?? 0;
    int endHour = prefs.getInt('endHour') ?? 18;
    int endMinute = prefs.getInt('endMinute') ?? 0;
    // Comparing the times
    if (endHour > startHour || (endHour == startHour && endMinute > startMinute)) {
      return true;
    }
    return false;
  }

  void _showInvalidTimeError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: Text(
            LanguageService.getTranslation('app_time_alert_title') ?? 'Invalid Time Settings',
          ),
          content: Text(
              LanguageService.getTranslation('app_time_alert_body') ?? 'End time cannot be earlier than start time. Change end time in settings to see notifications',
            style: const TextStyle(
            fontSize: 20.0,
            // backgroundColor: Colors.grey[500]
          ),),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(fontSize: 24.0),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    notificationService.init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/LogoBack2cover2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 260.0), //was 300

            // Stack to position the Divider above the text
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(60.0, 30.0, 30.0, 10.0),
                  child: Text(
                    LanguageService.getTranslation('app_title:app_slogan') ?? 'Default title: Default slogan',
                    style: const TextStyle(
                      fontSize: 28.0,
                      color: Color(0xFFEFEFEF),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Positioned(
                  top: 0,
                  left: 10,
                  right: 10,
                  child: Divider(
                    height: 1,
                    color: Color(0xFF002D75),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
             Text(
              LanguageService.getTranslation('app_exhort') ?? 'Let\'s take care of your back!',
              style: const TextStyle(
                fontSize: 18.0,
                color: Color(0xFFEFEFEF),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 7.0),
            ElevatedButton(
              onPressed: () async {
                bool endTimeIsValid = await _isEndTimeValid();
                if (!endTimeIsValid) {
                  // Show error message
                  _showInvalidTimeError();
                  return;
                }
                // Toggle the state and run the corresponding function
                setState(() {
                  isRunning = !isRunning;
                  if (isRunning) {
                    notificationService.startScheduledNotifications();
                  } else {
                    notificationService.cancelAllNotifications();
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent[700],
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                ),
              ),
              child: Text(
                (() {
                  if (isRunning) {
                    return LanguageService.getTranslation('app_stop') ?? 'Stop';
                  } else {
                    return LanguageService.getTranslation('app_start') ?? 'Start';
                  }
                })(),
                style: const TextStyle(
                  letterSpacing: 1.5,
                ),
              ),
            ),
            SizedBox(height: 130.0),
            // Upgrade to Pro button
            ElevatedButton(
              onPressed: () {
                // Navigate to Pro Features page
                Navigator.pushNamed(context, '/pro');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4AFF2F),
                foregroundColor: Colors.pink[400],
                textStyle: const TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              child: Text(
                 // 'Upgrade to Pro!'
                LanguageService.getTranslation('app_upgrade') ?? 'Upgrade to Pro!',
              ),

            ),
            SizedBox(height: 20.0),
            // Navigation menu row
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to About page
                    Navigator.pushNamed(context, '/about');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent[700],
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      letterSpacing: 1.5,
                    ),
                  ),
                  child: Text(
                      //'About'
                    LanguageService.getTranslation('app_about') ?? 'About',
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                          timeChangeHandler: timeChangeHandler,
                          notificationService: notificationService,
                          updateIsRunningCallback: (bool value) {
                            setState(() {
                              isRunning = value;
                            });
                          },
                          isRunning: isRunning,
                        ),
                      ),
                    );
                    // Navigate to Settings page
                    // Navigator.pushNamed(context, '/settings');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent[700],
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      letterSpacing: 1.5,
                    ),
                  ),
                  child: Text(
                     // 'Settings'
                    LanguageService.getTranslation('app_settings') ?? 'Settings',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}


