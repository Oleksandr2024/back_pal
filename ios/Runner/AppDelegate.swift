import UIKit
import Flutter

// added from tutorials
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

  //added FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
  GeneratedPluginRegistrant.register(with: registry)}

    GeneratedPluginRegistrant.register(with: self)

    //added next if statement
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenter
    }


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
