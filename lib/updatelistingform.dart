import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/imagepickerform.dart';
import 'package:flutter_alaqy/user_main.dart';

// import 'fucks.dart';
// import 'user_image_picker.dart';

class updatelistingform extends StatefulWidget {
  const updatelistingform(
      this.submitFn,
      this.isLoading,
      this.image,
      this.title,
      this.description,
      this.city, //this.area,
      this.category,
      this.updated);
  final bool isLoading;
  final dynamic image;
  final String title;
  final String description;
  final String city;
  // final String area;
  final String category;
  final bool updated;
  final void Function(
    String category,
    String city,
    //  String area,
    String title,
    String description,
    dynamic image,
  ) submitFn;

  @override
  updatelistingformState createState() => updatelistingformState();
}

class updatelistingformState extends State<updatelistingform> {
  bool cityon = false;
  bool caton = false;
  //bool aron = false;

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
  var _category;
  // var area;
  var _city;
  var looking;
//  var _userPassword = '';

  void _pickedImage(dynamic image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    setState(() {
      loading = true;
    });
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

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
    // if (_category == '') {
    //   setState(() {
    //     loading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Please choose a category.'),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ),
    //   );
    //   return;
    // }
    // final areaz = area ?? widget.area;
    final citzz = _city ?? widget.city;
    final catzz = _category ?? widget.category;

    if (isValid == true) {
      // if (area == null) {
      //   _formKey.currentState?.save();
      //   widget.submitFn(title.toString().trim(), _description.toString().trim(),
      //       _category.trim(), _city.trim(), widget.area, _userImageFile);
      // }
      // if (_city == null) {
      //   _formKey.currentState?.save();
      //   widget.submitFn(title.toString().trim(), _description.toString().trim(),
      //       _category.trim(), widget.city, area, _userImageFile);
      // }
      // if (_category == null) {
      //   _formKey.currentState?.save();
      //   widget.submitFn(title.toString().trim(), _description.toString().trim(),
      //       widget.category, _city.trim(), area, _userImageFile);
      // } else {
      _formKey.currentState?.save();
      widget.submitFn(
          title.toString().trim(),
          _description.toString().trim(),
          catzz,
          citzz, // areaz,
          _userImageFile);
      // }
    }

    //  Navigator.of(context).pushReplacementNamed(userChoose.routeName);

    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: const Text('in progress!'),
                content: const CircularProgressIndicator(),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {},
                      child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              '',
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.cyanAccent,
                                overflow: TextOverflow.visible,
                              ),
                              speed: const Duration(milliseconds: 200),
                            )
                          ],
                          totalRepeatCount: 2,
                          // repeatForever: true,
                          onNext: (p0, p1) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const UserMain('zero')));
                          }))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    //  final oppa = Provider.of<Auth>(context, listen: false).userId;
    print(widget.title);
    print(widget.description);

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
                    Center(
                      child: widget.updated
                          ? const Text(
                              'تم التعديل من قبل',
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                              ),
                            )
                          : const Text(
                              'التعديل!',
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    TextFormField(
                      key: const ValueKey('title'),
                      textAlign: TextAlign.center,
                      readOnly: widget.updated,
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: widget.updated
                              ? Color.fromARGB(48, 0, 0, 0)
                              : Colors.black),
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
                              ? 'من فضلك ادخل على الاقل ٣ حروف'
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
                      height: 14,
                    ),
                    widget.updated
                        ? Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.only(
                              top: 8,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: FittedBox(
                                child: Image.network(
                              widget.image,
                              // fit: BoxFit.fill,
                            )),
                          )
                        : UserImagePickerForm(
                            _pickedImage, widget.image, widget.updated),
                    TextFormField(
                      //  key: const ValueKey('username'),
                      textAlign: TextAlign.center,
                      readOnly: widget.updated,
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: widget.updated
                              ? Color.fromARGB(48, 0, 0, 0)
                              : Colors.black),
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
                          return (value.isEmpty) ? 'من فضلك ادخل وصف' : null;
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
                    // TextFormField(
                    //   //  key: const ValueKey('username'),
                    //   //     initialValue: widget.description,
                    //   readOnly: widget.updated,
                    //   enableSuggestions: false,
                    //   controller: _descriptiontroller,
                    //   validator: (value) {
                    //     if (value != null) {
                    //       return (value.isEmpty)
                    //           ? 'Please enter a value'
                    //           : null;
                    //     }
                    //   },
                    //   decoration:
                    //       const InputDecoration(labelText: 'description'),
                    //   onSaved: (value) {
                    //     if (value != null) {
                    //       _description = value;
                    //     }
                    //   },
                    // ),
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
                                    _city ?? widget.city ?? names[0],
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

// ListTile(
//                                 leading: Text(
//                                   _city ?? widget.city ?? names[0],
//                                   style: TextStyle(
//                                       color: cityon == false
//                                           ? Colors.grey
//                                           : Colors.deepPurple),
//                                 ),
//                                 title: DropdownButton(
//                                   underline: Text(
//                                     'city',
//                                     style: TextStyle(
//                                         color: cityon == false
//                                             ? Colors.grey
//                                             : Colors.amberAccent),
//                                   ),
//                                   icon: Icon(Icons.location_city_outlined,
//                                       color: cityon == false
//                                           ? Colors.grey
//                                           : Colors.deepPurple),
//                                   onChanged: (value) {
//                                     if (!widget.updated) {
//                                       for (var r = 0; r < names.length; r++) {
//                                         if (value == names[r]) {
//                                           _city = names[r];
//                                           setState(() {
//                                             cityon = true;
//                                           });
//                                         } else {
//                                           null;
//                                         }
//                                       }
//                                     }
//                                   },
//                                   selectedItemBuilder: (BuildContext context) {
//                                     return nnn;
//                                   },
//                                   items: mmm,

//                                   // items: [
//                                   //   DropdownMenuItem(
//                                   //     value: 'الاسكندرية',
//                                   //     child: Container(
//                                   //       child: Row(
//                                   //         children: const <Widget>[
//                                   //           Icon(Icons.location_city_outlined),
//                                   //           SizedBox(width: 2),
//                                   //           Text('الاسكندرية'),
//                                   //         ],
//                                   //       ),
//                                   //     ),
//                                   //   ),
//                                   // ],
//                                   // onChanged: (value) {
//                                   //   if (value == 'الاسكندرية') {
//                                   //     _city = "الاسكندرية";
//                                   //     setState(() {
//                                   //       cityon = !cityon;
//                                   //     });
//                                   //   }
//                                   // },
//                                 ),
//                                 onTap: () {},
//                               );
//                             }),
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
                                      _category ?? widget.category ?? names[0],
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

// ListTile(
//                                 leading: Text(
//                                   _category ?? widget.category ?? names[0],
//                                   style: TextStyle(
//                                       color: caton == false
//                                           ? Colors.grey
//                                           : Colors.deepPurple),
//                                 ),
//                                 trailing: DropdownButton(
//                                   underline: Text(
//                                     'category',
//                                     style: TextStyle(
//                                         color: caton == false
//                                             ? Colors.grey
//                                             : Colors.tealAccent),
//                                   ),
//                                   icon: Icon(Icons.category_outlined,
//                                       color: caton == false
//                                           ? Colors.grey
//                                           : Colors.deepPurple),
//                                   onChanged: (value) {
//                                     if (!widget.updated) {
//                                       for (var r = 0; r < names.length; r++) {
//                                         if (value == names[r]) {
//                                           _category = names[r];
//                                           setState(() {
//                                             caton = true;
//                                           });
//                                         }
//                                       }
//                                     } else {
//                                       null;
//                                     }
//                                   },
//                                   selectedItemBuilder: (BuildContext context) {
//                                     return nnn;
//                                   },
//                                   items: mmm,

//                                   // items: [
//                                   //   DropdownMenuItem(
//                                   //     value: 'ادوات المطبخ',
//                                   //     child: Container(
//                                   //       child: Row(
//                                   //         children: const <Widget>[
//                                   //           Icon(Icons.category_outlined),
//                                   //           Text('ادوات المطبخ'),
//                                   //         ],
//                                   //       ),
//                                   //     ),
//                                   //   ),
//                                   // ],
//                                   // onChanged: (value) {
//                                   //   if (value == 'ادوات المطبخ') {
//                                   //     _category = 'ادوات المطبخ';
//                                   //     setState(() {
//                                   //       caton = !caton;
//                                   //     });
//                                   //   }
//                                   // },
//                                 ),
//                                 onTap: () {},
//                               );
//                             }),
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
                    //           area ?? widget.area ?? '',
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
                    //             if (!widget.updated) {
                    //               for (var r = 0; r < names.length; r++) {
                    //                 if (value == names[r]) {
                    //                   area = names[r];
                    //                   setState(() {
                    //                     aron = !aron;
                    //                   });
                    //                 }
                    //               }
                    //             } else {
                    //               null;
                    //             }
                    //           },
                    //           selectedItemBuilder: (BuildContext context) {
                    //             return nnn;
                    //           },
                    //           items: mmm,
                    //           // items: [
                    //           //   DropdownMenuItem(
                    //           //     value: 'زيزينيا',
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
                    //           //     !widget.updated
                    //           //         ? setState(() {
                    //           //             area = 'زيزينيا';

                    //           //             aron = !aron;
                    //           //           })
                    //           //         : null;
                    //           //   }
                    //           // },
                    //         ),
                    //         onTap: () {
                    //           !widget.updated
                    //               ? setState(() {
                    //                   //   area = 'زيزينيا';

                    //                   aron = !aron;
                    //                 })
                    //               : null;
                    //         },
                    //       );
                    //     }),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Color.fromARGB(255, 253, 202, 0))),
                      onPressed: widget.updated
                          ? () {
                              null;
                            }
                          : () {
                              setState(() {
                                loading = true;
                              });
                              _trySubmit();
                            },
                      child: const Text(
                        'حفظ البيانات',
                        style: TextStyle(
                            fontFamily: 'Tajawal', color: Colors.black),
                      ),
                    ),
                    (loading)
                        ? const CircularProgressIndicator()
                        : const SizedBox(),
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
                        totalRepeatCount: 1,
                        onNext: (p0, p1) {
                          setState(() {
                            _descriptiontroller.text = widget.description;
                            _titlecontroller.text = widget.title;
                          });
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
