import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/alaqyform.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

// int id = 0;

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
// // Navigator.of(context).pushNamed(UpdateBusiness.routeName);
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

class AlaaqyProcess extends StatefulWidget {
  static const routeName = '/AlaaqyProcess';

  @override
  State<AlaaqyProcess> createState() => _AlaaqyProcessState();
}

class _AlaaqyProcessState extends State<AlaaqyProcess> {
  bool isLoading = false;
  dynamic idz;
  dynamic idzcity;
//  dynamic idzarea;
  dynamic idzcategory;
  final userx = FirebaseAuth.instance.currentUser!.uid;
  void _selectPage() async {
    print(userx);

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
    //  print(userx);
    final idx = useri.docs.isNotEmpty ? useri.docs.first.id : '';
    useri.docs.isNotEmpty
        ? FirebaseFirestore.instance
            .collection('customer_details')
            .doc(idx)
            .update({'seen': seensx, 'sent': sentsx})
        : null;
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
            //    "android_channel_id": "Default channel",
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

  // @pragma('vm:entry-point')
  // Future<void> _showNotification(
  //     String token, String body, String title) async {
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
  //           "android_channel_id": "your channel id",
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
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //       print('A new onMessageOpenedApp event was published!');
  //       // Navigator.pushNamed(
  //       //   context, '/',
  //       //   //  arguments: MessageArguments(message, true)
  //       // );
  //       Navigator.of(context).pushNamed(UpdateBusiness.routeName);
  //     });
  //     FirebaseMessaging.instance
  //         .getInitialMessage()
  //         .then((RemoteMessage? message) {
  //       if (message != null) {
  //         Navigator.pushNamed(
  //           context, '/updateBusiness',
  //           //    arguments: MessageArguments(message, true)
  //         );
  //         //   Navigator.of(context).pushNamed(UpdateBusiness.routeName);
  //       }
  //     });
  //     const AndroidNotificationDetails androidNotificationDetails =
  //         AndroidNotificationDetails('your channel id', 'your channel name',
  //             channelDescription: 'your channel description',
  //             importance: Importance.max,
  //             priority: Priority.high,
  //             ticker: 'ticker');
  //     const NotificationDetails notificationDetails =
  //         NotificationDetails(android: androidNotificationDetails);
  //     // await flutterLocalNotificationsPlugin.show(
  //     //     id++, title, body, notificationDetails,
  //     //     payload: message.data['body']);
  //   });
  // }

  // @pragma('vm:entry-point')
  // Future<void> _cancelAllNotifications() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }

  // @pragma('vm:entry-point')
  // Future<void> _deleteNotificationChannel() async {
  //   const String channelId = 'your channel id';
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.deleteNotificationChannel(channelId);
  // }

  void _submitAuthForm(
    String title,
    String description,
    String category,
    String city,
    //  String area,
    dynamic image,
  ) async {
    final url;
    final userid = FirebaseAuth.instance.currentUser!.uid;

    print(userid);
    final userdoc = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('second_uid', isEqualTo: userid)
        .get();
    final docid = userdoc.docs.first.id;
    final usernamex = userdoc.docs.first.data()['username'];
    final basicusernamex = userdoc.docs.first.data()['basicemail'];

    final username = usernamex.toString().split('@').first;
    final basicusername = basicusernamex.toString().split('@').first;

    const useriamge =
        'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169';
    setState(() {
      isLoading = true;
    });

    final getlength = await FirebaseFirestore.instance
        .collection('listing')
        .orderBy(
          'createdAt',
        )
        .get();
    var length = getlength.docs.length;

    final indexx = getlength.docs.length;
    print(indexx);
    setState(() {
      idz = indexx + 1;
    });

    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('listing$idz.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    final cittt = await FirebaseFirestore.instance
        .collection('city')
        .where('name', isEqualTo: city)
        .get();
    final cityyy = cittt.docs.isEmpty ? '1' : cittt.docs.first.id;
    final cattt = await FirebaseFirestore.instance
        .collection('category')
        .where('name', isEqualTo: category)
        .get();
    final catyyy = cattt.docs.isEmpty ? '1' : cattt.docs.first.id;
    // final areaaa = await FirebaseFirestore.instance
    //     .collection('area')
    //     .where('name', isEqualTo: area)
    //     .get();
    // final areooo = areaaa.docs.first.id;
    await FirebaseFirestore.instance
        .collection('listing')
        .doc(idz.toString())
        .set({
      'id': idz,
      'idstring': idz.toString(),
      'userid2': userid,
      'userid': docid,
      'title': title,
      'description': description,
      'createdAt': Timestamp.now(),
      'city': city == '' ? 'الاسكندرية' : city,
      'city_id': cityyy,
      'category_id': catyyy,
      // 'area_id': areooo,
      // 'area': area,
      'username': username,
      'basicemail': basicusername,

      'category': category == '' ? 'ادوات المطبخ' : category,
      'image_url': url == ''
          ? 'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
          : url,
      'userimage': useriamge,
      'messages': 0,
      'messages_seen': 0,
      'seen': 0,
      'storesidz': ['djxHD4FJea09n3KBYkoT'],
      'storesi': 0,
      'sent': 0,
      // 'orders': 0,
      //  'map': 0,
      'state': 'online',
      'closed': false,
      'total close': false,
      'updated': false,

      //  'news': 'New',
      //       'nationality': '',
//'city': '',
//'street': '',
    });
    await FirebaseFirestore.instance
        .collection('listdetails')
        .doc(idz.toString())
        .set({
      'id': idz,
      'userid2': userid,
      'userid': docid,
      'title': title,
      'description': description,
      'createdAt': Timestamp.now(),
      'city': city == '' ? 'الاسكندرية' : city,
      'city_id': cityyy,
      'category_id': catyyy,
      // 'area_id': areooo,
      // 'area': area,
      'closed': false,
      'total close': false,
      'username': username,
      'basicemail': basicusername,
      'category': category == '' ? 'ادوات المطبخ' : category,
      'image_url': url == ''
          ? 'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
          : url,
      'updated': false,
    });
    final busstart = await FirebaseFirestore.instance
        .collection('business_details')
        .where('city', isEqualTo: city)
        .where('category', isEqualTo: category)
        .get();
    final bogys = await FirebaseFirestore.instance
        .collection('business_details')
        .where('second_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final bogyid = bogys.docs.first.exists ? bogys.docs.first.id : '123';
    final List<String> items = [];
    for (var i = 0; i < busstart.docs.length; i++) {
      if (busstart.docs[i].id != bogyid) {
        items.add(busstart.docs[i].id);
      }
    }
    final List<DocumentSnapshot<Map<String, dynamic>>> sentx = [];
    final List<int> sent = [];
    final List<QuerySnapshot<Map<String, dynamic>>> sendz = [];

    final List<String> tokenx = [];
    final List<Future<QuerySnapshot<Map<String, dynamic>>>> sentxk = [];
    final List<int> sentk = [];
    final List<QuerySnapshot<Map<String, dynamic>>> sendzk = [];
    final List<String> tokenxk = [];
    for (var x = 0; x < items.length; x++) {
      sentx.add(await FirebaseFirestore.instance
          .collection('business_details')
          .doc(items[x])
          .get());
    }
    for (var y = 0; y < items.length; y++) {
      sent.add(sentx[y].data()!['sent']);
    }
    for (var z = 0; z < items.length; z++) {
      await FirebaseFirestore.instance
          .collection('business_details')
          .doc(items[z])
          .update({'sent': sent[z] + 1});
    }
    print(
        'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    print(
        'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');

    for (var k = 0; k < items.length; k++) {
      FirebaseFirestore.instance.collection('notify').add({
        'customerid': userid,
        'businessid': 'allorders',
        'listid': idz,
        'createdAt': Timestamp.now(),
        'to$userid': false,
        'to${items[k]}': true,
        'text': title,
        'target': items[k],
        'store_name': username
      });
      sendz.add(await FirebaseFirestore.instance
          .collection('customer_details')
          .doc(items[k])
          .collection('tokens')
          .get());
      print(
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      tokenx.add(sendz[k].docs.first.data()['registrationTokens']);
      print(
          'ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    }
    for (var s = 0; s < tokenx.length; s++) {
      sendpushnotification(tokenx[s], title, username);
    }
    // for (var kk = 0; kk < items.length; kk++) {
    //   sendz.add(await FirebaseFirestore.instance
    //       .collection('customer_details')
    //       .doc(items[kk])
    //       .collection('tokens')
    //       .get());
    //   print(
    //       'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    //   tokenx.add(sendz[kk].docs.first.data()['registrationTokens']);
    //   print(
    //       'ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    //   sendpushnotification(tokenx[kk], title, username);
    //   print(
    //       'vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');

    //   //  await _showNotification(tokenx[kk], title, username);

    //   //  await _cancelAllNotifications();
    // }
    //  await _showNotification(tokenx[1], title, username);
    id++;
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    // final tik = await FirebaseFirestore.instance
    //     .collection('customer_details')
    //     .doc(docid)
    //     .collection('tokens')
    //     .get();
    // final tok = tik.docs.first.data()['registrationTokens'];
    // sendpushnotification(tok, title, username);
    sendzk.add(await FirebaseFirestore.instance
        .collection('notify')
        .where('listid', isEqualTo: idz)
        .get());
    final kope = await FirebaseFirestore.instance
        .collection('notify')
        .where('listid', isEqualTo: idz)
        .get();

    // Future.delayed(const Duration(seconds: 3), (() async {
    //   //  _deleteNotificationChannel();
    //   for (var km = 0; km < kope.docs.length; km++) {
    //     tokenxk.add(kope.docs[km].id);
    //     print(tokenxk);
    //     print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    //     FirebaseFirestore.instance
    //         .collection('notify')
    //         .doc(tokenxk[km])
    //         .delete();
    //   }
    // }));

    if (city != '') {
      final citydoc = await FirebaseFirestore.instance
          .collection('city')
          .where('name', isEqualTo: city)
          .get();
      final cityid = citydoc.docs.isEmpty ? '1' : citydoc.docs.first.id;
      await FirebaseFirestore.instance
          .collection('city')
          .doc(cityid)
          .collection('listingsInThisCity')
          .doc(idz.toString())
          .set({'id': userid});
      final countlisdocs = await FirebaseFirestore.instance
          .collection('city')
          .doc(cityid)
          .collection('listingsInThisCity')
          .get();
      final countlis = countlisdocs.docs.length;
      await FirebaseFirestore.instance
          .collection('city')
          .doc(cityid)
          .update({'listinginthiscitylength': countlis});
    }
    if (category != '') {
      final catdoc = await FirebaseFirestore.instance
          .collection('category')
          .where('name', isEqualTo: category)
          .get();
      final catid = catdoc.docs.isEmpty ? '1' : catdoc.docs.first.id;
      await FirebaseFirestore.instance
          .collection('category')
          .doc(catid)
          .collection('listingsInThisCategory')
          .doc(idz.toString())
          .set({'id': userid});
      final countlisdocss = await FirebaseFirestore.instance
          .collection('category')
          .doc(catid)
          .collection('listingsInThisCategory')
          .get();
      final countliss = countlisdocss.docs.length;
      await FirebaseFirestore.instance
          .collection('category')
          .doc(catid)
          .update({'listingsInThisCategorylength': countliss});
    }
    // final areadoc = await FirebaseFirestore.instance
    //     .collection('area')
    //     .where('name', isEqualTo: area)
    //     .get();
    // final areaid = areadoc.docs.first.id;
    // await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .collection('listingsInThisArea')
    //     .doc(idz.toString())
    //     .set({'id': userid});
    // final countlisdocsss = await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .collection('listingsInThisarea')
    //     .get();
    // final countlisss = countlisdocsss.docs.length;
    // await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .update({'listingsInThisarealength': countlisss});
  }

  // void _selectPagee() async {
  //   final newidea = await FirebaseFirestore.instance
  //       .collection('listing')
  //       .where('userid2', isEqualTo: userx)
  //       .where('closed', isEqualTo: false)
  //       .get();
  //   List seens = [];
  //   List sents = [];

  //   for (var x = 0; x < newidea.docs.length; x++) {
  //     sents.add(newidea.docs[x].data()['sent']);
  //     seens.add(newidea.docs[x].data()['seen']);
  //   }
  //   const initialValue = 0.0;

  //   final seensx = seens.fold(
  //       initialValue, (previousValue, element) => previousValue + element);
  //   final sentsx = sents.fold(
  //       initialValue, (previousValue, element) => previousValue + element);
  //   final seezz = int.tryParse(seensx.toString());
  //   final useri = await FirebaseFirestore.instance
  //       .collection('customer_details')
  //       .where('second_uid', isEqualTo: userx)
  //       .get();
  //   final idx = useri.docs.first.id;
  //   final sen = useri.docs.first.data()['sent'];
  //   FirebaseFirestore.instance
  //       .collection('customer_details')
  //       .doc(idx)
  //       .update({'seen': seensx, 'sent': sentsx});
  // }
  bool stop = false;
  _launchURL() async {
    final Uri url =
        Uri.parse('https://api.whatsapp.com/send/?phone=201555563987');
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
    // if (!await launchUrl(url)) {
    //   throw Exception(
    //       'Could not launch https://api.whatsapp.com/send/?phone=201555563987');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              alaqyForm(_submitAuthForm, isLoading),
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
                // totalRepeatCount: 2,
                repeatForever: true,
                onNext: (p0, p1) {
                  // setState(() {
                  //   _selectPagee();
                  // });
                  _selectPage();
                  //   _selectPagee();
                },
              ),
              // AnimatedTextKit(
              //   animatedTexts: [
              //     TyperAnimatedText(
              //       '',
              //       textStyle: const TextStyle(
              //         fontSize: 20,
              //         color: Colors.cyanAccent,
              //         overflow: TextOverflow.visible,
              //       ),
              //       speed: const Duration(seconds: 2),
              //     )
              //   ],
              //   totalRepeatCount: 2,
              //   // repeatForever: true,
              //   onNext: (p0, p1) {
              //     //   setState(() {
              //     stop == false
              //         ? RestartWidget.restartApp(context)
              //         : null; //    });
              //     setState(() {
              //       stop = true;
              //     });
              //     //   _selectPagee();
              //   },
              // ),
            ])),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black12,
          onPressed: () {
            _launchURL();
          },
          child: ClipOval(
            child: Image.asset(
              'assets/whatsapp.png',
              fit: BoxFit.contain,
              opacity: AlwaysStoppedAnimation<double>(0.5),
            ),
            //  color: Color.fromARGB(255, 226, 219, 157),
          ),
        ));
  }
}
