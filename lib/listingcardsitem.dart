import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'badge.dart';
import 'listingcardsdetailsscreen.dart';

class ListingCardsItem extends StatelessWidget {
  final String id;
  final Timestamp createdAt;
  final String title;
  final String imageurl;
  final String description;
  final bool totalclose;
  final bool closed;
  final num messages;
  const ListingCardsItem(this.id, this.createdAt, this.title, this.imageurl,
      this.description, this.totalclose, this.closed, this.messages,
      {super.key});

  @override
  Widget build(BuildContext context) {
    int badgoo = 0;
    int bebo = 0;
    final size = MediaQuery.of(context).size;
    final hightx = size.height;
    final widthx = size.width;
    return (closed == true)
        ? GestureDetector(
            onTap: () async {
              final sub = await FirebaseFirestore.instance
                  .collection('listing')
                  .doc(id.toString())
                  .get();
              final see = sub.data()!['seen'];
              final mee = sub.data()!['messages'];
              final sen = sub.data()!['sent'];
              final stz = (([sub.data()!['storesidz']].length) - 1);
              final sti = [sub.data()!['storesi']];

              final subx = sen - mee;
              final seenx = see - subx;
              FirebaseFirestore.instance
                  .collection('listing')
                  .doc(id.toString())
                  .update({'seen': sen, 'storesi': stz});
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ListingCardsDetailsScreen(
                      id, createdAt, title, imageurl, description)));
            },
            child: Dismissible(
                key: ValueKey(id),
                background: Container(
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
                    size: 40,
                  ),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('هل أنت متأكد ؟'),
                      content: const Text(
                        'هل ترغب في حذف المنشور ؟',
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
                          onPressed: () {
                            messages > 0
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 3),
                                      content: const Text(
                                          ' لا يمكن حذف هذا الغرض  نهائيا بسبب وجود محادثة مفعلة'),
                                      backgroundColor:
                                          Theme.of(context).errorColor,
                                    ),
                                  )
                                : FirebaseFirestore.instance
                                    .collection('listing')
                                    .doc(id)
                                    .update({'total close': true});
                            Navigator.of(ctx).pop(true);
                          },
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) {
                  //Provider.of<Cart>(context, listen: false).removeItem(productId);
                },
                child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(children: [
                      Center(
                          child: Text(
                              'التاريخ:${DateFormat('dd/MM/yyyy hh:mm').format((createdAt).toDate())}',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey))),
                      const Text('مغلق',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, color: Colors.red)),
                      AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                              '<<<<<<<<<    إسحب إلى اليسار للحذف ',
                              colors: [
                                Colors.red,
                                Colors.green,
                                Colors.redAccent,
                              ],
                              textStyle: const TextStyle(
                                fontSize: 9,
                              ),
                              speed: const Duration(microseconds: 100)),
                        ],
                        repeatForever: true,
                        // onNext: (p0, p1) {
                        //   setbusidx();
                        // },
                      ),
                      messages > 0
                          ? StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('listing')
                                  .doc(id.toString())
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

                                if (userSnapshot.hasData == true) {
                                  final badgo1 = chatDocs!.data()!['messages'];
                                  final badgo2 =
                                      chatDocs.data()!['messages_seen'];

                                  badgoo = badgo1 - badgo2;
                                }

                                return badgoo != 0
                                    ? Badgee(
                                        value: badgoo.toString(),
                                        color: const Color.fromARGB(
                                            176, 244, 67, 54),
                                        child: const Icon(
                                          size: 28,
                                          Icons.chat_bubble_outline_rounded,
                                          color: Colors.black,
                                        ),
                                      )
                                    : const Icon(
                                        size: 28,
                                        Icons.chat_bubble_outline_rounded,
                                        color: Colors.black,
                                      );
                              })
                          : const SizedBox(),
                    ]))))
        : GestureDetector(
            onTap: () async {
              final sub = await FirebaseFirestore.instance
                  .collection('listing')
                  .doc(id.toString())
                  .get();
              final see = sub.data()!['seen'];
              final mee = sub.data()!['messages'];
              final sen = sub.data()!['sent'];
              final stz = (([sub.data()!['storesidz']].length) - 1);
              final sti = [sub.data()!['storesi']];

              final subx = sen - mee;
              final seenx = see - subx;
              FirebaseFirestore.instance
                  .collection('listing')
                  .doc(id.toString())
                  .update({'seen': sen, 'storesi': stz});
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ListingCardsDetailsScreen(
                      id, createdAt, title, imageurl, description)));
            },
            child: Dismissible(
                key: ValueKey(id),
                background: Container(
                  color: Theme.of(context).errorColor,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: const Icon(
                    Icons.close_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('هل أنت متأكد ؟'),
                      content: const Text(
                        'هل ترغب في إغلاق الطلب',
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
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('listing')
                                .doc(id.toString())
                                .update({'closed': true});
                            FirebaseFirestore.instance
                                .collection('listdetails')
                                .doc(id.toString())
                                .update({'closed': true});
                            Navigator.of(ctx).pop(true);
                          },
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) {
                  //Provider.of<Cart>(context, listen: false).removeItem(productId);
                },
                child: Center(
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 4,
                        ),
                        width: widthx - 50,
                        //   height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          color: Colors.grey.shade300,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 2,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: widthx - 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                            color: Color.fromARGB(255, 252, 250, 250),
                          ),
                          child: Column(children: [
                            // SingleChildScrollView(
                            //     scrollDirection: Axis.horizontal,
                            //     child:
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                      child: Container(
                                          width: 150,
                                          child: Column(children: [
                                            Text(
                                              //  softWrap: true,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              title.characters.take(30).string,
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Tajawal',
                                                  color: Colors.black),
                                              //      )
                                            ),
//
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              description.characters
                                                  .take(30)
                                                  .string,
                                              style: const TextStyle(
                                                  //        fontStyle: FontStyle.italic,
                                                  //   fontWeight: FontWeight.w100,
                                                  fontFamily: 'Tajawal',
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            //  Center(
                                            //   child:
                                            Text(
                                                '${DateFormat('dd/MM/yyyy hh:mm').format(createdAt.toDate())}',
                                                style: const TextStyle(
                                                    //   fontStyle: FontStyle.italic,
                                                    fontSize: 10,
                                                    color: Colors.black)),
                                            //  ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('listing')
                                                          .doc(id.toString())
                                                          .snapshots(),
                                                      builder:
                                                          (ctx, userSnapshot) {
                                                        if (userSnapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child: Text(
                                                              'Loading...',
                                                              style: TextStyle(
                                                                  fontSize: 2),
                                                            ),
                                                          );
                                                        }
                                                        final chatDocs =
                                                            userSnapshot.hasData
                                                                ? userSnapshot
                                                                    .data
                                                                : null;

                                                        if (userSnapshot
                                                                .hasData ==
                                                            true) {
                                                          final badgo1 = ([
                                                                chatDocs!
                                                                        .data()![
                                                                    'storesidz']
                                                              ].length) -
                                                              1;
                                                          final badgo2 =
                                                              (chatDocs.data()![
                                                                      'storesi'])
                                                                  as num;

                                                          badgoo = badgo1 -
                                                              badgo2.toInt();
                                                        }
                                                        final lito = [];
                                                        //final List<String> items = [];
                                                        for (var i = 0;
                                                            i <
                                                                [
                                                                  chatDocs!
                                                                          .data()![
                                                                      'storesidz']
                                                                ]
                                                                    .toList()
                                                                    .length;
                                                            i++) {
                                                          lito.add([
                                                            chatDocs.data()![
                                                                'storesidz']
                                                          ][i]);
                                                        }

                                                        return
// bads != 0
//                                   ?

                                                            StreamBuilder(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'reply_comment')
                                                                    .doc(id
                                                                        .toString())
                                                                    .snapshots(),
                                                                builder: (ctx,
                                                                    chatSnapshottt) {
                                                                  if (chatSnapshottt
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return chatSnapshottt
                                                                            .hasData
                                                                        ? const Center(
                                                                            child:
                                                                                CircularProgressIndicator(),
                                                                          )
                                                                        : const Center(
                                                                            child:
                                                                                Text('loading'),
                                                                          );
                                                                  }

                                                                  final chatDocs =
                                                                      chatSnapshottt
                                                                          .data!;
                                                                  return chatDocs
                                                                          .exists
                                                                      ? StreamBuilder(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection(
                                                                                  'reply_comment')
                                                                              .doc(id
                                                                                  .toString())
                                                                              .collection(
                                                                                  'reply')
                                                                              .snapshots(),
                                                                          builder: (ctx,
                                                                              chatSnapshotfx) {
                                                                            if (chatSnapshotfx.connectionState ==
                                                                                ConnectionState.waiting) {
                                                                              return chatSnapshotfx.hasData
                                                                                  ? const Center(
                                                                                      child: CircularProgressIndicator(),
                                                                                    )
                                                                                  : const Center(
                                                                                      child: Text('loading'),
                                                                                    );
                                                                            }

                                                                            final chatDocsfx =
                                                                                chatSnapshotfx.data!.docs;
                                                                            final number =
                                                                                chatDocsfx.length;
                                                                            //                       return Badgee(
                                                                            //                         value: number.toString(),
                                                                            //                         color: Colors.black12,
                                                                            //                         child: const Icon(
                                                                            //                           Icons.store_outlined,
                                                                            //                           color: Colors.cyanAccent,
                                                                            //                         ),
                                                                            //                       );
                                                                            //                     })
                                                                            //                 : const Icon(
                                                                            //                     Icons.store_outlined,
                                                                            //                     color: Colors.blueGrey,
                                                                            //                   );
                                                                            //           });
                                                                            // }),
                                                                            return StreamBuilder(
                                                                                stream: FirebaseFirestore.instance.collection('listing').doc(id.toString()).snapshots(),
                                                                                builder: (ctx, userSnapshot) {
                                                                                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                                                                                    return const Center(
                                                                                      child: Text(
                                                                                        'Loading...',
                                                                                        style: TextStyle(fontSize: 2),
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                  final chatDocs = userSnapshot.hasData ? userSnapshot.data : null;

                                                                                  if (userSnapshot.hasData == true) {
                                                                                    final badgo1 = chatDocs!.data()!['sent'];
                                                                                    final stix = [
                                                                                      chatDocs.data()!['storesi']
                                                                                    ];
                                                                                    final stz = (([
                                                                                          chatDocs.data()!['storesidz']
                                                                                        ].length) -
                                                                                        1);
                                                                                    final badgo2 = chatDocs.data()!['seen'];
                                                                                    final badgox = chatDocs.data()!['messages'];
                                                                                    final badgoxx = chatDocs.data()!['messages_seen'];

                                                                                    badgoo = (badgo1 - badgox) - (badgo2 - badgoxx);
                                                                                    // bebo = (stz -
                                                                                    //         stix.length)
                                                                                    //     .toInt();
                                                                                    bebo = (number - badgoo).toInt();
                                                                                  }
                                                                                  // print(
                                                                                  //     '$badgoo xxxxxxxx');
                                                                                  // print(
                                                                                  //     '$number  cccccccc');
                                                                                  // print(
                                                                                  //     '$bebo  `zzzzzz`');
                                                                                  return number != 0
                                                                                      ? Badgee(
                                                                                          value: number.toString(),
                                                                                          color: bebo == 0.0 || bebo == 0 ? const Color.fromARGB(176, 244, 67, 54) : Colors.black12,
                                                                                          child: const Icon(
                                                                                            size: 33,
                                                                                            Icons.store_outlined,
                                                                                            color: Colors.amber,
                                                                                          ),
                                                                                        )
                                                                                      : const Icon(
                                                                                          size: 33,
                                                                                          Icons.store_outlined,
                                                                                          color: Colors.black,
                                                                                        );
                                                                                });
                                                                          })
                                                                      : const Icon(
                                                                          size:
                                                                              33,
                                                                          Icons
                                                                              .store_outlined,
                                                                          color:
                                                                              Colors.black);
                                                                });
                                                      }),
                                                  SizedBox(
                                                    width: 17,
                                                  ),
                                                  StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('listing')
                                                          .doc(id.toString())
                                                          .snapshots(),
                                                      builder:
                                                          (ctx, userSnapshot) {
                                                        if (userSnapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child: Text(
                                                              'Loading...',
                                                              style: TextStyle(
                                                                  fontSize: 2),
                                                            ),
                                                          );
                                                        }
                                                        final chatDocs =
                                                            userSnapshot.hasData
                                                                ? userSnapshot
                                                                    .data
                                                                : null;

                                                        if (userSnapshot
                                                                .hasData ==
                                                            true) {
                                                          final badgo1 =
                                                              chatDocs!.data()![
                                                                  'messages'];
                                                          final badgo2 = chatDocs
                                                                  .data()![
                                                              'messages_seen'];

                                                          badgoo =
                                                              badgo1 - badgo2;
                                                        }

                                                        return badgoo != 0
                                                            ? Badgee(
                                                                value: badgoo
                                                                    .toString(),
                                                                color: const Color
                                                                        .fromARGB(
                                                                    176,
                                                                    244,
                                                                    67,
                                                                    54),
                                                                child:
                                                                    const Icon(
                                                                  size: 28,
                                                                  Icons
                                                                      .chat_bubble_outline_rounded,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            : const Icon(
                                                                size: 28,
                                                                Icons
                                                                    .chat_bubble_outline_rounded,
                                                                color: Colors
                                                                    .black,
                                                              );
                                                      })
                                                ]),
//SizedBox(height: 15,)
                                          ]))),
                                  Container(
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
                                        color:
                                            Color.fromARGB(255, 252, 250, 250),
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
                                            width: 100,
                                            height: 100,
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
                                            child: imageurl ==
                                                    'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
                                                ? Image.asset(
                                                    'assets/alaqyp.jpeg',
                                                    fit: BoxFit.contain,
                                                  )
                                                : Image.network(imageurl,
                                                    fit: BoxFit.fill,
                                                    isAntiAlias: true,
                                                    filterQuality:
                                                        FilterQuality.low),
                                          ),
                                          Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3,
                                                    color: Color.fromARGB(
                                                        255, 252, 250, 250),
                                                    strokeAlign: BorderSide
                                                        .strokeAlignOutside),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8)),
                                              ),
                                              child: SizedBox()),
                                        ])),
                                  ),
                                ]), //),
                            AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                    '<<<<<<<<<    اسحب الى اليسار لحذف المنشور ',
                                    colors: [
                                      Color.fromARGB(255, 226, 219, 157),
                                      Colors.black12,
                                      Color.fromARGB(255, 226, 219, 157),
                                    ],
                                    textStyle: const TextStyle(
                                      fontSize: 11,
                                    ),
                                    speed: const Duration(milliseconds: 100)),
                              ],
                              repeatForever: true,
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ]),
//        )
                        )))));
  }
}
