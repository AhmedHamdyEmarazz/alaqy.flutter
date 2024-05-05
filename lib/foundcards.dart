import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'SPLASHSCREEN.dart';
import 'ordercarditem.dart';

class foundCards extends StatefulWidget {
  static const routeName = '/foundCards';

  const foundCards({super.key});
  // final String oppi;
//  final String oppoo;

//  Messagess(this.oppoo, this.oppi);
  @override
  State<foundCards> createState() => foundCardsState();
}

class foundCardsState extends State<foundCards> {
  final reportcontroller = TextEditingController();
  dynamic report;

  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser!.uid;

    final fbm = FirebaseMessaging.instance;
    fbm.getToken();
    //  fbm.subscribeToTopic(notyu);
    fbm.onTokenRefresh;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('business_details')
                .where('second_uid', isEqualTo: userid)
                .snapshots(),
            builder: (ctx, chatSnapshottt) {
              if (chatSnapshottt.hasData == false) {
                return const Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(fontSize: 2),
                  ),
                );
              }
              if (chatSnapshottt.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (chatSnapshottt.hasData == false) {
                return const Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(fontSize: 2),
                  ),
                );
              }
              final chatDocss =
                  chatSnapshottt.hasData ? chatSnapshottt.data!.docs : null;
              final shopcity = chatDocss!.first.data()['city'];
              final shopcategory = chatDocss.first.data()['category'];
              final docid = chatDocss.first.id;
              final storename = chatDocss.first.data()['store_name'];
              final basicstorename = chatDocss.first.data()['basicstore_name'];

              return chatSnapshottt.hasData == false
                  ? const Center(
                      child: Text('loading'),
                    )
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('listing')
                          // .where('city', isEqualTo: shopcity)
                          // .where('category', isEqualTo: shopcategory)
                          //   .orderBy('createdAt', descending: true)
                          .snapshots(),
                      builder: (ctx, chatSnapshot) {
                        // if (chatSnapshot.connectionState ==
                        //     ConnectionState.waiting) {
                        //   return const Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                        if (chatSnapshot.hasData == false) {
                          return SplashScreen();
// const Center(
//                         child: CircularProgressIndicator(),
//                       );
                        }
                        final chatDocs = chatSnapshot.hasData
                            ? chatSnapshot.data!.docs
                            : null;
                        final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            arrange = [];
                        final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            arrangex = [];
                        for (var r = 0; r < chatDocs!.length; r++) {
                          arrangex.add(chatDocs[r]);
                        }
                        arrangex.sort((a, b) =>
                            (a.data()['createdAt'] as Timestamp)
                                .compareTo(b.data()['createdAt']));
                        arrange.addAll(arrangex.reversed);
                        return chatSnapshot.hasData == false
                            ? const Center(
                                child: Text('loading'),
                              )
                            : ListView.builder(
                                reverse: false,

                                ///
                                itemCount: arrange.length,
                                itemBuilder: (ctx, index) => Column(children: [
                                      (arrange[index]
                                              .data()
                                              .containsKey(basicstorename))
                                          ? arrange[index]
                                                      .data()[basicstorename] ==
                                                  'closedx'
                                              ? const SizedBox()
                                              : SizedBox(
                                                  //  height: 160,
                                                  width: double.infinity,
                                                  child: Ordercarditem(
                                                      arrange[index]
                                                          ['idstring'],
                                                      arrange[index]
                                                          ['createdAt'],
                                                      arrange[index]['title'],
                                                      arrange[index]
                                                          ['image_url'],
                                                      arrange[index]
                                                          ['description'],
                                                      arrange[index]
                                                          ['username'],
                                                      true,
                                                      arrange[index][
                                                          '${basicstorename}close'],
                                                      arrange[index]
                                                          [basicstorename],
                                                      basicstorename,
                                                      arrange[index][
                                                          '${basicstorename}price'],
                                                      basicstorename,
                                                      arrange[index]
                                                          ['basicemail'],
                                                      arrange[index]['closed']))
                                          : const SizedBox(),
                                      (arrange[index]
                                              .data()
                                              .containsKey(basicstorename))
                                          ? arrange[index]
                                                      .data()[basicstorename] ==
                                                  'closedx'
                                              ? const SizedBox()
                                              : const SizedBox(
                                                  height: 4,
                                                )
//  const Divider(
//                                                   color: Colors.black87,
//                                                   thickness: 2,
//                                                   indent: 100,
//                                                   endIndent: 100)
                                          : const SizedBox()
                                    ]));
                      });
            }));
  }
}
