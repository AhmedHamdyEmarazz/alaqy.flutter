import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/app_drawer.dart';
import 'package:flutter_alaqy/userChoose.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'badge.dart';
import 'updatelistingform.dart';
import 'user_main.dart';

class UpdateListing extends StatefulWidget {
  static const routeName = '/UserImagePicker';

  const UpdateListing(this.listid);

  final dynamic listid;

  @override
  UpdateListingState createState() => UpdateListingState();
}

class UpdateListingState extends State<UpdateListing> {
  final _controller = new TextEditingController();
  final _controllername = new TextEditingController();
  final userid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;
  dynamic idz;
  dynamic idzcity;
  // dynamic idzarea;
  dynamic idzcategory;

  var _enteredMessage = '';
  var _enteredMessagename = '';
  var _userImageFile;
  final userx = FirebaseAuth.instance.currentUser!.uid;

  // void foundsentseen(List items) async {
  //   List<DocumentSnapshot<Map<String, dynamic>>> useri = [];
  //   List<int> foundsentsx = [];
  //   List<int> foundseenx = [];
  //   for (var z = 0; z < items.length; z++) {
  //     var vbn = await FirebaseFirestore.instance
  //         .collection('business_details')
  //         .doc(items[z])
  //         .collection('mylistsx')
  //         .doc(widget.listid)
  //         .get();
  //     if (vbn.exists) {
  //       var userii = await FirebaseFirestore.instance
  //           .collection('business_details')
  //           .doc(items[z])
  //           .get();
  //       var sent = useri[z].data()!['foundsent'];
  //       var seen = useri[z].data()!['foundseen'];

  //       var upnum = useri[z].data()!['upnum'];
  //       var upnumseen = useri[z].data()!['upnumseen'];
  //       FirebaseFirestore.instance
  //           .collection('business_details')
  //           .doc(items[z])
  //           .update({'upnum': upnum + 1});
  //     }
  //     var userii = await FirebaseFirestore.instance
  //         .collection('business_details')
  //         .doc(items[z])
  //         .get();
  //     useri.add(userii);
  //     // final idx = useri.docs.first.id;
  //     final sent = useri[z].data()!['foundsent'];
  //     final seen = useri[z].data()!['foundseen'];

  //     final upnum = useri[z].data()!['upnum'];
  //     final upnumseen = useri[z].data()!['upnumseen'];

  //     final storenameb = useri[z].data()!['basicstore_name'];
  //     final listcont =
  //         await FirebaseFirestore.instance.collection('listing').get();

  //     // print(listcont.docs.length);
  //     // print(storenameb);
  //     foundsentsx.add(upnum);
  //     foundseenx.add(upnumseen);
  //     for (var z = 0; z < listcont.docs.length; z++) {
  //       if (listcont.docs[z].data().containsKey(storenameb)) {
  //         if (listcont.docs[z].data()[storenameb] == 'on') {
  //           foundsentsx.add(listcont.docs[z]
  //               .data()['post_owner_reply_to_business$storenameb']);
  //           foundseenx.add(listcont.docs[z]
  //               .data()['post_owner_seen_by_business$storenameb']);
  //           print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm$foundsentsx');
  //           print(foundseenx);
  //           print(seen);
  //           print(sent);
  //         }
  //       }
  //     }
  //     final mustaddedsent = foundsentsx.fold(
  //         0, (previousValue, element) => previousValue + element);
  //     final mustaddedseen = foundseenx.fold(
  //         0, (previousValue, element) => previousValue + element);

  //     FirebaseFirestore.instance
  //         .collection('business_details')
  //         .doc(items[z])
  //         .update({'foundsent': mustaddedsent, 'foundseen': mustaddedseen});
  //     final nameandtitle = await FirebaseFirestore.instance
  //         .collection('listing')
  //         .doc(widget.listid.toString())
  //         .get();
  //     final title = nameandtitle.data()!['title'];
  //     final name = nameandtitle.data()!['username'];

  //     final notifytest = await FirebaseFirestore.instance
  //         .collection('business_details')
  //         .doc(items[z])
  //         .collection('mylistsx')
  //         .doc(widget.listid.toString())
  //         .get();
  //     notifytest.exists
  //         ?
//FirebaseFirestore.instance.collection('notify').add({
  //             'customerid': userid,
  //             'businessid': items[z],
  //             'listid': idz,
  //             'createdAt': Timestamp.now(),
  //             'to$userid': false,
  //             'to${items[z]}': true,
  //             'text': title,
  //             'target': items[z],
  //             'store_name': name
  //           })
  //         : null;
  //   }
  // }
  void sendpushnotification(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'content-type': 'aplication/json',
          'Authorization':
              'key=AAAAYkVGhz8:APA91bE75B-XzSXGRP9xJ6M1Ljg7CavQe_No8g705E0XlPp1Q_QwCQ1T9o_9wjHChsWR5fpzQ1YlQ2l5D8STZGmJf9gcVuj4jRtf9lkWji79QmqOW_fwy6hg__twEGiBbooIidoVMaw-'
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'Flutter_Notification_Click',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            //    "android_channel_id": "Default channel",
          },
          "to": token,
        }),
      );
      print("herexxx push notification");
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
    print(token);
  }

  void _submitAuthForm(
    String title,
    String description,
    String category,
    String city,
    //  String area,
    dynamic image,
  ) async {
    final url;
    final userid = FirebaseAuth.instance.currentUser!.uid;

    // print(userid);
    final userdoc = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('second_uid', isEqualTo: userid)
        .get();
    final docid = userdoc.docs.first.id;
    final usernamex = userdoc.docs.first.data()['username'];
    final username = usernamex.toString().split('@').first;
    const useriamge =
        'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169';
    setState(() {
      isLoading = true;
    });

    final getlength = await FirebaseFirestore.instance
        .collection('listing')
        .orderBy(
          'createdAt',
        )
        .get();
    var length = getlength.docs.length;

    final indexx = getlength.docs.length;
    //  print(indexx);
    setState(() {
      idz = indexx + 1;
    });

    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('listing$idz.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    final img = await FirebaseFirestore.instance
        .collection('listing')
        .doc(widget.listid.toString())
        .get();

    final jpg = img.data()!['image_url'];
    final titlex = img.data()!['title'];
    final descriptionx = img.data()!['description'];
    final cityxx = img.data()!['city_id'];
    //   final areaxx = img.data()!['area_id'];
    final categoryxx = img.data()!['category_id'];
    final cityx = img.data()!['city'];
//   final areax = img.data()!['area'];
    final categoryx = img.data()!['category'];
    // print(city);
    // print(cityx);
    // print(area);
    // print(areax);
    // print(category);
    // print(categoryx);

    final cittt = await FirebaseFirestore.instance
        .collection('city')
        .where('name', isEqualTo: city)
        .get();
    final cattt = await FirebaseFirestore.instance
        .collection('category')
        .where('name', isEqualTo: category)
        .get();

    // final areaaa = await FirebaseFirestore.instance
    //     .collection('area')
    //     .where('name', isEqualTo: area)
    //     .get();
    // final areooo = areaaa.docs.isEmpty ? areaxx : areaaa.docs.first.id;
    final cityyy = cittt.docs.isEmpty ? cityxx : cittt.docs.first.id;
    final catyyy = cattt.docs.isEmpty ? categoryxx : cattt.docs.first.id;
    await FirebaseFirestore.instance
        .collection('listing')
        .doc(widget.listid.toString())
        .update({
      'title': title == '' ? titlex : title,
      'description': description == '' ? descriptionx : description,
      'city': city == '' ? cityx : city,
      //  'area': area == '' ? areax : area,
      'city_id': cityyy,
      'category_id': catyyy,
      //   'area_id': areooo,
      'category': category == '' ? categoryx : category,
      'image_url': url == '' ? jpg : url,
      'updated': true,
    });
    final listdocget = await FirebaseFirestore.instance
        .collection('listdetails')
        .doc(widget.listid.toString())
        .get();
    final firstiduser = listdocget.data()!['userid'];
    final name = listdocget.data()!['username'];

    await FirebaseFirestore.instance
        .collection('listdetails')
        .doc(widget.listid.toString())
        .update({
      'title': title == '' ? titlex : title,
      'description': description == '' ? descriptionx : description,
      'city': city == '' ? cityx : city,
      //    'area': area == '' ? areax : area,
      'category': category == '' ? categoryx : category,
      'city_id': cityyy,
      'category_id': catyyy,
      //     'area_id': areooo,
      'image_url': url == '' ? jpg : url,
      'updated': true,
    });
    final busstartx = await FirebaseFirestore.instance
        .collection('business_details')
        .where('city', isEqualTo: city)
        .where('category', isEqualTo: category)
        .get();
    final List<String> itemsx = [];
    final List<String> today = [];

    for (var i = 0; i < busstartx.docs.length; i++) {
      if (img
          .data()!
          .containsKey(busstartx.docs[i].data()['basicstore_name'])) {
        itemsx.add(busstartx.docs[i].id);
      }
    }
    final List<DocumentSnapshot<Map<String, dynamic>>> sentx = [];
    final List<int> sent = [];

    for (var x = 0; x < itemsx.length; x++) {
      sentx.add(await FirebaseFirestore.instance
          .collection('business_details')
          .doc(itemsx[x])
          .get());
    }
    for (var y = 0; y < itemsx.length; y++) {
      sent.add(sentx[y].data()!['sent']);
    }
    for (var z = 0; z < itemsx.length; z++) {
      await FirebaseFirestore.instance
          .collection('business_details')
          .doc(itemsx[z])
          .update({'sent': sent[z] + 1});
    }
    final List<String> tokenx = [];
    final List<QuerySnapshot<Map<String, dynamic>>> sendz = [];
    for (var kk = 0; kk < itemsx.length; kk++) {
      sendz.add(await FirebaseFirestore.instance
          .collection('customer_details')
          .doc(itemsx[kk])
          .collection('tokens')
          .get());
      tokenx.add(sendz[kk].docs.first.data()['registrationTokens']);
      print(
          'ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
      sendpushnotification(tokenx[kk], title, username);
    }
    for (var k = 0; k < itemsx.length; k++) {
      FirebaseFirestore.instance.collection('notify').add({
        'customerid': userid,
        'businessid': 'allorders',
        'listid': widget.listid.toString(),
        'createdAt': Timestamp.now(),
        'to$userid': false,
        'to${itemsx[k]}': true,
        'text': title,
        'target': itemsx[k],
        'store_name': username,
        'tok': tokenx[k]
      });
    }

    final busstart = await FirebaseFirestore.instance
        .collection('business_details')
        // .where('city', isEqualTo: city)
        // .where('category', isEqualTo: category)
        .get();
    final List<String> items = [];
    for (var i = 0; i < busstart.docs.length; i++) {
      if (busstart.docs[i].id != 'djxHD4FJea09n3KBYkoT') {
        items.add(busstart.docs[i].id);
      }
    }
    for (var z = 0; z < items.length; z++) {
      var vbn = await FirebaseFirestore.instance
          .collection('business_details')
          .doc(items[z])
          .collection('mylistsx')
          .doc(widget.listid)
          .get();

      if (vbn.exists) {
        print('vbn');
        FirebaseFirestore.instance
            .collection('business_details')
            .doc(vbn.data()!['id'])
            .collection('mylistsx')
            .doc(widget.listid)
            .update({widget.listid: true});
        FirebaseFirestore.instance
            .collection('business_details')
            .doc(vbn.data()!['id'])
            .collection('mylists')
            .doc(firstiduser)
            .update({'${widget.listid}${firstiduser}update': true});
        print(vbn.data()!['id']);
        var userii = await FirebaseFirestore.instance
            .collection('business_details')
            .doc(vbn.data()!['id'])
            .get();
        // var sent = userii[z].data()!['foundsent'];
        // var seen = userii[z].data()!['foundseen'];

        var upnum = userii.data()!['upnum'];
        var basicstore_name = userii.data()!['basicstore_name'];

        //     var upnumseen = userii[z].data()!['upnumseen'];
        FirebaseFirestore.instance
            .collection('business_details')
            .doc(vbn.data()!['id'])
            .update({'upnum': upnum + 1, '${basicstore_name}close': false});
        // FirebaseFirestore.instance.collection('notify').add({
        //   'customerid': userid,
        //   'businessid': 'allorders',
        //   'listid': widget.listid,
        //   'createdAt': Timestamp.now(),
        //   'to$userid': false,
        //   'to${vbn.data()!['id']}': true,
        //   'text': title,
        //   'target': vbn.data()!['id'],
        //   'store_name': name
        // });
        FirebaseFirestore.instance
            .collection('listing')
            .doc(widget.listid)
            .update({
          '${basicstore_name}close': false,
        });
      }
    }

    final citydoc = await FirebaseFirestore.instance
        .collection('city')
        .where('name', isEqualTo: city)
        .get();
    final citydocx = await FirebaseFirestore.instance
        .collection('city')
        .where('name', isEqualTo: cityx)
        .get();
    final cityid = citydoc.docs.first.id;
    final cityidx = citydocx.docs.first.id;
    await FirebaseFirestore.instance
        .collection('city')
        .doc(cityidx)
        .collection('listingsInThisCity')
        .doc(widget.listid)
        .delete();
    await FirebaseFirestore.instance
        .collection('city')
        .doc(cityid)
        .collection('listingsInThisCity')
        .doc(widget.listid)
        .set({'id': userid});
    final countlisdocs = await FirebaseFirestore.instance
        .collection('city')
        .doc(cityid)
        .collection('listingsInThisCity')
        .get();
    final countlisdocsx = await FirebaseFirestore.instance
        .collection('city')
        .doc(cityidx)
        .collection('listingsInThisCity')
        .get();
    final countlis = countlisdocs.docs.length;
    final countlisx = countlisdocsx.docs.length;

    await FirebaseFirestore.instance
        .collection('city')
        .doc(cityid)
        .update({'listinginthiscitylength': countlis});
    await FirebaseFirestore.instance
        .collection('city')
        .doc(cityidx)
        .update({'listinginthiscitylength': countlisx});
    final catdoc = await FirebaseFirestore.instance
        .collection('category')
        .where('name', isEqualTo: category)
        .get();
    final catdocx = await FirebaseFirestore.instance
        .collection('category')
        .where('name', isEqualTo: categoryx)
        .get();
    final catid = catdoc.docs.first.id;
    final catidx = catdocx.docs.first.id;
    await FirebaseFirestore.instance
        .collection('category')
        .doc(catidx)
        .collection('listingsInThisCategory')
        .doc(widget.listid)
        .delete();
    await FirebaseFirestore.instance
        .collection('category')
        .doc(catid)
        .collection('listingsInThisCategory')
        .doc(widget.listid)
        .set({'id': userid});

    final countlisdocss = await FirebaseFirestore.instance
        .collection('category')
        .doc(catid)
        .collection('listingsInThisCategory')
        .get();
    final countlisdocssx = await FirebaseFirestore.instance
        .collection('category')
        .doc(catidx)
        .collection('listingsInThisCategory')
        .get();
    final countliss = countlisdocss.docs.length;
    final countlissx = countlisdocssx.docs.length;
    await FirebaseFirestore.instance
        .collection('category')
        .doc(catidx)
        .update({'listingsInThisCategorylength': countlissx});
    await FirebaseFirestore.instance
        .collection('category')
        .doc(catid)
        .update({'listingsInThisCategorylength': countliss});
    // final areadoc = await FirebaseFirestore.instance
    //     .collection('area')
    //     .where('name', isEqualTo: area)
    //     .get();
    // final areaid = areadoc.docs.first.id;
    // final areadocx = await FirebaseFirestore.instance
    //     .collection('area')
    //     .where('name', isEqualTo: areax)
    //     .get();
    // final areaidx = areadocx.docs.first.id;
    // await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaidx)
    //     .collection('listingsInThisArea')
    //     .doc(widget.listid)
    //     .delete();
    // await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .collection('listingsInThisArea')
    //     .doc(widget.listid)
    //     .set({'id': userid});
    // final countlisdocsss = await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .collection('listingsInThisarea')
    //     .get();
    // final countlisdocsssx = await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaidx)
    //     .collection('listingsInThisarea')
    //     .get();
    // final countlisss = countlisdocsss.docs.length;
    // final countlisssx = countlisdocsssx.docs.length;
    // await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaidx)
    //     .update({'listingsInThisarealength': countlisssx});
    // await FirebaseFirestore.instance
    //     .collection('area')
    //     .doc(areaid)
    //     .update({'listingsInThisarealength': countlisss});
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
    final size = MediaQuery.of(context).size;
    final heightx = size.height;
    dynamic badgoo;
    dynamic bag = 0;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 252, 250, 250),
            foregroundColor: Colors.black,
            centerTitle: true,
            toolbarHeight: 80,
            title: Text(
              ' تعديل المنشور',
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('listing')
                .doc(widget.listid)
                .snapshots(),
            builder: (ctx, chatSnapshottt) {
              // if (chatSnapshottt.connectionState == ConnectionState.waiting) {
              //   return const Center(
              //     child: Text('Loading...'),
              //   );
              // }
              if (chatSnapshottt.hasData == false) {
                return const Center(child: Text(' Loading...'));
              }
              final chatdocs = chatSnapshottt.data;
              final imageurl = chatdocs!.data()!['image_url'];
              final title = chatdocs.data()!['title'];
              final description = chatdocs.data()!['description'];
              final city = chatdocs.data()!['city'];
              //   final area = chatdocs.data()!['area'];
              final category = chatdocs.data()!['category'];
              final updated = chatdocs.data()!['updated'];
              // print(isLoading);
              // print(imageurl);
              // print(title);
              // print(description);
              // print(city);
              // print(area);
              // print(category);
              // print(updated);

              return SingleChildScrollView(
                  child: Column(children: <Widget>[
                SizedBox(
                    height: heightx - 109,
                    child: updatelistingform(
                        _submitAuthForm,
                        isLoading,
                        imageurl,
                        title,
                        description,
                        city,
                        //area
                        category,
                        updated))
              ]));
            }),
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
