import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'foundcards.dart';

// import 'categoriesscreen.dart';
// import 'welcome.dart';
// import 'package:intl/intl_standalone.dart';
// import 'dart:io';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'auth_screen.dart';
// import 'great_places.dart';
// import 'places_list_screen.dart';
// import 'add_place_screen.dart';
// import 'place_detail_screen.dart';
// import 'auth.dart';
// import 'splash_screen.dart';

class FoundOrders extends StatelessWidget {
  static const routeName = '/FoundOrders';
  final userx = FirebaseAuth.instance.currentUser!.uid;
  // void _selectPage() async {
  //   final useri = await FirebaseFirestore.instance
  //       .collection('business_details')
  //       .where('second_uid', isEqualTo: userx)
  //       .get();
  //   final idx = useri.docs.first.id;
  //   final sen = useri.docs.first.data()['foundsent'];
  //   FirebaseFirestore.instance
  //       .collection('business_details')
  //       .doc(idx)
  //       .update({'foundseen': sen});
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

  @override
  Widget build(BuildContext context) {
    // _selectPage();
    final size = MediaQuery.of(context).size;
    final heightx = size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          // const SizedBox(
          //   height: 10,
          // ),
          // Center(
          //     child: SizedBox(
          //         //   height: 100,
          //         //   width: double.infinity,
          //         child: Image.asset(
          //   'assets/alaqy.jpeg',
          //   fit: BoxFit.contain,
          // ))),
          // const SizedBox(
          //   height: 10,
          // ),
          SizedBox(height: heightx - 215, child: const foundCards()),

          // AnimatedTextKit(
          //   animatedTexts: [
          //     TyperAnimatedText(
          //       '',
          //       textStyle: const TextStyle(
          //         fontSize: 20,
          //         color: Colors.cyanAccent,
          //         overflow: TextOverflow.visible,
          //       ),
          //       speed: const Duration(seconds: 5),
          //     )
          //   ],
          //   // totalRepeatCount: 2,
          //   repeatForever: true,
          //   onNext: (p0, p1) {
          //     _selectPage();
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
