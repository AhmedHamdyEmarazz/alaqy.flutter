import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/userChoose.dart';
import 'package:flutter_alaqy/userToBusinessForm.dart';

import 'app_drawer.dart';
import 'badge.dart';
import 'user_main.dart';
// import 'http_exception.dart';

// import 'auth_form.dart';
// import 'fuck.dart';
// import 'package:provider/provider.dart';
// import 'auth.dart';
// import 'chat_screen.dart';

class UserToBusinessScreen extends StatefulWidget {
  static const routeName = '/UserToBusinessScreen';
  String phone;
  String user_id;
  String user_id2;
  String username;

  UserToBusinessScreen(this.phone, this.user_id, this.user_id2, this.username,
      {super.key});
  @override
  UserToBusinessScreenState createState() => UserToBusinessScreenState();
}

class UserToBusinessScreenState extends State<UserToBusinessScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  final fbm = FirebaseMessaging;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _submitAuthForm(
    String email,
    String area,
    String storename,
    String category,
    String city,
    String password,
    String username,
    dynamic image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    // UserCredential authResult;
    final url;
    if (city == '' || category == '' || area == '') {
      return;
    }
    //  try {
    setState(() {
      _isLoading = true;
    });
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${widget.user_id2}.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    //    https: //firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169
    // if (!isLogin) {
    //   authResult = await _auth.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    // } else {
    //   authResult = await _auth.createUserWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   if (isLogin) {

    //     final oppa = Provider.of<Auth>(context, listen: false).userId;

    //   await Firestore.instance
    //       .collection('chato')
    //      .document(oppa)
    //     .setData({'pokeuser': 'x'});
    print(category);
    final cittt = await FirebaseFirestore.instance
        .collection('city')
        .where('name', isEqualTo: city)
        .get();
    final cityyy = cittt.docs.first.id;
    final cattt = await FirebaseFirestore.instance
        .collection('category')
        .where('name', isEqualTo: category)
        .get();
    final catyyy = cattt.docs.first.id;
    final areaaa = await FirebaseFirestore.instance
        .collection('area')
        .where('name', isEqualTo: area)
        .get();
    final areooo = areaaa.docs.first.id;
    final customerdoc = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('second_uid', isEqualTo: widget.user_id2)
        .get();
    final cusx = customerdoc.docs.first.id;
    final exactcus = await FirebaseFirestore.instance
        .collection('customer_details')
        .doc(cusx)
        .get();
    final name = exactcus.data()!['name'];
    final basicemail = exactcus.data()!['basicemail'];
    await FirebaseFirestore.instance
        .collection('business_details')
        .doc(widget.user_id)
        .set({
      'first_uid': widget.user_id,
      'second_uid': widget.user_id2,
      'phone_num': widget.phone,
      'createdAt': Timestamp.now(),
      'name': name,
      'username': widget.username,
      'basicemail': basicemail,
      'basicemailx': email,
      'basicstore_name': username,
      'area_id': areooo,
      'area': area,
      'foundsent': 0,
      'foundseen': 0,
      'city': city,
      'city_id': cityyy,
      'category_id': catyyy,
      'businesslast': true,
      'store_name': username,
      'category': category,
      'image_url': image == null
          ? 'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
          : url,
      'messages': 0,
      'seen': 0,
      'sent': 0,
      'orders': 0,
      //  'map': 0,
      'state': 'online',
      'updated': false,
      'upnum': 0,
      'upnumseen': 0,
      //  'news': 'New',
      //       'nationality': '',
//'city': '',
//'street': '',
    });

    final qwe = widget.user_id2;
    await FirebaseMessaging.instance.subscribeToTopic('business_details/$qwe');

    //   void _showErrorDialog(String message) {
    //     showDialog(
    //       context: context,
    //       builder: (ctx) => AlertDialog(
    //         title: const Text('An Error Occurred!'),
    //         content: Text(message),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('Okay'),
    //             onPressed: () {
    //               Navigator.of(ctx).pop();
    //             },
    //           )
    //         ],
    //       ),
    //     );
    //   }
    // } on HttpException catch (err) {
    //   var errMessage = 'Authentication failed';
    //   if (err.toString().contains('EMAIL_EXISTS')) {
    //     errMessage = 'This email address is already in use.';
    //   } else if (err.toString().contains('INVALID_EMAIL')) {
    //     errMessage = 'This is not a valid email address';
    //   } else if (err.toString().contains('WEAK_PASSWORD')) {
    //     errMessage = 'This password is too weak.';
    //   } else if (err.toString().contains('EMAIL_NOT_FOUND')) {
    //     errMessage = 'Could not find a user with that email.';
    //   } else if (err.toString().contains('INVALID_PASSWORD')) {
    //     errMessage = 'Invalid password.';
    //     //    } else {
    //     //      errMessage = 'Could not authenticate you. Please try again later.';
    //   }
    //     if (err.toString().isEmpty) {
    //     null;
    //    } else {
    //       errMessage = err.message;
//      }

    //    ScaffoldMessenger.of(ctx).showSnackBar(
    //       SnackBar(
//          content: Text(errMessage),
    //         backgroundColor: Theme.of(ctx).errorColor,
    //      ),
    //    );
    // setState(() {
    //   _isLoading = false;
    //    });
    //   _showErrorDialog(errMessage);
    // } catch (err) {
    //   if (err.toString().isEmpty) {
    //     null;
    //   } else {
    //     final errMessage = err.toString();
    //     _showErrorDialog(errMessage);

    //     print(err);
    //   }
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
    final citydoc = await FirebaseFirestore.instance
        .collection('city')
        .where('name', isEqualTo: city)
        .get();
    final cityid = citydoc.docs.first.id;
    await FirebaseFirestore.instance
        .collection('city')
        .doc(cityid)
        .collection('shopsInThisCity')
        .doc(widget.user_id)
        .set({'name': username});
    final countlisdocs = await FirebaseFirestore.instance
        .collection('city')
        .doc(cityid)
        .collection('shopsInThisCity')
        .get();
    final countlis = countlisdocs.docs.length;
    await FirebaseFirestore.instance
        .collection('city')
        .doc(cityid)
        .update({'shopsInThisCitylength': countlis});
    final catdoc = await FirebaseFirestore.instance
        .collection('category')
        .where('name', isEqualTo: category)
        .get();
    final catid = catdoc.docs.first.id;
    await FirebaseFirestore.instance
        .collection('category')
        .doc(catid)
        .collection('shopsInThisCategory')
        .doc(widget.user_id)
        .set({'name': username});
    final countlisdocss = await FirebaseFirestore.instance
        .collection('category')
        .doc(catid)
        .collection('shopsInThisCategory')
        .get();
    final countliss = countlisdocss.docs.length;
    await FirebaseFirestore.instance
        .collection('category')
        .doc(catid)
        .update({'shopsInThisCategorylength': countliss});
    final areadoc = await FirebaseFirestore.instance
        .collection('area')
        .where('name', isEqualTo: area)
        .get();
    final areaid = areadoc.docs.first.id;
    await FirebaseFirestore.instance
        .collection('area')
        .doc(areaid)
        .collection('shopsInThisArea')
        .doc(widget.user_id)
        .set({'name': username});
    final countlisdocsss = await FirebaseFirestore.instance
        .collection('area')
        .doc(areaid)
        .collection('shopsInThisArea')
        .get();
    final countlisss = countlisdocsss.docs.length;
    await FirebaseFirestore.instance
        .collection('area')
        .doc(areaid)
        .update({'shopsInThisArealength': countlisss});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightx = size.height;
    dynamic badgoo;
    dynamic bag = 0;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 252, 250, 250),
            foregroundColor: Colors.black,
            centerTitle: true,
            toolbarHeight: 80,
            title: Text(
              ' تفعيل حساب بيزنس',
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Tajawal',
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, userChoose.routeName),
                  icon: const Icon(Icons.home)),
            ]),
        drawer: AppDrawer(),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
            color: Color.fromARGB(255, 252, 250, 250),
            child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                  height: heightx - 205,
                  child: UserToBusinessForm(
                    _submitAuthForm,
                    _isLoading,
                  )),
              _isLoading ? const CircularProgressIndicator() : const SizedBox()
            ]))),
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
              label: 'الاقي عندك',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black12,
          onPressed: () {},
          child: Icon(
            Icons.headphones_outlined,
            color: Color.fromARGB(255, 226, 219, 157),
          ),
        ));
  }
}
// import * as functions from 'firebase-functions';
// import * as admin from 'firebase-admin';
// admin.initializeApp();

// const db = admin.firestore();
// const fcm = admin.messaging();
// export const sendToDevice = functions.firestore
//   .document('notify/{message}')
//   .onCreate(async snapshot => {


//     const order = snapshot.data();

//     const querySnapshot = await db
//       .collection('business_details')
//       .doc(order.target)
//       .collection('tokens')
//       .get();

//     const tokens = querySnapshot.docs.map(snap => snap.id);

//     const payload: admin.messaging.MessagingPayload = {
//       notification: {
//         title: order.username,
//         body: order.text,
//         // icon: 'your-icon-url',
//         // click_action: 'FLUTTER_NOTIFICATION_CLICK'
//       }
//     };

//     return fcm.sendToDevice(tokens, payload);
//   });

// // export const sendToTopic = functions.firestore
// //   .document('contact/{message}')
// //   .onCreate(async snapshot => {


// //     const cont = snapshot.data();

   
// //     const payload: admin.messaging.MessagingPayload = {
// //       notification: {
// //         title: cont.username,
// //         body: cont.text,
// //         icon: 'your-icon-url',
// //         click_action: 'FLUTTER_NOTIFICATION_CLICK'
// //       }
// //     };

// //     return fcm.sendToTopic('contact', payload);
// //   });
// // export const sendToTopictwo = functions.firestore
// //   .document('chat/{message}')
// //   .onCreate(async snapshot => {


// //     const chatting = snapshot.data();

   
// //     const payload: admin.messaging.MessagingPayload = {
// //       notification: {
// //         title: chatting.username,
// //         body: chatting.text,
// //         icon: 'your-icon-url',
// //         click_action: 'FLUTTER_NOTIFICATION_CLICK'
// //       }
// //     };

// //     return fcm.sendToTopic('chat', payload);
// //   });