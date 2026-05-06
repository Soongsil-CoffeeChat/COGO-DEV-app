import Flutter
import UIKit
import GoogleSignIn
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // FCM remote 알림은 setForegroundNotificationPresentationOptions를 따르고,
  // flutter_local_notifications가 생성한 로컬 알림은 항상 표시
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    let userInfo = notification.request.content.userInfo
    if userInfo["gcm.message_id"] != nil {
      // Remote FCM 알림: super(FCM)가 처리
      super.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    } else {
      // 로컬 알림(flutter_local_notifications): 항상 표시
      if #available(iOS 14.0, *) {
        completionHandler([.list, .banner, .sound, .badge])
      } else {
        completionHandler([.alert, .sound, .badge])
      }
    }
  }

  override func application(
      _ app: UIApplication,
      open url: URL,
      options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
