import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'badge.dart';
import 'chat_screens.dart';

class ListingCardsDetailsItem extends StatefulWidget {
  final String id;
  final String listid;
  final bool filter;
  final String area;

  const ListingCardsDetailsItem(this.id, this.listid, this.filter, this.area,
      {super.key});

  @override
  State<ListingCardsDetailsItem> createState() =>
      _ListingCardsDetailsItemState();
}

class _ListingCardsDetailsItemState extends State<ListingCardsDetailsItem> {
  int badgoo = 0;
  bool loadingxx = false;

  void routex(busid2x, username, storename, busidx, useridx, basicstorename,
      basicusername) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => ChatScreens(
            widget.listid,
            username,
            storename,
            'customer',
            busidx,
            busid2x,
            useridx,
            basicstorename,
            basicusername)));
  }

  @override
  Widget build(BuildContext context) {
    final userx = FirebaseAuth.instance.currentUser!.uid;
    print(widget.id);
    print(widget.listid);
    print('xxxxxxxxxxxxxxxx');

    return Dismissible(
        key: ValueKey(widget.id),
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
                'هل ترغب في حذف المعرض من القائمة ؟',
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
                    final busi = await FirebaseFirestore.instance
                        .collection('business_details')
                        .doc(widget.id.toString())
                        .get();
                    final name = busi.data()!['basicstore_name'];
                    final listo = await FirebaseFirestore.instance
                        .collection('listing')
                        .doc(widget.listid.toString())
                        .get();
                    final chatind = listo.data()![name];

                    print(
                        '$chatind zzzzzzzzzzzzzzzzzz zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
                    chatind == 'off'
                        ? FirebaseFirestore.instance
                            .collection('listing')
                            .doc(widget.listid.toString())
                            .update({
                            '${busi.data()!['basicstore_name']}close': true
                          })
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 3),
                              content: const Text(
                                  'لا يمكن حذف هذا الغرض بسبب وجود محادثة'),
                              backgroundColor: Theme.of(context).errorColor,
                            ),
                          );
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
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('business_details')
                .doc(widget.id.toString())
                .snapshots(),
            builder: (ctx, chatSnapshottt) {
              if (chatSnapshottt.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
              final chatDocs =
                  chatSnapshottt.hasData ? chatSnapshottt.data : null;
              final store_name = chatDocs!.data()!['store_name'];
              final basicstore_name = chatDocs.data()!['basicstore_name'];

              final busid = chatDocs.data()!['first_uid'];
              final busid2 = chatDocs.data()!['second_uid'];
              final area_id = chatDocs.data()!['area_id'];

// final kobry = await FirebaseFirestore.instance
//                     .collection('business_details')
//                     .doc(id.toString()).get();
              return chatSnapshottt.hasData == false
                  ? const Center(
                      child: Text('no valid orders yet'),
                    )
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('listing')
                          .doc(widget.listid.toString())
                          .snapshots(),
                      builder: (ctx, chatSnapshot) {
                        if (chatSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LinearProgressIndicator(),
                          );
                        }
                        final chatDocss =
                            chatSnapshot.hasData ? chatSnapshot.data : null;
                        final store_nameprice =
                            chatDocss!.data()!['${basicstore_name}price'];

                        final store_messagesIndicator =
                            chatDocss.data()!['$basicstore_name'];
                        final store_closeIndicator =
                            chatDocss.data()!['${basicstore_name}close'];
                        final store_messages =
                            chatDocss.data()!['${basicstore_name}messages'];
                        final store_messagesseen =
                            chatDocss.data()!['${basicstore_name}messagesseen'];
                        final cusid = chatDocss.data()!['userid'];
                        final messbaqy = store_messages - store_messagesseen;
                        final messages = chatDocss.data()!['messages'];
                        final messages_seen =
                            chatDocss.data()!['messages_seen'];
                        final sent = chatDocss.data()!['sent'];
                        final seen = chatDocss.data()!['seen'];
                        final sentminseen = sent - seen;
                        final username = chatDocss.data()!['username'];
                        final basicusername = chatDocss.data()!['basicemail'];
                        final area_id_list = chatDocss.data()!['area_id'];

// final kobry = await FirebaseFirestore.instance
//                     .collection('business_details')
//                     .doc(id.toString()).get();
                        return chatSnapshottt.hasData == false
                            ? const Center(
                                child: Text('no valid orders yet'),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  final seendoc = await FirebaseFirestore
                                      .instance
                                      .collection('listing')
                                      .doc(widget.listid.toString())
                                      .get();
                                  final seen = seendoc.data()!['seen'];
                                  await FirebaseFirestore.instance
                                      .collection('listing')
                                      .doc(widget.listid.toString())
                                      .update({
                                    'seen': sentminseen == 0
                                        ? seen
                                        : seen + messbaqy,
                                    'messages_seen': messages_seen + messbaqy,
                                    '${basicstore_name}messagesseen':
                                        store_messages
                                  });
                                },
                                child:
//  store_closeIndicator == true
//                                     ? SizedBox()
//                                     :
                                    !widget.filter
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 4,
                                            ),
                                            child: Column(children: [
                                              ListTile(
                                                onTap: () async {
                                                  setState(() {
                                                    loadingxx = true;
                                                  });
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('listing')
                                                      .doc(widget.listid
                                                          .toString())
                                                      .update({
                                                    'seen': sentminseen == 0
                                                        ? seen
                                                        : seen + messbaqy,
                                                    'messages_seen':
                                                        messages_seen +
                                                            messbaqy,
                                                    '${basicstore_name}messagesseen':
                                                        store_messages
                                                  });
                                                  routex(
                                                      busid2,
                                                      username,
                                                      store_name,
                                                      busid,
                                                      cusid,
                                                      basicstore_name,
                                                      basicusername);
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 3), (() {
                                                    setState(() {
                                                      loadingxx = false;
                                                    });
                                                  }));
                                                },
                                                dense: true,
                                                visualDensity:
                                                    VisualDensity.compact,
                                                style: ListTileStyle.list,
                                                selectedColor: Color.fromARGB(
                                                    96, 255, 193, 7),
                                                tileColor:
                                                    Color.fromARGB(7, 0, 0, 0),
                                                trailing: Text(
                                                  '$store_name',
                                                  style: const TextStyle(
                                                      //   fontStyle: FontStyle.italic,
                                                      fontFamily: 'Tajawal',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                leading: loadingxx == true
                                                    ? const Center(
                                                        child:
                                                            LinearProgressIndicator(),
                                                      )
                                                    : Container(
                                                        width: 40,
                                                        child: GestureDetector(
                                                            onTap: () async {
                                                              setState(() {
                                                                loadingxx =
                                                                    true;
                                                              });
                                                              final cusiddoc =
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'listing')
                                                                      .doc(widget
                                                                          .listid
                                                                          .toString())
                                                                      .get();
                                                              final cusid =
                                                                  cusiddoc.data()![
                                                                      'userid'];
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'listing')
                                                                  .doc(widget
                                                                      .listid
                                                                      .toString())
                                                                  .update({
                                                                'seen': sentminseen ==
                                                                        0
                                                                    ? seen
                                                                    : seen +
                                                                        messbaqy,
                                                                'messages_seen':
                                                                    messages_seen +
                                                                        messbaqy,
                                                                '${basicstore_name}messagesseen':
                                                                    store_messages
                                                              });
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (ctx) => ChatScreens(
                                                                      widget
                                                                          .listid,
                                                                      username,
                                                                      store_name,
                                                                      'customer',
                                                                      busid,
                                                                      busid2,
                                                                      cusid,
                                                                      basicstore_name,
                                                                      basicusername)));
                                                              routex(
                                                                  busid2,
                                                                  username,
                                                                  store_name,
                                                                  busid,
                                                                  cusid,
                                                                  basicstore_name,
                                                                  basicusername);
                                                              Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                                  (() {
                                                                setState(() {
                                                                  loadingxx =
                                                                      false;
                                                                });
                                                              }));
                                                            },
//
                                                            child:
                                                                StreamBuilder(
                                                                    stream: FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'listing')
                                                                        .doc(widget
                                                                            .listid
                                                                            .toString())
                                                                        .snapshots(),
                                                                    builder: (ctx,
                                                                        userSnapshot) {
                                                                      if (userSnapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return const Center(
                                                                          child:
                                                                              Text(
                                                                            'Loading...',
                                                                            style:
                                                                                TextStyle(fontSize: 2),
                                                                          ),
                                                                        );
                                                                      }
                                                                      final chatDocs = userSnapshot
                                                                              .hasData
                                                                          ? userSnapshot
                                                                              .data
                                                                          : null;

                                                                      if (userSnapshot
                                                                              .hasData ==
                                                                          true) {
                                                                        final badgo1 =
                                                                            chatDocs!.data()!['${basicstore_name}messages'];
                                                                        final badgo2 =
                                                                            chatDocs.data()!['${basicstore_name}messagesseen'];

                                                                        badgoo =
                                                                            badgo1 -
                                                                                badgo2;
                                                                      }

                                                                      return badgoo !=
                                                                              0
                                                                          ? Badgee(
                                                                              value: badgoo.toString(),
                                                                              color: const Color.fromARGB(176, 244, 67, 54),
                                                                              child: IconButton(
                                                                                icon: const Icon(Icons.messenger_outline),
                                                                                onPressed: () async {
                                                                                  setState(() {
                                                                                    loadingxx = true;
                                                                                  });
                                                                                  await FirebaseFirestore.instance.collection('listing').doc(widget.listid.toString()).update({
                                                                                    'seen': sentminseen == 0 ? seen : seen + messbaqy,
                                                                                    'messages_seen': messages_seen + messbaqy,
                                                                                    '${basicstore_name}messagesseen': store_messages
                                                                                  });
                                                                                  routex(busid2, username, store_name, busid, cusid, basicstore_name, basicusername);
                                                                                  Future.delayed(const Duration(seconds: 3), (() {
                                                                                    setState(() {
                                                                                      loadingxx = false;
                                                                                    });
                                                                                  }));
                                                                                },
                                                                              ),
                                                                            )
                                                                          : IconButton(
                                                                              icon: const Icon(Icons.messenger_outline),
                                                                              onPressed: () async {
                                                                                setState(() {
                                                                                  loadingxx = true;
                                                                                });
                                                                                final targ = await FirebaseFirestore.instance.collection('listing').doc(widget.listid.toString()).get();
                                                                                final userid = targ.data()!['userid'];

                                                                                await FirebaseFirestore.instance.collection('listing').doc(widget.listid.toString()).update({
                                                                                  '${basicstore_name}messagesseen': store_messages
                                                                                });
                                                                                // Navigator.of(context).push(MaterialPageRoute(
                                                                                //     builder: (ctx) => ChatScreens(
                                                                                //         widget
                                                                                //             .listid,
                                                                                //         username,
                                                                                //         store_name,
                                                                                //         'customer',
                                                                                //         busid,
                                                                                //         busid2,
                                                                                //         userid,
                                                                                //         basicstore_name,
                                                                                //         basicusername)));
                                                                                routex(busid2, username, store_name, busid, cusid, basicstore_name, basicusername);
                                                                                Future.delayed(const Duration(seconds: 3), (() {
                                                                                  setState(() {
                                                                                    loadingxx = false;
                                                                                  });
                                                                                }));
                                                                              },
                                                                            );
                                                                    }))),
                                                title: Text(
                                                  '$store_nameprice  EGP',
                                                  style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.amber),
                                                ),
                                              ),
                                              AnimatedTextKit(
                                                animatedTexts: [
                                                  ColorizeAnimatedText(
                                                      '<<<<<<<<<    اسحب الى اليسار لحذف الغرض ',
                                                      //   textAlign: TextAlign.end,
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 226, 219, 157),
                                                        Colors.black12,
                                                        Color.fromARGB(
                                                            255, 226, 219, 157),
                                                      ],
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 11,
                                                      ),
                                                      speed: const Duration(
                                                          milliseconds: 100)),
                                                ],
                                                repeatForever: true,
                                              ),
                                              // const Divider(
                                              //     color: Colors.black87,
                                              //     thickness: 2,
                                              //     indent: 100,
                                              //     endIndent: 100),
                                              SizedBox(
                                                height: 2,
                                              ),
                                            ]))
                                        : area_id == widget.area
                                            ? Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 4,
                                                ),
                                                child: Column(children: [
                                                  ListTile(
                                                    onTap: () async {
                                                      setState(() {
                                                        loadingxx == true;
                                                      });
                                                      final targ =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'listing')
                                                              .doc(widget.listid
                                                                  .toString())
                                                              .get();
                                                      final userid = targ
                                                          .data()!['userid'];

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('listing')
                                                          .doc(widget.listid
                                                              .toString())
                                                          .update({
                                                        '${basicstore_name}messagesseen':
                                                            store_messages
                                                      });
                                                      // Navigator.of(context).push(MaterialPageRoute(
                                                      //     builder: (ctx) => ChatScreens(
                                                      //         widget.listid,
                                                      //         username,
                                                      //         store_name,
                                                      //         'customer',
                                                      //         busid,
                                                      //         busid2,
                                                      //         userid,
                                                      //         basicstore_name,
                                                      //         basicusername)));
                                                      routex(
                                                          busid2,
                                                          username,
                                                          store_name,
                                                          busid,
                                                          cusid,
                                                          basicstore_name,
                                                          basicusername);
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 3), (() {
                                                        setState(() {
                                                          loadingxx = false;
                                                        });
                                                      }));
                                                    },
                                                    dense: true,
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    style: ListTileStyle.list,
                                                    selectedColor:
                                                        Color.fromARGB(
                                                            96, 255, 193, 7),
                                                    tileColor: Color.fromARGB(
                                                        7, 0, 0, 0),
                                                    trailing: Text(
                                                      '$store_name',
                                                      style: const TextStyle(
                                                          //   fontStyle: FontStyle.italic,
                                                          fontFamily: 'Tajawal',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    leading: loadingxx == true
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : Container(
                                                            width: 40,
                                                            child: GestureDetector(
                                                                onTap: () async {
                                                                  final cusiddoc = await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'listing')
                                                                      .doc(widget
                                                                          .listid
                                                                          .toString())
                                                                      .get();
                                                                  final cusid =
                                                                      cusiddoc.data()![
                                                                          'userid'];
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'listing')
                                                                      .doc(widget
                                                                          .listid
                                                                          .toString())
                                                                      .update({
                                                                    'seen': sentminseen ==
                                                                            0
                                                                        ? seen
                                                                        : seen +
                                                                            messbaqy,
                                                                    'messages_seen':
                                                                        messages_seen +
                                                                            messbaqy,
                                                                    '${basicstore_name}messagesseen':
                                                                        store_messages
                                                                  });
                                                                  Navigator.of(context).push(MaterialPageRoute(
                                                                      builder: (ctx) => ChatScreens(
                                                                          widget
                                                                              .listid,
                                                                          username,
                                                                          store_name,
                                                                          'customer',
                                                                          busid,
                                                                          busid2,
                                                                          cusid,
                                                                          basicstore_name,
                                                                          basicusername)));
                                                                  routex(
                                                                      busid2,
                                                                      username,
                                                                      store_name,
                                                                      busid,
                                                                      cusid,
                                                                      basicstore_name,
                                                                      basicusername);
                                                                  Future.delayed(
                                                                      const Duration(
                                                                          seconds:
                                                                              3),
                                                                      (() {
                                                                    setState(
                                                                        () {
                                                                      loadingxx =
                                                                          false;
                                                                    });
                                                                  }));
                                                                },
//
                                                                child: StreamBuilder(
                                                                    stream: FirebaseFirestore.instance.collection('listing').doc(widget.listid.toString()).snapshots(),
                                                                    builder: (ctx, userSnapshot) {
                                                                      if (userSnapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return const Center(
                                                                          child:
                                                                              Text(
                                                                            'Loading...',
                                                                            style:
                                                                                TextStyle(fontSize: 2),
                                                                          ),
                                                                        );
                                                                      }
                                                                      final chatDocs = userSnapshot
                                                                              .hasData
                                                                          ? userSnapshot
                                                                              .data
                                                                          : null;

                                                                      if (userSnapshot
                                                                              .hasData ==
                                                                          true) {
                                                                        final badgo1 =
                                                                            chatDocs!.data()!['${basicstore_name}messages'];
                                                                        final badgo2 =
                                                                            chatDocs.data()!['${basicstore_name}messagesseen'];

                                                                        badgoo =
                                                                            badgo1 -
                                                                                badgo2;
                                                                      }

                                                                      return badgoo !=
                                                                              0
                                                                          ? Badgee(
                                                                              value: badgoo.toString(),
                                                                              color: const Color.fromARGB(176, 244, 67, 54),
                                                                              child: IconButton(
                                                                                icon: const Icon(Icons.messenger_outline),
                                                                                onPressed: () async {
                                                                                  setState(() {
                                                                                    loadingxx == true;
                                                                                  });
                                                                                  await FirebaseFirestore.instance.collection('listing').doc(widget.listid.toString()).update({
                                                                                    'seen': sentminseen == 0 ? seen : seen + messbaqy,
                                                                                    'messages_seen': messages_seen + messbaqy,
                                                                                    '${basicstore_name}messagesseen': store_messages
                                                                                  });
                                                                                  routex(busid2, username, store_name, busid, cusid, basicstore_name, basicusername);
                                                                                  Future.delayed(const Duration(seconds: 3), (() {
                                                                                    setState(() {
                                                                                      loadingxx = false;
                                                                                    });
                                                                                  }));
                                                                                },
                                                                              ),
                                                                            )
                                                                          : IconButton(
                                                                              icon: const Icon(Icons.messenger_outline),
                                                                              onPressed: () async {
                                                                                setState(() {
                                                                                  loadingxx == true;
                                                                                });
                                                                                final targ = await FirebaseFirestore.instance.collection('listing').doc(widget.listid.toString()).get();
                                                                                final userid = targ.data()!['userid'];

                                                                                await FirebaseFirestore.instance.collection('listing').doc(widget.listid.toString()).update({
                                                                                  '${basicstore_name}messagesseen': store_messages
                                                                                });
                                                                                // Navigator.of(context).push(MaterialPageRoute(
                                                                                //     builder: (ctx) => ChatScreens(
                                                                                //         widget.listid,
                                                                                //         username,
                                                                                //         store_name,
                                                                                //         'customer',
                                                                                //         busid,
                                                                                //         busid2,
                                                                                //         userid,
                                                                                //         basicstore_name,
                                                                                //         basicusername)));
                                                                                routex(busid2, username, store_name, busid, cusid, basicstore_name, basicusername);
                                                                                Future.delayed(const Duration(seconds: 3), (() {
                                                                                  setState(() {
                                                                                    loadingxx = false;
                                                                                  });
                                                                                }));
                                                                              },
                                                                            );
                                                                    }))),
                                                    title: Text(
                                                      '$store_nameprice  EGP',
                                                      style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.amber),
                                                    ),
                                                  ),

                                                  AnimatedTextKit(
                                                    animatedTexts: [
                                                      ColorizeAnimatedText(
                                                          '<<<<<<<<<    اسحب الى اليسار لحذف الغرض ',
                                                          //   textAlign: TextAlign.end,
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                226, 219, 157),
                                                            Colors.black12,
                                                            Color.fromARGB(255,
                                                                226, 219, 157),
                                                          ],
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 11,
                                                          ),
                                                          speed: const Duration(
                                                              milliseconds:
                                                                  100)),
                                                    ],
                                                    repeatForever: true,
                                                  ),
                                                  // const Divider(
                                                  //     color: Colors.black87,
                                                  //     thickness: 2,
                                                  //     indent: 100,
                                                  //     endIndent: 100),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                ]))
                                            : const SizedBox());
//        )
                      });
            }));
  }
}
