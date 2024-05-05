import UIKit
import Flutter
import UserNotifications
import SwiftUI
import FirebaseMessaging
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,

    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
 FirebaseApp.configure()
//Messaging.messaging().delegate = self
    GeneratedPluginRegistrant.register(with: self)
// if (@available(iOS 12.0, *)) {
//   [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
// }
 UNUserNotificationCenter.current().delegate = self

let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
UNUserNotificationCenter.current().requestAuthorization(
  options: authOptions,
  completionHandler: { _, _ in }
)

application.registerForRemoteNotifications()
// if #available(iOS 10.0, *) {
//      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//     }
   
//  application.registerForRemoteNotifications()
// application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  //  return super.application(application, didFinishLaunchingWithOptions: launchOptions)

 }
// override
func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
  print("Firebase registration token: \(String(describing: fcmToken))")

  let dataDict: [String: String] = ["token": fcmToken ?? ""]
  NotificationCenter.default.post(
    name: Notification.Name("FCMToken"),
    object: nil,
    userInfo: dataDict
  )
  // TODO: If necessary send token to application server.
  // Note: This callback is fired at each app startup and whenever a new token is generated.
}
override
func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
  return GoogleSignIn.GIDSignIn.sharedInstance.handle(url)
}
//guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//// Create Google Sign In configuration object.
//let config = GIDConfiguration(clientID: clientID)
//     GIDSignIn.sharedInstance.configuration = config
//
//// Start the sign in flow!
//GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
//  guard error == nil else {
//    // ...
//  }
//
//  guard let user = result?.user,
//    let idToken = user.idToken?.tokenString
//  else {
//    // ...
//  }
//
//  let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                 accessToken: user.accessToken.tokenString)
//
//  // ...
//}
override
func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
}
