import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alaqy/userChoose.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'main.dart';
import 'updateuser.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @pragma('vm:entry-point')
  Future<void> _showNotification() async {
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
        ?.show(id++, 'الاقي', 'لقد قمت بتسجيل الخروج',
            notificationDetails: notificationDetails.iOS, payload: 'item x');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.show(id++, 'الاقي', 'لقد قمت بتسجيل الخروج',
            notificationDetails: notificationDetails.android,
            payload: 'item x');
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/homez');
    SystemNavigator.pop();
    RestartWidget.restartApp(context);
  }

  @pragma('vm:entry-point')
  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(--id);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AppBar(
                    elevation: 0,
                    backgroundColor: Color.fromARGB(255, 252, 250, 250),
                    foregroundColor: Colors.black,
                    centerTitle: true,
                    toolbarHeight: 80,
                    title: Center(
                        child: SizedBox(
                            //   height: 100,
                            //   width: double.infinity,
                            child: Image.asset(
                      'assets/alaqy.jpeg',
                      fit: BoxFit.contain,
                    ))),
                    automaticallyImplyLeading: false,
                  ),
                  //    const Divider(),
                  // Container(
                  //     margin: const EdgeInsets.symmetric(
                  //       vertical: 16,
                  //       horizontal: 8,
                  //     ),
                  //     width: 120,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(12),
                  //           topRight: Radius.circular(12),
                  //           bottomLeft: Radius.circular(12),
                  //           bottomRight: Radius.circular(12)),
                  //       color: Colors.black45,
                  //     ),
                  //     padding: const EdgeInsets.symmetric(
                  //       vertical: 1,
                  //       horizontal: 1,
                  //     ),
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       width: 120,
                  //       decoration: const BoxDecoration(
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(12),
                  //             topRight: Radius.circular(12),
                  //             bottomLeft: Radius.circular(12),
                  //             bottomRight: Radius.circular(12)),
                  //         color: Colors.white,
                  //       ),
                  //       child: AnimatedTextKit(
                  //           animatedTexts: [
                  //             ScaleAnimatedText('تفعيل حساب بيزنس',
                  //                 textStyle: TextStyle(
                  //                     color: Color.fromARGB(255, 253, 202, 0),
                  //                     fontFamily: 'Tajawal'),
                  //                 textAlign: TextAlign.center,
                  //                 duration: const Duration(milliseconds: 2200),
                  //                 scalingFactor: 0.1),
                  //             ScaleAnimatedText('اضغط هنا',
                  //                 textStyle: TextStyle(
                  //                     color: Color.fromARGB(255, 253, 202, 0),
                  //                     fontFamily: 'Tajawal'),
                  //                 textAlign: TextAlign.center,
                  //                 duration: const Duration(milliseconds: 2200),
                  //                 scalingFactor: 0.1)
                  //           ],
                  //           repeatForever: true,
                  //           pause: const Duration(milliseconds: 0),
                  //           onTap: () async {
                  //             // print('switch');
                  //             // Navigator.pushReplacement(
                  //             //     context,
                  //             //     MaterialPageRoute(
                  //             //         builder: (context) => businessChoose()));
                  //             Navigator.of(context).pushReplacementNamed(
                  //                 businessChoose.routeName);
                  //           }),
                  //     )),
                  // ListTile(
                  //     leading: const Icon(Icons.switch_account_outlined),
                  //     title: const Text(
                  //       'تفعيل حساب بيزنس',
                  //       style: const TextStyle(
                  //         fontFamily: 'Tajawal',
                  //       ),
                  //     ),
                  //     onTap: () async {
                  //       Navigator.of(context)
                  //           .pushReplacementNamed(businessChoose.routeName);
                  //     }),
                  // const Divider(),
                  ListTile(
                      leading: const Icon(Icons.home_outlined),
                      title: const Text(
                        'الرئيسية',
                        style: const TextStyle(
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      onTap: () async {
                        Navigator.popAndPushNamed(
                            context, userChoose.routeName);
                      }),

                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.account_box_outlined),
                    title: const Text('حسابي'),
                    onTap: () {
                      Navigator.of(context).pushNamed(UpdateUser.routeName);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => UpdateUser()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text(
                      'الخروج',
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    onTap: () async {
                      final userdoc = await FirebaseFirestore.instance
                          .collection('customer_details')
                          .where('second_uid',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .get();
                      if (userdoc.docs.first.exists) {
                        final userdocid = userdoc.docs.first.id;
                        FirebaseFirestore.instance
                            .collection('customer_details')
                            .doc(userdocid)
                            .update({
                          'state': 'offline',
                          'lastseen': Timestamp.now(),
                        });
                      }
                      _showNotification();
                    },
                  ),
                ],
              ),
            )));
  }
}
