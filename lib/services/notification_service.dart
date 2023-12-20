import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:math';
import 'package:back_pal/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_pal/services/user_preferences_manager.dart';

class NotificationService {

  static const String channelId = 'channelId';
  static const String channelName = 'channelName';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initializes the FlutterLocalNotificationsPlugin and starts periodic notifications.
  Future<void> init() async {
    try{
      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      var initializationSettingsIOS = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async{}
      );

      final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {}, ///don't know if I need this
      );

      // startPeriodicNotifications(); // to start sending notifications when app starts
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }


  /// Shows a notification with the given [title] and [body].
  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails,
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
    );
  }

  Timer? initialTimer; // Keep track of the initial timer
  List<Timer> subsequentTimers = []; // Keep track of subsequent timers
  ///check if it is weekend or not
  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  void startScheduledNotifications() async {
    final now = DateTime.now();
    await scheduleNextNotificationCycle(now);
  }


  Future<void> scheduleNextNotificationCycle(DateTime currentTime) async {
    // Retrieve user preferences
    final startHour = UserPreferencesManager.getStartHour();
    final startMinute = UserPreferencesManager.getStartMinute();
    final endHour = UserPreferencesManager.getEndHour();
    final endMinute = UserPreferencesManager.getEndMinute();
    final intervalMinutes = UserPreferencesManager.getInterval();
    final includeWeekends = UserPreferencesManager.getIncludeWeekends();

    // Convert interval to Duration
    final interval = Duration(minutes: intervalMinutes);

    // Calculate next start and end times
    DateTime nextStartTime = calculateNextStartTime(currentTime, startHour, startMinute);
    DateTime nextEndTime = DateTime(nextStartTime.year, nextStartTime.month, nextStartTime.day, endHour, endMinute);

    // If the current time is before next end time
    if (currentTime.isBefore(nextEndTime)) {
      // Calculate initial delay for the first notification
      final initialDelay = nextStartTime.isAfter(currentTime)
          ? nextStartTime.difference(currentTime)
          : Duration.zero;

      // Schedule the first notification after the initial delay
      initialTimer = Timer(initialDelay, () {
        // Show the first notification and set up periodic notifications
        showRandomNotification();
        Timer subsequentTimer = Timer.periodic(interval, (Timer timer) {
          final now = DateTime.now();
          if (now.isBefore(nextEndTime)) {
            showRandomNotification();
          } else {
            timer.cancel(); // Stop the timer at end time
            // Schedule for next day if weekends are included or it's not a weekend
            if (includeWeekends || !isWeekend(nextStartTime.add(Duration(days: 1)))) {
              scheduleNextNotificationCycle(nextEndTime);
            }
          }
        });
        subsequentTimers.add(subsequentTimer); // Keep track of the timer
      });
    }
  }
  // Future<void> scheduleNextNotificationCycle(DateTime currentTime) async {
  //   // Use UserPreferencesManager to get the preferences
  //   final startHour = UserPreferencesManager.getStartHour();
  //   final startMinute = UserPreferencesManager.getStartMinute();
  //   final endHour = UserPreferencesManager.getEndHour();
  //   final endMinute = UserPreferencesManager.getEndMinute();
  //   final intervalDuration = Duration(minutes: UserPreferencesManager.getInterval()); // Changed to use getInterval()
  //
  //   DateTime nextStartTime = calculateNextStartTime(currentTime, startHour, startMinute);
  //   DateTime nextEndTime = DateTime(nextStartTime.year, nextStartTime.month, nextStartTime.day, endHour, endMinute);
  //
  //   bool includeWeekends = UserPreferencesManager.getIncludeWeekends();
  //
  //   if (currentTime.isBefore(nextEndTime)) {
  //     final initialDelay = nextStartTime.difference(currentTime);
  //     initialTimer = Timer(initialDelay, () {
  //       showRandomNotification();
  //
  //       Timer subsequentTimer = Timer.periodic(intervalDuration, (Timer timer) {
  //         // ... (No changes in this part)
  //       });
  //       subsequentTimers.add(subsequentTimer);
  //     });
  //   }
  // }


  DateTime calculateNextStartTime(DateTime current, int startHour, int startMinute) {
    DateTime nextStart = DateTime(current.year, current.month, current.day, startHour, startMinute);
    if (current.isAfter(nextStart)) {
      nextStart = nextStart.add(Duration(days: 1));
    }
    return nextStart;
  }

  //convert interval to human readable representation of the interval
  // String formatDuration(Duration duration) {
  //   if (duration.inDays > 0) {
  //     return '${duration.inDays} day(s)';
  //   } else if (duration.inHours > 0) {
  //     return '${duration.inHours} hour(s)';
  //   } else if (duration.inMinutes > 0) {
  //     return '${duration.inMinutes} minute(s)';
  //   } else {
  //     return '${duration.inSeconds} second(s)';
  //   }
  // }

  DateTime calculateNextScheduledTime(
      DateTime current, int startHour, int startMinute, int endHour, int endMinute, Duration interval) {
    DateTime nextScheduledTime = DateTime(current.year, current.month, current.day, startHour, startMinute);

    while (nextScheduledTime.isBefore(current) ||
        nextScheduledTime.hour >= endHour ||
        (nextScheduledTime.hour == endHour && nextScheduledTime.minute >= endMinute)) {
      nextScheduledTime = nextScheduledTime.add(interval);
    }

    return nextScheduledTime;
  }


  Future<void> showRandomNotification() async { //added
    List<String> titles = LanguageService.getTranslationList('notification_titles');
    List<String> messages = LanguageService.getTranslationList('notification_messages');

    Random random = Random();
    String randomTitle = titles[random.nextInt(titles.length)];
    String randomMessage = messages[random.nextInt(messages.length)];

    await showNotification(randomTitle, randomMessage);
  }


    /// Cancels all scheduled notifications.
    void cancelAllNotifications() {
      initialTimer?.cancel();
      for(var timer in subsequentTimers){
        timer.cancel();
      }
      flutterLocalNotificationsPlugin.cancelAll();
    }
  }