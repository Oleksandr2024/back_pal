import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:math';
import 'package:back_pal/services/language_service.dart';
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
      print('notifications initialized'); //works 1
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
    print('inside showNotification: ');
  }

  Timer? initialTimer; // Keep track of the initial timer
  List<Timer> subsequentTimers = []; // Keep track of subsequent timers
  ///check if it is weekend or not
  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.friday || date.weekday == DateTime.sunday;
  }

  void startScheduledNotifications() async {
    final now = DateTime.now();
    final startHour = UserPreferencesManager.getStartHour();
    final startMinute = UserPreferencesManager.getStartMinute();
    final endHour = UserPreferencesManager.getEndHour();
    final endMinute = UserPreferencesManager.getEndMinute();
    final intervalMinutes = UserPreferencesManager.getInterval();
    final includeWeekends = UserPreferencesManager.getIncludeWeekends();

    final intervalDuration = Duration(minutes: intervalMinutes);
    DateTime nextStartTime = calculateNextStartTime(now, startHour, startMinute);
    DateTime nextEndTime = DateTime(now.year, now.month, now.day, endHour, endMinute);

    // Cancel any existing timers
    initialTimer?.cancel();
    for (var timer in subsequentTimers) {
      timer.cancel();
    }
    subsequentTimers.clear();

    // Check if current time is during the notification period
    if (now.isBefore(nextEndTime) && (includeWeekends || !isWeekend(now))) {
      final timeUntilNextNotification = now.isBefore(nextStartTime)
          ? nextStartTime.difference(now)
          : intervalDuration - Duration(seconds: now.second, milliseconds: now.millisecond, microseconds: now.microsecond);

      initialTimer = Timer(timeUntilNextNotification, () {
        showRandomNotification();
        setPeriodicNotifications(nextEndTime, intervalDuration);
      });
    } else {
      // Schedule next notification for the next start time, considering weekends
      scheduleNextStart(includeWeekends, startHour, startMinute, intervalDuration);
    }
  }

  void setPeriodicNotifications(DateTime endDateTime, Duration interval) {
    Timer periodicTimer = Timer.periodic(interval, (Timer t) {
      final now = DateTime.now();
      if (now.isBefore(endDateTime)) {
        showRandomNotification();
      } else {
        t.cancel(); // Stop the timer after end time
      }
    });
    subsequentTimers.add(periodicTimer);
  }

  void scheduleNextStart(bool includeWeekends, int startHour, int startMinute, Duration interval) {
    DateTime nextDay = DateTime.now().add(Duration(days: 1));
    while (isWeekend(nextDay) && !includeWeekends) {
      nextDay = nextDay.add(Duration(days: 1));
    }
    DateTime nextStartTime = calculateNextStartTime(nextDay, startHour, startMinute);
    final timeUntilStartNextDay = nextStartTime.difference(DateTime.now());
    initialTimer = Timer(timeUntilStartNextDay, () {
      showRandomNotification();
      setPeriodicNotifications(DateTime(nextDay.year, nextDay.month, nextDay.day, UserPreferencesManager.getEndHour(), UserPreferencesManager.getEndMinute()), interval);
    });
  }
  // void startScheduledNotifications() async {
  //   final now = DateTime.now();
  //   final startHour = UserPreferencesManager.getStartHour();
  //   final startMinute = UserPreferencesManager.getStartMinute();
  //   final endHour = UserPreferencesManager.getEndHour();
  //   final endMinute = UserPreferencesManager.getEndMinute();
  //   final intervalMinutes = UserPreferencesManager.getInterval();
  //   final includeWeekends = UserPreferencesManager.getIncludeWeekends();
  //
  //   final intervalDuration = Duration(minutes: intervalMinutes);
  //   DateTime nextStartTime = calculateNextStartTime(now, startHour, startMinute);
  //   DateTime nextEndTime = DateTime(now.year, now.month, now.day, endHour, endMinute);
  //
  //   // Cancel any existing timers
  //   initialTimer?.cancel();
  //   subsequentTimers.forEach((timer) => timer.cancel());
  //   subsequentTimers.clear();
  //
  //   // Check if current time is during the notification period
  //   if (now.isBefore(nextEndTime) && (includeWeekends || !isWeekend(now))) {
  //     final timeUntilNextNotification = now.isBefore(nextStartTime)
  //         ? nextStartTime.difference(now)
  //         : intervalDuration;
  //     initialTimer = Timer(timeUntilNextNotification, () {
  //       showRandomNotification();
  //       Timer.periodic(intervalDuration, (Timer t) {
  //         final now = DateTime.now();
  //         if (now.isBefore(nextEndTime) && (includeWeekends || !isWeekend(now))) {
  //           showRandomNotification();
  //         } else {
  //           t.cancel(); // Stop the timer after end time or on weekends
  //         }
  //       });
  //     });
  //   } else {
  //     // Schedule next notification for the next start time, considering weekends
  //     DateTime nextDay = now.add(Duration(days: 1));
  //     while (isWeekend(nextDay) && !includeWeekends) {
  //       nextDay = nextDay.add(Duration(days: 1));
  //     }
  //     nextStartTime = calculateNextStartTime(nextDay, startHour, startMinute);
  //     final timeUntilStartNextDay = nextStartTime.difference(now);
  //     initialTimer = Timer(timeUntilStartNextDay, () {
  //       showRandomNotification();
  //       Timer.periodic(intervalDuration, (Timer t) {
  //         final now = DateTime.now();
  //         DateTime todayEndTime = DateTime(now.year, now.month, now.day, endHour, endMinute);
  //         if (now.isBefore(todayEndTime) && (includeWeekends || !isWeekend(now))) {
  //           showRandomNotification();
  //         } else {
  //           t.cancel(); // Stop the timer after end time or on weekends
  //         }
  //       });
  //     });
  //   }
  // }


// Helper method to find the next weekday start time
  DateTime findNextWeekdayStartTime(DateTime current, int startHour, int startMinute) {
    DateTime nextStart = current.add(Duration(days: 1));
    print('here 11 nextStart is: $nextStart');
    while (isWeekend(nextStart)) {
      nextStart = nextStart.add(Duration(days: 1));
      print('nextStart if weekend is: $nextStart');
    }
    print('Daate here: is: $DateTime(nextStart.year, nextStart.month, nextStart.day, startHour, startMinute)');
    return DateTime(nextStart.year, nextStart.month, nextStart.day, startHour, startMinute);
  }

  DateTime calculateNextStartTime(DateTime current, int startHour, int startMinute) {
    DateTime startToday = DateTime(current.year, current.month, current.day, startHour, startMinute);
    DateTime endToday = DateTime(current.year, current.month, current.day, UserPreferencesManager.getEndHour(), UserPreferencesManager.getEndMinute());

    if (current.isBefore(startToday)) {
      return startToday;
    } else if (current.isAfter(endToday)) {
      return DateTime(current.year, current.month, current.day + 1, startHour, startMinute);
    } else {
      // Adjust nextStart to a time definitely in the past within today's active period
      return startToday; //.subtract(Duration(seconds: 3));
    }
  }

  Future<void> showRandomNotification() async { //added
    List<String> titles = LanguageService.getTranslationList('notification_titles');
    List<String> messages = LanguageService.getTranslationList('notification_messages');

    Random random = Random();
    String randomTitle = titles[random.nextInt(titles.length)];
    String randomMessage = messages[random.nextInt(messages.length)];

    await showNotification(randomTitle, randomMessage);
    print('inside showRandomNotification: ');
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