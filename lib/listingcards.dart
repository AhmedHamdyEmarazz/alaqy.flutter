import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'SPLASHSCREEN.dart';
import 'listingcardsitem.dart';

class ListingCards extends StatefulWidget {
  static const routeName = '/listingCards';

  const ListingCards({super.key});

  @override
  State<ListingCards> createState() => ListingCardsState();
}

class ListingCardsState extends State<ListingCards> {
//   Future<void> makePostRequest(String? token, String? userId) async {
//     String url = 'https://alaqybackend.onrender.com/api/user/get-requests';

//     Map<String, String> headers = {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer $token',
//     };

//     Map<String, dynamic> jsonBody = {
//       'userId': userId,
//     };

//     http.Response response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: json.encode(jsonBody),
//     );
//     print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
//     print(response.body);
//   }

  // void funcx() async {
  //   String? token = await getToken();
  //   String? userId = await getUserId();
  //   Future.delayed(const Duration(seconds: 5), (() {
  //     makePostRequest(token!, userId!);
  //   }));
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  funcx();
    final userid = FirebaseAuth.instance.currentUser!.uid;

    final fbm = FirebaseMessaging.instance;
    fbm.getToken();
    fbm.onTokenRefresh;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('customer_details')
            .where('second_uid', isEqualTo: userid)
            .snapshots(),
        builder: (ctx, chatSnapshott) {
          final chatDocss =
              chatSnapshott.hasData ? chatSnapshott.data!.docs : null;
//final tryx = chatDocss!.first.id;
          return chatSnapshott.hasData == false
              ? Center(child: SizedBox(height: 700, child: SplashScreen()))
// const Center(
//                         child: CircularProgressIndicator(),
//                       );
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('listing')
                      .where('userid', isEqualTo: chatDocss!.first.id)
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (ctx, chatSnapshottt) {
                    // if (chatSnapshottt.connectionState == ConnectionState.waiting) {
                    //   return const Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                    final chatDocs = chatSnapshottt.hasData
                        ? chatSnapshottt.data!.docs
                        : null;
                    return chatSnapshottt.hasData == false
                        ? Center(
                            child: SizedBox(height: 700, child: SplashScreen()))
// const Center(
//                         child: CircularProgressIndicator(),
//                       );
                        : ListView.builder(
                            //  reverse: true,
                            itemCount: chatDocs!.length,
                            itemBuilder: (ctx, index) => Column(children: [
                                  SizedBox(
                                    //  height: 160,
                                    width: double.infinity,
                                    child: //(chatDocs[index]['closed'] == true)
//  &&
                                        (chatDocs[index]['total close'] == true)
                                            ? const SizedBox()
                                            // : chatDocs[index]['closed'] == true
                                            //     ? Dismissible(
                                            //         key:
                                            //             ValueKey(chatDocs[index]['idstring']),
                                            //         background: Container(
                                            //           color: Theme.of(context).errorColor,
                                            //           alignment: Alignment.centerRight,
                                            //           padding:
                                            //               const EdgeInsets.only(right: 20),
                                            //           margin: const EdgeInsets.symmetric(
                                            //             horizontal: 15,
                                            //             vertical: 4,
                                            //           ),
                                            //           child: const Icon(
                                            //             Icons.delete,
                                            //             color: Colors.white,
                                            //             size: 40,
                                            //           ),
                                            //         ),
                                            //         direction: DismissDirection.endToStart,
                                            //         confirmDismiss: (direction) {
                                            //           return showDialog(
                                            //             context: context,
                                            //             builder: (ctx) => AlertDialog(
                                            //               title: const Text('Are you sure?'),
                                            //               content: const Text(
                                            //                 'Do you want to remove this order?',
                                            //               ),
                                            //               actions: <Widget>[
                                            //                 TextButton(
                                            //                   child: const Text('No'),
                                            //                   onPressed: () {
                                            //                     Navigator.of(ctx).pop(false);
                                            //                   },
                                            //                 ),
                                            //                 TextButton(
                                            //                   child: const Text('Yes'),
                                            //                   onPressed: () {
                                            //                     FirebaseFirestore.instance
                                            //                         .collection('listing')
                                            //                         .doc(chatDocs[index]
                                            //                             ['idstring'])
                                            //                         .update({
                                            //                       'total close': true
                                            //                     });
                                            //                     Navigator.of(ctx).pop(true);
                                            //                   },
                                            //                 ),
                                            //               ],
                                            //             ),
                                            //           );
                                            //         },
                                            //         onDismissed: (direction) {
                                            //           //Provider.of<Cart>(context, listen: false).removeItem(productId);
                                            //         },
                                            //         child: SizedBox(
                                            //             height: 50,
                                            //             width: double.infinity,
                                            //             child: Column(children: [
                                            //               Center(
                                            //                   child: Text(
                                            //                       'date:${DateFormat('dd/MM/yyyy hh:mm').format((chatDocs[index]['createdAt']).toDate())}',
                                            //                       style: const TextStyle(
                                            //                           fontStyle:
                                            //                               FontStyle.italic,
                                            //                           color: Colors.grey))),
                                            //               const Text('closed',
                                            //                   style: TextStyle(
                                            //                       fontStyle: FontStyle.italic,
                                            //                       color: Colors.red)),
                                            //             ])))
                                            : ListingCardsItem(
                                                chatDocs[index]['idstring'],
                                                chatDocs[index]['createdAt'],
                                                chatDocs[index]['title'],
                                                chatDocs[index]['image_url'],
                                                chatDocs[index]['description'],
                                                chatDocs[index]['total close'],
                                                chatDocs[index]['closed'],
                                                chatDocs[index]['messages'],
                                              ),
                                  ),
                                  // chatDocs[index]['closed'] == true
                                  //     ? const SizedBox()
                                  //     : const Divider(thickness: 3, color: Colors.black)
                                ]));
                  });
        });
  }
}
