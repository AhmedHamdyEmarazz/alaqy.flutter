import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'SPLASHSCREEN.dart';
import 'listingcardsdetailsitem.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ListingCardsDetailsScreensub extends StatefulWidget {
  static const routeName = '/ListingCardsDetailsScreen';
  final String id;
  final Timestamp createdAt;
  final String title;
  final String imageurl;
  final String description;
  final String areaid;
  final bool _showOnlyFavorites;
  const ListingCardsDetailsScreensub(this.id, this.createdAt, this.title,
      this.imageurl, this.description, this.areaid, this._showOnlyFavorites,
      {super.key});
  // final String oppi;
//  final String oppoo;

//  Messagess(this.oppoo, this.oppi);
  @override
  State<ListingCardsDetailsScreensub> createState() =>
      ListingCardsDetailsScreensubState();
}

class ListingCardsDetailsScreensubState
    extends State<ListingCardsDetailsScreensub> {
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
            return Center(child: SizedBox(height: 280, child: SplashScreen()));
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
              ? Center(
                  child:
                      SizedBox(height: 280, child: LinearProgressIndicator()))

// const Center(
//                         child: CircularProgressIndicator(),
//                       );
              : SizedBox(
                  child: ScrollablePositionedList.builder(
                      //  reverse: true,
                      itemCount: storesidzx.length,
                      itemBuilder: (ctx, index) => SingleChildScrollView(
                            child:
                                // Column(children: [
                                ListingCardsDetailsItem(
                                    storesidzx[index],
                                    widget.id,
                                    widget._showOnlyFavorites,
                                    widget.areaid),
                            //   AnimatedTextKit(
                            //     animatedTexts: [
                            //       ColorizeAnimatedText(
                            //           '<<<<<<<<<    اسحب الى اليسار لحذف الغرض ',
                            //           //   textAlign: TextAlign.end,
                            //           colors: [
                            //             Color.fromARGB(255, 226, 219, 157),
                            //             Colors.black12,
                            //             Color.fromARGB(255, 226, 219, 157),
                            //           ],
                            //           textStyle: const TextStyle(
                            //             fontSize: 11,
                            //           ),
                            //           speed: const Duration(milliseconds: 100)),
                            //     ],
                            //     repeatForever: true,
                            //   ),
                            //   // const Divider(
                            //   //     color: Colors.black87,
                            //   //     thickness: 2,
                            //   //     indent: 100,
                            //   //     endIndent: 100),
                            //   SizedBox(
                            //     height: 2,
                            //   ),
                            //  ])
                          )));
        });
  }
}
