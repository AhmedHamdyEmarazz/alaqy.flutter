import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ListingCardsDetailsScreensub.dart';
import 'SPLASHSCREEN.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ListingCardsDetailsScreensubx extends StatefulWidget {
  static const routeName = '/ListingCardsDetailsScreensubx';
  final String id;
  final Timestamp createdAt;
  final String title;
  final String imageurl;
  final String description;
  const ListingCardsDetailsScreensubx(
      this.id, this.createdAt, this.title, this.imageurl, this.description,
      {super.key});
  // final String oppi;
//  final String oppoo;

//  Messagess(this.oppoo, this.oppi);
  @override
  State<ListingCardsDetailsScreensubx> createState() =>
      ListingCardsDetailsScreensubxState();
}

class ListingCardsDetailsScreensubxState
    extends State<ListingCardsDetailsScreensubx> {
  var _showOnlyFavorites = false;
  List businessareasids = [];
  List businessareas = [];
  List<Widget> nnn = [];
  List<DropdownMenuItem> mmm = [];
  var area = '';
  var areax = '';

  bool loading = false;
  @override
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
  // void initState() {
  //   super.initState();
  //   final fbm = FirebaseMessaging.instance;
  //   fbm.requestNotificationPermissions();
  //   fbm.configure(onMessage: (msg) {
  //     print(msg);
  //     return;
  //   }, onLaunch: (msg) {
  //     print(msg);
  //     return;
  //   }, onResume: (msg) {
  //     print(msg);
  //     return;
  //   });
  //   fbm.getToken();
  //   //  fbm.unsubscribeFromTopic('beek');
  // }
  // void initState() {
  //   super.initState();
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage message) {
  //         if (message != null) {
  //           // Navigator.pushNamed(context, '/message',
  //           //     arguments: MessageArguments(message, true));
  //         }
  //       } as FutureOr Function(RemoteMessage? value));
  // }

  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final usex = FirebaseAuth.instance.currentUser == null
        ? ''
        : FirebaseAuth.instance.currentUser!.uid;
    dynamic badgoo;
    dynamic bag = 0;

    final fbm = FirebaseMessaging.instance;
    fbm.getToken();
    //  fbm.subscribeToTopic(notyu);
    fbm.onTokenRefresh;
    print('$area xxxxxx');
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('listing')
            .doc(widget.id.toString())
            .snapshots(),
        builder: (ctx, chatSnapshottt) {
          if (chatSnapshottt.hasData == false) {
            return SplashScreen();
// const Center(
//                         child: CircularProgressIndicator(),
//                       );
          }
          final chatDocs = chatSnapshottt.hasData ? chatSnapshottt.data : null;
          List storesidzx = chatDocs!.data()!['storesidz'];
          storesidzx.remove(storesidzx.first);
          // for (var r = 0; r < storesidzx.length; r++) {
          //   var busname = FirebaseFirestore.instance
          //       .collection('business_details')
          //       .doc(storesidzx[r])
          //       .get();
          //   businessareasids
          //       .add(busname.then((value) => value.data()!['area_id']));
          // }
          // for (var x = 0; x < businessareasids.length; x++) {
          //   var areaname = FirebaseFirestore.instance
          //       .collection('area')
          //       .doc(businessareasids[x])
          //       .get();
          //   businessareas
          //       .add(areaname.then((value) => value.data()!['name']));
          // }
          return chatSnapshottt.hasData == false
              ? //SplashScreen()
              const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Column(children: [
                    SizedBox(
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
                                trailing: DropdownButton(
                                  alignment: Alignment.bottomRight,
                                  underline: loading == false
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : Text(
                                          _showOnlyFavorites == false
                                              ? 'تصفية حسب المنطقة'
                                              : areax,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: _showOnlyFavorites == false
                                                  ? Colors.grey
                                                  : Colors.blueGrey),
                                        ),
                                  // icon: Icon(Icons.location_on_outlined,
                                  //     color: _showOnlyFavorites == false
                                  //         ? Colors.grey
                                  //         : Colors.blueGrey),
                                  onChanged: (value) {
                                    if (businessareas.isEmpty) {
                                      null;
                                    }
                                    if (businessareas.isNotEmpty) {
                                      for (var m = 0;
                                          m < businessareas.length;
                                          m++) {
                                        if (value == businessareas[m]) {
                                          area = businessareasids[m];
                                          areax = businessareas[m];

                                          setState(() {
                                            _showOnlyFavorites = true;
                                            areax = businessareas[m];
                                          });
                                          print('$area vvvv');
                                        }
                                      }
                                    }
                                  },
                                  selectedItemBuilder: (BuildContext context) {
                                    return nnn;
                                  },
                                  items: mmm,
                                ),
                                leading:
// DropdownButton(
//                                     alignment: Alignment.bottomRight,
                                    // underline: loading == false
                                    //     ? const Center(child:  CircularProgressIndicator())
                                    //     : Text(
                                    //         _showOnlyFavorites == false
                                    //             ? 'تصفية حسب المنطقة'
                                    //             : area,
                                    //         style: TextStyle(
                                    //             color: _showOnlyFavorites == false
                                    //                 ? Colors.grey
                                    //                 : Colors.blueGrey),
                                    //       ),
                                    //     icon:
                                    Icon(Icons.location_on_outlined,
                                        color: _showOnlyFavorites == false
                                            ? Colors.grey
                                            : Colors.blueGrey),
                                //   onChanged:
                                onTap: () {
                                  if (businessareas.isEmpty) {
                                    null;
                                  }
                                  if (businessareas.isNotEmpty) {
                                    // for (var m = 0;
                                    //     m < businessareas.length;
                                    //     m++) {
                                    //   if (value == businessareas[m]) {
                                    //     area = businessareasids[m];
                                    //     areax = businessareas[m];
                                    //     setState(() {
                                    //       _showOnlyFavorites = true;
                                    //       areax = businessareas[m];
                                    //     });
                                    //     print(area);
                                    //   }
                                    // }
                                    setState(() {
                                      _showOnlyFavorites = false;
                                    });
                                  }
                                },
                                // selectedItemBuilder:
                                //     (BuildContext context) {
                                //   return nnn;
                                // },
                                // items: mmm,
                              ),
                            )
//                                )
                            )),
                    GestureDetector(
                        onTap: () {
                          widget.imageurl ==
                                  'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
                              ? null
                              : Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
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
                                                strokeAlign: BorderSide
                                                    .strokeAlignOutside),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(8)),
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
                                            color: Color.fromARGB(
                                                255, 252, 250, 250),
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
                    Expanded(
                        child: ListingCardsDetailsScreensub(
                            widget.id,
                            widget.createdAt,
                            widget.title,
                            widget.imageurl,
                            widget.description,
                            area,
                            _showOnlyFavorites) //),
                        ),
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
                          if (storesidzx.isEmpty) {}
                          var listx = await FirebaseFirestore.instance
                              .collection('listing')
                              .doc(widget.id)
                              .get();
                          final listcity = listx.data()!['city_id'];
                          // var areanamez = await FirebaseFirestore.instance
                          //     .collection('area')
                          //     .get();
                          for (var r = 0; r < storesidzx.length; r++) {
                            var busname = await FirebaseFirestore.instance
                                .collection('business_details')
                                .doc(storesidzx[r])
                                .get();
                            businessareasids.add(busname.data()!['area_id']);
                          }
                          // businessareasids.toSet().toList();
                          businessareasids = [
                            ...{...businessareasids}
                          ];
                          print(businessareasids);
                          print("الله اكبر");

                          // var xomnia = businessareasids.length;
                          // for (var j = 0; j < xomnia; j++) {
                          //   print(xomnia);
                          //   print("الله اكبر");

                          //   if (j > 0 &&
                          //       businessareasids[j] ==
                          //           businessareasids[j - 1]) {
                          //     businessareasids.removeAt(j - 1);
                          //     setState(() {
                          //       xomnia = xomnia - 1;
                          //     });
                          //   }
                          // }
                          for (var x = 0; x < businessareasids.length; x++) {
                            var areaname = await FirebaseFirestore.instance
                                .collection('city')
                                .doc(listcity)
                                .collection('areas')
                                .doc(businessareasids[x])
                                .get();
                            businessareas.add(areaname.data()!['name']);
                          }
                          //  businessareas.getRange(0, storesidzx.length);
                          if (businessareas.isEmpty) {
                            mmm.add(DropdownMenuItem(
                                value: 'no stores yet',
                                child: Container(
                                  child: Row(
                                    children: const <Widget>[
                                      Icon(Icons.location_on),
                                      SizedBox(width: 2),
                                      Text('no stores yet'),
                                    ],
                                  ),
                                )));
                            nnn.add(const Text('no stores yet'));
                          }
                          if (businessareas.isNotEmpty) {
                            for (var z = 0; z < businessareas.length; z++) {
                              nnn.add(Text(businessareas[z]));
                              mmm.add(DropdownMenuItem(
                                  value: businessareas[z],
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(Icons.location_on),
                                        const SizedBox(width: 2),
                                        Text(businessareas[z]),
                                      ],
                                    ),
                                  )));
                            }
                          }
                          setState(() {
                            loading = true;
                          });
                        }
                      },
                    ),
                  ]));
        });
  }
}
