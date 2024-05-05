import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/businesskoshk.dart';

import 'app_drawer22.dart';
import 'badge.dart';
import 'business_main.dart';
import 'profilepic.dart';

class Updatebranch extends StatefulWidget {
  static const routeName = '/Updatebranch';
  final String id;

  const Updatebranch(this.id, {super.key});
  @override
  UpdatebranchState createState() => UpdatebranchState();
}

class UpdatebranchState extends State<Updatebranch> {
  final _controller = new TextEditingController();
  final _controllername = new TextEditingController();
  final userid = FirebaseAuth.instance.currentUser!.uid;
  var urlx;
  var urlxx;

  var _enteredMessage = '';
  var _enteredMessagename = '';
  var _userImageFile;
  bool loading = false;
  void _pickedImage(dynamic image) async {
    setState(() {
      loading = true;
    });
    _userImageFile = image;
// void _submitAuthForm(
    //   File image,
//  ) async {
    final url;
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('update${DateTime.now()}.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
      // final userdoc = await FirebaseFirestore.instance
      //     .collection('koshk')
      //     .doc(userid)
      //     .get();
      // final docid = userdoc.id;
      // await FirebaseFirestore.instance.collection('branches').doc(docid).set({
      //   'image_url': url,
      // });

      // _controller.text = url;
    } else {
      url = '';
    }
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    setState(() {
      urlx = url;
    });
    print(urlx);
    setState(() {
      loading = false;
    });
    // }
    //  Navigator.of(context).pushReplacementNamed(EditBranch.routeName);
  }

  void _sendMessage() async {
    final userdoc =
        await FirebaseFirestore.instance.collection('koshk').doc(userid).get();
    final docid = userdoc.id;
    final store_name = userdoc.data()!['store_name'];
    final busid = userdoc.data()!['busid'];

    FirebaseFirestore.instance.collection('branches').doc(widget.id).update({
      //   'username': store_name,
      //    'basic_branch_name': _enteredMessagename.trim(),
      'branch_name': _controllername.text.trim(),
      'image_url': urlx == null ? 'asset' : urlx,
      // 'busid': busid
    });
    final userdocc = await FirebaseFirestore.instance
        .collection('products')
        .where('braid', isEqualTo: widget.id)
        .get();
    for (var r = 0; r < userdocc.docs.length; r++) {
      FirebaseFirestore.instance
          .collection('products')
          .doc(userdocc.docs[r].id)
          .update({
        'branch_name': _controllername.text.trim(),
      });
    }
    FocusScope.of(context).unfocus();
    _controllername.clear();

    Navigator.of(context).pushReplacementNamed(BusinessKoshk.routeName);
  }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');

  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.create(recursive: true);
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  //   return file;
  // }

  @override
  Widget build(BuildContext context) {
    dynamic badgoo;
    dynamic bag = 0;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 252, 250, 250),
            foregroundColor: Colors.black,
            centerTitle: true,
            toolbarHeight: 80,
            title: Text(
              ' بيانات القسم',
              style: const TextStyle(
                fontFamily: 'Tajawal',
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.popAndPushNamed(
                      context, BusinessKoshk.routeName),
                  icon: const Icon(Icons.home)),
            ]),
        drawer: AppDrawer22(),
        body: SingleChildScrollView(
            child: SizedBox(
                child: Column(children: [
          urlx != null
              ? profilepic(_pickedImage, urlx, false)
              : profilepic(_pickedImage, urlxx, false),
          Container(
              width: 250,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              child: Expanded(
                child: TextFormField(
                  //   readOnly: updated == true ? true : false,
                  textAlign: TextAlign.center,

                  decoration: InputDecoration(
                    label: Center(
                        child: Text(
                      ' اسم القسم',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color.fromARGB(48, 0, 0, 0)),
                    )),
// helperStyle: TextStyle(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey.shade200)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    filled: true, //_phoneController.text == '' ? true : false,
                    fillColor: Colors.white,
                    // hintText: "Phone Number"
                  ),
                  controller: _controllername,
                  validator: (value) {
                    if (value != null) {
                      return (value.isEmpty) ? 'برجاء ادخال اسم مناسب' : null;
                    }
                    if (value != null) {
                      return (value.isEmpty || value.length < 4)
                          ? 'ليس اقل من ٤ حروف'
                          : null;
                    }
                  },
                  // decoration: const InputDecoration(
                  //     labelText: 'update user name'),
                  onChanged: (value) {
                    setState(() {
                      _enteredMessagename = value;
                    });
                  },
                ),
              )),
          loading == true
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Center(
                        child: TextButton(
                            child: Container(
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
                                child: Text(
                                  'موافق',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber.shade500,
                                  ),
                                )),
                            onPressed: () {
                              _controllername.text.trim().isEmpty ||
                                      _controllername.text.trim().length < 3
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: const Text(
                                            'لا بد ان يحتوي الاسم على ثلاث حروف على الاقل'),
                                        backgroundColor:
                                            Theme.of(context).errorColor,
                                      ),
                                    )
                                  : showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('تمت العملية بنجاح'),
                                        content:
                                            const CircularProgressIndicator(),
                                        actions: <Widget>[
                                          TextButton(
                                            child: AnimatedTextKit(
                                              animatedTexts: [
                                                TyperAnimatedText(
                                                  '',
                                                  textStyle: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.cyanAccent,
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                  speed: const Duration(
                                                      seconds: 3),
                                                )
                                              ],
                                              totalRepeatCount: 2,
                                              // repeatForever: true,
                                              onNext: (p1, p2) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            Updatebranch(
                                                                widget.id)));
                                                Navigator.of(ctx).pop(false);
                                              },
                                            ),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    );
                              _controllername.text.trim().isEmpty ||
                                      _controllername.text.trim().length < 3
                                  ? null
                                  : _sendMessage();
                            }))
                  ],
                ),
          SizedBox(
            height: 20,
          ),
          AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  '',
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.cyanAccent,
                    overflow: TextOverflow.visible,
                  ),
                  speed: const Duration(milliseconds: 100),
                )
              ],
              totalRepeatCount: 2,
              onNext: (p0, p1) async {
                final name = await FirebaseFirestore.instance
                    .collection('branches')
                    .doc(widget.id)
                    .get();
                setState(() {
                  _controllername.text = name.data()!['branch_name'];
                  urlxx = name.data()!['image_url'];
                });
              }),
        ]))),
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
