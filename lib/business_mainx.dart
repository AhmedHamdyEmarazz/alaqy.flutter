import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/app_drawer2.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'allordersx.dart';
import 'business_main.dart';
import 'foundordersx.dart';

class BusinessMainx extends StatefulWidget {
  static const routeName = '/BusinessMainx';
  final String idx;
  final String phonex;

  const BusinessMainx(this.idx, this.phonex, {super.key});
  @override
  BusinessMainxState createState() => BusinessMainxState();
}

class BusinessMainxState extends State<BusinessMainx> {
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 1;
  int _selectedPageIndexx = 0;

  final userx = FirebaseAuth.instance.currentUser!.uid;
  int badgoo = 0;
  String? mtoken = '';
  final fbm = FirebaseMessaging.instance;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    _pages = [
      {
        'page': AllOrdersx(), //
        'title': 'كل الطلبات',
      },
      {
        'page': FoundOrdersx(), //
        'title': 'موجود',
      },
    ];
    super.initState();
    // requestpermission();
    // getToken();
    // initInfo();
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
//         importance: Importance.high,
//         styleInformation: bigtextstyleinformation,
//         priority: Priority.high,
//         playSound: true,
//       );
//       NotificationDetails platformchannelspecifies = NotificationDetails(
//         android: androidplatformchannelspecifies,
//       );
//       // await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
//       //     message.notification!.body, platformchannelspecifies,
//       //     payload: message.data['body']);
//     });
//   }

//   void saveToken(String token) async {
//     final lord = await FirebaseFirestore.instance
//         .collection('customer_details')
//         .where('phone_num', isEqualTo: widget.phonex)
//         .get();
//     final balaha = lord.docs.isEmpty ? '' : lord.docs.first.data()['first_uid'];
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

  void _selectPage(int index) async {
    // if (_selectedPageIndex == 0) {
    //   final useri = await FirebaseFirestore.instance
    //       .collection('business_details')
    //       .where('second_uid', isEqualTo: userx)
    //       .get();
    //   final idx = useri.docs.first.id;
    //   final sen = useri.docs.first.data()['sent'];
    //   FirebaseFirestore.instance
    //       .collection('business_details')
    //       .doc(idx)
    //       .update({'seen': sen});
    // }
    setState(() {
      _selectedPageIndex = index;
      _selectedPageIndexx = index;
    });
  }

  // void foundsentseen() async {
  //   final useri = await FirebaseFirestore.instance
  //       .collection('business_details')
  //       .where('second_uid', isEqualTo: userx)
  //       .get();
  //   final idx = useri.docs.first.id;
  //   final sent = useri.docs.first.data()['foundsent'];
  //   final seen = useri.docs.first.data()['foundseen'];

  //   final upnum = useri.docs.first.data()['upnum'];
  //   final upnumseen = useri.docs.first.data()['upnumseen'];

  //   final storenameb = useri.docs.first.data()['basicstore_name'];
  //   final listcont =
  //       await FirebaseFirestore.instance.collection('listing').get();
  //   List<DocumentSnapshot<Map<String, dynamic>>> sentx = [];
  //   List<int> foundsentsx = [];
  //   List<int> foundseenx = [];
  //   // print(listcont.docs.length);
  //   // print(storenameb);
  //   foundsentsx.add(upnum);
  //   foundseenx.add(upnumseen);
  //   for (var z = 0; z < listcont.docs.length; z++) {
  //     if (listcont.docs[z].data().containsKey(storenameb)) {
  //       if (listcont.docs[z].data()[storenameb] == 'on') {
  //         foundsentsx.add(listcont.docs[z]
  //             .data()['post_owner_reply_to_business$storenameb']);
  //         foundseenx.add(listcont.docs[z]
  //             .data()['post_owner_seen_by_business$storenameb']);
  //         print(foundsentsx);
  //         print(foundseenx);
  //         print(seen);
  //         print(sent);
  //       }
  //     }
  //   }
  //   final mustaddedsent = foundsentsx.fold(
  //       0, (previousValue, element) => previousValue + element);
  //   final mustaddedseen =
  //       foundseenx.fold(0, (previousValue, element) => previousValue + element);

  //   FirebaseFirestore.instance
  //       .collection('business_details')
  //       .doc(idx)
  //       .update({'foundsent': mustaddedsent, 'foundseen': mustaddedseen});
  // }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 9), (() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const BusinessMain('none')));
    }));
    //  RestartWidget.restartApp(context);
    print('mainxxxxx');
    // fbm.subscribeToTopic('chat');
    // fbm.subscribeToTopic('listing');
    // fbm.subscribeToTopic('notify');
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil('/myapp', (Route<dynamic> route) => false);
    // fbm.onTokenRefresh;
    return Scaffold(
      // drawer: AppDrawer2(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 252, 250, 250),
        foregroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 135,
        title: Column(children: [
          // AnimatedTextKit(
          //   animatedTexts: [
          //     TyperAnimatedText(
          //       '',
          //       textStyle:
          //           const TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
          //       speed: const Duration(seconds: 2),
          //     )
          //   ],
          //   // totalRepeatCount: 2,
          //   repeatForever: true,
          //   onNext: (p0, p1) {
          //     //  Future.delayed(const Duration(seconds: 2), (() {
          //     Navigator.of(context)
          //         .pushReplacementNamed(businessChoose.routeName);
          //     // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     //     builder: (ctx) => const BusinessMain('none')));

          //     //    }));
          //   },
          // ),
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
          Center(
              child: SizedBox(
                  //   height: 100,
                  //   width: double.infinity,
                  child: Image.asset(
            'assets/alaqy.jpeg',
            fit: BoxFit.contain,
          ))),
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
              //   SystemNavigator.routeInformationUpdated(location: '/myapp');
              // Navigator.of(context).pushReplacementNamed(MyApp.routeName);

              //   setState(() {
              //    RestartWidget.restartApp(context);
              // Navigator.pushNamed(
              //   context, '/',
              //   //  arguments: MessageArguments(message, true)
              // );
              print(
                  'restartzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
              //   _selectPagee();
            },
          ),
        ])
        // flexibleSpace: AnimatedTextKit(
        //   animatedTexts: [
        //     TyperAnimatedText(
        //       '',
        //       textStyle:
        //           const TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
        //       speed: const Duration(seconds: 5),
        //     )
        //   ],
        //   // totalRepeatCount: 2,
        //   repeatForever: true,
        //   onNext: (p0, p1) {
        //     foundsentseen();
        //   },
        // ),
// Text(
//           widget.idx == 'none'
//               ? _pages![_selectedPageIndex]['title'].toString()
//               : _pages![_selectedPageIndexx]['title'].toString(),
//           style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
//         ),
        ,
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
        ],
      ),
      drawer: AppDrawer2(),
      body: widget.idx == 'none'
          ? _pages![_selectedPageIndex]['page'] as Widget
          : _pages![_selectedPageIndexx]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        elevation: 0,
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
        items: const [
          BottomNavigationBarItem(
            //   backgroundColor: Colors.cyanAccent,
            icon:
                //  StreamBuilder(
                //     stream: FirebaseFirestore.instance
                //         .collection('business_details')
                //         .where('phone_num', isEqualTo: widget.phonex)

                //         // .doc(FirebaseAuth.instance.currentUser!.uid)
                //         .snapshots(),
                //     builder: (ctx, userSnapshotx) {
                //       if (userSnapshotx.hasData == false) {
                //         return const Center(
                //           child: Text(
                //             'Loading...',
                //             style: TextStyle(fontSize: 2),
                //           ),
                //         );
                //       }
                //       if (userSnapshotx.connectionState ==
                //           ConnectionState.waiting) {
                //         return const Center(
                //           child: Text(
                //             'Loading...',
                //             style: TextStyle(fontSize: 2),
                //           ),
                //         );
                //       }
                //       if (userSnapshotx.hasData == false) {
                //         return const Center(
                //           child: Text(
                //             'Loading...',
                //             style: TextStyle(fontSize: 2),
                //           ),
                //         );
                //       }
                //       final chatDocs =
                //           userSnapshotx.hasData ? userSnapshotx.data : null;

                //       if (userSnapshotx.hasData == true) {
                //         final badgo1 = chatDocs!.docs.first.data()['sent'];
                //         final badgo2 = chatDocs.docs.first.data()['seen'];

                //         badgoo = badgo1 - badgo2;
                //       }

                //       return userSnapshotx.hasData == false
                //           ? const Center(
                //               child: Text(
                //                 'Loading...',
                //                 style: TextStyle(fontSize: 2),
                //               ),
                //             )
                //           : badgoo != 0
                //               ? Badgee(
                //                   value: badgoo.toString(),
                //                   color: const Color.fromARGB(176, 244, 67, 54),
                //                   child: const Icon(Icons.all_inclusive_rounded),
                //                 )
                // : const
                Icon(Icons.all_inclusive_rounded),

            label: 'كل الطلبات',
          ),
          BottomNavigationBarItem(
              //   backgroundColor: Colors.cyanAccent,
              icon:
//  StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection('business_details')
//                       .where('phone_num', isEqualTo: widget.phonex)

//                       // .doc(FirebaseAuth.instance.currentUser!.uid)
//                       .snapshots(),
//                   builder: (ctx, userSnapshot) {
//                     if (userSnapshot.hasData == false) {
//                       return const Center(
//                         child: Text(
//                           'Loading...',
//                           style: TextStyle(fontSize: 2),
//                         ),
//                       );
//                     }
//                     if (userSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return const Center(
//                         child: Text(
//                           'Loading...',
//                           style: TextStyle(fontSize: 2),
//                         ),
//                       );
//                     }
//                     final chatDocs =
//                         userSnapshot.hasData ? userSnapshot.data : null;
//                     if (userSnapshot.hasData == false) {
//                       return const Center(
//                         child: Text(
//                           'Loading...',
//                           style: TextStyle(fontSize: 2),
//                         ),
//                       );
//                     }
//                     if (userSnapshot.hasData == true) {
//                       final badgo1 = chatDocs!.docs.first.data()['foundsent'];
//                       final badgo2 = chatDocs.docs.first.data()['foundseen'];
//                       final upnum = chatDocs.docs.first.data()['upnum'];
//                       final upnumseen = chatDocs.docs.first.data()['upnumseen'];

//                       badgoo = (badgo1 + upnum) - (badgo2 + upnumseen);
//                     }

//                     return userSnapshot.hasData == false
//                         ? const Center(
//                             child: Text(
//                               'Loading...',
//                               style: TextStyle(fontSize: 2),
//                             ),
//                           )
//                         : badgoo != 0
//                             ? Badgee(
//                                 value: badgoo.toString(),
//                                 color: const Color.fromARGB(176, 244, 67, 54),
//                                 child: const Icon(Icons.navigation),
//                               )
                  //    : const
                  Icon(Icons.navigation),
              label: 'موجود'),
        ],
      ),
    );
  }
}
