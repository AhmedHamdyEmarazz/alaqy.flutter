import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/app_drawer.dart';
import 'package:flutter_alaqy/user_main.dart';

import 'alaaqyProcess.dart';
import 'listing.dart';

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

class UserMainx extends StatefulWidget {
  static const routeName = '/UserMainx';
  final String idx;
  const UserMainx(this.idx, {super.key});
  @override
  UserMainxState createState() => UserMainxState();
}

class UserMainxState extends State<UserMainx> {
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 1;
  int _selectedPageIndexx = 0;

  final usex = FirebaseAuth.instance.currentUser == null
      ? ''
      : FirebaseAuth.instance.currentUser!.uid;
  dynamic badgoo;
  dynamic bag = 0;

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

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), (() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const UserMain('none')));
    }));
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil('/myapp', (Route<dynamic> route) => true);
    print(
        'maaaaaaaaiiiiinnnnxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    final size = MediaQuery.of(context).size;
    final hightx = size.height;
    // fbm.subscribeToTopic('chat');
    // fbm.subscribeToTopic('listing');
    // fbm.subscribeToTopic('notify');

    // fbm.onTokenRefresh;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 252, 250, 250),
          foregroundColor: Colors.black,
          centerTitle: true,
          toolbarHeight: 135,
          title: Column(children: [
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
                //   Navigator.of(context).pushReplacementNamed(MyApp.routeName);
                // SystemNavigator.routeInformationUpdated(location: '/myapp');
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     '/myapp', (Route<dynamic> route) => false);
                //   setState(() {
                //     RestartWidget.restartApp(context);
                // Navigator.pushNamed(
                //   context, '/',
                //   //  arguments: MessageArguments(message, true)
                // );
                print(
                    'restartzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
                //   _selectPagee();
              },
            ),
          ]),
          actions: const [
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
            icon: Icon(Icons.history_edu_outlined),

            label: 'منشورات سابقة',
          ),
          BottomNavigationBarItem(
            //   backgroundColor: Colors.cyanAccent,
            icon: Icon(Icons.search),
            label: 'ألاقي عندك',
          ),
        ],
      ),
    );
  }
}
