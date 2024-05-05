import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alaqy/AuthScreenBusiness.dart';
import 'package:flutter_alaqy/authScreenUser.dart';

class MyHomePagee extends StatefulWidget {
  static const routeName = '/home';

  // const MyHomePagee({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePagee> createState() => _MyHomePageeState();
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

class _MyHomePageeState extends State<MyHomePagee> with WidgetsBindingObserver {
  var bus = true;
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
                                Card(
                                    color: bus != true
                                        ? Color.fromARGB(226, 0, 0, 0)
                                        : Color.fromARGB(35, 158, 158, 158),
                                    shadowColor: Colors.amber,
                                    elevation: bus != true ? 20 : 0,
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 3,
                                          horizontal: 1,
                                        ),
                                        //width: 120,
                                        height: bus != true ? 60 : 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          color: bus != true
                                              ? Color.fromARGB(226, 0, 0, 0)
                                              : Color.fromARGB(
                                                  35, 158, 158, 158),
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
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4)),
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
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      height: -0.01,
                                                      fontSize: 12,
                                                      //      fontStyle: FontStyle.italic,
                                                      fontWeight: (bus == true) ? FontWeight.normal : FontWeight.bold,
                                                      shadows: [
                                                        Shadow(
                                                            blurRadius:
                                                                bus == false
                                                                    ? 3
                                                                    : 0)
                                                      ]),
                                                ),
                                                //        textColor: Theme.of(context).primaryColor,
                                                onPressed: () async {
                                                  print('user');
                                                  if (FirebaseAuth.instance
                                                          .currentUser !=
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
                                                    final usid = active
                                                            .docs.isNotEmpty
                                                        ? active.docs.first.id
                                                        : 'none';
                                                    active.docs.isNotEmpty
                                                        ? FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'customer_details')
                                                            .doc(usid)
                                                            .update({
                                                            'activated': true
                                                          })
                                                        : null;
                                                  }
                                                  setState(() {
                                                    bus = false;
                                                  });
                                                  print(bus);

                                                  //  Navigator.of(context).pushNamed(userChoose.routeName);
                                                })))),
                                //   const Text('او'),
                                const SizedBox(width: 9),
                                Card(
                                    color: bus == true
                                        ? Color.fromARGB(226, 0, 0, 0)
                                        : Color.fromARGB(35, 158, 158, 158),
                                    shadowColor: Colors.amber,
                                    elevation: bus == true ? 20 : 0,
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 3,
                                          horizontal: 1,
                                        ),
                                        //width: 120,
                                        height: bus == true ? 60 : 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          color: bus == true
                                              ? Color.fromARGB(226, 0, 0, 0)
                                              : Color.fromARGB(
                                                  35, 158, 158, 158),
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
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4)),
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
                                                              bus == true
                                                                  ? 3
                                                                  : 0)
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
                                            )))),
                              ])))),
              const SizedBox(
                height: 20,
              ),
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
