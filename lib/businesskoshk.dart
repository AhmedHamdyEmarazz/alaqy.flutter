import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/branchdetails.dart';
import 'package:flutter_alaqy/businesskoshkq.dart';
import 'package:flutter_alaqy/koshkbuild.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'EditBranch.dart';
import 'app_drawer22.dart';
import 'badge.dart';
import 'business_main.dart';
import 'businesskoshkw.dart';

class BusinessKoshk extends StatefulWidget {
  static const routeName = '/BusinessKoshk';
  final bool loadingxx;

  const BusinessKoshk(this.loadingxx, {super.key});
  @override
  BusinessKoshkState createState() => BusinessKoshkState();
}

class BusinessKoshkState extends State<BusinessKoshk> {
  final userx = FirebaseAuth.instance.currentUser!.uid;
  int badgoo = 0;
  String? mtoken = '';
  final fbm = FirebaseMessaging.instance;
  String? stop;
  bool stopp = false;
  bool slip = false;

  int iz = 0;

  dynamic turtlezz;
  dynamic titlemega;
  dynamic bodymega;
  dynamic busid2;
  dynamic username;
  dynamic store_name;
  dynamic busid;
  dynamic cusid;
  dynamic basicstore_name;
  dynamic basicusername;
  final _descriptiontroller = TextEditingController();
  final linkcontroller = TextEditingController();

  var description = '';
  var _link = '';

  var _description;
  var link;
  bool loading = false;
  bool loadingx = false;

  ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  void scrollTo(int index) {
    _scrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
        alignment: 0);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      slip = true;
    });
    setState(() {
      slip = true;
    });
    setState(() {
      slip = true;
    });
    setState(() {
      slip = true;
    });
    final size = MediaQuery.of(context).size;
    final hightx = size.height;
    final widthx = size.width;
    final userid = FirebaseAuth.instance.currentUser!.uid;
    dynamic badgoo;
    dynamic bag = 0;

    return Scaffold(
        drawer: AppDrawer22(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 252, 250, 250),
          foregroundColor: Colors.black,
          centerTitle: true,
          toolbarHeight: 135,
          title: Container(
              padding: const EdgeInsets.only(
                right: 50,
                //    horizontal: 30,
              ),
              child: Column(children: [
                AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        '   ',
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.cyanAccent,
                          overflow: TextOverflow.visible,
                        ),
                        speed: const Duration(milliseconds: 200),
                      )
                    ],
                    totalRepeatCount: 2,
                    // repeatForever: true,
                    onNext: (p0, p1) async {
                      // slip == true
                      //     ? null
                      setState(() {
                        stopp = true;
                      });
                    }),
                SizedBox(
                  height: 70,
                ),
                Text(
                  'الكشك',
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      //    RestartWidget.restartApp(context);
                    },
                    child: Center(
                        child: SizedBox(
                            //   height: 100,
                            //   width: double.infinity,
                            child: Image.asset(
                      'assets/alaqy.jpeg',
                      fit: BoxFit.contain,
                    )))),
                SizedBox(
                  height: 25,
                ),
              ])),
          actions: [],
        ),
        //  drawer: AppDrawer(),
        body: SizedBox(
            height: 600,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('koshk')
                    .doc(userid)
                    .snapshots(),
                builder: (ctx, chatSnapshottt) {
                  if (chatSnapshottt.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final chatDocs =
                      chatSnapshottt.hasData ? chatSnapshottt.data! : null;
                  return chatSnapshottt.hasData == false
                      ? //SplashScreen()
                      Center(
                          child: Column(children: [
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                              width: 222,
                              child: TextFormField(
                                //  key: const ValueKey('username'),
                                decoration: InputDecoration(
                                  label: Center(
                                      child: Text(
                                    ' وصف مختصر',
                                    style: TextStyle(
                                        fontFamily: 'Tajawal',
                                        color: Color.fromARGB(48, 0, 0, 0)),
                                  )),
// helperStyle: TextStyle(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  filled:
                                      true, //_phoneController.text == '' ? true : false,
                                  fillColor: Colors.white,
                                  // hintText: "Phone Number"
                                ),
                                enableSuggestions: false,
                                controller: _descriptiontroller,
                                validator: (value) {
                                  if (value != null) {
                                    return (value.isEmpty)
                                        ? 'من فضلك ادخل وصف'
                                        : null;
                                  }
                                  return null;
                                },
                                // decoration:
                                //     const InputDecoration(labelText: 'description'),
                                onSaved: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _description = value;
                                    });
                                    //    _descriptiontroller.clear();
                                  }
                                },
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: 222,
                              child: TextFormField(
                                //  key: const ValueKey('username'),
                                decoration: InputDecoration(
                                  label: Center(
                                      child: Text(
                                    'لينك مصرفي',
                                    style: TextStyle(
                                        fontFamily: 'Tajawal',
                                        color: Color.fromARGB(48, 0, 0, 0)),
                                  )),
// helperStyle: TextStyle(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  filled:
                                      true, //_phoneController.text == '' ? true : false,
                                  fillColor: Colors.white,
                                  // hintText: "Phone Number"
                                ),
                                enableSuggestions: false,
                                controller: linkcontroller,
                                validator: (value) {
                                  if (value != null) {
                                    return (value.isEmpty)
                                        ? 'من فضلك ادخل لينك'
                                        : null;
                                  }
                                  return null;
                                },
                                // decoration:
                                //     const InputDecoration(labelText: 'description'),
                                onSaved: (value) {
                                  if (value != null) {
                                    setState(() {
                                      link = value;
                                    });
                                    //    _descriptiontroller.clear();
                                  }
                                },
                              )),
                          loading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.amber,
                                  backgroundColor: Colors.white,
                                ))
                              : SizedBox(),
                          Stack(
                            children: [
                              Center(
                                  child: TextButton(
                                      child: Container(
                                        width: 130,
                                        height: 40,
                                        alignment: Alignment.center,
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
                                          color:
                                              Color.fromARGB(47, 96, 125, 139),
                                        ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            ScaleAnimatedText(
                                              'بناء الكشك',
                                              textStyle: TextStyle(
                                                fontFamily: 'Tajawal',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber.shade500,
                                              ),
                                            )
                                          ],
                                          //   totalRepeatCount: 2,
                                          repeatForever: true,
                                          onTap: () async {
                                            setState(() {
                                              loading = true;
                                            });
                                            final businessdata =
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        'business_details')
                                                    .where('second_uid',
                                                        isEqualTo: FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                    .get();
                                            FirebaseFirestore.instance
                                                .collection('koshk')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .set({
                                              'store_name': businessdata
                                                  .docs.first
                                                  .data()['store_name'],
                                              'basic_store_name': businessdata
                                                  .docs.first
                                                  .data()['store_name'],
                                              'image_url': businessdata
                                                  .docs.first
                                                  .data()['image_url'],
                                              'description': _descriptiontroller
                                                  .text
                                                  .trim(),
                                              'financial_link':
                                                  linkcontroller.text.trim(),
                                              'createdAt': Timestamp.now(),
                                              'busid':
                                                  businessdata.docs.first.id,
                                            });
                                            // Navigator.of(context)
                                            //     .pushNamed(koshkbuild.routeName);
                                            setState(() {
                                              loading = false;
                                            });
                                          },
                                        ),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        final businessdata =
                                            await FirebaseFirestore
                                                .instance
                                                .collection('business_details')
                                                .where(
                                                    'second_uid',
                                                    isEqualTo: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid)
                                                .get();
                                        FirebaseFirestore.instance
                                            .collection('koshk')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .set({
                                          'store_name': businessdata.docs.first
                                              .data()['store_name'],
                                          'image_url': businessdata.docs.first
                                              .data()['image_url'],
                                          'description':
                                              _descriptiontroller.text.trim(),
                                          'financial_link':
                                              linkcontroller.text.trim(),
                                          'createdAt': Timestamp.now(),
                                          'busid': businessdata.docs.first.id,
                                        });
                                        // Navigator.of(context)
                                        //     .pushNamed(koshkbuild.routeName);
                                        setState(() {
                                          loading = false;
                                        });
                                      }))
                            ],
                          ),
                        ]))
                      : SingleChildScrollView(
                          child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${chatSnapshottt.data!['store_name']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text('الحذف ؟'),
                                          content: const Text(
                                              'هل تريد حذف الكشك الخاص بك بكافة اقسامه؟ '),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('لا'),
                                              onPressed: () {
                                                Navigator.of(ctx).pop(false);
                                              },
                                            ),
                                            TextButton(
                                                child: const Text('تاكيد'),
                                                onPressed: () async {
                                                  final userdocc =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'products')
                                                          .where('storename',
                                                              isEqualTo:
                                                                  '${chatSnapshottt.data!['store_name']}')
                                                          .get();
                                                  if (userdocc
                                                      .docs.isNotEmpty) {
                                                    for (var r = 0;
                                                        r <
                                                            userdocc
                                                                .docs.length;
                                                        r++) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'products')
                                                          .doc(userdocc
                                                              .docs[r].id)
                                                          .delete();
                                                    }
                                                  }

                                                  final userdosc =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'branches')
                                                          .where('username',
                                                              isEqualTo:
                                                                  '${chatSnapshottt.data!['store_name']}')
                                                          .get();
                                                  if (userdosc
                                                      .docs.isNotEmpty) {
                                                    for (var r = 0;
                                                        r <
                                                            userdosc
                                                                .docs.length;
                                                        r++) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'branches')
                                                          .doc(userdosc
                                                              .docs[r].id)
                                                          .delete();
                                                    }
                                                  }
                                                  FirebaseFirestore.instance
                                                      .collection('koshk')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .delete();
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'business_details')
                                                      .doc(
                                                          '${chatSnapshottt.data!['busid']}')
                                                      .update({
                                                    'i_deleted_koshk':
                                                        Timestamp.now(),
                                                  });
                                                }),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ]),
                          Text('${chatSnapshottt.data!['description']}'),
                          Text(
                            '${chatSnapshottt.data!['financial_link']}',
                            style: TextStyle(color: Colors.blue),
                          ),
                          koshkbuild(
                            chatSnapshottt.data!['store_name'],
                            chatSnapshottt.data!['image_url'],
                            chatSnapshottt.data!['description'],
                            chatSnapshottt.data!['financial_link'],
                          ),
                          Stack(
                            children: [
                              Center(
                                  child: TextButton(
                                      child: Container(
                                        width: 130,
                                        height: 40,
                                        alignment: Alignment.center,
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
                                          color:
                                              Color.fromARGB(47, 96, 125, 139),
                                        ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            ScaleAnimatedText(
                                              'اضافة قسم ',
                                              textStyle: TextStyle(
                                                fontFamily: 'Tajawal',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber.shade500,
                                              ),
                                            )
                                          ],
                                          //   totalRepeatCount: 2,
                                          repeatForever: true,
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                EditBranch.routeName);
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(EditBranch.routeName);
                                      }))
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  slip = true;
                                });
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => BusinessKoshkw(
                                            chatDocs!.data()!['busid'])));
                              },
                              child: Text('عرض الاقسام')),
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                '',
                                textStyle: const TextStyle(
                                    //   fontStyle: FontStyle.italic,
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                              )
                            ],
                            totalRepeatCount: 2,
                            //     repeatForever: true,
                            onNext: (p0, p1) {
                              !widget.loadingxx
                                  ? null
                                  : setState(() {
                                      slip = true;
                                    });
                              !widget.loadingxx
                                  ? null
                                  : Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (ctx) => BusinessKoshkq()));
                            },
                          ),
                          Container(
                              height: 400,
                              //      color: Color.fromARGB(10, 0, 0, 0),
                              width: widthx - 40,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('branches')
                                      .where('busid',
                                          isEqualTo: chatDocs!.data()!['busid'])
                                      .snapshots(),
                                  builder: (ctx, chatSnapshot) {
                                    if (chatSnapshot.hasData == false) {
                                      return SizedBox(height: 50);
                                    }
                                    final chatDocss = chatSnapshot.hasData
                                        ? chatSnapshot.data!.docs
                                        : null;
                                    final List<
                                        QueryDocumentSnapshot<
                                            Map<String, dynamic>>> arrange = [];
                                    final List<
                                            QueryDocumentSnapshot<
                                                Map<String, dynamic>>>
                                        arrangex = [];
                                    if (chatSnapshot.hasData != false) {
                                      for (var r = 0;
                                          r < chatDocss!.length;
                                          r++) {
                                        arrangex.add(chatDocss[r]);
                                      }
                                    }
                                    arrangex.sort((a, b) =>
                                        (a.data()['createdAt'] as Timestamp)
                                            .compareTo(b.data()['createdAt']));
                                    arrange.addAll(arrangex.reversed);
                                    //   scrollTo(arrange.length);
                                    if (chatSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return chatSnapshot.hasData == false
                                          ? SizedBox()
                                          : const Center(
                                              child: Text('Loading...'),
                                            );
                                    }
                                    // if (chatSnapshottt.connectionState ==
                                    //     ConnectionState.waiting) {
                                    //   chatSnapshot.hasData == false
                                    //       ? SizedBox()
                                    //       : widget.loadingxx == false
                                    //           ? null
                                    //           : Navigator.of(context)
                                    //               .pushReplacement(
                                    //                   MaterialPageRoute(
                                    //                       builder: (ctx) =>
                                    //                           BusinessKoshk(
                                    //                               false)));
                                    // }

                                    return chatSnapshot.hasData == false
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 400,
                                            width: 280,
                                            child: SizedBox(
                                              height: 400,
                                              width: 280,
                                              child: Scaffold(
                                                  body: SizedBox(
                                                      height: 400,
                                                      width: 280,
                                                      child:
                                                          ScrollablePositionedList
                                                              .builder(
                                                        // addAutomaticKeepAlives:
                                                        //     false,

                                                        itemPositionsListener:
                                                            itemPositionsListener,
                                                        shrinkWrap: true,
                                                        itemScrollController:
                                                            _scrollController,
                                                        itemCount:
                                                            arrange.length,
                                                        itemBuilder: (ctx, index) => Container(
                                                            height: 60,
                                                            child: SingleChildScrollView(
                                                                child: Container(
                                                                    height: 60,
                                                                    color: Color.fromARGB(10, 0, 0, 0),
                                                                    child: Column(children: [
                                                                      Dismissible(
                                                                          key: ValueKey(arrange[index]
                                                                              .id),
                                                                          background:
                                                                              Container(
                                                                            color:
                                                                                Theme.of(context).errorColor,
                                                                            alignment:
                                                                                Alignment.centerRight,
                                                                            padding:
                                                                                const EdgeInsets.only(right: 20),
                                                                            margin:
                                                                                const EdgeInsets.symmetric(
                                                                              horizontal: 15,
                                                                              vertical: 4,
                                                                            ),
                                                                            child:
                                                                                const Icon(
                                                                              Icons.delete,
                                                                              color: Colors.white,
                                                                              size: 20,
                                                                            ),
                                                                          ),
                                                                          direction: DismissDirection
                                                                              .endToStart,
                                                                          confirmDismiss:
                                                                              (direction) {
                                                                            return showDialog(
                                                                              context: context,
                                                                              builder: (ctx) => AlertDialog(
                                                                                title: const Text('تاكيد الحذف؟'),
                                                                                content: const Text(
                                                                                  'هل ترغب في حذف القسم بكامل منتجاته ؟',
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    child: const Text('لا'),
                                                                                    onPressed: () {
                                                                                      Navigator.of(ctx).pop(false);
                                                                                    },
                                                                                  ),
                                                                                  TextButton(
                                                                                    child: const Text('نعم'),
                                                                                    onPressed: () async {
                                                                                      FirebaseFirestore.instance.collection('branches').doc(arrange[index].id).delete();
                                                                                      final userdocc = await FirebaseFirestore.instance.collection('products').where('braid', isEqualTo: '${arrange[index].id}').get();
                                                                                      if (userdocc.docs.isNotEmpty) {
                                                                                        for (var r = 0; r < userdocc.docs.length; r++) {
                                                                                          FirebaseFirestore.instance.collection('products').doc(userdocc.docs[r].id).delete();
                                                                                          FirebaseFirestore.instance.collection('business_details').doc('${chatSnapshottt.data!['busid']}').update({
                                                                                            'i_deleted_branch ${arrange[index].data()['branch_name']}': Timestamp.now(),
                                                                                          });
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                          onDismissed:
                                                                              (direction) {
                                                                            //Provider.of<Cart>(context, listen: false).removeItem(productId);
                                                                          },
                                                                          child: ListTile(
                                                                              onTap: () {
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => branchdetails(arrange[index].id, false)));
                                                                                //  null;
                                                                                //chatSnapshot.data!.docs[index]
                                                                              },
                                                                              tileColor: Color.fromARGB(255, 252, 250, 250),
                                                                              //Color.fromARGB(10, 0, 0, 0),
                                                                              dense: true,
                                                                              visualDensity: VisualDensity.compact,
                                                                              style: ListTileStyle.list,
                                                                              selectedColor: Color.fromARGB(96, 255, 193, 7),
                                                                              trailing: AnimatedTextKit(
                                                                                animatedTexts: [
                                                                                  TyperAnimatedText(
                                                                                    '${arrange[index].data()['branch_name']}',
                                                                                    textStyle: const TextStyle(
                                                                                        //   fontStyle: FontStyle.italic,
                                                                                        fontFamily: 'Tajawal',
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.amber),
                                                                                  )
                                                                                ],
                                                                                //  totalRepeatCount: 2,
                                                                                repeatForever: true,
                                                                                // onNext: (p0, p1) {
                                                                                //   //     widget.loadingxx ? null : Navigator.popUntil(context, ModalRoute.withName('/BusinessMain'));
                                                                                //   !widget.loadingxx
                                                                                //       ? null
                                                                                //       : setState(() {
                                                                                //           slip = true;
                                                                                //         });
                                                                                //   // !widget.loadingxx
                                                                                //   //     ? null
                                                                                //   //     : Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => BusinessKoshk(true)));
                                                                                // },
                                                                              ),
                                                                              leading: FittedBox(
                                                                                  fit: BoxFit.contain,
                                                                                  clipBehavior: Clip.antiAlias,
                                                                                  //     child: CircleAvatar(
                                                                                  child: arrange[index].data()['image_url'] == 'asset' || arrange[index].data()['image_url'] == null
                                                                                      ? Image.asset(
                                                                                          'assets/alaqyp.jpeg',
                                                                                          fit: BoxFit.contain,
                                                                                        )
                                                                                      : Image.network(
                                                                                          arrange[index].data()['image_url'],
                                                                                          fit: BoxFit.fill,
                                                                                          //   ),
                                                                                        )),
                                                                              title: Text(
                                                                                '⏏️',
                                                                                style: const TextStyle(
                                                                                    //   fontStyle: FontStyle.italic,
                                                                                    fontFamily: 'Tajawal',
                                                                                    //  fontWeight: FontWeight.bold,
                                                                                    color: Colors.black),
                                                                              ))),
                                                                      Divider(
                                                                          height:
                                                                              4,
                                                                          thickness:
                                                                              4,
                                                                          color:
                                                                              Colors.white),
                                                                      // AnimatedTextKit(
                                                                      //     animatedTexts: [
                                                                      //       TyperAnimatedText(
                                                                      //         '  ',
                                                                      //         textStyle: const TextStyle(
                                                                      //           fontSize: 20,
                                                                      //           color: Colors.cyanAccent,
                                                                      //           overflow: TextOverflow.visible,
                                                                      //         ),
                                                                      //         speed: const Duration(milliseconds: 200),
                                                                      //       )
                                                                      //     ],
                                                                      //     totalRepeatCount: 2,
                                                                      //     //  repeatForever: true,
                                                                      //     onNext: (p0, p1) async {
                                                                      //       showDialog(
                                                                      //         context: context,
                                                                      //         builder: (ctx) => AlertDialog(
                                                                      //           title: const Text('تحميل الاقسام'),
                                                                      //           content: const LinearProgressIndicator(),
                                                                      //           actions: <Widget>[
                                                                      //             TextButton(
                                                                      //               child: AnimatedTextKit(
                                                                      //                 animatedTexts: [
                                                                      //                   TyperAnimatedText(
                                                                      //                     'موافق',
                                                                      //                     textStyle: const TextStyle(
                                                                      //                       fontSize: 20,
                                                                      //                       color: Colors.cyanAccent,
                                                                      //                       overflow: TextOverflow.visible,
                                                                      //                     ),
                                                                      //                     speed: const Duration(milliseconds: 200),
                                                                      //                   )
                                                                      //                 ],
                                                                      //                 // totalRepeatCount: 2,
                                                                      //                 repeatForever: true,
                                                                      //                 onNext: (p0, p1) {},
                                                                      //               ),
                                                                      //               onPressed: () {
                                                                      //                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => BusinessKoshk(true)));
                                                                      //                 Navigator.of(ctx).pop(false);
                                                                      //               },
                                                                      //             ),
                                                                      //           ],
                                                                      //         ),
                                                                      //       );
                                                                      //     }),
                                                                    ])))),
                                                      ))),
                                            ));
                                  }))
                        ]));
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
                                            const BusinessMain('zero')));
                              },
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.all_inclusive_rounded),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const BusinessMain('zero')));
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
                                                  const BusinessMain('none')));
                                    },
                                  ),
                                )
                              : IconButton(
                                  icon: Icon(Icons.navigation),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const BusinessMain('none')));
                                  },
                                );
                    }),
                label: 'موجود'),
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
