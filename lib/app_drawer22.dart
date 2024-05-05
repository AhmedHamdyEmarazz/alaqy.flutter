import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alaqy/businessChoose.dart';
import 'package:flutter_alaqy/userChoose.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'businesskoshk.dart';
import 'main.dart';
import 'updatebusiness.dart';

class AppDrawer22 extends StatefulWidget {
  @override
  _AppDrawer22State createState() => _AppDrawer22State();
}

class _AppDrawer22State extends State<AppDrawer22> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @pragma('vm:entry-point')
  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Default channel', 'Default channel',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, 'الاقي', 'لقد قمت بتسجيل الخروج', notificationDetails,
        payload: 'item x');
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
                            child: Image.asset(
                      'assets/alaqy.jpeg',
                      fit: BoxFit.contain,
                    ))),
                    automaticallyImplyLeading: false,
                  ),
                  ListTile(
                      leading: const Icon(Icons.switch_account_outlined),
                      title: const Text(
                        'تفعيل حساب عميل',
                        style: const TextStyle(
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      onTap: () async {
                        Navigator.of(context)
                            .pushReplacementNamed(userChoose.routeName);
                      }),
                  const Divider(),
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
                            context, businessChoose.routeName);
                      }),
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

                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/home');
                      _showNotification();
                      SystemNavigator.pop();
                      RestartWidget.restartApp(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.account_box_rounded),
                    title: const Text(
                      'حسابي',
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(UpdateBusiness.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.house_siding_outlined),
                    title: const Text(
                      'الكشك الخاص',
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(BusinessKoshk.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.handshake),
                    title: const Text(
                      'المعاملات',
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).pushNamed(UpdateBusiness.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.search),
                    title: const Text(
                      'البحث',
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).pushNamed(UpdateBusiness.routeName);
                    },
                  ),
                ],
              ),
            )));
  }
}
