import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:math';
import 'package:back_pal/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  /// Schedules periodic notifications every 5 seconds.
  // void startPeriodicNotifications() {
  //   // Schedule periodic notifications every 5 seconds
  //   const Duration interval = Duration(seconds: 5);
  //
  //   // Use a repeating method to trigger notifications every 5 seconds
  //   flutterLocalNotificationsPlugin.periodicallyShow(
  //     0,
  //     'Repeating Notification',
  //     'This notification repeats every 5 seconds.',
  //     RepeatInterval.everyMinute, // Adjust the interval as needed
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channelId,
  //         channelName,
  //         importance: Importance.max,
  //       ),
  //     ),
  //   );
  // }

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


  // void startTimer(Duration interval, int startHour, int endHour) {
  //   Timer timer = Timer.periodic(interval, (Timer timer) {
  //     final now = DateTime.now();
  //     if (now.hour >= startHour && now.hour < endHour && !isWeekend(now)) {
  //       showNotification(
  //         'Notification Title',
  //         'Notification Body',
  //       );
  //     }
  //   });
  //
  //   subsequentTimers.add(timer); // Keep track of the subsequent timer
  // }

  void startScheduledNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intervalInSeconds = prefs.getInt('notificationInterval') ?? 1800; // Default to 30 minutes
    int startHour = prefs.getInt('startHour') ?? 9; // Default to 9:00 AM
    int startMinute = prefs.getInt('startMinute') ?? 0;
    final interval = Duration(seconds: intervalInSeconds);
    //final interval = Duration(seconds: 5); //for testing needs - comment two rows above to test

    final now = DateTime.now();
    // final startHour = 0;
    // final startMinute = 0;
    final endHour = 23;
    final endMinute = 0;


    if (!isWeekend(now)) {
      DateTime scheduledTime = calculateNextScheduledTime(now, startHour, startMinute, endHour, endMinute, interval);

      // Calculate the initial delay until the next scheduled notification
      final initialDelay = scheduledTime.difference(now);

      // Schedule the first notification
      initialTimer = Timer(initialDelay, () {
        showRandomNotification(); // Using showRandomNotification instead

        // Schedule subsequent notifications with the specified interval
        Timer subsequentTimer = Timer.periodic(interval, (Timer timer) {
          showRandomNotification(); // Using showRandomNotification instead
        });
        subsequentTimers.add(subsequentTimer); // Keep track of subsequent timers
      });
    }

    // ... rest of your code ...
  }

  // void startScheduledNotifications() {
  //   final now = DateTime.now();
  //   final startHour = 0;
  //   final startMinute = 0;
  //   final endHour = 23;
  //   final endMinute = 0;
  //   final interval = Duration(seconds: 5);
  //
  //   if (!isWeekend(now)) {
  //     DateTime scheduledTime = calculateNextScheduledTime(now, startHour, startMinute, endHour, endMinute, interval);
  //
  //     // Calculate the initial delay until the next scheduled notification
  //     final initialDelay = scheduledTime.difference(now);
  //
  //     // Schedule the first notification
  //     initialTimer = Timer(initialDelay, () {
  //       showRandomNotification(); // Using showRandomNotification instead
  //
  //       // Schedule subsequent notifications with the specified interval
  //       Timer subsequentTimer = Timer.periodic(interval, (Timer timer) {
  //         showRandomNotification(); // Using showRandomNotification instead
  //       });
  //       subsequentTimers.add(subsequentTimer); // Keep track of subsequent timers
  //     });
  //   }
  // }

  //convert interval to human readable representation of the interval
  String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} day(s)';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hour(s)';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute(s)';
    } else {
      return '${duration.inSeconds} second(s)';
    }
  }

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