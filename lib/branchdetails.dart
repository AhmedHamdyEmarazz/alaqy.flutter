import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/koshkbuild.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'app_drawer22.dart';
import 'badge.dart';
import 'branchdetailsx.dart';
import 'business_main.dart';
import 'editproduct.dart';
import 'updatebranch.dart';
import 'updateproduct.dart';

class branchdetails extends StatefulWidget {
  static const routeName = '/branchdetails';
  final String id;
  final bool loadingxx;

  const branchdetails(this.id, this.loadingxx, {super.key});

  @override
  branchdetailsState createState() => branchdetailsState();
}

class branchdetailsState extends State<branchdetails> {
  final userx = FirebaseAuth.instance.currentUser!.uid;
  int badgoo = 0;
  String? mtoken = '';
  final fbm = FirebaseMessaging.instance;
  String? stop;
  bool stopp = false;
  bool slip = true;

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
  ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), (() {
      widget.loadingxx == true
          ? null
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => branchdetailsx(widget.id)));
    }));
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
                    totalRepeatCount: 3,
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('branches')
                .doc(widget.id)
                .snapshots(),
            builder: (ctx, chatSnapshott) {
              if (chatSnapshott.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text('Loading...'),
                );
              }
              if (chatSnapshott.hasData == false) {
                return SizedBox();
              }
              final img = chatSnapshott.data!['image_url'] == null
                  ? 'asset'
                  : chatSnapshott.data!['image_url'];
              return SingleChildScrollView(
                  child: Column(children: [
                SizedBox(
                  height: 6,
                ),

                Text(
                  '${chatSnapshott.data!['branch_name']}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      fontFamily: 'Tajawal',
                      color: Colors.amber),
                ),
                TextButton.icon(
                  onPressed: () {
                    print('هذا امر عجيب');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Updatebranch(
                              widget.id,
                            )));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.amber,
                  ),
                  label: Text(
                    'تعديل القسم',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Color.fromARGB(74, 0, 0, 0)),
                  ),
                ),
                koshkbuild(
                  '',
                  img,
                  '',
                  '',
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
                                color: Color.fromARGB(47, 96, 125, 139),
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ScaleAnimatedText(
                                    'اضافة منتج ',
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
                                  // Navigator.of(context).pushNamed(
                                  //     Editproduct.routeName);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          EditProduct(widget.id)));
                                },
                              ),
                            ),
                            onPressed: () {
                              // Navigator.of(context).pushNamed(
                              //     Editproduct.routeName);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => EditProduct(widget.id)));
                            }))
                  ],
                ),
                // GestureDetector(
                //     onVerticalDragUpdate: (details) =>
                //         Scrollable.ensureVisible(context),
                //     child:
                Container(
                    height: 400,
                    //      color: Color.fromARGB(10, 0, 0, 0),
                    width: widthx - 40,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .where('braid', isEqualTo: widget.id)
                            .snapshots(),
                        builder: (ctx, chatSnapshot) {
                          if (chatSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text('Loading...'),
                            );
                          }
                          if (chatSnapshot.hasData == false) {
                            return SizedBox();
                          }
                          final chatDocs = chatSnapshot.hasData
                              ? chatSnapshot.data!.docs
                              : null;
                          final List<
                                  QueryDocumentSnapshot<Map<String, dynamic>>>
                              arrange = [];
                          final List<
                                  QueryDocumentSnapshot<Map<String, dynamic>>>
                              arrangex = [];
                          if (chatSnapshot.hasData != false) {
                            for (var r = 0; r < chatDocs!.length; r++) {
                              arrangex.add(chatDocs[r]);
                            }
                          }
                          arrangex.sort((a, b) =>
                              (a.data()['createdAt'] as Timestamp)
                                  .compareTo(b.data()['createdAt']));
                          arrange.addAll(arrangex.reversed);
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
                                              child: ScrollablePositionedList
                                                  .builder(
                                                      shrinkWrap: true,
                                                      itemScrollController:
                                                          _scrollController,
                                                      itemCount: arrange.length,
                                                      itemBuilder: (ctx,
                                                              index) =>
                                                          SingleChildScrollView(
                                                              child: Container(
                                                                  //    height: 500,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                      children: [
                                                                        Dismissible(
                                                                            key: ValueKey(arrange[index]
                                                                                .id),
                                                                            background:
                                                                                Container(
                                                                              color: Theme.of(context).errorColor,
                                                                              alignment: Alignment.centerRight,
                                                                              padding: const EdgeInsets.only(right: 20),
                                                                              margin: const EdgeInsets.symmetric(
                                                                                horizontal: 15,
                                                                                vertical: 4,
                                                                              ),
                                                                              child: const Icon(
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
                                                                                    'هل ترغب في حذف المنتج ؟',
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
                                                                                        FirebaseFirestore.instance.collection('products').doc(arrange[index].id).delete();
                                                                                        FirebaseFirestore.instance.collection('business_details').doc('${arrange[index].data()['busid']}').update({
                                                                                          'i_deleted_product ${arrange[index].data()['product_name']}': Timestamp.now(),
                                                                                        });
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
                                                                                  // // + date
// likes in branches and products collections
//// + update branch_name in products collection after updating the branch name in branches collection  it self
//// + delete function for every step
////+  change the whole koshk name
//+ no taken names
                                                                                  Navigator.of(context).push(MaterialPageRoute(
                                                                                      builder: (ctx) => Updateproduct(
                                                                                            arrange[index].id,
                                                                                          )));
                                                                                },
                                                                                tileColor: Color.fromARGB(255, 252, 250, 250),
//Color.fromARGB(10, 0, 0, 0),
                                                                                dense: true,
                                                                                visualDensity: VisualDensity.compact,
                                                                                style: ListTileStyle.list,
                                                                                selectedColor: Color.fromARGB(96, 255, 193, 7),
                                                                                title: Text(
                                                                                  '${arrange[index].data()['product_name']}',
                                                                                  style: const TextStyle(
                                                                                      //   fontStyle: FontStyle.italic,
                                                                                      fontFamily: 'Tajawal',
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.amber),
                                                                                ),
                                                                                trailing: FittedBox(
                                                                                    fit: BoxFit.cover,
                                                                                    clipBehavior: Clip.antiAlias,
//                                                             child:
// CircleAvatar(
                                                                                    child: arrange[index].data()['image_url'] == 'asset' || arrange[index].data()['image_url'] == null
                                                                                        ? Image.asset(
                                                                                            'assets/alaqyp.jpeg',
                                                                                            fit: BoxFit.contain,
                                                                                          )
                                                                                        : Image.network(
                                                                                            arrange[index].data()['image_url'],
                                                                                            fit: BoxFit.fill,
                                                                                            //  ),
                                                                                          )),
                                                                                leading: Icon(
                                                                                  Icons.edit,
                                                                                  color: Colors.amber,
                                                                                ))),
                                                                        Divider(
                                                                            height:
                                                                                4,
                                                                            thickness:
                                                                                4,
                                                                            color:
                                                                                Colors.white)
                                                                      ]))))))));
                        }))
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
