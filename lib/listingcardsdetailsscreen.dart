import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/updatelisting.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ListingCardsDetailsScreensubx.dart';
import 'app_drawer.dart';
import 'badge.dart';
import 'user_main.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ListingCardsDetailsScreen extends StatefulWidget {
  static const routeName = '/ListingCardsDetailsScreen';
  final String id;
  final Timestamp createdAt;
  final String title;
  final String imageurl;
  final String description;
  const ListingCardsDetailsScreen(
      this.id, this.createdAt, this.title, this.imageurl, this.description,
      {super.key});
  // final String oppi;
//  final String oppoo;

//  Messagess(this.oppoo, this.oppi);
  @override
  State<ListingCardsDetailsScreen> createState() =>
      ListingCardsDetailsScreenState();
}

class ListingCardsDetailsScreenState extends State<ListingCardsDetailsScreen> {
  var _showOnlyFavorites = false;
  List businessareasids = [];
  List businessareas = [];
  List<Widget> nnn = [];
  List<DropdownMenuItem> mmm = [];
  var area = '';
  var areax = '';

  bool loading = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  final _transformationController = TransformationController();

  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  // void initState() {
  //   super.initState();
  //   final fbm = FirebaseMessaging.instance;
  //   fbm.requestNotificationPermissions();
  //   fbm.configure(onMessage: (msg) {
  //     print(msg);
  //     return;
  //   }, onLaunch: (msg) {
  //     print(msg);
  //     return;
  //   }, onResume: (msg) {
  //     print(msg);
  //     return;
  //   });
  //   fbm.getToken();
  //   //  fbm.unsubscribeFromTopic('beek');
  // }
  // void initState() {
  //   super.initState();
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage message) {
  //         if (message != null) {
  //           // Navigator.pushNamed(context, '/message',
  //           //     arguments: MessageArguments(message, true));
  //         }
  //       } as FutureOr Function(RemoteMessage? value));
  // }
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

  Future<void> _showNotification(String title, String body) async {
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Default channel', 'Default channel',
            channelDescription: 'your channel description',
            icon: "mipmap/ic_launcher",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
        linux: LinuxNotificationDetails(),
        macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.show(1, title, body,
            notificationDetails: notificationDetails.iOS, payload: 'item x');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.show(1, title, body,
            notificationDetails: notificationDetails.android,
            payload: 'item x');
  }

  void notify() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final userdoc = await FirebaseFirestore.instance
          .collection('customer_details')
          .where('second_uid',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userdoc.docs.first.exists) {
        final userdocid = userdoc.docs.first.id;
        print(userdocid);
        print('userdocidxxx');
        final notif = await FirebaseFirestore.instance
            .collection('notify')
            .where('target', isEqualTo: userdocid)
            .get();
        if (notif.docs.first.exists) {
          final nofid = notif.docs.first.id;
          final tit = notif.docs.first.data()['store_name'];
          final bod = notif.docs.first.data()['text'];
          _showNotification(tit, bod);
          //  FirebaseFirestore.instance.collection('notify').doc(nofid).delete();
        }
      }
    }
  }

  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final usex = FirebaseAuth.instance.currentUser == null
        ? ''
        : FirebaseAuth.instance.currentUser!.uid;
    dynamic badgoo;
    dynamic bag = 0;

    final fbm = FirebaseMessaging.instance;
    fbm.getToken();
    //  fbm.subscribeToTopic(notyu);
    fbm.onTokenRefresh;
    print('$area xxxxxx');
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 252, 250, 250),
            foregroundColor: Colors.black,
            centerTitle: true,
            toolbarHeight: 80,
            title: Column(children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                ),
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
                  notify();
                  //    });

                  //   _selectPagee();
                },
              ),
            ]),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => UpdateListing(
                            widget.id,
                          )));
                },
                icon: const Icon(
                  Icons.update,
                  color: Colors.amber,
                ),
                label: Text(
                  'تعديل المنشور',
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      color: Color.fromARGB(74, 0, 0, 0)),
                ),
              )
//  IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                         builder: (ctx) => UpdateListing(
//                               widget.id,
//                             )));
//                   }, //=> Navigator.popAndPushNamed(context, '/'),
//                   icon: const Icon(Icons.update)),
              // PopupMenuButton(
              //   onSelected: (FilterOptions selectedValue) {
              //     setState(() {
              //       if (selectedValue == FilterOptions.Favorites) {
              //         _showOnlyFavorites = true;
              //       } else {
              //         _showOnlyFavorites = false;
              //       }
              //     });
              //   },
              //   icon: const Icon(
              //     Icons.more_vert,
              //   ),
              //   itemBuilder: (_) => [
              //     const PopupMenuItem(
              //       value: FilterOptions.Favorites,
              //       child: Text('filter by area'),
              //     ),
              //     const PopupMenuItem(
              //       value: FilterOptions.All,
              //       child: Text('Show All'),
              //     ),
              //   ],
              // ),
              // DropdownButton(
              //   underline: Text(
              //     'filter by Area',
              //     style: TextStyle(
              //         color: _showOnlyFavorites == false
              //             ? Colors.grey
              //             : Colors.blueGrey),
              //   ),
              //   icon: Icon(Icons.location_on,
              //       color: _showOnlyFavorites == false
              //           ? Colors.grey
              //           : Colors.deepPurple),
              //   onChanged: (value) {
              //     for (var r = 0; r < businessareas.length; r++) {
              //       if (value == businessareas[r]) {
              //         area = businessareas[r];
              //         setState(() {
              //           _showOnlyFavorites = !_showOnlyFavorites;
              //         });
              //       }
              //     }
              //   },
              //   selectedItemBuilder: (BuildContext context) {
              //     return nnn;
              //   },
              //   items: mmm,
              // ),
            ]),
        body: Container(
            child: SingleChildScrollView(
                child: SizedBox(
                    height: 750,
                    child: Column(children: <Widget>[
                      Expanded(
                          child: ListingCardsDetailsScreensubx(
                              widget.id,
                              widget.createdAt,
                              widget.title,
                              widget.imageurl,
                              widget.description)),
                    ])))),
        bottomNavigationBar: BottomNavigationBar(
          //   backgroundColor: Color.fromARGB(255, 226, 219, 157),
          elevation: 0,
          //   onTap: _selectPage,
          backgroundColor: Color.fromARGB(255, 252, 250, 250),
          unselectedItemColor: Colors.grey.shade400,
          selectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Tajawal',
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Tajawal',
          ),
          // currentIndex:
          //     widget.idx == 'none' ? _selectedPageIndex : _selectedPageIndexx,
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
                            child: IconButton(
                              icon: Icon(Icons.history_edu_outlined),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const UserMain('zero')));
                              },
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.history_edu_outlined),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const UserMain('zero')));
                            },
                          );
                  }),
              label: 'منشورات سابقة',
            ),
            BottomNavigationBarItem(
              //       backgroundColor: Color.fromARGB(255, 226, 219, 157),
              icon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => const UserMain('none')));
                },
              ),
              label: 'ألاقي عندك',
            ),
          ],
        ),
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
