import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/imagepickerform.dart';
import 'package:flutter_alaqy/user_main.dart';

// import 'fucks.dart';
// import 'user_image_picker.dart';

class alaqyForm extends StatefulWidget {
  const alaqyForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String category,
    String city,
    //  String area,
    String title,
    String description,
    dynamic image,
  ) submitFn;

  @override
  alaqyFormState createState() => alaqyFormState();
}

class alaqyFormState extends State<alaqyForm> {
  bool cityon = false;
  bool caton = false;
  // bool aron = false;

  bool loading = false;
  final storecontroller = TextEditingController();
  final _descriptiontroller = TextEditingController();
  final _titlecontroller = TextEditingController();

  var _userImageFile;
  var _description;

  final _formKey = GlobalKey<FormState>();
  // var _isLogin = true;
  var title = '';
  var description = '';
  var _category = '';
  //var area;
  var _city = '';
  var looking;
//  var _userPassword = '';

  void _pickedImage(dynamic image) {
    _userImageFile = image;
  }

  void routex() async {
    setState(() {
      _titlecontroller.clear();
      _descriptiontroller.clear();
    });

    Future.delayed(const Duration(seconds: 1), (() {
      Navigator.of(context).pop();

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const UserMain('zero')));
    }));
  }

  // @pragma('vm:entry-point')
  // Future<void> _cancelAllNotifications() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }

  void _trySubmit() async {
    setState(() {
      loading = true;
    });
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    final categorydocs =
        await FirebaseFirestore.instance.collection('category').doc('1').get();
    final citydocs =
        await FirebaseFirestore.instance.collection('city').doc('1').get();
    final cityname = citydocs.data()!['name'];
    final categoryname = categorydocs.data()!['name'];
    print(cityname);
    print(categoryname);
    // if (_userImageFile == null && _isLogin) {
    //   setState(() {
    //     loading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Please pick an image.'),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ),
    //   );
    //   return;
    // }
    // if (_city == '') {
    //   setState(() {
    //     loading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Please choose a city.'),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ),
    //   );
    //   return;
    // }
    if (_titlecontroller.text.trim().length < 2) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('أسم المنتج يجب ألا يقل عن  حرفين'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (_descriptiontroller.text.trim().length < 3) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('الوصف يجب ألا يقل عن ٣ حروف'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid == true) {
      _formKey.currentState?.save();
      widget.submitFn(
          _titlecontroller.text.trim(), //   title.toString().trim(),
          _descriptiontroller.text.trim(), // _description.toString().trim(),
          _category.trim() == '' ? categoryname : _category.trim(),
          _city.trim() == '' ? cityname : _city.trim(),
          _userImageFile);
    }

    //  Navigator.of(context).pushReplacementNamed(userChoose.routeName);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('نجاح العملية!'),
        content: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'الطلب جاري',
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.cyanAccent,
                overflow: TextOverflow.visible,
              ),
              speed: const Duration(milliseconds: 100),
            )
          ],
          // totalRepeatCount: 2,
          repeatForever: true,
          onNext: (p0, p1) {
            // setState(() {
            //   _titlecontroller.clear();
            //   _descriptiontroller.clear();
            // });

            Future.delayed(const Duration(seconds: 2), (() {
              Navigator.of(ctx).pop();

              //   Navigator.of(context).pushReplacement(
              //       MaterialPageRoute(builder: (ctx) => const UserMain('zero')));
              //   // setState(() {

              //   //  });
            }));
          },
        ),
//  Text(
//           'Your order is on progress',
//         ),
        // actions: <Widget>[
        //   TextButton(
        //     child: const Text('ok'),
        //     onPressed: () {
        //       Navigator.of(ctx).pop(false);
        //     },
        //   ),
        // ],
      ),
    );
    Future.delayed(const Duration(seconds: 2), (() {
      setState(() {
        loading = false;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const UserMain('zero')));
      _titlecontroller.clear();
      _descriptiontroller.clear();
    }));
  }

  @override
  Widget build(BuildContext context) {
    //  final oppa = Provider.of<Auth>(context, listen: false).userId;

    return Center(
      child: (loading)
          ? const CircularProgressIndicator()
          : Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    UserImagePickerForm(_pickedImage, null, false),
                    SizedBox(
                      height: 9,
                    ),
                    TextFormField(
                      textDirection: TextDirection.rtl,
                      //   keyboardType: TextInputType.multiline,
                      //   maxLines: null,
                      key: const ValueKey('title'),
                      decoration: InputDecoration(
                        label: Center(
                            child: Text(
                          ' إسم المنتج',
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              color: Color.fromARGB(48, 0, 0, 0)),
                        )),
// helperStyle: TextStyle(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        filled:
                            true, //_phoneController.text == '' ? true : false,
                        fillColor: Colors.white,
                        // hintText: "Phone Number"
                      ),
                      enableSuggestions: false,
                      controller: _titlecontroller,
                      validator: (value) {
                        if (value != null) {
                          return (value.isEmpty || value.length < 3)
                              ? 'من فضلك إدخل على الأقل ٣ حروف'
                              : null;
                        }
                        return null;
                      },
                      // decoration: const InputDecoration(labelText: 'title'),
                      onSaved: (value) {
                        if (value != null) {
                          setState(() {
                            title = value;
                          });

                          //   _titlecontroller.clear();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      //  key: const ValueKey('username'),
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
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
                            borderSide:
                                BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        filled:
                            true, //_phoneController.text == '' ? true : false,
                        fillColor: Colors.white,
                        // hintText: "Phone Number"
                      ),
                      enableSuggestions: false,
                      controller: _descriptiontroller,
                      validator: (value) {
                        if (value != null) {
                          return (value.isEmpty) ? 'من فضلك إدخل وصف' : null;
                        }
                        return null;
                      },
                      // decoration:
                      //     const InputDecoration(labelText: 'description'),
                      onSaved: (value) {
                        if (value != null) {
                          setState(() {
                            _description = value;
                          });
                          //    _descriptiontroller.clear();
                        }
                      },
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('city')
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
                        List names = [];
                        List<Widget> nnn = [];
                        List<DropdownMenuItem> mmm = [];
                        for (var x = 0; x < chatDocs!.docs.length; x++) {
                          names.add(chatDocs.docs[x].data()['name']);
                        }
                        for (var r = 0; r < names.length; r++) {
                          nnn.add(Text(names[r]));
                          mmm.add(DropdownMenuItem(
                              value: names[r],
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.location_city_outlined),
                                    const SizedBox(width: 2),
                                    Text(names[r]),
                                  ],
                                ),
                              )));
                        }
                        return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 4,
                              //   horizontal: 1,
                            ),
                            //   width: 120,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey.shade200,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 1,
                              horizontal: 1,
                            ),
                            child: Container(
                                alignment: Alignment.center,
                                //   width: 120,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Colors.white,
                                ),
                                child: DropdownButton(
                                  underline: Text(
                                    _city == ''
                                        ? names.isEmpty
                                            ? ''
                                            : names[0]
                                        : _city,
                                    style: TextStyle(
                                        fontFamily: 'Tajawal',
                                        //     fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  // icon: Text(
                                  //   _city == ''
                                  //       ? names.isEmpty
                                  //           ? ''
                                  //           : names[0]
                                  //       : _city,
                                  //   style: TextStyle(
                                  //       fontFamily: 'Tajawal',
                                  //       //     fontWeight: FontWeight.bold,
                                  //       color: Color.fromARGB(255, 0, 0, 0)),
                                  // ),
                                  onChanged: (value) {
                                    for (var k = 0; k < names.length; k++) {
                                      if (value == names[k]) {
                                        _city = names[k];
                                        setState(() {
                                          cityon = true;
                                        });
                                      }
                                    }
                                  },
                                  selectedItemBuilder: (BuildContext context) {
                                    return nnn;
                                  },
                                  items: mmm,

// [
//                                       DropdownMenuItem(
//                                         value: 'الاسكندرية',
//                                         child: Container(
//                                           child: Row(
//                                             children: const <Widget>[
//                                               Icon(
//                                                   Icons.location_city_outlined),
//                                               SizedBox(width: 2),
//                                               Text('الاسكندرية'),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
                                  onTap: () {},
                                )));
                      },
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('category')
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
                          List names = [];
                          List<Widget> nnn = [];
                          List<DropdownMenuItem> mmm = [];
                          for (var x = 0; x < chatDocs!.docs.length; x++) {
                            names.add(chatDocs.docs[x].data()['name']);
                          }
                          for (var r = 0; r < names.length; r++) {
                            nnn.add(Text(names[r]));
                            mmm.add(DropdownMenuItem(
                                value: names[r],
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      const Icon(Icons.category_outlined),
                                      const SizedBox(width: 2),
                                      Text(names[r]),
                                    ],
                                  ),
                                )));
                          }
                          return Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 4,
                                //   horizontal: 1,
                              ),
                              //   width: 120,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Colors.grey.shade200,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 1,
                                horizontal: 1,
                              ),
                              child: Container(
                                  alignment: Alignment.center,
                                  //   width: 120,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButton(
                                    underline: Text(
                                      _category == ''
                                          ? names.isEmpty
                                              ? ''
                                              : names[0]
                                          : _category,
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          //     fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    onChanged: (value) {
                                      for (var l = 0; l < names.length; l++) {
                                        if (value == names[l]) {
                                          _category = names[l];
                                          setState(() {
                                            caton = true;
                                          });
                                        }
                                      }
                                    },
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return nnn;
                                    },
                                    items: mmm,
                                    onTap: () {},
                                  )));
                        }),

//                     StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                             .collection('city')
//                             .snapshots(),
//                         builder: (ctx, userSnapshot) {
//                           if (userSnapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                               child: Text(
//                                 'Loading...',
//                                 style: TextStyle(fontSize: 2),
//                               ),
//                             );
//                           }
//                           final chatDocs =
//                               userSnapshot.hasData ? userSnapshot.data : null;
//                           List names = [];
//                           List<Widget> nnn = [];
//                           List<DropdownMenuItem> mmm = [];
//                           for (var x = 0; x < chatDocs!.docs.length; x++) {
//                             names.add(chatDocs.docs[x].data()['name']);
//                           }
//                           for (var r = 0; r < names.length; r++) {
//                             nnn.add(Text(names[r]));
//                             mmm.add(DropdownMenuItem(
//                                 value: names[r],
//                                 child: Container(
//                                   child: Row(
//                                     children: <Widget>[
//                                       const Icon(Icons.location_city_outlined),
//                                       const SizedBox(width: 2),
//                                       Text(names[r]),
//                                     ],
//                                   ),
//                                 )));
//                           }
//                           return ListTile(
//                               leading: Text(
//                                 _city == '' ? names[0] : _city,
//                                 style: TextStyle(
//                                     color: cityon == false
//                                         ? Colors.grey
//                                         : Colors.deepPurple),
//                               ),
//                               title: DropdownButton(
//                                 underline: Text(
//                                   'city',
//                                   style: TextStyle(
//                                       color: cityon == false
//                                           ? Colors.grey
//                                           : Colors.amberAccent),
//                                 ),
//                                 icon: Icon(Icons.location_city_outlined,
//                                     color: cityon == false
//                                         ? Colors.grey
//                                         : Colors.deepPurple),
//                                 onChanged: (value) {
//                                   for (var r = 0; r < names.length; r++) {
//                                     if (value == names[r]) {
//                                       _city = names[r];
//                                       setState(() {
//                                         cityon = true;
//                                       });
//                                     }
//                                   }
//                                 },
//                                 selectedItemBuilder: (BuildContext context) {
//                                   return nnn;
//                                 },
//                                 items: mmm,

// // [
// //                                       DropdownMenuItem(
// //                                         value: 'الاسكندرية',
// //                                         child: Container(
// //                                           child: Row(
// //                                             children: const <Widget>[
// //                                               Icon(
// //                                                   Icons.location_city_outlined),
// //                                               SizedBox(width: 2),
// //                                               Text('الاسكندرية'),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
//                                 onTap: () {},
//                               ));
//                         }),
//                     StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                             .collection('category')
//                             .snapshots(),
//                         builder: (ctx, userSnapshot) {
//                           if (userSnapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                               child: Text(
//                                 'Loading...',
//                                 style: TextStyle(fontSize: 2),
//                               ),
//                             );
//                           }
//                           final chatDocs =
//                               userSnapshot.hasData ? userSnapshot.data : null;
//                           List names = [];
//                           List<Widget> nnn = [];
//                           List<DropdownMenuItem> mmm = [];
//                           for (var x = 0; x < chatDocs!.docs.length; x++) {
//                             names.add(chatDocs.docs[x].data()['name']);
//                           }
//                           for (var r = 0; r < names.length; r++) {
//                             nnn.add(Text(names[r]));
//                             mmm.add(DropdownMenuItem(
//                                 value: names[r],
//                                 child: Container(
//                                   child: Row(
//                                     children: <Widget>[
//                                       const Icon(Icons.category_outlined),
//                                       const SizedBox(width: 2),
//                                       Text(names[r]),
//                                     ],
//                                   ),
//                                 )));
//                           }
//                           return ListTile(
//                             leading: Text(
//                               _category == '' ? names[0] : _category,
//                               style: TextStyle(
//                                   color: caton == false
//                                       ? Colors.grey
//                                       : Colors.deepPurple),
//                             ),
//                             trailing: DropdownButton(
//                               underline: Text(
//                                 'category',
//                                 style: TextStyle(
//                                     color: caton == false
//                                         ? Colors.grey
//                                         : Colors.tealAccent),
//                               ),
//                               icon: Icon(Icons.category_outlined,
//                                   color: caton == false
//                                       ? Colors.grey
//                                       : Colors.deepPurple),
//                               onChanged: (value) {
//                                 for (var r = 0; r < names.length; r++) {
//                                   if (value == names[r]) {
//                                     _category = names[r];
//                                     setState(() {
//                                       caton = true;
//                                     });
//                                   }
//                                 }
//                               },
//                               selectedItemBuilder: (BuildContext context) {
//                                 return nnn;
//                               },
//                               items: mmm,

//                               //   items: [
//                               //     DropdownMenuItem(
//                               //       value: 'ادوات المطبخ',
//                               //       child: Container(
//                               //         child: Row(
//                               //           children: const <Widget>[
//                               //             Icon(Icons.category_outlined),
//                               //             Text('ادوات المطبخ'),
//                               //           ],
//                               //         ),
//                               //       ),
//                               //     ),
//                               //   ],
//                               //   onChanged: (value) {
//                               //     if (value == 'ادوات المطبخ') {
//                               //       _category = 'ادوات المطبخ';
//                               //       setState(() {
//                               //         caton = !caton;
//                               //       });
//                               //     }
//                               //   },
//                             ),
//                             onTap: () {},
//                           );
//                         }),
                    // StreamBuilder(
                    //     stream: FirebaseFirestore.instance
                    //         .collection('area')
                    //         .snapshots(),
                    //     builder: (ctx, userSnapshot) {
                    //       if (userSnapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return const Center(
                    //           child: Text(
                    //             'Loading...',
                    //             style: TextStyle(fontSize: 2),
                    //           ),
                    //         );
                    //       }
                    //       final chatDocs = userSnapshot.hasData
                    //           ? userSnapshot.data
                    //           : null;
                    //       List names = [];
                    //       List<Widget> nnn = [];
                    //       List<DropdownMenuItem> mmm = [];
                    //       for (var x = 0; x < chatDocs!.docs.length; x++) {
                    //         names.add(chatDocs.docs[x].data()['name']);
                    //       }
                    //       for (var r = 0; r < names.length; r++) {
                    //         nnn.add(Text(names[r]));
                    //         mmm.add(DropdownMenuItem(
                    //             value: names[r],
                    //             child: Container(
                    //               child: Row(
                    //                 children: <Widget>[
                    //                   const Icon(Icons.location_on),
                    //                   const SizedBox(width: 2),
                    //                   Text(names[r]),
                    //                 ],
                    //               ),
                    //             )));
                    //       }
                    //       return ListTile(
                    //         leading: Text(
                    //           area ?? '',
                    //           style: TextStyle(
                    //               color: aron == false
                    //                   ? Colors.grey
                    //                   : Colors.deepPurple),
                    //         ),
                    //         trailing: DropdownButton(
                    //           underline: Text(
                    //             'area',
                    //             style: TextStyle(
                    //                 color: aron == false
                    //                     ? Colors.grey
                    //                     : Colors.blueGrey),
                    //           ),
                    //           icon: Icon(Icons.location_on,
                    //               color: aron == false
                    //                   ? Colors.grey
                    //                   : Colors.deepPurple),
                    //           onChanged: (value) {
                    //             for (var r = 0; r < names.length; r++) {
                    //               if (value == names[r]) {
                    //                 area = names[r];
                    //                 setState(() {
                    //                   aron = !aron;
                    //                 });
                    //               }
                    //             }
                    //           },
                    //           selectedItemBuilder: (BuildContext context) {
                    //             return nnn;
                    //           },
                    //           items: mmm,
                    //           // items: [
                    //           //   DropdownMenuItem(
                    //           //     value: 'زيزينيا', //  from data base
                    //           //     child: Container(
                    //           //       child: Row(
                    //           //         children: const <Widget>[
                    //           //           Icon(Icons.location_on),
                    //           //           SizedBox(width: 2),
                    //           //           Text('زيزينيا'),
                    //           //         ],
                    //           //       ),
                    //           //     ),
                    //           //   ),
                    //           // ],
                    //           // onChanged: (value) {
                    //           //   if (value == 'زيزينيا') {
                    //           //     setState(() {
                    //           //       area = 'زيزينيا';

                    //           //       aron = !aron;
                    //           //     });
                    //           //   }
                    //           // },
                    //         ),
                    //         onTap: () {
                    //           setState(() {
                    //             //   area = 'زيزينيا';

                    //             aron = !aron;
                    //           });
                    //         },
                    //       );
                    //     }),
                    const SizedBox(height: 17),
                    (loading) ? const CircularProgressIndicator() : SizedBox(),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Color.fromARGB(255, 253, 202, 0))),
                        onPressed: () async {
                          setState(() {
                            loading == true;
                            //     oldo = true;
                          });
                          final lisdoc = await FirebaseFirestore.instance
                              .collection('customer_details')
                              .where('second_uid',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .get();
                          final busid = lisdoc.docs.last.id;
                          final bancheck = await FirebaseFirestore.instance
                              .collection('ban')
                              .where('user', isEqualTo: busid)
                              .get();
                          if (bancheck.docs.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  ' لقد تم حظرك من إستخدام هذه الخاصية . يرجى مراجعة المسئولين',
                                ),
                                backgroundColor: Theme.of(context).errorColor,
                              ),
                            );
                          } else
                            _trySubmit();
                          //    }));
                          Future.delayed(const Duration(seconds: 6), (() {
                            setState(() {
                              loading = false;
                            });
                          }));
                          // Future.delayed(const Duration(seconds: 8), (() {
                          //   setState(() async {
                          //     await _cancelAllNotifications();
                          //   });
                          // }));
                        },
                        child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'حفظ البيانات',
                                style: TextStyle(
                                    fontFamily: 'Tajawal', color: Colors.black),
                                //  style: TextStyle(color: Colors.black),
                              ),
                            ))),
                    //  ElevatedButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         loading = true;
                    //       });
                    //       _trySubmit();
                    //     },
                    //     child: const Text('submit'),
                    //   ),
                    // (loading)
                    //     ? const CircularProgressIndicator()
                    //     : const SizedBox(),
                  ],
                ),
              ),
            ),
    );
  }
}
