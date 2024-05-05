import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/userChoose.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SPLASHSCREEN.dart';
import 'app_drawer.dart';
import 'badge.dart';
import 'profilepic.dart';
import 'user_main.dart';

class UpdateUser extends StatefulWidget {
  static const routeName = '/updateuser';

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _controller = new TextEditingController();
  final _controllername = new TextEditingController();
  final userid = FirebaseAuth.instance.currentUser!.uid;

  var _enteredMessage = '';
  var _enteredMessagename = '';
  var _userImageFile;
  void _pickedImage(dynamic image) async {
    _userImageFile = image;
// void _submitAuthForm(
    //   File image,
//  ) async {
    final url;
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('update${DateTime.now()}.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
      final userdoc = await FirebaseFirestore.instance
          .collection('customer_details')
          .where('second_uid', isEqualTo: userid)
          .get();
      final docid = userdoc.docs.first.id;
      await FirebaseFirestore.instance
          .collection('customer_details')
          .doc(docid)
          .update({
        'image_url': url,
      });
      final userdocx = await FirebaseFirestore.instance
          .collection('listing')
          .where('userid2', isEqualTo: userid)
          .get();
      if (userdocx.docs.isNotEmpty) {
        //  final List<String> items = [];
        for (var i = 0; i < userdocx.docs.length; i++) {
          //   items.add(userdocx.docs[i]['cattitle']);
          final docidx = userdocx.docs[i].id;
          final chax = await FirebaseFirestore.instance
              .collection('chat')
              .doc(docidx)
              .collection('chatx')
              .get();
          for (var x = 0; x < chax.docs.length; x++) {
            final chaxid = chax.docs[x].id;
            await FirebaseFirestore.instance
                .collection('chat')
                .doc(docidx)
                .collection('chatx')
                .doc(chaxid)
                .update({
              'userimage': url,
            });
          }
        }
      }
      _controller.text = url;
    } else {
      url = '';
    }

    // }
    Navigator.of(context).pushReplacementNamed(UpdateUser.routeName);
  }

  void _sendMessage() async {
    final userdoc = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('second_uid', isEqualTo: userid)
        .get();
    final docid = userdoc.docs.first.id;
//  final cityname = userdoc.docs.first.data()['city'];
//     final categoryname = userdoc.docs.first.data()['category'];
//  final areaname = userdoc.docs.first.data()['area'];
// final citydocs = await FirebaseFirestore.instance
//         .collection('city')
//         .where('name', isEqualTo: cityname)
//         .get();
//     final categorydocs = await FirebaseFirestore.instance
//         .collection('category')
//         .where('name', isEqualTo: categoryname)
//         .get();
// final areadocs = await FirebaseFirestore.instance
//         .collection('area')
//         .where('name', isEqualTo: areaname)
//         .get();
//  final cityid = citydocs.docs.first.id;
//     final categoryid = categorydocs.docs.first.id;
//  final areaid = citydocs.docs.first.id;
//  await FirebaseFirestore.instance
//         .collection('city')
//         .doc(cityid)
//         .collection('listingsInThisCity')
//         .doc(userid)
//         .update({
//       'name': _enteredMessagename.trim(),
//     });
//  await FirebaseFirestore.instance
//         .collection('category')
//         .doc(categoryid)
//         .collection('listingsInThisCategory')
//         .doc(userid)
//         .update({
//       'name': _enteredMessagename.trim(),
//     });
// await FirebaseFirestore.instance
//         .collection('area')
//         .doc(categoryid)
//         .collection('listingsInThisArea')
//         .doc(userid)
//         .update({
//       'name': _enteredMessagename.trim(),
//     });
    FirebaseFirestore.instance
        .collection('customer_details')
        .doc(docid)
        .update({
      'username':
          "${_enteredMessagename.trim().replaceAll(RegExp(r' '), '_')}@alaqy.com",
      'name': _enteredMessagename.trim(),
      'updated': true,
    });
    final userdocc = await FirebaseFirestore.instance
        .collection('business_details')
        .where('second_uid', isEqualTo: userid)
        .get();
    if (userdocc.docs.isNotEmpty) {
      final docidd = userdocc.docs.first.id;
      await FirebaseFirestore.instance
          .collection('business_details')
          .doc(docidd)
          .update({
        'username':
            "${_enteredMessagename.trim().replaceAll(RegExp(r' '), '_')}@alaqy.com",
        'name': _enteredMessagename.trim(),
      });
    }
    final userdocx = await FirebaseFirestore.instance
        .collection('listing')
        .where('userid2', isEqualTo: userid)
        .get();
    if (userdocx.docs.isNotEmpty) {
      //  final List<String> items = [];
      for (var i = 0; i < userdocx.docs.length; i++) {
        //   items.add(userdocx.docs[i]['cattitle']);
        var cityname = userdocx.docs[i].data()['city'];
        var categoryname = userdocx.docs[i].data()['category'];
        var areaname = userdocx.docs[i].data()['area'];
        var citydocs = await FirebaseFirestore.instance
            .collection('city')
            .where('name', isEqualTo: cityname)
            .get();
        var categorydocs = await FirebaseFirestore.instance
            .collection('category')
            .where('name', isEqualTo: categoryname)
            .get();
        var areadocs = await FirebaseFirestore.instance
            .collection('area')
            .where('name', isEqualTo: areaname)
            .get();
        var cityid = citydocs.docs.first.id;
        var categoryid = categorydocs.docs.first.id;
        var areaid = areadocs.docs.first.id;
        FirebaseFirestore.instance
            .collection('city')
            .doc(cityid)
            .collection('listingsInThisCity')
            .doc(userid)
            .update({
          'name': _enteredMessagename.trim(),
        });
        FirebaseFirestore.instance
            .collection('category')
            .doc(categoryid)
            .collection('listingsInThisCategory')
            .doc(userid)
            .update({
          'name': _enteredMessagename.trim(),
        });
        FirebaseFirestore.instance
            .collection('area')
            .doc(areaid)
            .collection('listingsInThisArea')
            .doc(userid)
            .update({
          'name': _enteredMessagename.trim(),
        });
        final docidx = userdocx.docs[i].id;
        FirebaseFirestore.instance.collection('listing').doc(docidx).update({
          'username': _enteredMessagename
              .trim() //.replaceAll(RegExp(r' '), '_')}@alaqy.com",
          // 'name': _enteredMessagename.trim(),
        });
      }
      final userdocx2 = await FirebaseFirestore.instance
          .collection('listdetails')
          .where('userid2', isEqualTo: userid)
          .get();
      if (userdocx2.docs.isNotEmpty) {
        //  final List<String> items = [];
        for (var i = 0; i < userdocx2.docs.length; i++) {
          //   items.add(userdocx.docs[i]['cattitle']);
          final docidx2 = userdocx2.docs[i].id;
          FirebaseFirestore.instance
              .collection('listdetails')
              .doc(docidx2)
              .update({
            'username': _enteredMessagename
                .trim() //.replaceAll(RegExp(r' '), '_')}@alaqy.com",
            // 'name': _enteredMessagename.trim(),
          });
          final chax = await FirebaseFirestore.instance
              .collection('chat')
              .doc(docidx2)
              .collection('chatx')
              .get();
          for (var x = 0; x < chax.docs.length; x++) {
            final chaxid = chax.docs[i].id;
            final chaxstorename = chax.docs[i].data()['store_name'];
            final chaxusername = chax.docs[i].data()['username'];
            final seendoc = await FirebaseFirestore.instance
                .collection('chat')
                .doc(docidx2)
                .collection('chatx')
                .doc('$chaxusername$chaxstorename')
                .get();
            final seendocx = await FirebaseFirestore.instance
                .collection('chat')
                .doc(docidx2)
                .collection('chatx')
                .doc('${chaxusername}bus$chaxstorename')
                .get();
            // seendoc.exists
            //     ? await FirebaseFirestore.instance
            //         .collection('chat')
            //         .doc(docidx2)
            //         .collection('chatx')
            //         .doc('$chaxusername$chaxstorename')
            //         .delete()
            //     : null;
            // seendocx.exists
            //     ? await FirebaseFirestore.instance
            //         .collection('chat')
            //         .doc(docidx2)
            //         .collection('chatx')
            //         .doc('${chaxusername}bus$chaxstorename')
            //         .delete()
            //     : null;
            FirebaseFirestore.instance
                .collection('chat')
                .doc(docidx2)
                .collection('chatx')
                .doc(chaxid)
                .update({
              'username': _enteredMessagename.trim(),
              //  'combo': '${_enteredMessagename.trim()}$chaxstorename'
            });
          }
        }
      }
    }
    FocusScope.of(context).unfocus();
    _controller.clear();

    Navigator.of(context).pushReplacementNamed(UpdateUser.routeName);
  }

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
              ' الحساب الشخصي',
              style: const TextStyle(
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
        body: SizedBox(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('customer_details')
                    .where('second_uid', isEqualTo: userid)
                    .snapshots(),
                builder: (ctx, chatSnapshottt) {
                  // if (chatSnapshottt.connectionState ==
                  //     ConnectionState.waiting) {
                  //   return const Center(
                  //     child: Text('Loading...'),
                  //   );
                  // }
                  if (chatSnapshottt.hasData == false) {
                    return SplashScreen();
// const Center(
//                         child: CircularProgressIndicator(),
//                       );;
                  }
                  final chatdocs = chatSnapshottt.data!.docs;
                  final imageurl = chatdocs.first.data()['image_url'];
                  final updated = chatdocs.first.data()['updated'];
                  final username = chatdocs.first.data()['username'];
                  final phone = chatdocs.first.data()['phone_num'];

                  return SingleChildScrollView(
                      child: SizedBox(
                          child: Column(children: [
                    Center(
                      child: updated
                          ? const Text(
                              'تم التعديل من قبل',
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                              ),
                            )
                          : const Text(
                              'التعديل!',
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      phone,
                      style:
                          TextStyle(fontFamily: 'Tajawal', color: Colors.black),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    profilepic(_pickedImage, imageurl, updated),
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(8),
                      //    child: Expanded(
                      child: TextFormField(
                        readOnly: updated == true ? true : false,
                        textAlign: TextAlign.center,

                        decoration: InputDecoration(
                          label: Center(
                              child: Text(
                            ' تعديل الإسم',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Color.fromARGB(48, 0, 0, 0)),
                          )),
// helperStyle: TextStyle(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300)),
                          filled:
                              true, //_phoneController.text == '' ? true : false,
                          fillColor: Colors.white,
                          // hintText: "Phone Number"
                        ),
                        controller: _controllername,
                        validator: (value) {
                          if (value != null) {
                            return (value.isEmpty)
                                ? 'برجاء إدخال إسم مناسب'
                                : null;
                          }
                          if (value != null) {
                            return (value.isEmpty || value.length < 4)
                                ? 'ليس اقل من ٤ حروف'
                                : null;
                          }
                        },
                        // decoration: const InputDecoration(
                        //     labelText: 'update user name'),
                        onChanged: (value) {
                          setState(() {
                            _enteredMessagename = value;
                          });
                        },
                      ),
                    ),
                    Stack(
                      children: [
                        Center(
                            child: TextButton(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 9,
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                      color: Color.fromARGB(47, 96, 125, 139),
                                    ),
                                    child: Text(
                                      'موافق',
                                      style: TextStyle(
                                        fontFamily: 'Tajawal',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber.shade500,
                                      ),
                                    )),
                                onPressed: () {
                                  _enteredMessagename.trim().isEmpty ||
                                          _enteredMessagename.trim().length < 3
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 2),
                                            content: Text(
                                                'من فضلك إدخل إسم يحتوي على ثلاث حروف او اكثر'),
                                            backgroundColor:
                                                Theme.of(context).errorColor,
                                          ),
                                        )
                                      : showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title:
                                                const Text('تم التحديث بنجاح'),
                                            content: const Center(
                                                child:
                                                    LinearProgressIndicator()),
                                            actions: <Widget>[
                                              TextButton(
                                                child: AnimatedTextKit(
                                                  animatedTexts: [
                                                    TyperAnimatedText(
                                                      '',
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Colors.cyanAccent,
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                      speed: const Duration(
                                                          seconds: 3),
                                                    )
                                                  ],
                                                  totalRepeatCount: 2,
                                                  // repeatForever: true,
                                                  onNext: (p1, p2) {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            UpdateUser
                                                                .routeName);
                                                    Navigator.of(ctx)
                                                        .pop(false);
                                                  },
                                                ),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        );
                                  _enteredMessagename.trim().isEmpty ||
                                          _enteredMessagename.trim().length < 3
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 2),
                                            content: Text(
                                                'من فضلك إدخل إسم يحتوي على ثلاث حروف او اكثر'),
                                            backgroundColor:
                                                Theme.of(context).errorColor,
                                          ),
                                        )
                                      : _sendMessage();
                                }))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        'يمكنك تعديل الإسم الشخصي مرة واحدة فقط',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Colors.redAccent,
                        ),
                      ),
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
                            speed: const Duration(milliseconds: 100),
                          )
                        ],
                        totalRepeatCount: 1,
                        onNext: (p0, p1) {
                          setState(() {
                            _controllername.text =
                                ((username.toString().split('@').first)
                                    .trim()
                                    .replaceAll(RegExp(r'_'), ' '));
                          });
                        }),
                  ])));
                })),
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
