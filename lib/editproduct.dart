import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/businesskoshk.dart';

import 'ImagePicker.dart';
import 'app_drawer22.dart';
import 'badge.dart';
import 'branchdetails.dart';
import 'business_main.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/EditProduct';
  final String id;

  const EditProduct(this.id, {super.key});
  @override
  EditProductState createState() => EditProductState();
}

class EditProductState extends State<EditProduct> {
  final _controller = new TextEditingController();
  final _controllername = new TextEditingController();
  final _controllerdescription = new TextEditingController();
  final _controllerprice = new TextEditingController();

  final userid = FirebaseAuth.instance.currentUser!.uid;
  var urlx;
  var urlx2;
  var urlx3;
  var urlx4;
  var urlx5;

  var _enteredMessage = '';
  var _enteredMessagename = '';
  var _enteredMessagename2 = '';
  var _enteredMessagename3 = '';

  var _userImageFile;
  var _userImageFile2;
  var _userImageFile3;
  var _userImageFile4;
  var _userImageFile5;
  void _pickedImage2(dynamic image) async {
    _userImageFile2 = image;
    final url;
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('update${DateTime.now()}.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    setState(() {
      urlx2 = url;
    });
  }

  void _pickedImage3(dynamic image) async {
    _userImageFile3 = image;
    final url;
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('update${DateTime.now()}.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    setState(() {
      urlx3 = url;
    });
  }

  void _pickedImage4(dynamic image) async {
    _userImageFile4 = image;
    final url;
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('update${DateTime.now()}.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    setState(() {
      urlx4 = url;
    });
  }

  void _pickedImage5(dynamic image) async {
    _userImageFile5 = image;
    final url;
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('update${DateTime.now()}.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    setState(() {
      urlx5 = url;
    });
  }

  void _pickedImage(dynamic image) async {
    _userImageFile = image;
    final url;
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('update${DateTime.now()}.jpg');
      await ref.putFile(image).whenComplete(() => image);

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    setState(() {
      urlx = url;
    });
  }

  void _sendMessage() async {
    print('zzzzzzzz');
    final userdoc = await FirebaseFirestore.instance
        .collection('branches')
        .doc(widget.id)
        .get();
    final docid = userdoc.id;
    final store_name = userdoc.data()!['username'];
    final branch_name = userdoc.data()!['branch_name'];

    final busid = userdoc.data()!['busid'];
    print('xxxxxxxxx');

    FirebaseFirestore.instance.collection('products').add({
      'storename': store_name,
      'basic_productname_name': _enteredMessagename.trim(),
      'product_name': _enteredMessagename.trim(),
      'product_price': _controllerprice.text.trim(),
      'product_description': _controllerdescription.text.trim(),
      'branch_name': branch_name,
      'braid': docid,
      'image_url': urlx == null ? 'asset' : urlx,
      'image_url2': urlx2 == null ? 'asset' : urlx2,
      'image_url3': urlx3 == null ? 'asset' : urlx3,
      'image_url4': urlx4 == null ? 'asset' : urlx4,
      'image_url5': urlx5 == null ? 'asset' : urlx5,
      'busid': busid,
      'createdAt': Timestamp.now(),
    });
    // final userdocc = await FirebaseFirestore.instance
    //     .collection('business_details')
    //     .where('second_uid', isEqualTo: userid)
    //     .get();

    FocusScope.of(context).unfocus();
    _controllername.clear();
    _controllerdescription.clear();
    _controllerprice.clear();

    // Navigator.of(context).pushReplacementNamed(BusinessKoshk.routeName);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => branchdetails(widget.id, false)));
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
              ' بيانات المنتج',
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
          UserImagePicker(_pickedImage),
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
                      ' اسم المنتج',
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
                      ' وصف المنتج',
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
                  controller: _controllerdescription,
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
                      _enteredMessagename2 = value;
                    });
                  },
                ),
              )),
          Container(
              width: 250,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              child: Expanded(
                child: TextFormField(
                  //   readOnly: updated == true ? true : false,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('EGP',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: 'Tajawal',
                                  color: Color.fromARGB(48, 0, 0, 0))),
                          Text('السعر',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Tajawal',
                                  color: Color.fromARGB(48, 0, 0, 0))),
                        ]),
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
                  controller: _controllerprice,
                  validator: (value) {
                    if (value != null) {
                      return (value.isEmpty) ? 'برجاء ادخال اسم مناسب' : null;
                    }
                  },
                  // decoration: const InputDecoration(
                  //     labelText: 'update user name'),
                  onChanged: (value) {
                    setState(() {
                      _enteredMessagename3 = value;
                    });
                  },
                ),
              )),
          urlx != null ? Center(child: Text('2')) : SizedBox(),
          urlx != null ? UserImagePicker(_pickedImage2) : SizedBox(),
          urlx != null ? Center(child: Text('3')) : SizedBox(),
          urlx != null ? UserImagePicker(_pickedImage3) : SizedBox(),
          urlx != null ? Center(child: Text('4')) : SizedBox(),
          urlx != null ? UserImagePicker(_pickedImage4) : SizedBox(),
          urlx != null ? Center(child: Text('5')) : SizedBox(),
          urlx != null ? UserImagePicker(_pickedImage5) : SizedBox(),
          Stack(
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
                        _enteredMessagename.trim().isEmpty ||
                                _enteredMessagename.trim().length < 3 ||
                                _enteredMessagename2.trim().isEmpty ||
                                _enteredMessagename2.trim().length < 3
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 4),
                                  content: const Text(
                                      'لا بد من ادخال اسم و وصف  يحتوي على ثلاث حروف على الاقل'),
                                  backgroundColor: Theme.of(context).errorColor,
                                ),
                              )
                            : _enteredMessagename3.trim().isEmpty
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: const Text(
                                          'لا بد من ادخال سعر للمنتج'),
                                      backgroundColor:
                                          Theme.of(context).errorColor,
                                    ),
                                  )
                                : urlx == null
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: const Text(
                                              'لا بد من ادخال  صورة واحدة على الاقل للمنتج'),
                                          backgroundColor:
                                              Theme.of(context).errorColor,
                                        ),
                                      )
                                    : showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title:
                                              const Text('تمت العملية بنجاح'),
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
                                                  // Navigator.of(context)
                                                  //     .pushReplacementNamed(
                                                  //         EditProduct
                                                  //             .routeName);
                                                  Navigator.of(ctx).pop(false);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              branchdetails(
                                                                  widget.id,
                                                                  false)));
                                                },
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      );
                        _enteredMessagename.trim().isEmpty ||
                                _enteredMessagename.trim().length < 3 ||
                                _enteredMessagename2.trim().isEmpty ||
                                _enteredMessagename2.trim().length < 3 ||
                                _enteredMessagename3.trim().isEmpty ||
                                urlx == null
                            ? null
                            : _sendMessage();
                      }))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          AnimatedTextKit(animatedTexts: [
            TyperAnimatedText(
              '',
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.cyanAccent,
                overflow: TextOverflow.visible,
              ),
              speed: const Duration(milliseconds: 100),
            )
          ], totalRepeatCount: 1, onNext: (p0, p1) async {}),
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