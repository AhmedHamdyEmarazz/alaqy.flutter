import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/app_drawer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'alaaqyProcess.dart';
import 'badge.dart';
import 'chat_screens.dart';
import 'listing.dart';
import 'main.dart';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'Searchprodtypeonly.dart';
// import 'bossmanageroverview.dart';
// import 'category.dart';
// import 'Listing.dart';
// import 'ordershistory.dart';
// import 'badge.dart';
// import 'cart_screen.dart';
// import 'categoriesscreen.dart';
// import 'categoryitem.dart';
// import 'package:provider/provider.dart';
// import 'app_drawer.dart';
// import 'cart.dart';
// import 'categories.dart';
//int id = 0;

// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });

//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }

// String? selectedNotificationPayload;

// /// A notification action which triggers a url launch event
// const String urlLaunchActionId = 'id_1';

// /// A notification action which triggers a App navigation event
// const String navigationActionId = 'id_3';

// /// Defines a iOS/MacOS notification category for text input actions.
// const String darwinNotificationCategoryText = 'textCategory';

// /// Defines a iOS/MacOS notification category for plain actions.
// const String darwinNotificationCategoryPlain = 'plainCategory';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
//     StreamController<ReceivedNotification>.broadcast();

// final StreamController<String?> selectNotificationStream =
//     StreamController<String?>.broadcast();
// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

// const String portName = 'notification_send_port';
// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
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

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//           FlutterLocalNotificationsPlugin();
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;

//       // if (notification != null && android != null) {
//       //   flutterLocalNotificationsPlugin.show(
//       //       notification.hashCode,
//       //       notification.title,
//       //       notification.body,
//       //       const NotificationDetails(
//       //         android: AndroidNotificationDetails(
//       //           playSound: true, enableLights: true, priority: Priority.high,
//       //           'widget.id',
//       //           'widget.storename',
//       //           //  widget.description,
//       //           // TODO add a proper drawable resource to android, for now using
//       //           //      one that already exists in example app.
//       //           icon: 'launch_background',
//       //         ),
//       //       ));
//       // }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       // Navigator.pushNamed(
//       //   context, '/',
//       //   //  arguments: MessageArguments(message, true)
//       // );
//     });
//     print('Got a message whilst in the foreground!');
//     print('Message data: ${message.data}');

//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//     }
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

class UserMain extends StatefulWidget {
  static const routeName = '/UserMain';
  final String idx;
  const UserMain(this.idx, {super.key});
  @override
  UserMainState createState() => UserMainState();
}

class UserMainState extends State<UserMain> {
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 1;
  int _selectedPageIndexx = 0;

  final usex = FirebaseAuth.instance.currentUser == null
      ? ''
      : FirebaseAuth.instance.currentUser!.uid;
  dynamic badgoo;
  dynamic bag = 0;
  String? stop;
  bool stopp = false;
  bool slip = true;

  int iz = 0;
  dynamic turtlezz;
  dynamic titlemega;
  dynamic bodymega;
  dynamic busid2;
  dynamic username;
  dynamic store_name;
  dynamic busid;
  dynamic cusid;
  dynamic basicstore_name;
  dynamic basicusername;
  dynamic turtleFu;
  String? mtoken = '';
  final fbm = FirebaseMessaging.instance;

  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    _pages = [
      {
        'page': Listing(), //
        'title': 'منشورات سابقة',
      },
      {
        'page': AlaaqyProcess(), //
        'title': 'ألاقي عندك',
      },
    ];
    super.initState();

    requestpermission();
    getToken();
    initInfo();
    saveToken('token');
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}

  initInfo() async {
    var androidinitialize = const AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationsettings = InitializationSettings(
      android: androidinitialize,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(initializationsettings,
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse? payload) async {
      try {
        if (payload != null && payload.toString().isNotEmpty) {
        } else {}
      } catch (e) {}
      return;
    });
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert:
          true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge:
          true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound:
          true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      //   sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
      //   badgeNumber: int?, // The application's icon badge number
      //   attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
      //   subtitle: String?, //Secondary description  (only from iOS 10 onwards)
      //  threadIdentifier: String? (only from iOS 10 onwards)
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
        12345,
        "A Notification From My Application",
        "This notification was sent using Flutter Local Notifcations Package",
        platformChannelSpecifics,
        payload: 'data');
  }
//     // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     //   // for (var r = id; id == 0; r--) {
//     //   //   id--;
//     //   //   print('$id wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
//     //   // }

//     //   print('on  message');
//     //   print(
//     //       'onmessage:${message.notification!.title}/${message.notification!.body}');
//     //   BigTextStyleInformation bigtextstyleinformation = BigTextStyleInformation(
//     //     message.notification!.body.toString(),
//     //     htmlFormatBigText: true,
//     //     contentTitle: message.notification!.title.toString(),
//     //     htmlFormatContentTitle: true,
//     //   );
//     //   AndroidNotificationDetails androidplatformchannelspecifies =
//     //       AndroidNotificationDetails(
//     //     'your channel id',
//     //     'your channel name',
//     //     importance: Importance.max,
//     //     styleInformation: bigtextstyleinformation,
//     //     priority: Priority.max,
//     //     playSound: true,
//     //   );
//     //   NotificationDetails platformchannelspecifies = NotificationDetails(
//     //     android: androidplatformchannelspecifies,
//     //   );
//     //   //   sendpushnotification(
//     //   //     mtoken!, message.notification!.body!, message.notification!.title!);
//     //   // final lord = await FirebaseFirestore.instance
//     //   //     .collection('customer_details')
//     //   //     .where('second_uid',
//     //   //         isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//     //   //     .get();
//     //   // final balaha = lord.docs.first.data()['username'];
//     //   // message.notification!.title != balaha
//     //   //    ?

//     //   print('$id xxxxxxxxxxxxxxxxxxxzzzzzzzzzxxxxxxx');

//     //   //   if (id < 1) {

//     //   // await flutterLocalNotificationsPlugin.show(
//     //   //     id++,
//     //   //     message.notification!.title,
//     //   //     message.notification!.body,
//     //   //     platformchannelspecifies,
//     //   //     payload: message.data.toString());
//     //   //    }
//     //   // if (id >= 1) {
//     //   //   await flutterLocalNotificationsPlugin.show(
//     //   //       id++,
//     //   //       message.notification!.title,
//     //   //       message.notification!.body,
//     //   //       platformchannelspecifies,
//     //   //       payload: message.data['body']);
//     //   //   flutterLocalNotificationsPlugin.cancel(--id);
//     //   // }

//     //   //  await flutterLocalNotificationsPlugin.cancel(--id);
//     //   //  }
//     //   //  if (id.isEven) {
//     //   //   await flutterLocalNotificationsPlugin.show(
//     //   //       id++,
//     //   //       message.notification!.title,
//     //   //       message.notification!.body,
//     //   //       platformchannelspecifies,
//     //   //       payload: message.data['body']);
//     //   // }
//     // });
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
//   initInfo() {
//     var androidinitialize =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
// //var iosinitialize = const IOSFlutterLocalNotificationsPlugin().initialize(initializationSettings)
//     var initializationsettings =
//         InitializationSettings(android: androidinitialize);
//     flutterLocalNotificationsPlugin.initialize(initializationsettings,
//         onDidReceiveBackgroundNotificationResponse:
//             (NotificationResponse? payload) async {
//       try {
//         if (payload != null && payload.toString().isNotEmpty) {
//         } else {}
//       } catch (e) {}
//       return;
//     });
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
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
//         'dbfood',
//         'dbfood',
//         importance: Importance.max,
//         styleInformation: bigtextstyleinformation,
//         priority: Priority.max,
//         playSound: true,
//       );
//       NotificationDetails platformchannelspecifies = NotificationDetails(
//         android: androidplatformchannelspecifies,
//       );
//       await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
//           message.notification!.body, platformchannelspecifies,
//           payload: message.data['body']);
//     });
//   }

  // void saveToken(String token) async {
  //   final lord = await FirebaseFirestore.instance
  //       .collection('customer_details')
  //       .where('second_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   final balaha = lord.docs.first.data()['first_uid'];
  //   print(balaha);
  //   await FirebaseFirestore.instance
  //       .collection('customer_details')
  //       .doc(balaha)
  //       .collection('tokens')
  //       .doc(token)
  //       .set({
  //     'createdAt': Timestamp.now(),
  //     'platform': Platform.operatingSystem.toString(),
  //     'registrationTokens': token,
  //   });
  // }

  // void requestpermission() async {
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
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('user granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('user granted provisional permission');
  //   } else {
  //     print('user declined');
  //   }
  // }

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       mtoken = token;
  //       print('my token is $mtoken');
  //     });
  //     saveToken(token!);
  //   });
  // }

  void _selectPage(int index) async {
    // if (_selectedPageIndex == 0) {
    //   final useri = await FirebaseFirestore.instance
    //       .collection('customer_details')
    //       .where('second_uid', isEqualTo: userx)
    //       .get();
    //   final idx = useri.docs.first.id;
    //   final sen = useri.docs.first.data()['sent'];
    //   FirebaseFirestore.instance
    //       .collection('customer_details')
    //       .doc(idx)
    //       .update({'seen': sen});
    // }
    setState(() {
      _selectedPageIndex = index;
      _selectedPageIndexx = index;
    });
  }

  final userx = FirebaseAuth.instance.currentUser!.uid;
  void _selectPagee() async {
    final newidea = await FirebaseFirestore.instance
        .collection('listing')
        .where('userid2', isEqualTo: userx)
        .where('closed', isEqualTo: false)
        .get();
    List seens = [];
    List sents = [];

    for (var x = 0; x < newidea.docs.length; x++) {
      sents.add(newidea.docs[x].data()['sent']);
      seens.add(newidea.docs[x].data()['seen']);
    }
    const initialValue = 0.0;

    final seensx = seens.fold(
        initialValue, (previousValue, element) => previousValue + element);
    final sentsx = sents.fold(
        initialValue, (previousValue, element) => previousValue + element);
    final seezz = int.tryParse(seensx.toString());
    final useri = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('second_uid', isEqualTo: userx)
        .get();
    final idx = useri.docs.isNotEmpty ? useri.docs.first.id : '';
    useri.docs.isNotEmpty
        ? FirebaseFirestore.instance
            .collection('customer_details')
            .doc(idx)
            .update({'seen': seensx, 'sent': sentsx})
        : null;
  }

  void routex(listid, busid2x, username, storename, busidx, useridx,
      basicstorename, basicusername) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => ChatScreens(listid, username, storename, 'customer',
            busidx, busid2x, useridx, basicstorename, basicusername)));
  }

  void businessstuff(turtleF, turtlezF) async {
    final listdetails = await FirebaseFirestore.instance
        .collection('listing')
        .doc(turtlezF.toString())
        .get();
    final cusidx = listdetails.data()!['userid'];
    final usernamex = listdetails.data()!['username'];
    final basicusernamex = listdetails.data()!['basicemail'];
    final store_messages = listdetails.data()!['${basicstore_name}messages'];
    final store_messagesseen =
        listdetails.data()!['${basicstore_name}messagesseen'];
    final messbaqy = store_messages - store_messagesseen;

    final messages_seen = listdetails.data()!['messages_seen'];
    final sent = listdetails.data()!['sent'];
    final seen = listdetails.data()!['seen'];
    final sentminseen = sent - seen;
    final busdetails = await FirebaseFirestore.instance
        .collection('business_details')
        .doc(turtleF)
        .get();

    final store_namex = busdetails.data()!['store_name'];
    final basicstore_namex = busdetails.data()!['basicstore_name'];
    final busid2x = busdetails.data()!['second_uid'];
    await FirebaseFirestore.instance
        .collection('listing')
        .doc(turtlezF.toString())
        .update({
      'seen': sentminseen == 0 ? seen : seen + messbaqy,
      'messages_seen': messages_seen + messbaqy,
      '${basicstore_name}messagesseen': store_messages
    });
  }

  Future<void> _showNotificationx(titlemegaxx, bodymegaxx) async {
    // setState(() {
    //   stopp = true;
    // });
    // flutterLocalNotificationsPlugin.cancelAll();

    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('لا اله الا الله محمد رسول الله');
    // print(message.notification!.title);
    final titlex = await FirebaseFirestore.instance
        .collection('notify')
        .where('store_name', isEqualTo: titlemegaxx)
        .get();
    final turtle = titlex.docs.last.data()['businessid'];
    final trid = titlex.docs.last.id;

    turtle == 'allorders'
        ? setState(() {
            stop = 'allorders';
          })
        // : turtle == 'found'
        //     ? setState(() {
        //         stop = 'found';
        //       })
        : setState(() {
            stop = 'updatebusiness';
          });
    final turtlez = titlex.docs.last.data()['listid'];

    if (turtle != 'allorders') {
      //    final turtle = titlex.docs.last.data()['businessid'];

      final busdocs = await FirebaseFirestore.instance
          .collection('business_details')
          .where('second_uid',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      final busdoc = busdocs.docs.first;
      final basistoname = busdoc.data()['basicstore_name'];
      final targ = await FirebaseFirestore.instance
          .collection('listing')
          .doc(turtlez.toString())
          .get();
      final cusidx = targ.data()!['userid'];
      final usernamex = targ.data()!['username'];
      final basicusernamex = targ.data()!['basicemail'];
      final busid2x = FirebaseAuth.instance.currentUser!.uid;

      setState(() {
        turtlezz = turtlez.toString();
        cusid = cusidx;
        username = usernamex;
        basicusername = basicusernamex;
        store_name = titlemegaxx;
        basicstore_name = basistoname;
        busid2 = FirebaseAuth.instance.currentUser!.uid;
        busid = busdoc.id;
      });
    } else {
      setState(() {
        turtlezz = turtlez.toString();
        // cusid = cusidx;
        // username = usernamex;
        // basicusername = basicusernamex;
        // store_name = message.notification!.title;
        // basicstore_name = basistoname;
        busid2 = FirebaseAuth.instance.currentUser!.uid;
        // busid = busdoc.id;
      });
    }
    // setState(() {
    //   titlemega = message.notification!.title;
    //   bodymega = message.notification!.body;
    //   stopp = true;
    // });
    //  });
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Default channel', 'Default channel',
            channelDescription: 'Default channel',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert:
          true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge:
          true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound:
          true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      //   sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
      //   badgeNumber: int?, // The application's icon badge number
      //   attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
      //   subtitle: String?, //Secondary description  (only from iOS 10 onwards)
      //  threadIdentifier: String? (only from iOS 10 onwards)
    );
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        id++, titlemegaxx, bodymegaxx, notificationDetails,
        payload: 'item y');
    print(titlemegaxx);
    print(bodymegaxx);
  }

  void sendpushnotification(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'content-type': 'aplication/json',
          'Authorization':
              'key=AAAAYkVGhz8:APA91bE75B-XzSXGRP9xJ6M1Ljg7CavQe_No8g705E0XlPp1Q_QwCQ1T9o_9wjHChsWR5fpzQ1YlQ2l5D8STZGmJf9gcVuj4jRtf9lkWji79QmqOW_fwy6hg__twEGiBbooIidoVMaw-'
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'Flutter_Notification_Click',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            //     "android_channel_id": "Default channel",
          },
          "to": token,
        }),
      );
      print("herexxx push notification");
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
    print(token);
  }

  void sendpushnotificationx() async {
    setState(() {
      stopp = true;
      slip = false;
    });
    flutterLocalNotificationsPlugin.cancelAll();
    print('لا اله الا الله محمد رسول الله');
    //  print(message.notification!.title);
    final busstart = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('second_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final titlex = await FirebaseFirestore.instance
        .collection('notify')
        .where('target', isEqualTo: busstart.docs.first.id)
        .get();
    final turtle = titlex.docs.last.data()['businessid'];
    final tok = titlex.docs.last.data()['tok'];

    final turtlez = titlex.docs.last.data()['listid'];
    final titlemegax = titlex.docs.last.data()['store_name'];
    final bodymegax = titlex.docs.last.data()['text'];
    print(turtle);
    print('7777777777777777777777777777777777777777');

    turtle == 'listing'
        ? setState(() {
            stop = 'listing';
          })
        : setState(() {
            stop = 'UpdateUser';
          });
    if (turtle != 'listing') {
      final listdetails = await FirebaseFirestore.instance
          .collection('listing')
          .doc(turtlez.toString())
          .get();
      final cusidx = listdetails.data()!['userid'];
      final usernamex = listdetails.data()!['username'];
      final basicusernamex = listdetails.data()!['basicemail'];
      print('88888888888888888888888888888888888888888');

      final busdetails = await FirebaseFirestore.instance
          .collection('business_details')
          .doc(turtle)
          .get();
      final store_namex = titlex.docs.last.data()['store_name'];
      final basicstore_namex = busdetails.data()!['basicstore_name'];
      final busid2x = busdetails.data()!['second_uid'];
      print('9999999999999999999999990999999999');

      setState(() {
        turtlezz = turtlez.toString();
        cusid = cusidx;
        username = usernamex;
        basicusername = basicusernamex;
        store_name = store_namex;
        basicstore_name = basicstore_namex;
        busid2 = busid2x;
        turtleFu = turtle;
      });
    } else {
      setState(() {
        turtlezz = turtlez.toString();
        turtleFu = turtle;
      });
    }
    // setState(() {
    //   titlemega = message.notification!.title;
    //   bodymega = message.notification!.body;
    //   stopp = true;
    // });
    // });
    final List<String> tokenxk = [];

    for (var km = 0; km < titlex.docs.length; km++) {
      tokenxk.add(titlex.docs[km].id);
      print(tokenxk);
      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      FirebaseFirestore.instance.collection('notify').doc(tokenxk[km]).delete();
    }
    //     Future.delayed(const Duration(seconds: 10), (() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'content-type': 'aplication/json',
          'Authorization':
              'key=AAAAYkVGhz8:APA91bE75B-XzSXGRP9xJ6M1Ljg7CavQe_No8g705E0XlPp1Q_QwCQ1T9o_9wjHChsWR5fpzQ1YlQ2l5D8STZGmJf9gcVuj4jRtf9lkWji79QmqOW_fwy6hg__twEGiBbooIidoVMaw-'
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'Flutter_Notification_Click',
            'status': 'done',
            'body': bodymegax,
            'title': titlemegax,
          },
          "notification": <String, dynamic>{
            "title": titlemegax,
            "body": bodymegax,
            //     "android_channel_id": "Default channel",
          },
          "to": tok,
        }),
      );
      print("herexxx push notification");
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
    //    }));
    //  print(token);
    //   print(titlemega);
    // flutterLocalNotificationsPlugin.cancelAll();
    // _showNotificationx(titlemega, bodymega);
    Future.delayed(const Duration(seconds: 7), (() {
      setState(() {
        stopp = false;
        slip = true;
        iz = 0;
      });
    }));
  }

  onSelectNotification(NotificationResponse notificationResponse) async {
    print('قل اعوذ برب الفلق');
    //     var payloadData = jsonDecode(notificationResponse.payload!);
    print('قل اعوذ برب الناس');

    //print("payload $payload");
    //   selectedNotificationPayload
    if (selectedNotificationPayload.toString() == 'item x') {
      RestartWidget.restartApp(context);
    } else if (stop != 'listing') {
      businessstuff(turtleFu, turtlezz);
    }

    stop == 'listing'
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const UserMain('zero')))
        : routex(turtlezz, busid2, username, store_name, turtleFu, cusid,
            basicstore_name, basicusername);
    print("ccccccccccccccccccccccccc");
// flutterLocalNotificationsPlugin.cancel(--id);

    flutterLocalNotificationsPlugin.cancelAll();
  }

  void begin() async {
    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    var details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details!.didNotificationLaunchApp) {
      print(details.notificationResponse!.payload);
      print('zazazazazaza');
    }
  }

  onDidReceiveLocalNotificationn(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           // Navigator.of(context, rootNavigator: true).pop();
    //           // await Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(
    //           //     builder: (context) =>   SecondScreen(payload),
    //           //   ),
    //           // );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  Future<void> _showNotification() async {
    setState(() {
      stopp = true;
      slip = false;
    });
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin.cancelAll();
    } else if (Platform.isIOS) {
      null;
    }
    // flutterLocalNotificationsPlugin.cancelAll();
    print('لا اله الا الله محمد رسول الله');
    //  print(message.notification!.title);
    final busstart = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('second_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final titlex = await FirebaseFirestore.instance
        .collection('notify')
        .where('target', isEqualTo: busstart.docs.first.id)
        .get();
    final turtle = titlex.docs.last.data()['businessid'];
    final tok = titlex.docs.last.data()['tok'];

    final turtlez = titlex.docs.last.data()['listid'];
    final titlemegax = titlex.docs.last.data()['store_name'];
    final bodymegax = titlex.docs.last.data()['text'];
    print(turtle);
    print('7777777777777777777777777777777777777777');

    turtle == 'listing'
        ? setState(() {
            stop = 'listing';
          })
        : setState(() {
            stop = 'UpdateUser';
          });
    if (turtle != 'listing') {
      final listdetails = await FirebaseFirestore.instance
          .collection('listing')
          .doc(turtlez.toString())
          .get();
      final cusidx = listdetails.data()!['userid'];
      final usernamex = listdetails.data()!['username'];
      final basicusernamex = listdetails.data()!['basicemail'];

      final busdetails = await FirebaseFirestore.instance
          .collection('business_details')
          .doc(turtle)
          .get();
      final store_namex = titlex.docs.last.data()['store_name'];
      final basicstore_namex = busdetails.data()!['basicstore_name'];
      final busid2x = busdetails.data()!['second_uid'];

      setState(() {
        turtlezz = turtlez.toString();
        cusid = cusidx;
        username = usernamex;
        basicusername = basicusernamex;
        store_name = store_namex;
        basicstore_name = basicstore_namex;
        busid2 = busid2x;
        turtleFu = turtle;
      });
    } else {
      setState(() {
        turtlezz = turtlez.toString();
        turtleFu = turtle;
      });
    }
    // setState(() {
    //   titlemega = message.notification!.title;
    //   bodymega = message.notification!.body;
    //   stopp = true;
    // });
    // });
    final List<String> tokenxk = [];

    for (var km = 0; km < titlex.docs.length; km++) {
      tokenxk.add(titlex.docs[km].id);
      //   print(tokenxk);
      // print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      FirebaseFirestore.instance.collection('notify').doc(tokenxk[km]).delete();
    }
    var initializationSettingsAndroid =
        new AndroidInitializationSettings("app_icon");
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    // var initializationSettingsIOS = new IOSInitializationSettings(
    //     requestAlertPermission: false,
    //     requestBadgePermission: false,
    //     requestSoundPermission: false,
    //     onDidReceiveLocalNotification:
    //         (int? id, String? title, String? body, String? payload) async {});

    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification,
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert:
          true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge:
          true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound:
          true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      //   sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
      //   badgeNumber: int?, // The application's icon badge number
      //   attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
      //   subtitle: String?, //Secondary description  (only from iOS 10 onwards)
      //  threadIdentifier: String? (only from iOS 10 onwards)
    );
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Default channel', 'Default channel',
            channelDescription: 'Default channel',
            icon: "app_icon",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSPlatformChannelSpecifics);
    // ReceivedNotification(
    //     id: id, title: titlemegax, body: bodymegax, payload: 'item y');

    await flutterLocalNotificationsPlugin.show(
        id++, titlemegax, bodymegax, notificationDetails,
        payload: 'item y');
    //     sendpushnotification(tok, bodymegax, '{$titlemegax}xxx');

    print(titlemega);
    // flutterLocalNotificationsPlugin.cancelAll();
    // _showNotificationx(titlemega, bodymega);
    Future.delayed(const Duration(seconds: 7), (() {
      setState(() {
        stopp = false;
        slip = true;
        iz = 0;
      });
    }));
  }

  // Future<void> _startForegroundService() async {
  //   print('البللللم');
  //   var idxx = 0;
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('Default channel', 'Default channel',
  //           channelDescription: 'your channel description',
  //           icon: "mipmap/ic_launcher",
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.show(idxx++, 'alaqy', 'welcome',
  //           notificationDetails: androidNotificationDetails, payload: 'item x');
  // }

  @override
  Widget build(BuildContext context) {
    // _startForegroundService();
    begin();
    final size = MediaQuery.of(context).size;
    final hightx = size.height;
    final userxc = FirebaseAuth.instance.currentUser!.uid;

    // fbm.subscribeToTopic('chat');
    // fbm.subscribeToTopic('listing');
    // fbm.subscribeToTopic('notify');

    // fbm.onTokenRefresh;

    // if (stopp == false) {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   //  flutterLocalNotificationsPlugin.cancelAll()
    //   setState(() {
    //     slip = true;
    //   });
    //   print(message.notification!.title);
    //   final titlex = await FirebaseFirestore.instance
    //       .collection('notify')
    //       .where('store_name', isEqualTo: message.notification!.title)
    //       .get();
    //   final turtle = titlex.docs.last.data()['businessid'];
    //   final turtlez = titlex.docs.last.data()['listid'];

    //   turtle == 'listing'
    //       ? setState(() {
    //           stop = 'listing';
    //         })
    //       : setState(() {
    //           stop = 'UpdateUser';
    //         });
    //   if (turtle != 'listing') {
    //     final listdetails = await FirebaseFirestore.instance
    //         .collection('listing')
    //         .doc(turtlez.toString())
    //         .get();
    //     final cusidx = listdetails.data()!['userid'];
    //     final usernamex = listdetails.data()!['username'];
    //     final basicusernamex = listdetails.data()!['basicemail'];

    //     final busdetails = await FirebaseFirestore.instance
    //         .collection('business_details')
    //         .doc(turtle)
    //         .get();
    //     final store_namex = message.notification!.title;
    //     final basicstore_namex = busdetails.data()!['basicstore_name'];
    //     final busid2x = busdetails.data()!['second_uid'];

    //     setState(() {
    //       turtlezz = turtlez.toString();
    //       cusid = cusidx;
    //       username = usernamex;
    //       basicusername = basicusernamex;
    //       store_name = store_namex;
    //       basicstore_name = basicstore_namex;
    //       busid2 = busid2x;
    //       turtleFu = turtle;
    //     });
    //   } else {
    //     setState(() {
    //       turtlezz = turtlez.toString();
    //       turtleFu = turtle;
    //     });
    //   }
    //   setState(() {
    //     titlemega = message.notification!.title;
    //     bodymega = message.notification!.body;
    //     stopp = true;
    //   });
    //   print(turtle);
    //   print(id);
    //   print("تسقط البلحة");

    //   // if (id > 1) {
    //   //   for (var r = id; id == 1; r--) {
    //   //     setState(() async {
    //   //       await flutterLocalNotificationsPlugin.cancel(--id);
    //   //     });
    //   //   }
    //   //   setState(() {
    //   //     id = 0;
    //   //   });
    //   //   print(id);
    //   // }
    //   final List<String> tokenxk = [];
    //   for (var km = 0; km < titlex.docs.length; km++) {
    //     tokenxk.add(titlex.docs[km].id);
    //     // print(tokenxk);
    //     // print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    //     FirebaseFirestore.instance
    //         .collection('notify')
    //         .doc(tokenxk[km])
    //         .delete();
    //   }
    // });

    return FirebaseNotificationsHandler(
        onOpenNotificationArrive: (navigatorKey, payload) async {
          slip == true ? _showNotification() : print(' xxانا اللهو الخفي');
          print(iz);
          print('hamas');
        },
        onTap: (navigatorKey, appState, payload) async {
          print(
              "XXXXXXXXxxxxxxxxxxxxNotification tapped with $appState & payload $payload");
          setState(() {
            stopp = true;
            slip = false;
          });
          // flutterLocalNotificationsPlugin.cancelAll();
          print('لا اله الا الله محمد رسول الله');
          //  print(message.notification!.title);
          final busstart = await FirebaseFirestore.instance
              .collection('customer_details')
              .where('second_uid',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();
          final titlex = await FirebaseFirestore.instance
              .collection('notify')
              .where('target', isEqualTo: busstart.docs.first.id)
              .get();
          final turtle = titlex.docs.last.data()['businessid'];
          final tok = titlex.docs.last.data()['tok'];

          final turtlez = titlex.docs.last.data()['listid'];
          final titlemegax = titlex.docs.last.data()['store_name'];
          final bodymegax = titlex.docs.last.data()['text'];
          print(turtle);
          print('7777777777777777777777777777777777777777');

          turtle == 'listing'
              ? setState(() {
                  stop = 'listing';
                })
              : setState(() {
                  stop = 'UpdateUser';
                });
          if (turtle != 'listing') {
            final listdetails = await FirebaseFirestore.instance
                .collection('listing')
                .doc(turtlez.toString())
                .get();
            final cusidx = listdetails.data()!['userid'];
            final usernamex = listdetails.data()!['username'];
            final basicusernamex = listdetails.data()!['basicemail'];

            final busdetails = await FirebaseFirestore.instance
                .collection('business_details')
                .doc(turtle)
                .get();
            final store_namex = titlex.docs.last.data()['store_name'];
            final basicstore_namex = busdetails.data()!['basicstore_name'];
            final busid2x = busdetails.data()!['second_uid'];

            setState(() {
              turtlezz = turtlez.toString();
              cusid = cusidx;
              username = usernamex;
              basicusername = basicusernamex;
              store_name = store_namex;
              basicstore_name = basicstore_namex;
              busid2 = busid2x;
              turtleFu = turtle;
            });
          } else {
            setState(() {
              turtlezz = turtlez.toString();
              turtleFu = turtle;
            });
          }
          // setState(() {
          //   titlemega = message.notification!.title;
          //   bodymega = message.notification!.body;
          //   stopp = true;
          // });
          // });
          final List<String> tokenxk = [];

          for (var km = 0; km < titlex.docs.length; km++) {
            tokenxk.add(titlex.docs[km].id);
            // print(tokenxk);
            // print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
            FirebaseFirestore.instance
                .collection('notify')
                .doc(tokenxk[km])
                .delete();
          }
          Future.delayed(const Duration(seconds: 7), (() {
            setState(() {
              stopp = false;
              slip = true;
              iz = 0;
            });
          }));
          if (selectedNotificationPayload.toString() == 'item x') {
            RestartWidget.restartApp(context);
          } else if (stop != 'listing') {
            businessstuff(turtleFu, turtlezz);
          }

          stop == 'listing'
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const UserMain('zero')))
              : routex(turtlezz, busid2, username, store_name, turtleFu, cusid,
                  basicstore_name, basicusername);
          print("ccccccccccccccccccccccccc");
// flutterLocalNotificationsPlugin.cancel(--id);
          flutterLocalNotificationsPlugin.cancelAll();
        },
        channelName: 'Default channel',
        channelId: 'Default channel',
        enableLogs: true,
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 252, 250, 250),
              foregroundColor: Colors.black,
              centerTitle: true,
              toolbarHeight: 135,
              title: Container(
                  padding: const EdgeInsets.only(
                    right: 50,
                    //    horizontal: 30,
                  ),
                  child: Column(children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      widget.idx == 'none'
                          ? _pages![_selectedPageIndex]['title'].toString()
                          : _pages![_selectedPageIndexx]['title'].toString(),
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          //   RestartWidget.restartApp(context);
                        },
                        child: Center(
                            child: SizedBox(
                                //   height: 100,
                                //   width: double.infinity,
                                child: Image.asset(
                          'assets/alaqy.jpeg',
                          fit: BoxFit.contain,
                        )))),
                    SizedBox(
                      height: 25,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          '',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.cyanAccent,
                            overflow: TextOverflow.visible,
                          ),
                          speed: const Duration(seconds: 2),
                        )
                      ],
                      totalRepeatCount: 2,
                      // repeatForever: true,
                      onNext: (p0, p1) {
                        begin();
                      },
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          '  ',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.cyanAccent,
                            overflow: TextOverflow.visible,
                          ),
                          speed: const Duration(seconds: 2),
                        )
                      ],
                      // totalRepeatCount: 2,
                      repeatForever: true,
                      onNext: (p0, p1) {
                        //   setState(() {
                        _selectPagee();
                        //    });

                        //   _selectPagee();
                      },
                    ),
                  ])),
              actions: [
                // DropdownButton(
                //   underline: Container(),
                //   icon: Icon(
                //     Icons.more_vert,
                //     color: Theme.of(context).primaryIconTheme.color,
                //   ),
                //   items: [
                //     DropdownMenuItem(
                //       value: 'logout',
                //       child: Container(
                //         child: Row(
                //           children: const <Widget>[
                //             Icon(Icons.exit_to_app),
                //             SizedBox(width: 8),
                //             Text('Logout'),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                //   onChanged: (itemIdentifier) {
                //     if (itemIdentifier == 'logout') {
                //       FirebaseAuth.instance.signOut();
                //       Navigator.of(context).pushReplacementNamed('/');
                //     }
                //   },
                // )
              ]),
          //  drawer: AppDrawer(),
          body: widget.idx == 'none'
              ? _pages![_selectedPageIndex]['page'] as Widget
              : _pages![_selectedPageIndexx]['page'] as Widget,
          bottomNavigationBar: BottomNavigationBar(
            //   backgroundColor: Color.fromARGB(255, 226, 219, 157),
            elevation: 0,
            onTap: _selectPage,
            enableFeedback: true,
            backgroundColor: Color.fromARGB(255, 252, 250, 250),
            unselectedItemColor: Colors.grey.shade400,
            selectedItemColor: Colors.black,
            selectedLabelStyle: TextStyle(
              fontFamily: 'Tajawal',
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Tajawal',
            ),
            currentIndex:
                widget.idx == 'none' ? _selectedPageIndex : _selectedPageIndexx,
            // type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('customer_details')
                        .where('second_uid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        // .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(fontSize: 2),
                          ),
                        );
                      }
                      final chatDocs =
                          userSnapshot.hasData ? userSnapshot.data : null;

                      if (userSnapshot.hasData == true) {
                        final badgo1 = chatDocs!.docs.first.data()['sent'];
                        final badgo2 = chatDocs.docs.first.data()['seen'];

                        badgoo = (badgo1 - badgo2).toString();
                        bag = double.tryParse(badgoo);
                      }
                      print(bag);
                      return bag != 0.0
                          ? Badgee(
                              value: badgoo.toString().split('.').first,
                              color: const Color.fromARGB(176, 244, 67, 54),
                              child: const Icon(Icons.history_edu_outlined),
                            )
                          : const Icon(Icons.history_edu_outlined);
                    }),
                label: 'منشورات سابقة',
              ),
              const BottomNavigationBarItem(
                //       backgroundColor: Color.fromARGB(255, 226, 219, 157),
                icon: Icon(Icons.search),
                label: 'ألاقي عندك',
              ),
            ],
          ),
        ));
  }
}
