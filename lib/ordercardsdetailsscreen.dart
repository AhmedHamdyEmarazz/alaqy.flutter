import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_drawer2.dart';
import 'badge.dart';
import 'business_main.dart';
import 'chat_screens.dart';

class OrderCardsDetailsScreen extends StatefulWidget {
  static const routeName = '/OrderCardsDetailsScreen';
  final String id;
  final Timestamp createdAt;
  final String title;
  final String imageurl;
  final String description;
  final String username;
  final String chatindicator;
  final String storename;
  final String basicstorename;
  final String basicusername;
  const OrderCardsDetailsScreen(
      this.id,
      this.createdAt,
      this.title,
      this.imageurl,
      this.description,
      this.username,
      this.chatindicator,
      this.storename,
      this.basicstorename,
      this.basicusername,
      {super.key});
  @override
  State<OrderCardsDetailsScreen> createState() =>
      OrderCardsDetailsScreenState();
}

class OrderCardsDetailsScreenState extends State<OrderCardsDetailsScreen> {
  int badgoo = 0;
  bool loading = false;
  String categoryx = '';
  String cityx = '';
  late String useridx;
  late String busidx;
  final busid2x = FirebaseAuth.instance.currentUser!.uid;
  bool loadingxx = false;

  final _transformationController = TransformationController();

  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  @override
  void initState() {
    // setState(() {
    //   loadingxx = false;
    // });
    super.initState();
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
    // Future.delayed(const Duration(seconds: 3), (() {
    //   setState(() {
    //     loadingxx = false;
    //   });
    // }));
    dynamic badgoo;
    dynamic bag = 0;
    return Scaffold(
        drawer: AppDrawer2(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 252, 250, 250),
          foregroundColor: Colors.black,
          centerTitle: true,
          toolbarHeight: 80,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Tajawal',
            ),
          ),
        ),
        body: ListView.builder(
          //             reverse: true,

          itemCount: 1,
// chatDocs.length,
          itemBuilder: (ctx, index) => Column(children: [
            SingleChildScrollView(
                child: Column(children: <Widget>[
              GestureDetector(
                  onTap: () {
                    widget.imageurl ==
                            'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
                        ? null
                        : Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (ctx) => GestureDetector(
                                onDoubleTapDown: _handleDoubleTapDown,
                                onDoubleTap: _handleDoubleTap,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                    child: InteractiveViewer(
                                        transformationController:
                                            _transformationController,
                                        child: Container(
                                            child: Image.network(
                                          widget.imageurl,
                                          fit: BoxFit.contain,
                                        )))))));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      // width: 60,
                      // height: 60,
                      margin: const EdgeInsets.only(
                        top: 15,
                        right: 5,
                        left: 5,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 252, 250, 250),
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          clipBehavior: Clip.antiAlias,
                          child: Stack(children: [
                            Container(
                                width: 250,
                                height: 200,
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //     width: 3,
                                //     color: Color.fromARGB(
                                //         255, 252, 250, 250),
                                //   ),
                                //   borderRadius: BorderRadius.only(
                                //       topLeft: Radius.circular(8),
                                //       topRight: Radius.circular(8),
                                //       bottomLeft: Radius.circular(8),
                                //       bottomRight: Radius.circular(8)),
                                // ),
                                child: Container(
                                    height: 202,
                                    width: 252,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 6,
                                          color: Colors.grey.shade300,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    child: Container(
                                      height: 200,
                                      width: 250,
                                      child: widget.imageurl ==
                                              'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
                                          ? Image.asset(
                                              'assets/alaqyp.jpeg',
                                              fit: BoxFit.contain,
                                            )
                                          : Image.network(
                                              widget
                                                  .imageurl, //                                        loadedProduct.imageUrlxxxxxxxx,
                                              fit: BoxFit.fill,
                                            ),
                                    ))),
                            Container(
                                width: 250,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3,
                                      color: Color.fromARGB(255, 252, 250, 250),
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                ),
                                child: SizedBox()),
                          ])))),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 250,
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                      color: Colors.black),
                  //      )
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 250,
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      //        fontStyle: FontStyle.italic,
                      //   fontWeight: FontWeight.w100,
                      fontFamily: 'Tajawal',
                      color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 250,
                child: Text(
                    '${DateFormat('dd/MM/yyyy hh:mm').format(widget.createdAt.toDate())}',
                    style: const TextStyle(
                        //   fontStyle: FontStyle.italic,
                        fontSize: 10,
                        color: Colors.black)),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 250,
                child: Text(
                  'الصنف: $categoryx',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 10,
                      //        fontStyle: FontStyle.italic,
                      //   fontWeight: FontWeight.w100,
                      fontFamily: 'Tajawal',
                      color: Colors.blueGrey),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 250,
                child: Text(
                  'المدينة: $cityx',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 10,
                      //        fontStyle: FontStyle.italic,
                      //   fontWeight: FontWeight.w100,
                      fontFamily: 'Tajawal',
                      color: Colors.blueGrey),
                ),
              ),
              //   child: Container(
              //       height: 300,
              //       width: double.infinity,
              //       child: Image.network(
              //         widget
              //             .imageurl, //                                        loadedProduct.imageUrlxxxxxxxx,
              //         fit: BoxFit.fill,
              //       )),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   width: double.infinity,
              //   child: Text(
              //     widget.description,
              //     textAlign: TextAlign.center,
              //     softWrap: true,
              //   ),
              // ),
              // Center(
              //   child: Text(
              //       'date:${DateFormat('dd/MM/yyyy hh:mm').format(widget.createdAt.toDate())}',
              //       style: const TextStyle(
              //           fontStyle: FontStyle.italic, color: Colors.grey)),
              // ),
              // Center(
              //   child: Text('category: $categoryx',
              //       style: const TextStyle(
              //           fontStyle: FontStyle.italic, color: Colors.purple)),
              // ),
              // Center(
              //   child: Text('city: $cityx',
              //       style: const TextStyle(
              //           fontStyle: FontStyle.italic, color: Colors.deepPurple)),
              // ),
              widget.chatindicator == 'on'
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('listing')
                          .doc(widget.id.toString())
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
                          final badgo1 = chatDocs!.data()![
                              'post_owner_reply_to_business${widget.storename}'];
                          final badgo2 = chatDocs.data()![
                              'post_owner_seen_by_business${widget.storename}'];

                          badgoo = badgo1 - badgo2;
                        }

                        return loadingxx == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : badgoo != 0
                                ? Badgee(
                                    value: badgoo.toString(),
                                    color:
                                        const Color.fromARGB(176, 244, 67, 54),
                                    child: GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          loadingxx = true;
                                        });
                                        Future.delayed(
                                            const Duration(seconds: 3), (() {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (ctx) => ChatScreens(
                                                      widget.id,
                                                      widget.username,
                                                      widget.storename,
                                                      'business',
                                                      busidx,
                                                      busid2x,
                                                      useridx,
                                                      widget.basicstorename,
                                                      widget.basicusername)));
                                          // setState(() {
                                          //   loadingxx = false;
                                          // });
                                        }));
                                        Future.delayed(
                                            const Duration(seconds: 3), (() {
                                          setState(() {
                                            loadingxx = false;
                                          });
                                        }));
                                        final targ = await FirebaseFirestore
                                            .instance
                                            .collection('listing')
                                            .doc(widget.id.toString())
                                            .get();
                                        final userid = targ.data()!['userid'];
                                        final repto = targ.data()![
                                            'post_owner_reply_to_business${widget.storename}'];
                                        FirebaseFirestore.instance
                                            .collection('listing')
                                            .doc(widget.id.toString())
                                            .update({
                                          'post_owner_seen_by_business${widget.storename}':
                                              repto
                                        });
                                        final chox = await FirebaseFirestore
                                            .instance
                                            .collection('business_details')
                                            .where('second_uid',
                                                isEqualTo: FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .get();
                                        final busid =
                                            chox.docs.last.data()['first_uid'];
                                        final busid2 = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (ctx) => ChatScreens(
                                        //             widget.id,
                                        //             widget.username,
                                        //             widget.storename,
                                        //             'business',
                                        //             busid,
                                        //             busid2,
                                        //             userid,
                                        //             widget.basicstorename,
                                        //             widget.basicusername)));
                                        // setState(() {
                                        //   loadingxx = false;
                                        // });
                                      },
                                      child: IconButton(
                                        // need gesturedetecture  for doubletap
                                        icon:
                                            const Icon(Icons.messenger_outline),
                                        onPressed: () async {
                                          setState(() {
                                            loadingxx = true;
                                          });
                                          Future.delayed(
                                              const Duration(seconds: 3), (() {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (ctx) => ChatScreens(
                                                        widget.id,
                                                        widget.username,
                                                        widget.storename,
                                                        'business',
                                                        busidx,
                                                        busid2x,
                                                        useridx,
                                                        widget.basicstorename,
                                                        widget.basicusername)));
                                            // setState(() {
                                            //   loadingxx = false;
                                            // });
                                          }));
                                          Future.delayed(
                                              const Duration(seconds: 3), (() {
                                            setState(() {
                                              loadingxx = false;
                                            });
                                          }));
                                          final targ = await FirebaseFirestore
                                              .instance
                                              .collection('listing')
                                              .doc(widget.id.toString())
                                              .get();
                                          final userid = targ.data()!['userid'];
                                          final repto = targ.data()![
                                              'post_owner_reply_to_business${widget.storename}'];
                                          FirebaseFirestore.instance
                                              .collection('listing')
                                              .doc(widget.id.toString())
                                              .update({
                                            'post_owner_seen_by_business${widget.storename}':
                                                repto
                                          });
                                          final chox = await FirebaseFirestore
                                              .instance
                                              .collection('business_details')
                                              .where('second_uid',
                                                  isEqualTo: FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                              .get();
                                          final busid = chox.docs.last
                                              .data()['first_uid'];
                                          final busid2 = FirebaseAuth
                                              .instance.currentUser!.uid;
                                          print(widget.id);
                                          print(widget.username);
                                          print(widget.storename);
                                          print(busid);
                                          print(busid2);
                                          print(userid);

                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (ctx) => ChatScreens(
                                          //             widget.id,
                                          //             widget.username,
                                          //             widget.storename,
                                          //             'business',
                                          //             busid,
                                          //             busid2,
                                          //             userid,
                                          //             widget.basicstorename,
                                          //             widget.basicusername)));
                                          // setState(() {
                                          //   loadingxx = false;
                                          // });
                                        },
                                      ),
                                    ))
                                : GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        loadingxx = true;
                                      });
                                      Future.delayed(const Duration(seconds: 3),
                                          (() {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (ctx) => ChatScreens(
                                                    widget.id,
                                                    widget.username,
                                                    widget.storename,
                                                    'business',
                                                    busidx,
                                                    busid2x,
                                                    useridx,
                                                    widget.basicstorename,
                                                    widget.basicusername)));
                                        // setState(() {
                                        //   loadingxx = false;
                                        // });
                                      }));
                                      Future.delayed(const Duration(seconds: 3),
                                          (() {
                                        setState(() {
                                          loadingxx = false;
                                        });
                                      }));
                                      final targ = await FirebaseFirestore
                                          .instance
                                          .collection('listing')
                                          .doc(widget.id.toString())
                                          .get();
                                      final userid = targ.data()!['userid'];
                                      final repto = targ.data()![
                                          'post_owner_reply_to_business${widget.storename}'];
                                      FirebaseFirestore.instance
                                          .collection('listing')
                                          .doc(widget.id.toString())
                                          .update({
                                        'post_owner_seen_by_business${widget.storename}':
                                            repto
                                      });
                                      final chox = await FirebaseFirestore
                                          .instance
                                          .collection('business_details')
                                          .where('second_uid',
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .get();
                                      final busid =
                                          chox.docs.last.data()['first_uid'];
                                      final busid2 = FirebaseAuth
                                          .instance.currentUser!.uid;
                                      print(widget.id);
                                      print(widget.username);
                                      print(widget.storename);
                                      print(busid);
                                      print(busid2);
                                      print(userid);
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (ctx) => ChatScreens(
                                      //         widget.id,
                                      //         widget.username,
                                      //         widget.storename,
                                      //         'business',
                                      //         busid,
                                      //         busid2,
                                      //         userid,
                                      //         widget.basicstorename,
                                      //         widget.basicusername)));
                                      // setState(() {
                                      //   loadingxx = false;
                                      // });
                                    },
                                    child: IconButton(
                                      // need gesturedetecture  for doubletap
                                      icon: const Icon(Icons.messenger_outline),
                                      onPressed: () async {
                                        setState(() {
                                          loadingxx = true;
                                        });
                                        Future.delayed(
                                            const Duration(seconds: 3), (() {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (ctx) => ChatScreens(
                                                      widget.id,
                                                      widget.username,
                                                      widget.storename,
                                                      'business',
                                                      busidx,
                                                      busid2x,
                                                      useridx,
                                                      widget.basicstorename,
                                                      widget.basicusername)));
                                          // setState(() {
                                          //   loadingxx = false;
                                          // });
                                        }));
                                        Future.delayed(
                                            const Duration(seconds: 3), (() {
                                          setState(() {
                                            loadingxx = false;
                                          });
                                        }));
                                        final targ = await FirebaseFirestore
                                            .instance
                                            .collection('listing')
                                            .doc(widget.id.toString())
                                            .get();
                                        final repto = targ.data()![
                                            'post_owner_reply_to_business${widget.storename}'];
                                        FirebaseFirestore.instance
                                            .collection('listing')
                                            .doc(widget.id.toString())
                                            .update({
                                          'post_owner_seen_by_business${widget.storename}':
                                              repto
                                        });
                                        final chox = await FirebaseFirestore
                                            .instance
                                            .collection('business_details')
                                            .where('second_uid',
                                                isEqualTo: FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .get();
                                        final busid =
                                            chox.docs.last.data()['first_uid'];
                                        final busid2 = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        final userid = targ.data()!['userid'];

                                        print(widget.id);
                                        print(widget.username);
                                        print(widget.storename);
                                        print(busid);
                                        print(busid2);
                                        print(userid);
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (ctx) => ChatScreens(
                                        //             widget.id,
                                        //             widget.username,
                                        //             widget.storename,
                                        //             'business',
                                        //             busid,
                                        //             busid2,
                                        //             userid,
                                        //             widget.basicstorename,
                                        //             widget.basicusername)));
                                        // setState(() {
                                        //   loadingxx = false;
                                        // });
                                      },
                                    ),
                                  );
                      })
                  : const SizedBox(),
              AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      '',
                      textStyle: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 13),
                      speed: const Duration(milliseconds: 200),
                    )
                  ],
                  totalRepeatCount: 1,
                  //  repeatForever: true,
                  // onFinished: () => setState(() {
                  //   loading = true;
                  // }),
                  onNext: (p0, p1) async {
                    if (loading == false) {
                      final listdoc = await FirebaseFirestore.instance
                          .collection('listing')
                          .doc(widget.id)
                          .get();
                      final city = listdoc.data()!['city'];
                      final category = listdoc.data()!['category'];

                      final chox = await FirebaseFirestore.instance
                          .collection('business_details')
                          .where('second_uid',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .get();
                      setState(() {
                        cityx = city;
                        categoryx = category;
                        useridx = listdoc.data()!['userid'];
                        busidx = chox.docs.first.data()['first_uid'];
                      });
                    }

                    setState(() {
                      loading = true;
                      //  loadingxx = false;
                    });
                  }),
            ])),
          ]),
        ),
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
                        child: LinearProgressIndicator(),
                      );
                    }
                    // if (userSnapshotx.connectionState ==
                    //     ConnectionState.waiting) {
                    //   return const Center(
                    //     child: Text(
                    //       'Loading...',
                    //       style: TextStyle(fontSize: 2),
                    //     ),
                    //   );
                    // }
                    if (userSnapshotx.hasData == false) {
                      return const Center(
                        child: LinearProgressIndicator(),
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
