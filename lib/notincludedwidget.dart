import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alaqy/AllOrders.dart';
import 'package:flutter_alaqy/AuthScreenBusiness.dart';
import 'package:flutter_alaqy/FoundOrders.dart';
import 'package:flutter_alaqy/SPLASHSCREEN.dart';
import 'package:flutter_alaqy/alaaqyProcess.dart';
import 'package:flutter_alaqy/authScreenUser.dart';
import 'package:flutter_alaqy/businessChoose.dart';
import 'package:flutter_alaqy/business_main.dart';
import 'package:flutter_alaqy/listing.dart';
import 'package:flutter_alaqy/profilepic.dart';
import 'package:flutter_alaqy/updatebusiness.dart';
import 'package:flutter_alaqy/updateuser.dart';
import 'package:flutter_alaqy/userChoose.dart';
import 'package:flutter_alaqy/userToBusinessScreen.dart';
import 'package:flutter_alaqy/user_main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'ImagePicker.dart';
import 'business_mainx.dart';
import 'chat_screens.dart';
import 'mainb.dart';
import 'mainu.dart';
import 'numberPhone.dart';
import 'opening.dart';
import 'user_mainx.dart';

int id = 0;

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();
const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';
// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   //Navigator.of(context).pushReplacementNamed(UpdateUser.routeName);
//   // handle action
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         // Navigator.pushNamed(
//         //   context, '/',
//         //   //  arguments: MessageArguments(message, true)
//         // );
//       }
//     });

//     // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     //   print('A new onMessageOpenedApp event was published!');
//     //   // Navigator.pushNamed(
//     //   //   context, '/',
//     //   //   //  arguments: MessageArguments(message, true)
//     //   // );
//     // });
//     // print('Got a message whilst in the foreground!');
//     // print('Message data: ${message.data}');

//     // if (message.notification != null) {
//     //   print('Message also contained a notification: ${message.notification}');
//     //   // for (var r = id; id == 0; r--) {
//     //   //   id--;
//     //   //   print('$id wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
//     //   // }
//     // }
//   });
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   print('User granted permission: ${settings.authorizationStatus}');
//   messaging.subscribeToTopic('notify');
//   print("Handling a background message: ${message.messageId}");
// }

//@pragma('vm:entry-point')
// Future<void> _onBackgroundMessage(RemoteMessage message) async {
//   debugPrint('we have received a notification ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// await _configureLocalTimeZone();
  @pragma('vm:entry-point')
  void firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // if (id > 0) {
      //   null;
      // } else {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
//  Navigator.pushNamed(
//         context, '/',
//          arguments: MessageArguments(message, true)
        //  )
        await Navigator.of(context)
            .pushReplacementNamed(UpdateBusiness.routeName);

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                playSound: true, enableLights: true, priority: Priority.high,
                'Default channel',
                'Default channel',
                //  widget.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        print('A new onMessageOpenedApp event was published!');
        // Navigator.pushNamed(
        //   context, '/',
        //   //  arguments: MessageArguments(message, true)
        // );
        await Navigator.of(context)
            .pushReplacementNamed(UpdateBusiness.routeName);
      });
    });
//  }

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && Platform.isLinux
            ? null
            : await flutterLocalNotificationsPlugin
                .getNotificationAppLaunchDetails();
    // String initialRoute = HomePage.routeName;
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
      //  initialRoute = SecondPage.routeName;
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsDarwin,
      // macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      //  onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }
  // void didChangeAppLifecycleStatee(AppLifecycleState state) async {
  //   // super.didChangeAppLifecycleState(state);
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     final userdoc = await FirebaseFirestore.instance
  //         .collection('customer_details')
  //         .where('second_uid',
  //             isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     if (userdoc.docs.first.exists) {
  //       final userdocid = userdoc.docs.first.id;
  //       print(userdocid);
  //       print('userdocid');

  //       switch (state) {
  //         case AppLifecycleState.resumed:
  //           FirebaseFirestore.instance
  //               .collection('customer_details')
  //               .doc(userdocid)
  //               .update({
  //             'state': 'online',
  //             'lastseen': Timestamp.now(),
  //           });
  //           print("app in resumed");
  //           break;
  //         case AppLifecycleState.inactive:
  //           FirebaseFirestore.instance
  //               .collection('customer_details')
  //               .doc(userdocid)
  //               .update({
  //             'state': 'offline',
  //             'lastseen': Timestamp.now(),
  //           });
  //           print("app in inactive");
  //           break;
  //         case AppLifecycleState.paused:
  //           FirebaseFirestore.instance
  //               .collection('customer_details')
  //               .doc(userdocid)
  //               .update({
  //             'state': 'offline',
  //             'lastseen': Timestamp.now(),
  //           });
  //           print("app in paused");
  //           break;
  //         case AppLifecycleState.detached:
  //           FirebaseFirestore.instance
  //               .collection('customer_details')
  //               .doc(userdocid)
  //               .update({
  //             'state': 'offline',
  //             'lastseen': Timestamp.now(),
  //           });
  //           print("app in detached");
  //           break;
  //       }
  //     }
  //   }
  // }
  //////////FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
  runApp(RestartWidget(child: const MyApp()));
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

// @pragma('vm:entry-point')
// Future<void> _deleteNotificationChannel() async {
//   const String channelId = 'Notifications';
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.deleteNotificationChannel(channelId);
// }

// @pragma('vm:entry-point')
// Future<void> _deleteNotificationChannelx() async {
//   const String channelId = 'Default channel';
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.deleteNotificationChannel(channelId);
// }

// @pragma('vm:entry-point')
// Future<void> _deleteNotificationChannelxx() async {
//   const String channelId = 'System silent channel';
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.deleteNotificationChannel(channelId);
// }

// @pragma('vm:entry-point')
// Future<void> _cancelNotification() async {
//   await flutterLocalNotificationsPlugin.cancel(--id);
// }

// @pragma('vm:entry-point')
// Future<void> _cancelNotificationx() async {
//   await flutterLocalNotificationsPlugin.cancel(--id);
// }

// @pragma('vm:entry-point')
// Future<void> _cancelNotificationz() async {
//   await flutterLocalNotificationsPlugin.cancel(--id);
// }

// @pragma('vm:entry-point')
// Future<void> _cancelNotificationc() async {
//   await flutterLocalNotificationsPlugin.cancel(--id);
// }

// @pragma('vm:entry-point')
// Future<void> _cancelNotificationv() async {
//   await flutterLocalNotificationsPlugin.cancel(--id);
// }

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  String? mtoken = '';
  final fbm = FirebaseMessaging.instance;
  bool stop = true;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    requestpermission();
    getToken();
    initInfo();
  }

  initInfo() {
    var androidinitialize = const AndroidInitializationSettings('app_icon');
//var iosinitialize = const IOSFlutterLocalNotificationsPlugin().initialize(initializationSettings)
    var initializationsettings =
        InitializationSettings(android: androidinitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsettings,
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse? payload) async {
      try {
        if (payload != null && payload.toString().isNotEmpty) {
          //  Navigator.of(context).pushReplacementNamed(UpdateBusiness.routeName);
        } else {}
      } catch (e) {}
      return;
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // for (var r = id; id == 0; r--) {
      //   id--;
      //   print('$id wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
      // }

      print('on  message');
      print(
          'onmessage:${message.notification!.title}/${message.notification!.body}');
      BigTextStyleInformation bigtextstyleinformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidplatformchannelspecifies =
          AndroidNotificationDetails(
        'Default channel',
        'Default channel',
        importance: Importance.max,
        styleInformation: bigtextstyleinformation,
        priority: Priority.max,
        playSound: true,
      );
      NotificationDetails platformchannelspecifies = NotificationDetails(
        android: androidplatformchannelspecifies,
      );
      //   sendpushnotification(
      //     mtoken!, message.notification!.body!, message.notification!.title!);
      // final lord = await FirebaseFirestore.instance
      //     .collection('customer_details')
      //     .where('second_uid',
      //         isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      //     .get();
      // final balaha = lord.docs.first.data()['username'];
      // message.notification!.title != balaha
      //    ?

      print('$id xxxxxxxxxxxxxxxxxxxzzzzzzzzzxxxxxxx');
      if (id.isOdd) {
        await flutterLocalNotificationsPlugin.show(
            id++,
            message.notification!.title,
            message.notification!.body,
            platformchannelspecifies,
            payload: message.data.toString());
        flutterLocalNotificationsPlugin.cancel(--id);
      }
      if (id.isEven) {
        // await flutterLocalNotificationsPlugin.show(
        //     id++,
        //     message.notification!.title,
        //     message.notification!.body,
        //     platformchannelspecifies,
        //     payload: message.data['body']);
        flutterLocalNotificationsPlugin.cancel(--id);
      }

      //  await flutterLocalNotificationsPlugin.cancel(--id);
      //  }
      //  if (id.isEven) {
      //   await flutterLocalNotificationsPlugin.show(
      //       id++,
      //       message.notification!.title,
      //       message.notification!.body,
      //       platformchannelspecifies,
      //       payload: message.data['body']);
      // }
    });
    // Future.delayed(const Duration(seconds: 3), (() {
    //   _incrementCounter();
    //   flutterLocalNotificationsPlugin.cancel(--id);
    // }));
    // print(stop);
    // Future.delayed(const Duration(seconds: 7), (() {
    //   _incrementCounterx();
    //   //   flutterLocalNotificationsPlugin.cancel(--id);
    // }));
    // print(stop);
    //   _incrementCounterx();
    // for (var r = id; id == 0; r--) {
    //   id--;
    //   print('$id wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
    // }
  }

// Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;
// _stream.listen((RemoteMessage event) async {
//   if (event.data != null) {
//     await Navigator.of(context).push(...);
//   }
// });
  void saveToken(String token) async {
    final lord = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('second_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final balaha = lord.docs.first.data()['first_uid'];
    print(balaha);
    await FirebaseFirestore.instance
        .collection('customer_details')
        .doc(balaha)
        .collection('tokens')
        .doc(token)
        .set({
      'createdAt': Timestamp.now(),
      'platform': Platform.operatingSystem.toString(),
      'registrationTokens': token,
    });
  }

  void requestpermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      print('user declined');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('my token is $mtoken');
      });
      saveToken(token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    void car() {
      Navigator.of(context).pushReplacementNamed(UpdateBusiness.routeName);
    }

    flutterLocalNotificationsPlugin.cancelAll();
    var phoneController;
    var accTypem;
    var pick;
    var uid;
    var uid2;
    var sup;
    var kok;
    var usern;
    var usern2;
    var idd;
    var username;
    var storename;
    var stringo;
    var bus1;
    var bus2;
    var cusid;
    var idx;
    var idy;
    var basicusername;
    var basicstorename;
    var phx;
    var icc;
    var koje;
    var fas;
    var iccc;
    var kojee;
    var fass;
    // _deleteNotificationChannel();
    // _deleteNotificationChannel();
    // _deleteNotificationChannel();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();
    // _cancelNotification();

    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return KeyedSubtree(
        key: key,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            routes: {
              Listing.routeName: (ctx) => Listing(),
              AlaaqyProcess.routeName: (ctx) => AlaaqyProcess(),
              UserMain.routeName: (ctx) => UserMain(idx),
              UserMainx.routeName: (ctx) => UserMainx(icc),
              SplashScreen.routeName: (ctx) => SplashScreen(),
              BusinessMain.routeName: (ctx) => BusinessMain(idy),
              BusinessMainx.routeName: (ctx) => BusinessMainx(idy, phx),

              AllOrders.routeName: (ctx) => AllOrders(),
              MyHomePagee.routeName: (ctx) => MyHomePagee(),
              MyHomePagez.routeName: (ctx) => MyHomePagez(),
              MyApp.routeName: (ctx) => MyApp(),
              FoundOrders.routeName: (ctx) => FoundOrders(),
              LoginScreen.routeName: (ctx) => LoginScreen(accTypem, koje),
              userChoose.routeName: (ctx) => userChoose(),
              businessChoose.routeName: (ctx) => businessChoose(),
              profilepic.routeName: (ctx) => profilepic(iccc, kojee, fass),
              AuthScreenUser.routeName: (ctx) =>
                  AuthScreenUser(phoneController, uid, sup, kok),
              AuthScreenBusiness.routeName: (ctx) =>
                  AuthScreenBusiness(phoneController, uid, sup, usern2, fas),
              UserImagePicker.routeName: (ctx) => UserImagePicker(pick),
              UserToBusinessScreen.routeName: (ctx) =>
                  UserToBusinessScreen(phoneController, uid, uid2, usern),
              ChatScreens.routeName: (ctx) => ChatScreens(
                  idd,
                  username,
                  storename,
                  stringo,
                  bus1,
                  bus2,
                  cusid,
                  basicusername,
                  basicstorename),
              UpdateUser.routeName: (ctx) => UpdateUser(),
              UpdateBusiness.routeName: (ctx) => UpdateBusiness(),

              //    AuthFormUser.routeName: (ctx) => AuthFormUser(),
            },
            home: FirebaseNotificationsHandler(
              onOpenNotificationArrive: (navigatorKey, payload) {
                @pragma('vm:entry-point')
                Future<void> _cancelNotification() async {
                  await flutterLocalNotificationsPlugin.cancel(--id);
                }

                _cancelNotification();

                Navigator.of(context)
                    .pushReplacementNamed(UpdateBusiness.routeName);
                navigatorKey.currentState!.pushNamed('updateBusiness');
              },
              onTap: (navigatorKey, appState, payload) {
                print(
                    "XXXXXXXXxxxxxxxxxxxxNotification tapped with $appState & payload $payload");
                setState(() {});
                final context = navigatorKey.currentContext!;
                print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");

                Navigator.of(context)
                    .pushReplacementNamed(UpdateBusiness.routeName);
                navigatorKey.currentState!.pushNamed('updateBusiness');
                // OR
                Navigator.pushNamed(context, 'updateBusiness');
                print("ccccccccccccccccccccccccc");
              },
              channelName: 'Default channel',
              channelId: 'Default channel',
              enableLogs: true,
              child: widget.child,
            )));
  }
}
// void didChangeAppLifecycleState(AppLifecycleState state) async {
//     final userdoc = await FirebaseFirestore.instance
//         .collection('customer_details')
//         .where('second_uid',
//             isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     final userdocid = userdoc.docs.first.id;

//     switch (state) {
//       case AppLifecycleState.resumed:
//         FirebaseFirestore.instance
//             .collection('customer_details')
//             .doc(userdocid)
//             .update({'state': 'online'});
//         print("app in resumed");
//         break;
//       case AppLifecycleState.inactive:
//         FirebaseFirestore.instance
//             .collection('customer_details')
//             .doc(userdocid)
//             .update({'state': 'offline'});
//         print("app in inactive");
//         break;
//       case AppLifecycleState.paused:
//         FirebaseFirestore.instance
//             .collection('customer_details')
//             .doc(userdocid)
//             .update({'state': 'offline'});
//         print("app in paused");
//         break;
//       case AppLifecycleState.detached:
//         FirebaseFirestore.instance
//             .collection('customer_details')
//             .doc(userdocid)
//             .update({'state': 'offline'});
//         print("app in detached");
//         break;
//     }
//   }

class MyApp extends StatefulWidget {
  static const routeName = '/myapp';
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // String? mtoken = '';
  // final fbm = FirebaseMessaging.instance;
  // bool stop = true;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // requestpermission();
    // getToken();
    // initInfo();
    //  requestpermissionx();
  }

  // void _incrementCounter() {
  //   stop++;
  // }

  // void _incrementCounterx() {
  //   for (var r = id; id == 0; r--) {
  //     id--;
  //     print('$id wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
  //   }
  //   stop--;
  //   // id --;
  // }
  // void requestpermissionx() async {
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   // if (initialMessage?.data['type'] == 'chat') {
  //   // Navigator.pushNamed(
  //   //   context, '/updateBusiness',
  //   //   // arguments: ChatArguments(initialMessage));
  //   // );
  //   Navigator.of(context).pushNamed(UpdateBusiness.routeName);

  //   //}
  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     //  if (message.data['type'] == 'chat') {
  //     // Navigator.pushNamed(
  //     //   context, '/updateBusiness',
  //     //   //   arguments: ChatArguments(message)
  //     // );
  //     Navigator.of(context).pushNamed(UpdateBusiness.routeName);

  //     //   }
  //   });
  // }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (FirebaseAuth.instance.currentUser != null) {
      final userdoc = await FirebaseFirestore.instance
          .collection('customer_details')
          .where('second_uid',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userdoc.docs.first.exists) {
        final userdocid = userdoc.docs.first.id;
        print(userdocid);
        print('userdocid');

        switch (state) {
          case AppLifecycleState.resumed:
            FirebaseFirestore.instance
                .collection('customer_details')
                .doc(userdocid)
                .update({
              'state': 'online',
              'lastseen': Timestamp.now(),
            });
            print("app in resumed");
            break;
          case AppLifecycleState.inactive:
            FirebaseFirestore.instance
                .collection('customer_details')
                .doc(userdocid)
                .update({
              'state': 'offline',
              'lastseen': Timestamp.now(),
            });
            print("app in inactive");
            //   requestpermissionx();

            break;
          case AppLifecycleState.paused:
            FirebaseFirestore.instance
                .collection('customer_details')
                .doc(userdocid)
                .update({
              'state': 'offline',
              'lastseen': Timestamp.now(),
            });
            print("app in paused");
            break;
          case AppLifecycleState.detached:
            FirebaseFirestore.instance
                .collection('customer_details')
                .doc(userdocid)
                .update({
              'state': 'offline',
              'lastseen': Timestamp.now(),
            });
            print("app in detached");
            break;
        }
      }
    }
  }

  // void sendpushnotification(String token, String body, String title) async {
  //   @pragma('vm:entry-point')
  //   Future<void> _onBackgroundMessage(RemoteMessage message) async {
  //     await Firebase.initializeApp(
  //         // options: DefaultFirebaseOptions.currentPlatform,
  //         );
  //     debugPrint('we have received a notification ${message.notification}');
  //   }

  //   @pragma('vm:entry-point')
  //   Future<void> _firebaseMessagingBackgroundHandler(
  //       RemoteMessage message) async {
  //     // If you're going to use other Firebase services in the background, such as Firestore,
  //     // make sure you call `initializeApp` before using other Firebase services.
  //     await Firebase.initializeApp();
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       FirebaseMessaging.instance
  //           .getInitialMessage()
  //           .then((RemoteMessage? message) {
  //         if (message != null) {
  //           // Navigator.pushNamed(
  //           //   context, '/',
  //           //   //  arguments: MessageArguments(message, true)
  //           // );
  //         }
  //       });

  //       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //         final FlutterLocalNotificationsPlugin
  //             flutterLocalNotificationsPlugin =
  //             FlutterLocalNotificationsPlugin();
  //         RemoteNotification? notification = message.notification;
  //         AndroidNotification? android = message.notification?.android;

  //         if (notification != null && android != null) {
  //           flutterLocalNotificationsPlugin.show(
  //               notification.hashCode,
  //               notification.title,
  //               notification.body,
  //               const NotificationDetails(
  //                 android: AndroidNotificationDetails(
  //                   //   playSound: true, enableLights: true,
  //                   // importance: Importance.max,

  //                   priority: Priority.high,
  //                   'dbfood',
  //                   'dbfood',
  //                   //  widget.description,
  //                   // TODO add a proper drawable resource to android, for now using
  //                   //      one that already exists in example app.
  //                   icon: 'launch_background',
  //                 ),
  //               ));
  //         }
  //       });

  //       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //         print('A new onMessageOpenedApp event was published!');
  //         // Navigator.pushNamed(
  //         //   context, '/',
  //         //   //  arguments: MessageArguments(message, true)
  //         // );
  //       });
  //       print('Got a message whilst in the foreground!');
  //       print('Message data: ${message.data}');

  //       if (message.notification != null) {
  //         print(
  //             'Message also contained a notification: ${message.notification}');
  //       }
  //     });
  //     FirebaseMessaging messaging = FirebaseMessaging.instance;

  //     NotificationSettings settings = await messaging.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true,
  //     );

  //     await FirebaseMessaging.instance
  //         .setForegroundNotificationPresentationOptions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //     print('User granted permission: ${settings.authorizationStatus}');
  //     messaging.subscribeToTopic('notify');
  //     print("Handling a background message: ${message.messageId}");
  //   }

  //   @pragma('vm:entry-point')
  //   Future<void> _onBackgroundMessagee(RemoteMessage message) async {
  //     debugPrint('we have received a notification ${message.messageId}');
  //   }

  //   try {
  //     await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'content-type': 'aplication/json',
  //         'Authorization':
  //             'key=AAAAYkVGhz8:APA91bE75B-XzSXGRP9xJ6M1Ljg7CavQe_No8g705E0XlPp1Q_QwCQ1T9o_9wjHChsWR5fpzQ1YlQ2l5D8STZGmJf9gcVuj4jRtf9lkWji79QmqOW_fwy6hg__twEGiBbooIidoVMaw-'
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'priority': 'high',
  //         'data': <String, dynamic>{
  //           'click_action': 'Flutter_Notification_Click',
  //           'status': 'done',
  //           'body': body,
  //           'title': title,
  //         },
  //         "notification": <String, dynamic>{
  //           "title": title,
  //           "body": body,
  //           "android_channel_id": "dbfood",
  //         },
  //         "to": token,
  //       }),
  //     );
  //     print("herexxx push notification");
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("error push notification");
  //     }
  //   }
  // }

//   initInfo() {
//     var androidinitialize = const AndroidInitializationSettings('app_icon');
// //var iosinitialize = const IOSFlutterLocalNotificationsPlugin().initialize(initializationSettings)
//     var initializationsettings =
//         InitializationSettings(android: androidinitialize);
//     flutterLocalNotificationsPlugin.initialize(initializationsettings,
//         onDidReceiveBackgroundNotificationResponse:
//             (NotificationResponse? payload) async {
//       try {
//         if (payload != null && payload.toString().isNotEmpty) {
//           //  Navigator.of(context).pushReplacementNamed(UpdateBusiness.routeName);
//         } else {}
//       } catch (e) {}
//       return;
//     });
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       // for (var r = id; id == 0; r--) {
//       //   id--;
//       //   print('$id wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
//       // }

//       print('on  message');
//       print(
//           'onmessage:${message.notification!.title}/${message.notification!.body}');
//       BigTextStyleInformation bigtextstyleinformation = BigTextStyleInformation(
//         message.notification!.body.toString(),
//         htmlFormatBigText: true,
//         contentTitle: message.notification!.title.toString(),
//         htmlFormatContentTitle: true,
//       );
//       AndroidNotificationDetails androidplatformchannelspecifies =
//           AndroidNotificationDetails(
//         'your channel id',
//         'your channel name',
//         importance: Importance.max,
//         styleInformation: bigtextstyleinformation,
//         priority: Priority.max,
//         playSound: true,
//       );
//       NotificationDetails platformchannelspecifies = NotificationDetails(
//         android: androidplatformchannelspecifies,
//       );
//       //   sendpushnotification(
//       //     mtoken!, message.notification!.body!, message.notification!.title!);
//       // final lord = await FirebaseFirestore.instance
//       //     .collection('customer_details')
//       //     .where('second_uid',
//       //         isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//       //     .get();
//       // final balaha = lord.docs.first.data()['username'];
//       // message.notification!.title != balaha
//       //    ?

//       print('$id xxxxxxxxxxxxxxxxxxxzzzzzzzzzxxxxxxx');
//       //   if (id < 1) {

//       await flutterLocalNotificationsPlugin.show(
//           id++,
//           message.notification!.title,
//           message.notification!.body,
//           platformchannelspecifies,
//           payload: message.data.toString());
//       //    }
//       // if (id >= 1) {
//       //   await flutterLocalNotificationsPlugin.show(
//       //       id++,
//       //       message.notification!.title,
//       //       message.notification!.body,
//       //       platformchannelspecifies,
//       //       payload: message.data['body']);
//       //   flutterLocalNotificationsPlugin.cancel(--id);
//       // }

//       //  await flutterLocalNotificationsPlugin.cancel(--id);
//       //  }
//       //  if (id.isEven) {
//       //   await flutterLocalNotificationsPlugin.show(
//       //       id++,
//       //       message.notification!.title,
//       //       message.notification!.body,
//       //       platformchannelspecifies,
//       //       payload: message.data['body']);
//       // }
//     });
//     // Future.delayed(const Duration(seconds: 3), (() {
//     //   _incrementCounter();
//     //   flutterLocalNotificationsPlugin.cancel(--id);
//     // }));
//     // print(stop);
//     // Future.delayed(const Duration(seconds: 7), (() {
//     //   _incrementCounterx();
//     //   //   flutterLocalNotificationsPlugin.cancel(--id);
//     // }));
//     // print(stop);
//     //   _incrementCounterx();
//     // for (var r = id; id == 0; r--) {
//     //   id--;
//     //   print('$id wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
//     // }
//   }

// // Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;
// // _stream.listen((RemoteMessage event) async {
// //   if (event.data != null) {
// //     await Navigator.of(context).push(...);
// //   }
// // });
//   void saveToken(String token) async {
//     final lord = await FirebaseFirestore.instance
//         .collection('customer_details')
//         .where('second_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     final balaha = lord.docs.first.data()['first_uid'];
//     print(balaha);
//     await FirebaseFirestore.instance
//         .collection('customer_details')
//         .doc(balaha)
//         .collection('tokens')
//         .doc(token)
//         .set({
//       'createdAt': Timestamp.now(),
//       'platform': Platform.operatingSystem.toString(),
//       'registrationTokens': token,
//     });
//   }

//   void requestpermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('user granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('user granted provisional permission');
//     } else {
//       print('user declined');
//     }
//   }

//   void getToken() async {
//     await FirebaseMessaging.instance.getToken().then((token) {
//       setState(() {
//         mtoken = token;
//         print('my token is $mtoken');
//       });
//       saveToken(token!);
//     });
//   }

  //@pragma('vm:entry-point')
  // Future<void> _startForegroundService() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.startForegroundService(1, 'alaqy', 'welcome',
  //           notificationDetails: androidNotificationDetails, payload: 'item x');
  // }

  // @pragma('vm:entry-point')
  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin
  //       .show(id++, 'alaqy', 'welcome', notificationDetails, payload: 'item x');
  // }

  // @pragma('vm:entry-point')
  // Future<void> _showNotificationWithNoSound() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name', channelAction:AndroidNotificationChannelAction.update,
  //           channelDescription: 'silent channel description',
  //           playSound: false,
  //           styleInformation: DefaultStyleInformation(true, true));
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     presentSound: false,
  //   );
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: darwinNotificationDetails,
  //       macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(id++, '<b>silent</b> alaqy',
  //       '<b>silent</b> welcome', notificationDetails);
  // }
  // @pragma('vm:entry-point')
  // Future<void> _deleteNotificationChannel() async {
  //   const String channelId = 'Notifications';
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.deleteNotificationChannel(channelId);
  // }

  // @pragma('vm:entry-point')
  // Future<void> _deleteNotificationChannelx() async {
  //   const String channelId = 'Default channel';
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.deleteNotificationChannel(channelId);
  // }

  // @pragma('vm:entry-point')
  // Future<void> _deleteNotificationChannelxx() async {
  //   const String channelId = 'System silent channel';
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.deleteNotificationChannel(channelId);
  // }

  // @pragma('vm:entry-point')
  // Future<void> _cancelAllNotifications() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }

//class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // _deleteNotificationChannel();
    // _deleteNotificationChannelx();
    // _deleteNotificationChannelxx();

    // Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;
    // _stream.listen((RemoteMessage event) async {
    //   if (event.data.isNotEmpty) {
    //     await Navigator.of(context)
    //         .pushReplacementNamed(UpdateBusiness.routeName);
    //   }
    // });
    // @pragma('vm:entry-point')
    // void notificationTapBackground(NotificationResponse notificationResponse) {
    //   Navigator.of(context).pushReplacementNamed(UpdateBusiness.routeName);
    // }
    // print(
    //     '$id xxxxxxxxxxxxxxxxxxxxxxxxxxxxzzzzzzzzzzzzzzzzzzzzzzxxxxxxxxxxxxxxxxzzzzzzzzzz');
    //  _startForegroundService();
    // _showNotificationWithNoSound();
    // _showNotification();
    // Future.delayed(const Duration(seconds: 8), (() {
    //   setState(() async {
    //     await _cancelAllNotifications();
    //   });
    // }));
    // _cancelNotification();
    //  @pragma('vm:entry-point')

    //  @pragma('vm:entry-point')
    // Future<void> _firebaseMessagingBackgroundHandler(
    //     RemoteMessage message) async {
    //   // If you're going to use other Firebase services in the background, such as Firestore,
    //   // make sure you call `initializeApp` before using other Firebase services.
    //   await Firebase.initializeApp();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   FirebaseMessaging.instance
    //       .getInitialMessage()
    //       .then((RemoteMessage? message) {
    //     if (message != null) {
    //       // Navigator.pushNamed(
    //       //   context, '/',
    //       //   //  arguments: MessageArguments(message, true)
    //       // );
    //     }
    //   });

    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     final FlutterLocalNotificationsPlugin
    //         flutterLocalNotificationsPlugin =
    //         FlutterLocalNotificationsPlugin();
    //     RemoteNotification? notification = message.notification;
    //     AndroidNotification? android = message.notification?.android;

    //     if (notification != null && android != null) {
    //       flutterLocalNotificationsPlugin.show(
    //           notification.hashCode,
    //           notification.title,
    //           notification.body,
    //           const NotificationDetails(
    //             android: AndroidNotificationDetails(
    //               'your channel id', 'your channel name',
    //               //  widget.description,
    //               // TODO add a proper drawable resource to android, for now using
    //               //      one that already exists in example app.
    //               icon: 'app_icon',
    //             ),
    //           ));
    //     }
    //   });

//         FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//           print('A new onMessageOpenedApp event was published!');
    // Navigator.pushNamed(
    //   context, '/',
    //   //  arguments: MessageArguments(message, true)
    // );
// // Navigator.of(context).pushNamed(UpdateBusiness.routeName);
//          });
//         print('Got a message whilst in the foreground!');
//         print('Message data: ${message.data}');

//         if (message.notification != null) {
//           print(
//               'Message also contained a notification: ${message.notification}');
//         }
//       });
//       FirebaseMessaging messaging = FirebaseMessaging.instance;

//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );

//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       print('User granted permission: ${settings.authorizationStatus}');
//       messaging.subscribeToTopic('notify');
//       print("Handling a background message: ${message.messageId}");
//     }

//     @pragma('vm:entry-point')
//     Future<void> _onBackgroundMessage(RemoteMessage message) async {
//       debugPrint('we have received a notification ${message.messageId}');
//     }

//     void requestpermissionxx() async {
//       RemoteMessage? initialMessage =
//           await FirebaseMessaging.instance.getInitialMessage();
//       // If the message also contains a data property with a "type" of "chat",
//       // navigate to a chat screen
//       if (initialMessage?.data != null) {
//         Navigator.pushNamed(
//           context, '/updateBusiness',
//           // arguments: ChatArguments(initialMessage));
//         );
//         //}
//         // Also handle any interaction when the app is in the background via a
//         // Stream listener
//         FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//           if (message.data.isNotEmpty) {
//             Navigator.pushNamed(
//               context, '/updateBusiness',
//               //   arguments: ChatArguments(message)
//             );
//           }
//         });
//       }
//     }

//     requestpermissionxx();
    // void didChangeAppLifecycleStatee(AppLifecycleState state) async {
    //   // super.didChangeAppLifecycleState(state);
    //   if (FirebaseAuth.instance.currentUser != null) {
    //     final userdoc = await FirebaseFirestore.instance
    //         .collection('customer_details')
    //         .where('second_uid',
    //             isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //         .get();
    //     if (userdoc.docs.first.exists) {
    //       final userdocid = userdoc.docs.first.id;
    //       print(userdocid);
    //       print('userdocid');

    //       switch (state) {
    //         // case AppLifecycleState.resumed:
    //         //   FirebaseFirestore.instance
    //         //       .collection('customer_details')
    //         //       .doc(userdocid)
    //         //       .update({
    //         //     'state': 'online',
    //         //     'lastseen': Timestamp.now(),
    //         //   });
    //         //   print("app in resumed");
    //         //   break;
    //         case AppLifecycleState.inactive:
    //           FirebaseFirestore.instance
    //               .collection('customer_details')
    //               .doc(userdocid)
    //               .update({
    //             'state': 'offline',
    //             'lastseen': Timestamp.now(),
    //           });
    //           print("app in inactive");
    //           requestpermissionxx();
    //           break;
    //         //   case AppLifecycleState.paused:
    //         //     FirebaseFirestore.instance
    //         //         .collection('customer_details')
    //         //         .doc(userdocid)
    //         //         .update({
    //         //       'state': 'offline',
    //         //       'lastseen': Timestamp.now(),
    //         //     });
    //         //     print("app in paused");
    //         //     break;
    //         //   case AppLifecycleState.detached:
    //         //     FirebaseFirestore.instance
    //         //         .collection('customer_details')
    //         //         .doc(userdocid)
    //         //         .update({
    //         //       'state': 'offline',
    //         //       'lastseen': Timestamp.now(),
    //         //     });
    //         //     print("app in detached");
    //         //     break;
    //         // }
    //       }
    //     }
    //   }
    // }

    var phoneController;
    var accTypem;
    var pick;
    var uid;
    var uid2;
    var sup;
    var kok;
    var usern;
    var usern2;
    var idd;
    var username;
    var storename;
    var stringo;
    var bus1;
    var bus2;
    var cusid;
    var idx;
    var idy;
    var basicusername;
    var basicstorename;
    var phx;
    var icc;
    var koje;
    var fas;
    var iccc;
    var kojee;
    var fass;
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Alaaqy',
        theme: ThemeData(
          buttonTheme: ButtonThemeData(buttonColor: Colors.amber),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          // colorScheme: ColorScheme.light(
          //     onPrimary: Colors.amber,
          //     //   background: Colors.amber.shade700,
          //     primary: Colors.grey.shade400,
          //     secondary: Colors.green
          // )
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (ctx, snap) =>
              snap.connectionState == ConnectionState.waiting
                  ?
//  const Center(
//                   child: Text('Loading...'),
                  SplashScreen()
                  //)
                  : StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (ctx, snapShot) =>
                          snapShot.connectionState == ConnectionState.waiting
                              ?
//const Scaffold(body: Center(child: Text('Loading...')))
                              SplashScreen()
                              : snapShot.hasData
                                  ? opening()
                                  : const MyHomePage(title: 'Alaaqy')
                      //   : LoginScreen(),
                      ),
        ),
        routes: {
          Listing.routeName: (ctx) => Listing(),
          AlaaqyProcess.routeName: (ctx) => AlaaqyProcess(),
          UserMain.routeName: (ctx) => UserMain(idx),
          UserMainx.routeName: (ctx) => UserMainx(icc),
          SplashScreen.routeName: (ctx) => SplashScreen(),
          BusinessMain.routeName: (ctx) => BusinessMain(idy),
          BusinessMainx.routeName: (ctx) => BusinessMainx(idy, phx),

          AllOrders.routeName: (ctx) => AllOrders(),
          MyHomePagee.routeName: (ctx) => MyHomePagee(),
          MyHomePagez.routeName: (ctx) => MyHomePagez(),
          MyApp.routeName: (ctx) => MyApp(),
          FoundOrders.routeName: (ctx) => FoundOrders(),
          LoginScreen.routeName: (ctx) => LoginScreen(accTypem, koje),
          userChoose.routeName: (ctx) => userChoose(),
          businessChoose.routeName: (ctx) => businessChoose(),
          profilepic.routeName: (ctx) => profilepic(iccc, kojee, fass),
          AuthScreenUser.routeName: (ctx) =>
              AuthScreenUser(phoneController, uid, sup, kok),
          AuthScreenBusiness.routeName: (ctx) =>
              AuthScreenBusiness(phoneController, uid, sup, usern2, fas),
          UserImagePicker.routeName: (ctx) => UserImagePicker(pick),
          UserToBusinessScreen.routeName: (ctx) =>
              UserToBusinessScreen(phoneController, uid, uid2, usern),
          ChatScreens.routeName: (ctx) => ChatScreens(idd, username, storename,
              stringo, bus1, bus2, cusid, basicusername, basicstorename),
          UpdateUser.routeName: (ctx) => UpdateUser(),
          UpdateBusiness.routeName: (ctx) => UpdateBusiness(),

          //    AuthFormUser.routeName: (ctx) => AuthFormUser(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// void didChangeAppLifecycleStatee(AppLifecycleState state) async {
//   // super.didChangeAppLifecycleState(state);
//   if (FirebaseAuth.instance.currentUser != null) {
//     final userdoc = await FirebaseFirestore.instance
//         .collection('customer_details')
//         .where('second_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     if (userdoc.docs.first.exists) {
//       final userdocid = userdoc.docs.first.id;
//       print(userdocid);
//       print('userdocid');

//       switch (state) {
//         case AppLifecycleState.resumed:
//           FirebaseFirestore.instance
//               .collection('customer_details')
//               .doc(userdocid)
//               .update({
//             'state': 'online',
//             'lastseen': Timestamp.now(),
//           });
//           print("app in resumed");
//           break;
//         case AppLifecycleState.inactive:
//           FirebaseFirestore.instance
//               .collection('customer_details')
//               .doc(userdocid)
//               .update({
//             'state': 'offline',
//             'lastseen': Timestamp.now(),
//           });
//           print("app in inactive");
//           break;
//         case AppLifecycleState.paused:
//           FirebaseFirestore.instance
//               .collection('customer_details')
//               .doc(userdocid)
//               .update({
//             'state': 'offline',
//             'lastseen': Timestamp.now(),
//           });
//           print("app in paused");
//           break;
//         case AppLifecycleState.detached:
//           FirebaseFirestore.instance
//               .collection('customer_details')
//               .doc(userdocid)
//               .update({
//             'state': 'offline',
//             'lastseen': Timestamp.now(),
//           });
//           print("app in detached");
//           break;
//       }
//     }
//   }
// }

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  var bus = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   super.didChangeAppLifecycleState(state);
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     final userdoc = await FirebaseFirestore.instance
  //         .collection('customer_details')
  //         .where('second_uid',
  //             isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     if (userdoc.docs.first.exists) {
  //       final userdocid = userdoc.docs.first.id;
  //       print(userdocid);
  //       print('userdocid');

  //       switch (state) {
  //         case AppLifecycleState.resumed:
  //           FirebaseFirestore.instance
  //               .collection('customer_details')
  //               .doc(userdocid)
  //               .update({
  //             'state': 'online',
  //             'lastseen': Timestamp.now(),
  //           });
  //           print("app in resumed");
  //           break;
  //         case AppLifecycleState.inactive:
  //           FirebaseFirestore.instance
  //               .collection('customer_details')
  //               .doc(userdocid)
  //               .update({
  //             'state': 'offline',
  //             'lastseen': Timestamp.now(),
  //           });
  //           print("app in inactive");
  //           break;
  //         case AppLifecycleState.paused:
  //           FirebaseFirestore.instance
  //               .collection('customer_details')
  //               .doc(userdocid)
  //               .update({
  //             'state': 'offline',
  //             'lastseen': Timestamp.now(),
  //           });
  //           print("app in paused");
  //           break;
  //         case AppLifecycleState.detached:
  //           FirebaseFirestore.instance
  //               .collection('customer_details')
  //               .doc(userdocid)
  //               .update({
  //             'state': 'offline',
  //             'lastseen': Timestamp.now(),
  //           });
  //           print("app in detached");
  //           break;
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final fbm = FirebaseMessaging.instance;
    final fbmx = FirebaseMessaging.instance.getToken();

    fbm.subscribeToTopic('notify');
    fbm.subscribeToTopic('chat');
    fbm.subscribeToTopic('listing');

    fbm.onTokenRefresh;
    final size = MediaQuery.of(context).size;
    final hightx = size.height;
    final widthx = size.width;
    final useid = FirebaseAuth.instance.currentUser == null
        ? ''
        : FirebaseAuth.instance.currentUser!.uid;

    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    void initState() {
      super.initState();
      // FirebaseMessaging.instance
      //     .getInitialMessage()
      //     .then((RemoteMessage? message) {
      //   if (message != null) {
      //     Navigator.pushNamed(
      //       context, '/',
      //       //  arguments: MessageArguments(message, true)
      //     );
      //   }
      // });

      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   RemoteNotification? notification = message.notification;
      //   AndroidNotification? android = message.notification?.android;

      //   if (notification != null && android != null) {
      //     flutterLocalNotificationsPlugin.show(
      //         notification.hashCode,
      //         notification.title,
      //         notification.body,
      //         const NotificationDetails(
      //           android: AndroidNotificationDetails(
      //             'widget.id',
      //             'widget.storename',
      //             //  widget.description,
      //             // TODO add a proper drawable resource to android, for now using
      //             //      one that already exists in example app.
      //             icon: 'launch_background',
      //           ),
      //         ));
      //   }
      // });

      // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //   print('A new onMessageOpenedApp event was published!');
      //   Navigator.pushNamed(
      //     context, '/',
      //     //  arguments: MessageArguments(message, true)
      //   );
      // });
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 30,
              backgroundColor: Colors.grey,
            ),
            body:
// Center(
//             // Center is a layout widget. It takes a single child and positions it
//             // in the middle of the parent.
//             child:
                SingleChildScrollView(
                    child: Column(children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: SizedBox(
                      //   height: 100,
                      //   width: double.infinity,
                      child: Image.asset(
                'assets/alaqy.jpeg',
                fit: BoxFit.contain,
              ))),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontFamily: 'Tajawal', color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      //    color: Colors.white,
                      width: widthx,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 1,
                                    ),
                                    //width: 120,
                                    //  height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                          bottomLeft: Radius.circular(4),
                                          bottomRight: Radius.circular(4)),
                                      color: bus != true
                                          ? Color.fromARGB(226, 0, 0, 0)
                                          : Color.fromARGB(35, 158, 158, 158),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 2,
                                    ),
                                    child: Container(
                                        alignment: Alignment.center,
                                        //   width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          color: bus != true
                                              ? Color.fromARGB(226, 0, 0, 0)
                                              : Color.fromARGB(
                                                  34, 255, 255, 255),
                                        ),
                                        child: TextButton.icon(
                                            label:
//  Text(
//                                               '🏬',
//                                               style: TextStyle(
//                                                   // textBaseline:
//                                                   //     TextBaseline.alphabetic,
//                                                   // height: -0.01,
//                                                   fontSize: 12,
//                                                   //   fontStyle: FontStyle.italic,
//                                                   fontWeight: (bus == true) ? FontWeight.normal : FontWeight.bold,
//                                                   shadows: [
//                                                     Shadow(
//                                                         blurRadius: bus == false
//                                                             ? 3
//                                                             : 0)
//                                                   ]),
//                                             ),
                                                //   Icon(
                                                //   bus == true
                                                //     ? Icons.person_outline_rounded
                                                //     : Icons.person,
                                                // size: 27,
                                                SizedBox(
                                                    // height: 100,
                                                    // width: double.infinity,
                                                    child: Image.asset(
                                              'assets/alaqyzz.jpeg',
                                              fit: BoxFit.contain,
                                            )),
                                            icon: Text(
                                              ' حساب عميل',
                                              style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                  color: bus == true
                                                      ? Color.fromARGB(
                                                          184, 0, 0, 0)
                                                      : Colors.white,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  height: -0.01,
                                                  fontSize: 12,
                                                  //      fontStyle: FontStyle.italic,
                                                  fontWeight: (bus == true) ? FontWeight.normal : FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                        blurRadius: bus == false
                                                            ? 3
                                                            : 0)
                                                  ]),
                                            ),
                                            //        textColor: Theme.of(context).primaryColor,
                                            onPressed: () async {
                                              print('user');
                                              if (FirebaseAuth
                                                      .instance.currentUser !=
                                                  null) {
                                                final active =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'customer_details')
                                                        .where('second_uid',
                                                            isEqualTo:
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                        .get();
                                                final usid =
                                                    active.docs.isNotEmpty
                                                        ? active.docs.first.id
                                                        : 'none';
                                                active.docs.isNotEmpty
                                                    ? FirebaseFirestore.instance
                                                        .collection(
                                                            'customer_details')
                                                        .doc(usid)
                                                        .update(
                                                            {'activated': true})
                                                    : null;
                                              }
                                              setState(() {
                                                bus = false;
                                              });
                                              print(bus);

                                              //  Navigator.of(context).pushNamed(userChoose.routeName);
                                            }))),
                                //   const Text('او'),
                                const SizedBox(width: 9),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 1,
                                    ),
                                    //width: 120,
                                    //    height: 500,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                          bottomLeft: Radius.circular(4),
                                          bottomRight: Radius.circular(4)),
                                      color: bus == true
                                          ? Color.fromARGB(226, 0, 0, 0)
                                          : Color.fromARGB(35, 158, 158, 158),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 2,
                                    ),
                                    child: Container(
                                        alignment: Alignment.center,
                                        //   width: 120,
                                        //      height: 500,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          color: bus == true
                                              ? Color.fromARGB(226, 0, 0, 0)
                                              : Color.fromARGB(
                                                  34, 255, 255, 255),
                                        ),
                                        child: TextButton.icon(
                                          style: ButtonStyle(
                                            alignment: Alignment.center,
                                          ),
                                          label:
// Icon(
//                                             bus == false
//                                                 ? Icons
//                                                     .store_mall_directory_outlined //Icons.business_center_outlined
//                                                 : Icons.store_rounded,
//                                             color: Colors.redAccent,
//                                             size: 27,
//                                           ),
                                              SizedBox(
                                                  // height: 100,
                                                  // width: double.infinity,
                                                  child: Image.asset(
                                            'assets/alaqyz.jpeg',
                                            fit: BoxFit.contain,
                                          )),
                                          icon: Text(
                                            'حساب بيزنس',
                                            style: TextStyle(
                                                fontFamily: 'Tajawal',
                                                color: bus != true
                                                    ? Color.fromARGB(
                                                        184, 0, 0, 0)
                                                    : Colors.white,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                height: -0.01,
                                                fontSize: 12,
                                                //   fontStyle: FontStyle.italic,
                                                fontWeight: (bus == false) ? FontWeight.normal : FontWeight.bold,
                                                shadows: [
                                                  Shadow(
                                                      blurRadius:
                                                          bus == true ? 3 : 0)
                                                ]),
                                          ),
                                          //          textColor: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            // print(FirebaseAuth.instance.currentUser!.phoneNumber);
                                            // print(FirebaseAuth.instance.currentUser!.uid);
                                            // Navigator.of(context)
                                            //     .pushNamed(businessChoose.routeName);
                                            setState(() {
                                              bus = true;
                                            });
                                            print(bus);
                                          },
                                        ))),
                              ])))),
              // SizedBox(
              //   height: bus == true ? 1 : 23,
              // ),
              SizedBox(
                  height: hightx - 100,
                  child: bus == true
                      ? AuthScreenBusiness(
                          '', 'result.user!.uid', false, '', false)
                      : AuthScreenUser('', 'result.user!.uid', false, false)),
            ])))
//)
        ;
  }
}
