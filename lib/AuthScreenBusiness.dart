import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/authFormBusiness.dart';
// import 'http_exception.dart';

// import 'auth_form.dart';
// import 'fuck.dart';
// import 'package:provider/provider.dart';
// import 'auth.dart';
// import 'chat_screen.dart';

class AuthScreenBusiness extends StatefulWidget {
  static const routeName = '/AuthScreenBusiness';
  String phone;
  String user_id;
  bool sup;
  String username;
  bool koko;

  AuthScreenBusiness(
      this.phone, this.user_id, this.sup, this.username, this.koko,
      {super.key});
  @override
  AuthScreenBusinessState createState() => AuthScreenBusinessState();
}

class AuthScreenBusinessState extends State<AuthScreenBusiness> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  final fbm = FirebaseMessaging;

  void _showErrorDialog(String message) {
    setState(() {
      _isLoading = false;
    });

    var errMessage = 'Authentication failed';

    if (message.toString().contains('EMAIL_EXISTS')) {
      errMessage = 'هذا الاسم قد تم استخدامه من قبل';
    } else if (message.toString().contains('INVALID_EMAIL')) {
      errMessage = '@ غير مسموح باستخدام الحرف';
    } else if (message.toString().contains('Badly_Formatted')) {
      errMessage = '@ غير مسموح باستخدام الحرف';
    } else if (message.toString().contains('WEAK_PASSWORD')) {
      errMessage = 'كلمة المرور ضعيفة';
    } else if (message
        .toString()
        .contains('firebase_auth/network-request-failed')) {
      errMessage = 'خطا في الوصول الي الشبكة';
    } else if (message.toString().contains('EMAIL_NOT_FOUND')) {
      errMessage = 'لم نجد مستخدم بهذا الاسم';
    } else if (message.toString().contains('wrong-password')) {
      errMessage = 'كلمة المرور غير صحيحة';
    } else {
      errMessage = 'محاولة فاشلة .. الرجاء المحاولة مرة اخرى';
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حدوث خطأ'),
        content: Text(errMessage),
        actions: <Widget>[
          TextButton(
            child: const Text('موافق'),
            onPressed: () {
              setState(() {
                _isLoading = false;
              });
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
    setState(() {
      _isLoading = false;
    });
  }

  void _submitAuthForm(
    String email,
    String area,
    String category,
    String city,
    String password,
    String username,
    dynamic image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    // AuthResult authResult;

    try {
      final url;
      setState(() {
        _isLoading = true;
      });
      (widget.sup == false || widget.username != '') && widget.koko == false
          ? authResult = await _auth.signInWithEmailAndPassword(
              email: email,
              password: password,
            )
          : authResult = await _auth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
      print('trtrtrtrtrtrtrtrtr');

      if ((city == '' || category == '' || area == '') &&
          widget.sup == true &&
          widget.koko == false) {
        print('no reg reg reg');
        return;
      }
      // if ((widget.sup == false || widget.username != '') &&
      //     widget.koko == false) {
      //   //   if (widget.sup == false || widget.username != '') {
      //   authResult = await _auth.signInWithEmailAndPassword(
      //     email: email,
      //     password: password,
      //   );
      // } else {
      //   authResult = await _auth.createUserWithEmailAndPassword(
      //     email: email,
      //     password: password,
      //   );
      //   print('trtrtrtrtrtrtrtrtr');
      // }
      // final forg = widget.koko
      //     ? await FirebaseFirestore.instance
      //         .collection('customer_details')
      //         .where('phone_num', isEqualTo: widget.phone)
      //         .get()
      //     : await FirebaseFirestore.instance
      //         .collection('customer_details')
      //         .get();
      // final forgottenid = forg.docs.first.id;
      if (image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${authResult.user?.uid}.jpg');
        await ref.putFile(image).whenComplete(() => image);

        url = await ref.getDownloadURL();
      } else {
        url = '';
      }
      if ((widget.sup == true || widget.username != '') && !widget.koko) {
        //     final oppa = Provider.of<Auth>(context, listen: false).userId;

        //   await Firestore.instance
        //       .collection('chato')
        //      .document(oppa)
        //     .setData({'pokeuser': 'x'});
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
            .collection('city')
            .doc(cityyy)
            .collection('areas')
            .where('name', isEqualTo: area)
            .get();
        final areooo = areaaa.docs.first.id;
        print('loooooooooooooooooooooooooooooooooooooooooooooooooooooooooof');
        print(areaaa.docs.first.data()['name']);
        print('loooooooooooooooooooooooooooooooooooooooooooooooooooooooooop');

//  final areadocs = await FirebaseFirestore.instance
//                             .collection('area')
//                             .get();
        // final categorydocs = await FirebaseFirestore.instance
        //     .collection('category')
        //     .doc('1')
        //     .get();
        // final citydocs =
        //     await FirebaseFirestore.instance.collection('city').doc('1').get();
        // final cityname = citydocs.data()!['name'];
        // final categoryname = categorydocs.data()!['name'];

        await FirebaseFirestore.instance
            .collection('business_details')
            .doc(widget.user_id)
            .set({
          'first_uid': widget.user_id,
          'second_uid': authResult.user?.uid,
          'phone_num':
              widget.phone.startsWith('+') ? widget.phone : '+2${widget.phone}',
          'createdAt': Timestamp.now(),
          'name': (email.toString().split('@').first)
              .trim()
              .replaceAll(RegExp(r'_'), ' '),
          'area_id': areooo,
          'area': area,
          'username': email,
          'basicemail': email,
          'basicemailx': email,

          'basicstore_name': username,

          'foundsent': 0,
          'foundseen': 0,
          'city': city,
          'city_id': cityyy,
          'category_id': catyyy,

          'store_name': username,
          'category': category,
          'image_url': image == null
              ? 'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
              : url,
          'messages': 0,
          'seen': 0,
          'sent': 0,
          'orders': 0,
          'upnum': 0,
          'upnumseen': 0,

          'state': 'online',
          'updated': false,

          //  'news': 'New',
          //       'nationality': '',
//'city': '',
//'street': '',
        });
        if (widget.sup == true && !widget.koko) {
          await FirebaseFirestore.instance
              .collection('customer_details')
              .doc(widget.user_id)
              .set({
            'first_uid': widget.user_id,
            'second_uid': authResult.user?.uid,
            'phone_num': widget.phone.startsWith('+')
                ? widget.phone
                : '+2${widget.phone}',
            'createdAt': Timestamp.now(),
            //  'username': username,
            'username': email,
            'basicemail': email,
            'basicemailx': email,

            'basicstore_name': username,

            //   'city': city,
            //  'store_name': storename,
            //   'category': category,
            //    'image_url': url,
            'businesslast': true,
            'messages': 0,
            'seen': 0,
            'sent': 0,
            //  'orders': 0,
            //   'map': 0,
            'state': 'online',
            'lastseen': Timestamp.now(), 'activated': false,
            'updated': false,
            //       'nationality': '',
//'city': '',
//'street': '',
          });
        }
        if (widget.sup == false) {
          FirebaseFirestore.instance
              .collection('customer_details')
              .doc(widget.user_id)
              .update({
            'businesslast': true,
            'state': 'online',
            'lastseen': Timestamp.now(),
          });
        }
        final citydoc = await FirebaseFirestore.instance
            .collection('city')
            .where('name', isEqualTo: city)
            .get();
        final cityid = citydoc.docs.first.id;
        await FirebaseFirestore.instance
            .collection('city')
            .doc(cityid)
            .collection('shopsInThisCity')
            .doc(authResult.user?.uid)
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
            .doc(authResult.user?.uid)
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
            .collection('city')
            .doc(cityid)
            .collection('areas')
            .where('name', isEqualTo: area)
            .get();
        final areaid = areadoc.docs.first.id;
        await FirebaseFirestore.instance
            .collection('city')
            .doc(cityid)
            .collection('areas')
            .doc(areaid)
            .collection('shopsInThisArea')
            .doc(authResult.user?.uid)
            .set({'name': username});
        final countlisdocsss = await FirebaseFirestore.instance
            .collection('city')
            .doc(cityid)
            .collection('areas')
            .doc(areaid)
            .collection('shopsInThisArea')
            .get();
        final countlisss = countlisdocsss.docs.length;
        await FirebaseFirestore.instance
            .collection('city')
            .doc(cityid)
            .collection('areas')
            .doc(areaid)
            .update({'shopsInThisArealength': countlisss});
      }
      if (widget.koko) {
        print(widget.phone);
        print(authResult.user?.uid);
        print(email);
        print("خخخخخخخخخخخخخخخخخخخخخخخخخخ");
        // final forg = await FirebaseFirestore.instance
        //     .collection('customer_details')
        //     .where({'phone_num': widget.phone}).get();
        // final forgottenid = forg.docs.first.id;
        //   print(forgottenid);

        FirebaseFirestore.instance
            .collection('customer_details')
            .doc(widget.user_id)
            .update({
          'businesslast': true,
          'state': 'online',
          'lastseen': Timestamp.now(),
          'basicemailx': email,
          'second_uid': authResult.user?.uid,
        });
        // forgottenbusid == 'null'?  print("no business"):
        FirebaseFirestore.instance
            .collection('business_details')
            .doc(widget.user_id)
            .update({
          'basicemailx': email,
          'second_uid': authResult.user?.uid,
        });
        //  : print("no business");
        print("9999999999999999999999777777777777777777");
      }
      if (widget.sup == false) {
        if (widget.koko == false) {
          FirebaseFirestore.instance
              .collection('customer_details')
              .doc(widget.user_id)
              .update({
            'businesslast': true,
            'state': 'online',
            'lastseen': Timestamp.now(),
          });
        } else {
          print(widget.phone);
          print(authResult.user?.uid);
          print(email);
          print("خخخخخخخخخخخخخخخخخخخخخخخخخخ");
          // final forg = await FirebaseFirestore.instance
          //     .collection('customer_details')
          //     .where({'phone_num': widget.phone}).get();
          // final forgottenid = forg.docs.first.id;
          //   print(forgottenid);

          FirebaseFirestore.instance
              .collection('customer_details')
              .doc(widget.user_id)
              .update({
            'businesslast': true,
            'state': 'online',
            'lastseen': Timestamp.now(),
            'basicemailx': email,
            'second_uid': authResult.user?.uid,
          });
          // forgottenbusid == 'null'?  print("no business"):
          FirebaseFirestore.instance
              .collection('business_details')
              .doc(widget.user_id)
              .update({
            'basicemailx': email,
            'second_uid': authResult.user?.uid,
          });
          //  : print("no business");
          print("9999999999999999999999777777777777777777");
        }
      }
      void _showErrorDialog(String message) {
        var errMessage = 'Authentication failed';

        if (message.toString().contains('EMAIL_EXISTS')) {
          errMessage = 'هذا الاسم قد تم استخدامه من قبل';
        } else if (message.toString().contains('INVALID_EMAIL')) {
          errMessage = '@ غير مسموح باستخدام الحرف';
        } else if (message.toString().contains('Badly_Formatted')) {
          errMessage = '@ غير مسموح باستخدام الحرف';
        } else if (message.toString().contains('WEAK_PASSWORD')) {
          errMessage = 'كلمة المرور ضعيفة';
        } else if (message
            .toString()
            .contains('firebase_auth/network-request-failed')) {
          errMessage = 'خطا في الوصول الي الشبكة';
        } else if (message.toString().contains('EMAIL_NOT_FOUND')) {
          errMessage = 'لم نجد مستخدم بهذا الاسم';
        } else if (message.toString().contains('wrong-password')) {
          errMessage = 'كلمة المرور غير صحيحة';
        } else {
          errMessage = 'محاولة فاشلة .. الرجاء المحاولة مرة اخرى';
        }
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('فشل المحاولة'),
            content: Text(errMessage),
            actions: <Widget>[
              TextButton(
                child: const Text('موافق'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    } on HttpException catch (err) {
      var errMessage = 'Authentication failed';
      if (err.toString().contains('EMAIL_EXISTS')) {
        errMessage = 'هذا الاسم قد تم استخدامه من قبل';
      } else if (err.toString().contains('INVALID_EMAIL')) {
        errMessage = '@ غير مسموح باستخدام الحرف';
      } else if (err.toString().contains('Badly_Formatted')) {
        errMessage = '@ غير مسموح باستخدام الحرف';
      } else if (err.toString().contains('WEAK_PASSWORD')) {
        errMessage = 'كلمة المرور ضعيفة';
      } else if (err
          .toString()
          .contains('firebase_auth/network-request-failed')) {
        errMessage = 'خطا في الوصول الي الشبكة';
      } else if (err.toString().contains('EMAIL_NOT_FOUND')) {
        errMessage = 'لم نجد مستخدم بهذا الاسم';
      } else if (err.toString().contains('wrong-password')) {
        errMessage = 'كلمة المرور غير صحيحة';
      } else {
        errMessage = 'محاولة فاشلة .. الرجاء المحاولة مرة اخرى';
      }
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
      _showErrorDialog(errMessage);
    } catch (err) {
      if (err.toString().isEmpty) {
        null;
      } else {
        final errMessage = err.toString();
        _showErrorDialog(errMessage);

        print(err);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //  if (FirebaseAuth.instance.currentUser() != null) {
//      return Fuck();
    //  }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        // appBar: widget.user_id == 'result.user!.uidx'
        //     ? AppBar(
        //         title: const Text('alaqy auth'),
        //         actions: [
        //           IconButton(
        //               onPressed: () {
        //                 Navigator.of(context).pushReplacementNamed('/');
        //               },
        //               icon: const Icon(
        //                 Icons.swap_horizontal_circle_sharp,
        //                 size: 40,
        //               ))
        //         ],
        //       )
        //     : null,
        body: Container(
            child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: 20,
          ),
          // widget.user_id == 'result.user!.uid'
          //     ? AnimatedTextKit(
          //         animatedTexts: [
          //           ColorizeAnimatedText('',
          //               colors: [
          //                 Colors.tealAccent,
          //                 Colors.lightGreen,
          //                 Colors.cyanAccent,
          //               ],
          //               textStyle: const TextStyle(
          //                 fontSize: 23,
          //               ),
          //               textAlign: TextAlign.center,
          //               speed: const Duration(milliseconds: 100)),
          //         ],
          //         repeatForever: true,
          //       )
          //     : const SizedBox(
          //         height: 20,
          //       ),
          // widget.user_id == 'result.user!.uid'
          //     ? const Divider()
          //     : const SizedBox(
          //         height: 30,
          //       ),
          // AnimatedTextKit(
          //   animatedTexts: [
          //     !widget.sup
          //         ? ColorizeAnimatedText('Login ',
          //             colors: [
          //               Colors.tealAccent,
          //               Colors.deepPurple,
          //               Colors.cyanAccent,
          //             ],
          //             textStyle: const TextStyle(
          //               fontSize: 23,
          //             ),
          //             textAlign: TextAlign.center,
          //             speed: const Duration(milliseconds: 100))
          //         : ColorizeAnimatedText('Business account form',
          //             colors: [
          //               Colors.tealAccent,
          //               Colors.deepPurple,
          //               Colors.cyanAccent,
          //             ],
          //             textStyle: const TextStyle(
          //               fontSize: 23,
          //             ),
          //             textAlign: TextAlign.center,
          //             speed: const Duration(milliseconds: 100)),
          //   ],
          //   repeatForever: true,
          // ),
          // const Icon(
          //   Icons.business_center_outlined,
          //   color: Colors.deepPurple,
          // ),
          AuthFormBusiness(_submitAuthForm, _isLoading, widget.sup,
              widget.phone, widget.username, widget.koko, widget.user_id),
        ]))));
  }
}
