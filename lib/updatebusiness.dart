//import 'dart:html';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/app_drawer2.dart';
import 'package:flutter_alaqy/businessChoose.dart';
import 'package:flutter_alaqy/business_main.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SPLASHSCREEN.dart';
import 'badge.dart';
import 'profilepic.dart';

class UpdateBusiness extends StatefulWidget {
  static const routeName = '/updateBusiness';

  @override
  UpdateBusinessState createState() => UpdateBusinessState();
}

class UpdateBusinessState extends State<UpdateBusiness> {
  final _controller = new TextEditingController();
  final _controllername = new TextEditingController();
  final userid = FirebaseAuth.instance.currentUser!.uid;
  bool cityon = false;
  bool caton = false;
  bool aron = false;

  var city;
  var category;
  var area;
  var png;
  String? stname;
  var _enteredMessage = '';
  var _enteredMessagename = '';
  var _userImageFile;
  var urlx;
  var spin = false;
  var loading = true;

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
      setState(() {
        urlx = url;
        spin = true;
      });
      // final userdoc = await FirebaseFirestore.instance
      //     .collection('business_details')
      //     .where('second_uid', isEqualTo: userid)
      //     .get();
      // final docid = userdoc.docs.first.id;
      // final storename = userdoc.docs.first.data()['store_name'];
      // final basicstorename = userdoc.docs.first.data()['basicstore_name'];

      // print(docid);
      // print('docid');

      // await FirebaseFirestore.instance
      //     .collection('business_details')
      //     .doc(docid)
      //     .update({
      //   'image_url': url,
      // });

      // final userdocx = await FirebaseFirestore.instance
      //     .collection('listing')
      //     .where(basicstorename)
      //     .get();
      // final opp = userdocx.docs.toList();
      // if (userdocx.docs.isNotEmpty) {
      //   for (var i = 0; i < userdocx.docs.length; i++) {
      //     //   kop.add(opp[i].id);
      //     print('q');
      //     print(opp[i].id);

      //     final chax = await FirebaseFirestore.instance
      //         .collection('chat')
      //         .doc(opp[i].id)
      //         .collection('chatx')
      //         .where('basicstore_name', isEqualTo: basicstorename)
      //         .get();

      //     for (var x = 0; x < chax.docs.length; x++) {
      //       print('qqq');

      //       final col = chax.docs[x].id;
      //       print(col);
      //       await FirebaseFirestore.instance
      //           .collection('chat')
      //           .doc(opp[i].id)
      //           .collection('chatx')
      //           .doc(col)
      //           .update({
      //         'stroeimage': url,
      //       });
      //     }
      //   }
      // }
      _controller.text = url;
    } else {
      url = '';
    }

    // }
  }

  void _sendMessage(String storename) async {
    final userdoc = await FirebaseFirestore.instance
        .collection('business_details')
        .where('second_uid', isEqualTo: userid)
        .get();
    final docid = userdoc.docs.first.id;
    final cityname = userdoc.docs.first.data()['city'];
    final categoryname = userdoc.docs.first.data()['category'];
    final areaname = userdoc.docs.first.data()['area'];
    final storename = userdoc.docs.first.data()['store_name'];
    final koshk = await FirebaseFirestore.instance
        .collection('koshk')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (koshk.exists) {
      print(
          '((((((((((((((((((((((((((((((((((((object))))))))))))))))))))))))))))))))))))');
      FirebaseFirestore.instance
          .collection('koshk')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'store_name': _enteredMessage.trim().isEmpty
            ? _controllername.text.trim()
            : _enteredMessage.trim(),
        'image_url': urlx
      });
      final userdocc = await FirebaseFirestore.instance
          .collection('products')
          .where('storename', isEqualTo: storename)
          .get();
      if (userdocc.docs.isNotEmpty) {
        for (var r = 0; r < userdocc.docs.length; r++) {
          FirebaseFirestore.instance
              .collection('products')
              .doc(userdocc.docs[r].id)
              .update({
            'storename': _enteredMessage.trim().isEmpty
                ? _controllername.text.trim()
                : _enteredMessage.trim(),
          });
        }
      }

      final userdosc = await FirebaseFirestore.instance
          .collection('branches')
          .where('username', isEqualTo: storename)
          .get();
      if (userdosc.docs.isNotEmpty) {
        for (var r = 0; r < userdosc.docs.length; r++) {
          FirebaseFirestore.instance
              .collection('branches')
              .doc(userdosc.docs[r].id)
              .update({
            'username': _controllername.text.trim(),
          });
        }
      }
    }
    await FirebaseFirestore.instance
        .collection('business_details')
        .doc(docid)
        .update({
      'store_name': _controllername.text.trim(),
      'updated': true,
      'image_url': urlx
    });

    final citydocs = await FirebaseFirestore.instance
        .collection('city')
        .where('name', isEqualTo: cityname)
        .get();
    final categorydocs = await FirebaseFirestore.instance
        .collection('category')
        .where('name', isEqualTo: categoryname)
        .get();
    final cityid = citydocs.docs.first.id;
    final areaaa = await FirebaseFirestore.instance
        .collection('city')
        .doc(cityid)
        .collection('areas')
        .where('name', isEqualTo: areaname)
        .get();
    final areaid = areaaa.docs.first.id;
    final categoryid = categorydocs.docs.first.id;
    // await FirebaseFirestore.instance
    //     .collection('city')
    //     .doc(cityid)
    //     .collection('shopsInThisCity')
    //     .doc(userid)
    //     .update({
    //   'name': _enteredMessagename.trim(),
    // });
    // await FirebaseFirestore.instance
    //     .collection('category')
    //     .doc(categoryid)
    //     .collection('shopsInThisCategory')
    //     .doc(userid)
    //     .update({
    //   'name': _enteredMessagename.trim(),
    // });
    // await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .collection('shopsInThisArea')
    //     .doc(userid)
    //     .set({
    //   'name': _enteredMessagename.trim(),
    // });
    // final countlisdocsss = await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .collection('shopsInThisArea')
    //     .get();
    // final countlisss = countlisdocsss.docs.length;
    // await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .update({'shopsInThisArealength': countlisss});

    final userdocx = await FirebaseFirestore.instance
        .collection('listing')
        .where(storename)
        .get();
    final opp = userdocx.docs.toList();
    if (userdocx.docs.isNotEmpty) {
      for (var i = 0; i < userdocx.docs.length; i++) {
        //   kop.add(opp[i].id);
        print('q');
        print(opp[i].id);

        final chax = await FirebaseFirestore.instance
            .collection('chat')
            .doc(opp[i].id)
            .collection('chatx')
            .where('basicstore_name', isEqualTo: storename)
            .get();

        for (var x = 0; x < chax.docs.length; x++) {
          print('qqq');

          final col = chax.docs[x].id;
          print(col);
          await FirebaseFirestore.instance
              .collection('chat')
              .doc(opp[i].id)
              .collection('chatx')
              .doc(col)
              .update({
            'store_name': _enteredMessage.trim().isEmpty
                ? _controllername.text.trim()
                : _enteredMessage.trim(),
          });
          await FirebaseFirestore.instance
              .collection('chat')
              .doc(opp[i].id)
              .update({
            storename: _enteredMessage.trim().isEmpty
                ? _controllername.text.trim()
                : _enteredMessage.trim(),
          });
        }
        final comment = await FirebaseFirestore.instance
            .collection('reply_comment')
            .doc(opp[i].id)
            .collection('reply')
            .doc(docid)
            .get();
        comment.exists
            ? await FirebaseFirestore.instance
                .collection('reply_comment')
                .doc(opp[i].id)
                .collection('reply')
                .doc(docid)
                .update({'storename': _enteredMessagename.trim()})
            : null;
      }
    }

    FocusScope.of(context).unfocus();
    _controller.clear();
    Navigator.of(context).pushReplacementNamed(UpdateBusiness.routeName);
  }

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");
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
              'حسابي البيزنس ',
              style: const TextStyle(
                fontFamily: 'Tajawal',
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(businessChoose.routeName),

// Navigator.popAndPushNamed(context, '/'),
                  icon: const Icon(Icons.home)),
            ]),
        drawer: AppDrawer2(),
        body: SingleChildScrollView(
            child: SizedBox(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('business_details')
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
                      }
// const Center(
//                         child: CircularProgressIndicator(),
//                       );                  }
                      final chatdocs = chatSnapshottt.data!.docs;

                      final imageurl = chatdocs.first.data()['image_url'];
                      final updated = chatdocs.first.data()['updated'];
                      var _city = chatdocs.first.data()['city'];
                      var _category = chatdocs.first.data()['category'];
                      var _cityx = chatdocs.first.data()['city_id'];
                      var _cityxx = _cityx ?? '1';
                      var _areax = chatdocs.first.data()['area_id'];
                      var _area = chatdocs.first.data()['area'];
                      var _categoryx = chatdocs.first.data()['category_id'];
                      final busid = chatdocs.first.id;
                      var image = urlx ?? imageurl;
                      final storename =
                          chatdocs.first.data()['basicstore_name'];
                      final basicstorename =
                          chatdocs.first.data()['basicstore_name'];
                      final storenamelast = chatdocs.first.data()['store_name'];
                      final docid = chatdocs.first.id;
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
                          style: TextStyle(
                              fontFamily: 'Tajawal', color: Colors.black),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        urlx == null
                            ? profilepic(_pickedImage, imageurl, updated)
                            : profilepic(_pickedImage, urlx, updated),
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          // child: Expanded(
                          child: TextFormField(
                            readOnly: updated == true ? true : false,
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                              label: Center(
                                  child: Text(
                                'تعديل اسم المتجر',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    color: Color.fromARGB(48, 0, 0, 0)),
                              )),
// helperStyle: TextStyle(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
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
                                    ? 'الرجاء وضع اسم مناسب'
                                    : null;
                              }
                              if (value != null) {
                                return (value.isEmpty || value.length < 4)
                                    ? 'اربعة حروف على الاقل'
                                    : null;
                              }
                            },
                            // decoration: const InputDecoration(
                            //     labelText: 'update user name'),
                            onChanged: (value) {
                              setState(() {
                                _enteredMessagename = value;

                                spin = true;
                              });
                            },
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(top: 8),
                        //   padding: const EdgeInsets.all(8),
                        //   child: Expanded(
                        //     child: TextFormField(
                        //       readOnly: updated == true ? true : false,
                        //       controller: _controllername,
                        //       validator: (value) {
                        //         if (value != null) {
                        //           return (value.isEmpty)
                        //               ? 'Please enter a valid storename.'
                        //               : null;
                        //         }
                        //         if (value != null) {
                        //           return (value.isEmpty || value.length < 4)
                        //               ? 'Please enter at least 4 characters'
                        //               : null;
                        //         }
                        //       },
                        //       decoration: const InputDecoration(
                        //           labelText: 'update store name',
                        //           icon: Icon(Icons.edit)),
                        //       onChanged: (value) {
                        //         setState(() {
                        //           _enteredMessagename = value;
                        //           spin = true;
                        //         });
                        //       },
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: 5,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('city')
                                .snapshots(),
                            builder: (ctx, userSnapshot) {
                              if (userSnapshot.hasData == false) {
                                return const Center(child: Text(' Loading...'));
                              }

                              final chatDocs = userSnapshot.hasData
                                  ? userSnapshot.data
                                  : null;
                              List names = [];
                              List<Widget> nnn = [];
                              List<DropdownMenuItem> mmm = [];
                              for (var x = 0; x < chatDocs!.docs.length; x++) {
                                names.add(chatDocs.docs[x].data()['name']);
                              }
                              for (var r = 0; r < names.length; r++) {
                                nnn.add(Text(names[r]));
                                mmm.add(DropdownMenuItem(
                                    value: names[r],
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          const Icon(
                                              Icons.location_city_outlined),
                                          const SizedBox(width: 2),
                                          Text(names[r]),
                                        ],
                                      ),
                                    )));
                              }
                              return SizedBox(
                                  height: 50,
                                  //    width: double.infinity,
                                  child: Container(
                                      width: 260,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey,
                                          // strokeAlign:
                                          //     BorderSide.strokeAlignOutside
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      // child: Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 120,
                                          child: ListTile(
                                            leading: Text(
                                              city ?? _city ?? names[0],
                                              style: TextStyle(
                                                  color: cityon == false
                                                      ? Colors.grey
                                                      : Colors.deepPurple),
                                            ),
                                            trailing: DropdownButton(
                                              underline: Text(
                                                'المدينة',
                                                style: TextStyle(
                                                    color: cityon == false
                                                        ? Colors.grey
                                                        : Colors.amberAccent),
                                              ),
                                              // icon: Icon(Icons.location_city_outlined,
                                              //     color: cityon == false
                                              //         ? Colors.grey
                                              //         : Colors.deepPurple),
                                              onChanged: (value) async {
                                                if (!updated) {
                                                  for (var r = 0;
                                                      r < names.length;
                                                      r++) {
                                                    if (value == names[r]) {
                                                      city = names[r];
                                                      setState(() {
                                                        cityon = true;
                                                        spin = true;
                                                      });
                                                    }
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              selectedItemBuilder:
                                                  (BuildContext context) {
                                                return nnn;
                                              },
                                              items: mmm,
                                            ),
                                            onTap: () {},
                                          ))));
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('category')
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
                              final chatDocs = userSnapshot.hasData
                                  ? userSnapshot.data
                                  : null;
                              List names = [];
                              List<Widget> nnn = [];
                              List<DropdownMenuItem> mmm = [];
                              for (var x = 0; x < chatDocs!.docs.length; x++) {
                                names.add(chatDocs.docs[x].data()['name']);
                              }
                              for (var r = 0; r < names.length; r++) {
                                nnn.add(Text(names[r]));
                                mmm.add(DropdownMenuItem(
                                    value: names[r],
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          const Icon(Icons.category_outlined),
                                          const SizedBox(width: 2),
                                          Text(names[r]),
                                        ],
                                      ),
                                    )));
                              }
                              return SizedBox(
                                  height: 50,
                                  //    width: double.infinity,
                                  child: Container(
                                      width: 260,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey,
                                          // strokeAlign:
                                          //     BorderSide.strokeAlignOutside
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      // child: Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 120,
                                          child: ListTile(
                                            leading: Text(
                                              category ?? _category ?? names[0],
                                              style: TextStyle(
                                                  color: caton == false
                                                      ? Colors.grey
                                                      : Colors.deepPurple),
                                            ),
                                            trailing: DropdownButton(
                                              underline: Text(
                                                '    الصنف',
                                                style: TextStyle(
                                                    color: caton == false
                                                        ? Colors.grey
                                                        : Colors.tealAccent),
                                              ),
                                              // icon: Icon(Icons.category_outlined,
                                              //     color: caton == false
                                              //         ? Colors.grey
                                              //         : Colors.deepPurple),
                                              onChanged: (value) async {
                                                if (!updated) {
                                                  for (var r = 0;
                                                      r < names.length;
                                                      r++) {
                                                    if (value == names[r]) {
                                                      category = names[r];
                                                      setState(() {
                                                        caton = true;
                                                        spin = true;
                                                      });
                                                    }
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              selectedItemBuilder:
                                                  (BuildContext context) {
                                                return nnn;
                                              },
                                              items: mmm,
                                            ),
                                            onTap: () {},
                                          ))));
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('city')
                                .doc(_cityxx)
                                .collection('areas')
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
                              final chatDocs = userSnapshot.hasData
                                  ? userSnapshot.data
                                  : null;
                              List names = [];
                              List<Widget> nnn = [];
                              List<DropdownMenuItem> mmm = [];
                              for (var x = 0; x < chatDocs!.docs.length; x++) {
                                names.add(chatDocs.docs[x].data()['name']);
                              }
                              for (var r = 0; r < names.length; r++) {
                                nnn.add(Text(names[r]));
                                mmm.add(DropdownMenuItem(
                                    value: names[r],
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          const Icon(Icons.location_on),
                                          const SizedBox(width: 2),
                                          Text(names[r]),
                                        ],
                                      ),
                                    )));
                              }
                              return SizedBox(
                                  height: 50,
                                  //    width: double.infinity,
                                  child: Container(
                                      width: 260,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey,
                                          // strokeAlign:
                                          //     BorderSide.strokeAlignOutside
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      // child: Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 120,
                                          child: ListTile(
                                            leading: Text(
                                              area ?? _area,
                                              style: TextStyle(
                                                  color: aron == false
                                                      ? Colors.grey
                                                      : Colors.deepPurple),
                                            ),
                                            trailing: DropdownButton(
                                              underline: Text(
                                                '                   المنطقة',
                                                style: TextStyle(
                                                    color: aron == false
                                                        ? Colors.grey
                                                        : Colors.blueGrey),
                                              ),
                                              // icon: Icon(Icons.location_on,
                                              //     color: aron == false
                                              //         ? Colors.grey
                                              //         : Colors.deepPurple),
                                              onChanged: (value) {
                                                if (!updated) {
                                                  for (var r = 0;
                                                      r < names.length;
                                                      r++) {
                                                    if (value == names[r]) {
                                                      area = names[r];
                                                      setState(() {
                                                        aron = true;
                                                        spin = true;
                                                      });
                                                    }
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              selectedItemBuilder:
                                                  (BuildContext context) {
                                                return nnn;
                                              },
                                              items: mmm,
                                            ),
                                            onTap: () {
                                              // setState(() {
                                              //   //   area = 'زيزينيا';

                                              //   aron = !aron;
                                              // });
                                            },
                                          ))));
                            }),
                        SizedBox(
                          height: 8,
                        ),
                        const Center(
                          child: Text(
                            'إذا وافقت على التعديل ،لن يمكنك التعديل مرة أخرى',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              if (spin == true) {
                                setState(() {
                                  loading == true;
                                });

                                (_controllername.text.trim().isEmpty ||
                                            _controllername.text.trim().length <
                                                3) &&
                                        (_enteredMessage.trim().isEmpty ||
                                            _enteredMessagename.trim().length <
                                                3)
                                    ? null
                                    : _sendMessage(storename);
                                if ((_controllername.text.trim().isEmpty ||
                                        _controllername.text.trim().length <
                                            3) &&
                                    (_enteredMessage.trim().isEmpty ||
                                        _enteredMessagename.trim().length <
                                            3)) {
                                  setState(() {
                                    loading == false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                          'من فضلك إدخل إسم يحتوي على ثلاث حروف او اكثر'),
                                      backgroundColor:
                                          Theme.of(context).errorColor,
                                    ),
                                  );
                                } else if ((_controllername.text
                                            .trim()
                                            .isNotEmpty &&
                                        _controllername.text.trim().length >
                                            2) ||
                                    _enteredMessage.trim().isNotEmpty &&
                                        _enteredMessagename.trim().length > 2) {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => Center(
                                        child: SizedBox(
                                            height: 300,
                                            child: AlertDialog(
                                              title: const Text('جار التحديث '),
                                              content: Column(children: [
                                                const Text('برجاء الانتظار'),
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                              ]),
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
                                                    //   totalRepeatCount: 2,
                                                    repeatForever: true,
                                                    onNext: (p1, p2) {
                                                      if (loading == false) {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                UpdateBusiness
                                                                    .routeName);
                                                        Navigator.of(ctx)
                                                            .pop(false);
                                                      }
                                                    },
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ))),
                                  );
                                  await FirebaseFirestore.instance
                                      .collection('business_details')
                                      .doc(docid)
                                      .update({
                                    'image_url': image,
                                    'updated': true,
                                  });

                                  final userdocx = await FirebaseFirestore
                                      .instance
                                      .collection('listing')
                                      .where(basicstorename)
                                      .get();
                                  final opp = userdocx.docs.toList();
                                  if (userdocx.docs.isNotEmpty) {
                                    for (var i = 0;
                                        i < userdocx.docs.length;
                                        i++) {
                                      //   kop.add(opp[i].id);
                                      print('q');
                                      print(opp[i].id);

                                      final chax = await FirebaseFirestore
                                          .instance
                                          .collection('chat')
                                          .doc(opp[i].id)
                                          .collection('chatx')
                                          .where('basicstore_name',
                                              isEqualTo: basicstorename)
                                          .get();

                                      for (var x = 0;
                                          x < chax.docs.length;
                                          x++) {
                                        print('qqq');

                                        final col = chax.docs[x].id;
                                        print(col);
                                        await FirebaseFirestore.instance
                                            .collection('chat')
                                            .doc(opp[i].id)
                                            .collection('chatx')
                                            .doc(col)
                                            .update({
                                          'stroeimage': image,
                                        });
                                      }
                                    }
                                  }
                                  final cattt = await FirebaseFirestore.instance
                                      .collection('category')
                                      .where('name', isEqualTo: category)
                                      .get();
                                  final catyyy = cattt.docs.isEmpty
                                      ? _category
                                      : cattt.docs.first.id;
                                  final categoryzz = category ?? _category;
                                  final cityzz = city ?? _city;
                                  final areazz = area ?? _area;
                                  FirebaseFirestore.instance
                                      .collection('business_details')
                                      .doc(busid)
                                      .update({
                                    'category_id': catyyy,
                                    'category': categoryzz
                                  });

                                  final cittt = await FirebaseFirestore.instance
                                      .collection('city')
                                      .where('name', isEqualTo: city)
                                      .get();
                                  final cityyy = cittt.docs.isEmpty
                                      ? _cityx
                                      : cittt.docs.first.id;
                                  FirebaseFirestore.instance
                                      .collection('business_details')
                                      .doc(busid)
                                      .update(
                                          {'city': cityzz, 'city_id': cityyy});
                                  // final citydoc = await FirebaseFirestore.instance
                                  //     .collection('city')
                                  //     .where('name', isEqualTo: city)
                                  //     .get();
                                  final citydocx = await FirebaseFirestore
                                      .instance
                                      .collection('city')
                                      .where('name', isEqualTo: _city)
                                      .get();
                                  //   final cityid = citydoc.docs.first.id;
                                  final cityidx = citydocx.docs.first.id;
                                  // await FirebaseFirestore.instance
                                  //     .collection('city')
                                  //     .doc(cityidx)
                                  //     .collection('shopsInThisCity')
                                  //     .doc(userid)
                                  //     .delete();
                                  // await FirebaseFirestore.instance
                                  //     .collection('city')
                                  //     .doc(cityid)
                                  //     .collection('shopsInThisCity')
                                  //     .doc(userid)
                                  //     .set({'shopname': storenamelast});
                                  // final countlisdocs = await FirebaseFirestore
                                  //     .instance
                                  //     .collection('city')
                                  //     .doc(cityid)
                                  //     .collection('shopsInThisCity')
                                  //     .get();
                                  // final countlisdocsx = await FirebaseFirestore
                                  //     .instance
                                  //     .collection('city')
                                  //     .doc(cityidx)
                                  //     .collection('shopsInThisCity')
                                  //     .get();
                                  // final countlis = countlisdocs.docs.length;
                                  // final countlisx = countlisdocsx.docs.length;

                                  // await FirebaseFirestore.instance
                                  //     .collection('city')
                                  //     .doc(cityid)
                                  //     .update(
                                  //         {'shopsinthiscitylength': countlis});
                                  // await FirebaseFirestore.instance
                                  //     .collection('city')
                                  //     .doc(cityidx)
                                  //     .update(
                                  //         {'shopsinthiscitylength': countlisx});
                                  // final catdoc = await FirebaseFirestore.instance
                                  //     .collection('category')
                                  //     .where('name', isEqualTo: category)
                                  //     .get();
                                  // final catdocx = await FirebaseFirestore.instance
                                  //     .collection('category')
                                  //     .where('name', isEqualTo: _categoryx)
                                  //     .get();
                                  final areaaa = await FirebaseFirestore
                                      .instance
                                      .collection('city')
                                      .doc(cityidx)
                                      .collection('areas')
                                      .where('name', isEqualTo: area)
                                      .get();
                                  final areaxxx = cittt.docs.isEmpty
                                      ? _areax
                                      : areaaa.docs.first.id;
                                  FirebaseFirestore.instance
                                      .collection('business_details')
                                      .doc(busid)
                                      .update(
                                          {'area': areazz, 'area_id': areaxxx});
                                  // final areadoc = await FirebaseFirestore.instance
                                  //     .collection('city')
                                  //     .doc(cityidx)
                                  //     .collection('areas')
                                  //     .where('name', isEqualTo: area)
                                  //     .get();
                                  // final areadocx = await FirebaseFirestore
                                  //     .instance
                                  //     .collection('city')
                                  //     .doc(cityidx)
                                  //     .collection('areas')
                                  //     .where('name', isEqualTo: _area)
                                  //     .get();
                                  // final areaid = areadoc.docs.first.id;
                                  // final areaidx = areadocx.docs.first.id;
                                  // await FirebaseFirestore.instance
                                  //     .collection('area')
                                  //     .doc(areaidx)
                                  //     .collection('shopsInThisArea')
                                  //     .doc(userid)
                                  //     .delete();
                                  // await FirebaseFirestore.instance
                                  //     .collection('area')
                                  //     .doc(areaid)
                                  //     .collection('shopsInThisArea')
                                  //     .doc(userid)
                                  //     .set({'shopname': storenamelast});
                                  // final countlisdocsarea = await FirebaseFirestore
                                  //     .instance
                                  //     .collection('area')
                                  //     .doc(areaid)
                                  //     .collection('shopsInThisArea')
                                  //     .get();
                                  // final countlisdocsxarea =
                                  //     await FirebaseFirestore.instance
                                  //         .collection('area')
                                  //         .doc(areaidx)
                                  //         .collection('shopsInThisArea')
                                  //         .get();
                                  // final countlisarea =
                                  //     countlisdocsarea.docs.length;
                                  // final countlisxarea =
                                  //     countlisdocsxarea.docs.length;

                                  // await FirebaseFirestore.instance
                                  //     .collection('area')
                                  //     .doc(areaid)
                                  //     .update({
                                  //   'shopsinthisarealength': countlisarea
                                  //     });
                                  // await FirebaseFirestore.instance
                                  //     .collection('area')
                                  //     .doc(areaidx)
                                  //     .update({
                                  //   'shopsinthisarealength': countlisxarea
                                  // });
                                  // final catid = catdoc.docs.first.id;
                                  // final catidx = catdocx.docs.first.id;
                                  // await FirebaseFirestore.instance
                                  //     .collection('category')
                                  //     .doc(catidx)
                                  //     .collection('shopsInThisCategory')
                                  //     .doc(userid)
                                  //     .delete();
                                  // await FirebaseFirestore.instance
                                  //     .collection('category')
                                  //     .doc(catid)
                                  //     .collection('shopsInThisCategory')
                                  //     .doc(userid)
                                  //     .set({'name': storenamelast});

                                  // final countlisdocss = await FirebaseFirestore
                                  //     .instance
                                  //     .collection('category')
                                  //     .doc(catid)
                                  //     .collection('shopsInThisCategory')
                                  //     .get();
                                  // final countlisdocssx = await FirebaseFirestore
                                  //     .instance
                                  //     .collection('category')
                                  //     .doc(catidx)
                                  //     .collection('shopsInThisCategory')
                                  //     .get();
                                  // final countliss = countlisdocss.docs.length;
                                  // final countlissx = countlisdocssx.docs.length;
                                  // await FirebaseFirestore.instance
                                  //     .collection('category')
                                  //     .doc(catidx)
                                  //     .update({
                                  //   'shopsInThisCategorylength': countlissx
                                  // });
                                  // await FirebaseFirestore.instance
                                  //     .collection('category')
                                  //     .doc(catid)
                                  //     .update({
                                  //   'shopsInThisCategorylength': countliss
                                  // });
                                  setState(() {
                                    loading == false;
                                  });
                                }
                              }
                            },
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
                                child: Text('موافق',
                                    style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber.shade500,
                                    )))),

                        AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                '  ',
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyanAccent,
                                  overflow: TextOverflow.visible,
                                ),
                                speed: const Duration(milliseconds: 100),
                              )
                            ],
                            totalRepeatCount: 2,
                            //   repeatForever: true,
                            onNext: (p0, p1) async {
                              setState(() {
                                _controllername.text = storenamelast;
                                urlx = imageurl;
///// work that set the pic too
//// long time process issue fix by using loading spinner or some other way
// SingleChildScrollView & ScrollablePositionedList bug fix
                              });
                              print(storenamelast);
                            }),
                      ])));
                    }))),
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
                      .collection('business_details')
                      .where('second_uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      // .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (ctx, userSnapshotx) {
                    if (userSnapshotx.hasData == false) {
                      return const Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(fontSize: 2),
                        ),
                      );
                    }
                    if (userSnapshotx.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(fontSize: 2),
                        ),
                      );
                    }
                    if (userSnapshotx.hasData == false) {
                      return const Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(fontSize: 2),
                        ),
                      );
                    }
                    final chatDocs =
                        userSnapshotx.hasData ? userSnapshotx.data : null;

                    if (userSnapshotx.hasData == true) {
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
                              icon: Icon(Icons.all_inclusive_rounded),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const BusinessMain('none')));
                              },
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.all_inclusive_rounded),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const BusinessMain('none')));
                            },
                          );
                  }),
              label: 'كل الطلبات',
            ),
            BottomNavigationBarItem(
                //       backgroundColor: Color.fromARGB(255, 226, 219, 157),
                icon: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('business_details')
                        .where('second_uid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        // .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.hasData == false) {
                        return const Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(fontSize: 2),
                          ),
                        );
                      }
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
                      if (userSnapshot.hasData == false) {
                        return const Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(fontSize: 2),
                          ),
                        );
                      }
                      if (userSnapshot.hasData == true) {
                        final badgo1 = chatDocs!.docs.first.data()['foundsent'];
                        final badgo2 = chatDocs.docs.first.data()['foundseen'];
                        final upnum = chatDocs.docs.first.data()['upnum'];
                        final upnumseen =
                            chatDocs.docs.first.data()['upnumseen'];

                        badgoo = (badgo1 + upnum) - (badgo2 + upnumseen);
                      }

                      return userSnapshot.hasData == false
                          ? const Center(
                              child: Text(
                                'Loading...',
                                style: TextStyle(fontSize: 2),
                              ),
                            )
                          : badgoo != 0
                              ? Badgee(
                                  value: badgoo.toString(),
                                  color: const Color.fromARGB(176, 244, 67, 54),
                                  child: IconButton(
                                    icon: Icon(Icons.navigation),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const BusinessMain('zero')));
                                    },
                                  ),
                                )
                              : IconButton(
                                  icon: Icon(Icons.navigation),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const BusinessMain('zero')));
                                  },
                                );
                    }),
                label: 'موجود'),
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
