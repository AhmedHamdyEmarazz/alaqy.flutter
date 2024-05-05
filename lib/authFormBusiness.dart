import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ImagePicker.dart';
import 'business_main.dart';
import 'business_mainx.dart';
import 'numberPhone.dart';

// import 'fucks.dart';
// import 'user_image_picker.dart';

class AuthFormBusiness extends StatefulWidget {
  const AuthFormBusiness(
    this.submitFn,
    this.isLoading,
    this.supx,
    this.phone,
    this.username,
    this.koko,
    this.userx,
  );
  final bool supx;
  final bool isLoading;
  final String phone;
  final String username;
  final bool koko;
  final String userx;
  final void Function(
    String email,
    String area,
    String category,
    String city,
    String password,
    String userName,
    dynamic image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  AuthFormBusinessState createState() => AuthFormBusinessState();
}

class AuthFormBusinessState extends State<AuthFormBusiness> {
  bool cityon = false;
  bool caton = false;
  bool aron = false;
  bool eye = true;
  var oldo;
  bool loading = false;
  final _phoneController = TextEditingController();
  final _emailcontroller = TextEditingController();
  var _userImageFile;
  bool add = true;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  List names = [];
  List<Widget> nnn = [];
  List<DropdownMenuItem> mmm = [];
  List names2 = [];
  List<Widget> nnn2 = [];
  List<DropdownMenuItem> mmm2 = [];
  List names3 = [];
  List<Widget> nnn3 = [];
  List<DropdownMenuItem> mmm3 = [];
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _storename = '';
  var _category = '';
  var _userName = '';
  var _city = '';
  var _userPassword = '';
  var area = '';
  // var _userImageFile;

  void _pickedImage(dynamic image) {
    _userImageFile = image;
  }

  void _trySubmit() async {
    setState(() {
      loading = true;
    });
    //   final mobile = _phoneController.text.trim();
    final mobile = _phoneController.text.trim().startsWith('+')
        ? _phoneController.text.trim()
        : '+2${_phoneController.text.trim()}';
    print(mobile);
    final numberState = await FirebaseFirestore.instance
        .collection('business_details')
        .where('phone_num', isEqualTo: mobile)
        .get();
    final numberStatex = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('phone_num', isEqualTo: mobile)
        .get();
    final numberStatez = await FirebaseFirestore.instance
        .collection('customer_details')
        .where('phone_num',
            isEqualTo: widget.phone.startsWith('+')
                ? widget.phone
                : '+2${widget.phone}')
        .get();
    final copa = widget.koko == true
        ? numberStatez.docs.isNotEmpty
            ? numberStatez.docs.first
                .data()['basicemailx']
                .toString()
                .split('@')
                .first
            : 'numberStatez.docs.first.id'
        : numberState.docs.isNotEmpty
            ? (numberState.docs.first.data()['basicemail'])
                .toString()
                .split('@')
                .first
            : 'numberState.docs.first.id';

    if (numberState.docs.isNotEmpty) {
      final cops = widget.koko == true
          ? numberStatez.docs.first
              .data()['basicemailx']
              .toString()
              .split('@')
              .first
          : (numberState.docs.first.data()['basicemail'])
              .toString()
              .split('@')
              .first;
      setState(() {
        _userEmail = cops;
      });
      print(_userEmail);
    }
    if (widget.supx == false &&
        numberState.docs.isEmpty &&
        widget.username == '') {
      setState(() {
        loading = false;
      });
      numberStatex.docs.isNotEmpty || numberStatez.docs.isNotEmpty
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: const Text(
                    ' هذا الرقم لديه حساب عميل يمكنك الرجوع و الدخول كعميل فقط '),
                backgroundColor: Theme.of(context).errorColor,
              ),
            )
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                content: const Text('هذا الرقم لا ينتمي لأي حساب بيزنس'),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
      FocusScope.of(context).unfocus();

      return;
    }
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (area == '' && widget.supx && !widget.koko) {
      setState(() {
        loading = false;
        caton = false;
        cityon = false;
        aron = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: const Text('من فضلك إختر المنطقة'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      FocusScope.of(context).unfocus();

      return;
    }

    final lol = widget.koko == true
        ? '${copa}x@alaqy.com'
//'${numberStatez.docs.first.data()['name']}x@alaqy.com'
        : numberState.docs.isNotEmpty
            ? numberState.docs.first.data()['basicemailx']
            : '';
    if (isValid == true) {
      _formKey.currentState?.save();
      widget.supx && !widget.koko
          ? widget.submitFn(
              '${_userEmail.trim().replaceAll(RegExp(r' '), '_').replaceAll(RegExp(r'@'), '_')}@alaqy.com',
              area.trim(),
              _category.trim() == '' ? names2[0] : _category.trim(),
              _city.trim() == '' ? names[0] : _city.trim(),
              _userPassword.trim(),
              _userName.trim(),
              _userImageFile,
              _isLogin,
              context,
            )
          : (numberState.docs.isNotEmpty || numberStatez.docs.isNotEmpty)
              ? widget.submitFn(
                  lol, // numberState.docs.first.data()['basicemail'],
                  area.trim(),
                  _category.trim(),
                  _city.trim(),
                  _userPassword.trim(),
                  _userName.trim(),
                  _userImageFile,
                  _isLogin,
                  context,
                )
              : null;
      // _phoneController.clear();
      //  _emailcontroller.dispose();
      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user == null) {
          // Future.delayed(const Duration(seconds: 5), (() {
          //   return;
          // }));

          setState(() {
            loading = true;
          });
          // Future.delayed(const Duration(seconds: 2), (() {
          //   setState(() {
          //     loading = true;
          //   });
          // }));
          return;
          //   SplashScreen();
        }
        setState(() {
          loading = true;
        });
        try {
          setState(() {
            loading = true;
          });
        } on HttpException catch (err) {
          setState(() {
            loading = false;
          });
          var errMessage = 'Authentication failed';
          if (err.toString().contains('EMAIL_EXISTS')) {
            errMessage = 'هذا الإسم قد تم استخدامه من قبل';
          } else if (err.toString().contains('INVALID_EMAIL')) {
            errMessage = '@ غير مسموح بإستخدام الحرف';
          } else if (err.toString().contains('Badly_Formatted')) {
            errMessage = '@ غير مسموح بإستخدام الحرف';
          } else if (err.toString().contains('WEAK_PASSWORD')) {
            errMessage = 'كلمة المرور ضعيفة';
          } else if (err
              .toString()
              .contains('firebase_auth/network-request-failed')) {
            errMessage = 'خطأ في الوصول إلي الشبكة';
          } else if (err.toString().contains('EMAIL_NOT_FOUND')) {
            errMessage = 'لم نجد مستخدم بهذا الإسم';
          } else if (err.toString().contains('wrong-password')) {
            errMessage = 'كلمة المرور غير صحيحة';
          } else {
            errMessage = 'محاولة فاشلة .. الرجاء المحاولة مرة اخرى';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              content: Text(errMessage),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
          print('User is currently signed out!');
          setState(() {
            loading = false;
          });
        }

        if (_userEmail == '' && !widget.supx) {
          print('User is currently signed out!');
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              content: const Text('هذا الرقم لا ينتمي لأي حساب بيزنس'),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
          setState(() {
            loading = false;
          });
          return;
        } else if (numberStatex.docs.isEmpty && !widget.supx) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              content: const Text(
                  'هذا الرقم لم يقم بإنهاء التسجيل ..الرجاء التسجيل مرة اخرى'),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
          setState(() {
            loading = false;
          });
          return;
        } else {
          //   final con = navigatorKey.currentState!.context;
          // navigatorKey.currentContext.debugDoingBuild;
          //   if (numberState.docs.isNotEmpty && widget.supx == false) {
          if (_userPassword.trim().isEmpty || _userPassword.trim().length < 6) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text(
                    'كلمة المرور يجب أن تكون مكونة من 6 حروف أو أرقام على الأقل'),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
            setState(() {
              loading == false;
              oldo = false;
            });
            FocusScope.of(context).unfocus();

            return;
          }
          if (_userEmail.trim().isEmpty || _userEmail.trim().length < 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text(
                    'إسم المستخدم يجب أن يكون مكون من ثلاث حروف على الأقل'),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
            setState(() {
              loading == false;
              oldo = false;
            });
            FocusScope.of(context).unfocus();

            return;
          } else if (numberState.docs.isNotEmpty) {
            final uidq = (numberState.docs.first.data()['first_uid']);
            if (widget.supx == false) {
              FirebaseFirestore.instance
                  .collection('customer_details')
                  .doc(uidq)
                  .update({
                'businesslast': true,
              });
            }

// if( widget.supx || widget.koko){}
            widget.supx || widget.koko
                ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => BusinessMainx(
                        'none',
                        widget.phone.startsWith('+')
                            ? widget.phone
                            : '+2${widget.phone}')))
                : Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const BusinessMain('none')));

            print('User is signed in!');

            print('$user');
            //   SystemNavigator.pop();
            //     SystemNavigator.routeInformationUpdated(location: '/MyApp');
            //   RestartWidget.restartApp(context);
          }

          widget.supx || widget.koko
              ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => BusinessMainx('none', widget.phone)))
              : Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => const BusinessMain('none')));

          print('User is signed in!');
          //   SystemNavigator.routeInformationUpdated(location: '/');
          //  RestartWidget.restartApp(context);
          // Navigator.of(context).pushReplacementNamed(MyApp.routeName);
          // Navigator.of(context).restorablePushNamedAndRemoveUntil(
          //     MyApp.routeName, (route) => false);
        }
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.username);
    // print('${_userEmail}xx');
    //  final oppa = Provider.of<Auth>(context, listen: false).userId;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 30,
        ),
        //   child: SingleChildScrollView(
        // child: Padding(
        //   padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            //   const SizedBox(height: 15),
            widget.supx || widget.userx == 'result.user!.uidx'
                ? const SizedBox(height: 30)
                : const SizedBox(),
            widget.supx || widget.userx == 'result.user!.uidx'
                ? Center(
                    child: SizedBox(
                        //   height: 100,
                        //   width: double.infinity,
                        child: Image.asset(
                    'assets/alaqy.jpeg',
                    fit: BoxFit.contain,
                  )))
                : const SizedBox(),

            widget.supx || widget.userx == 'result.user!.uidx'
                ? const SizedBox(height: 10)
                : const SizedBox(),
            widget.koko ? const SizedBox(height: 100) : const SizedBox(),
            widget.supx
                ? Center(
                    child: Text(
                    !widget.koko ? 'بيانات المتجر' : "تعديل البيانات",
                    style:
                        TextStyle(fontFamily: 'Tajawal', color: Colors.black),
                  ))
                : widget.userx == 'result.user!.uidx'
                    ? const Center(
                        child: Text(
                        'هذا الرقم لديه حساب بالفعل',
                        style: TextStyle(
                            fontFamily: 'Tajawal', color: Colors.black),
                      ))
                    : const SizedBox(),
            const SizedBox(),
            // Text(widget.phone),
            // if (_isLogin) UserImagePicker(_pickedImage),
            widget.supx || widget.userx == 'result.user!.uidx'
                ? const SizedBox(height: 10)
                : const SizedBox(),
            widget.koko ? const SizedBox(height: 75) : const SizedBox(),

            if (widget.supx && !widget.koko)
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
                  // repeatForever: true,
                  onNext: (p0, p1) async {
                    if (add == true) {
                      final cit = _city == ''
                          ? await FirebaseFirestore.instance
                              .collection('city')
                              .get()
                          : await FirebaseFirestore.instance
                              .collection('city')
                              .where('name', isEqualTo: _city)
                              .get();
                      final areaid = cit.docs.first.id;
                      final areadocs = await FirebaseFirestore.instance
                          .collection('city')
                          .doc(areaid)
                          .collection('areas')
                          .get();
                      print(areadocs.docs.first.data()['name']);
                      final categorydocs = await FirebaseFirestore.instance
                          .collection('category')
                          .get();
                      final citydocs = await FirebaseFirestore.instance
                          .collection('city')
                          .get();
                      for (var x = 0; x < citydocs.docs.length; x++) {
                        names.add(citydocs.docs[x].data()['name']);
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

                      for (var y = 0; y < categorydocs.docs.length; y++) {
                        names2.add(categorydocs.docs[y].data()['name']);
                      }
                      for (var z = 0; z < names2.length; z++) {
                        nnn2.add(Text(names2[z]));
                        mmm2.add(DropdownMenuItem(
                            value: names2[z],
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.category_outlined),
                                  const SizedBox(width: 2),
                                  Text(names2[z]),
                                ],
                              ),
                            )));
                      }
                      for (var a = 0; a < areadocs.docs.length; a++) {
                        names3.add(areadocs.docs[a].data()['name']);
                      }
                      for (var b = 0; b < names3.length; b++) {
                        nnn3.add(Text(names3[b]));
                        mmm3.add(DropdownMenuItem(
                            value: names3[b],
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.location_on),
                                  const SizedBox(width: 2),
                                  Text(names3[b]),
                                ],
                              ),
                            )));
                      }
                    }
                    setState(() {
                      add == false;
                    });
                  }),
            if (widget.supx && !widget.koko) UserImagePicker(_pickedImage),
            if (widget.koko == false)
              if (widget.supx && widget.koko == false)
                SizedBox(
                  height: 9,
                ),
            TextFormField(
              //   initialValue: _initValues['phone'],
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              readOnly:
                  widget.userx == 'result.user!.uidx' ? true : widget.supx,
              decoration: InputDecoration(
                prefix: Text('+2'),
                label: Center(
                    child: Text(
                  'رقم الموبايل',
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      color: Color.fromARGB(48, 0, 0, 0)),
                )),
// helperStyle: TextStyle(),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                filled: true, //_phoneController.text == '' ? true : false,
                fillColor: (widget.userx == 'result.user!.uidx' || widget.supx)
                    ? Colors.grey.shade200
                    : Colors.white,
                // hintText: "Phone Number"
              ),
              controller: _phoneController,
              validator: (value) {
                if (value != null) {
                  return (value.isEmpty) ? 'من فضلك أدخل رقم موبايل' : null;
                }
              },
            ),
            // TextFormField(
            //   keyboardType: TextInputType.phone,
            //   readOnly: widget.supx,
            //   decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius:
            //               const BorderRadius.all(Radius.circular(8)),
            //           borderSide: BorderSide(color: Colors.grey.shade200)),
            //       focusedBorder: OutlineInputBorder(
            //           borderRadius:
            //               const BorderRadius.all(Radius.circular(8)),
            //           borderSide: BorderSide(color: Colors.grey.shade300)),
            //       filled: true,
            //       fillColor: Colors.grey[100],
            //       hintText: "Phone Number"),
            //   controller: _phoneController,
            // ),
            widget.koko ? const SizedBox(height: 14) : const SizedBox(),

            if (widget.supx && widget.koko == false) const SizedBox(height: 8),

            if (widget.supx && widget.koko == false)
              //   if (widget.supx)
              TextFormField(
                key: const ValueKey('email'),
                //   initialValue: _userEmail,
                textAlign: TextAlign.center,

                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                validator: (value) {
                  if (value != null) {
                    return (value.isEmpty || value.length < 3)
                        ? 'من فضلك ادخل ثلاث حروف على الاقل'
                        : null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey.shade200)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    filled: true,
                    fillColor: Colors.white,
                    //  labelText: widget.koko ? 'enter new Password' : 'Password',
                    label: Center(
                      //   labelText:
                      child: widget.koko == true
                          ? Text('من فضلك إختر إسم مناسب')
                          : Text(
                              'إسم المستخدم',
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  color: Color.fromARGB(48, 0, 0, 0)),
                            ),
                    )),
                //    obscureText: true,

                onSaved: (value) {
                  if (value != null) {
                    _userEmail = value;
                  }
                },
              ),
            // TextFormField(
            //   key: const ValueKey('email'),
            //   autocorrect: false,
            //   textCapitalization: TextCapitalization.none,
            //   enableSuggestions: false,
            //   validator: (value) {
            //     if (value != null) {
            //       return (value.isEmpty)
            //           ? 'Please enter a valid username.'
            //           : null;
            //     }
            //   },
            //   keyboardType: TextInputType.emailAddress,
            //   readOnly: widget.username == '' ? false : true,
            //   decoration: const InputDecoration(
            //     labelText: 'user name',
            //   ),
            //   controller: _emailcontroller,
            //   onSaved: (value) {
            //     if (value != null) {
            //       _userEmail = value;
            //     }
            //   },
            // ),
            if (widget.supx && widget.koko == false)
              SizedBox(
                height: 8,
              ),
            if (widget.supx && widget.koko == false)
              TextFormField(
                key: const ValueKey('usern'),
                //   initialValue: _userEmail,
                textAlign: TextAlign.center,

                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                validator: (value) {
                  if (value != null) {
                    return (value.isEmpty || value.length < 3)
                        ? 'من فضلك إدخل ثلاث حروف على الأقل'
                        : null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey.shade200)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    filled: true,
                    fillColor: Colors.white,
                    //  labelText: widget.koko ? 'enter new Password' : 'Password',
                    label: Center(
                      //   labelText:
                      child: widget.koko == true
                          ? Text('من فضلك إدخل إسم مناسب')
                          : Text(
                              'إسم المتجر',
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  color: Color.fromARGB(48, 0, 0, 0)),
                            ),
                    )),
                //    obscureText: true,

                onSaved: (value) {
                  if (value != null) {
                    _userName = value;
                  }
                },
              ),
            // TextFormField(
            //   key: const ValueKey('username'),
            //   autocorrect: true,
            //   textCapitalization: TextCapitalization.words,
            //   enableSuggestions: false,
            //   validator: (value) {
            //     if (value != null) {
            //       return (value.isEmpty || value.length < 3)
            //           ? 'Please enter at least 4 characters'
            //           : null;
            //     }
            //     //        return null;
            //   },
            //   decoration: const InputDecoration(labelText: 'store name'),
            //   onSaved: (value) {
            //     if (value != null) {
            //       _userName = value;
            //     }
            //   },
            // ),
            const SizedBox(height: 8),
            TextFormField(
              key: const ValueKey('password'),
              textAlign: TextAlign.center,
              validator: (value) {
                if (value != null) {
                  //                if (value!.isEmpty || value.length < 5) {
                  //                    return 'Password must be at least 5 characters long.';
                  //                  }
                  //                  return '';
                  //              },

                  return (value.isEmpty || value.length < 6)
                      ? 'كلمة المرور مكونة من 6 حروف أو أكثر'
                      : null;
                }
                //         return null;
              },
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: eye == true ? Colors.grey : Colors.amber,
                  icon: Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    setState(() {
                      eye = !eye;
                    });
                  },
                ),
                label: Center(
                    child: widget.koko == false
                        ? Text(
                            "كلمة المرور",
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Color.fromARGB(48, 0, 0, 0)),
                          )
                        : Text(
                            'إدخال كلمة مرور جديدة',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Color.fromARGB(48, 0, 0, 0)),
                          )),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                filled: true,
                fillColor: Colors.white,
                //  labelText: widget.koko ? 'enter new Password' : 'Password',
              ),
              obscureText: eye, //  true,
              onSaved: (value) {
                if (value != null) {
                  _userPassword = value;
                  print(_userPassword);
                }
              },
            ),
            // Container(
            //     alignment: Alignment.centerRight,
            //     child: IconButton(
            //       color: eye == true ? Colors.grey : Colors.amber,
            //       icon: Icon(Icons.remove_red_eye_outlined),
            //       onPressed: () {
            //         setState(() {
            //           eye = !eye;
            //         });
            //       },
            //     )),
            if (widget.supx && widget.koko == false) const SizedBox(height: 4),
            // TextFormField(
            //   key: const ValueKey('password'),
            //   validator: (value) {
            //     if (value != null) {
            //       //                if (value!.isEmpty || value.length < 5) {
            //       //                    return 'Password must be at least 5 characters long.';
            //       //                  }
            //       //                  return '';
            //       //              },

            //       return (value.isEmpty || value.length < 5)
            //           ? 'Password must be at least 5 characters long.'
            //           : null;
            //     }
            //     //         return null;
            //   },
            //   decoration: const InputDecoration(labelText: 'Password'),
            //   obscureText: true,
            //   onSaved: (value) {
            //     if (value != null) {
            //       _userPassword = value;
            //     }
            //   },
            // ),
            if (widget.supx && widget.koko == false)
              Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    //   horizontal: 1,
                  ),
                  //   width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        borderRadius: BorderRadius.all(Radius.circular(8)),
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
                      ))),
            if (widget.supx && widget.koko == false)
              Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    //   horizontal: 1,
                  ),
                  //   width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: DropdownButton(
                        underline: Text(
                          _category == ''
                              ? names2.isEmpty
                                  ? ''
                                  : names2[0]
                              : _category,
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              //     fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onChanged: (value) {
                          for (var l = 0; l < names2.length; l++) {
                            if (value == names2[l]) {
                              _category = names2[l];
                              setState(() {
                                caton = true;
                              });
                            }
                          }
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return nnn2;
                        },
                        items: mmm2,
                        onTap: () {},
                      ))),
            if (widget.supx && widget.koko == false)
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    //   horizontal: 1,
                  ),
                  //   width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: ListTile(
                          title: DropdownButton(
                        underline: Text(
                          area == '' ? '           اختر المنطقة' : area,
                          textAlign: //TextAlign.center,
                              area != '' ? TextAlign.center : TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              //     fontWeight: FontWeight.bold,
                              color: area == ''
                                  ? Color.fromARGB(46, 0, 0, 0)
                                  : Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onChanged: (value) {
                          for (var m = 0; m < names3.length; m++) {
                            if (value == names3[m]) {
                              area = names3[m];
                              setState(() {
                                aron = true;
                              });
                            }
                          }
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return nnn3;
                        },
                        items: mmm3,
                        onTap: () {},
                      )))),
            // if (widget.supx && widget.koko == false)
            //   ListTile(
            //       leading: Text(
            //         _city == ''
            //             ? names.isEmpty
            //                 ? ''
            //                 : names[0]
            //             : _city,
            //         style: TextStyle(
            //             color:
            //                 cityon == false ? Colors.grey : Colors.deepPurple),
            //       ),
            //       title: DropdownButton(
            //         underline: Text(
            //           'city',
            //           style: TextStyle(
            //               color: cityon == false
            //                   ? Colors.grey
            //                   : Colors.amberAccent),
            //         ),
            //         icon: Icon(Icons.location_city_outlined,
            //             color:
            //                 cityon == false ? Colors.grey : Colors.deepPurple),
            //         onChanged: (value) {
            //           for (var k = 0; k < names.length; k++) {
            //             if (value == names[k]) {
            //               _city = names[k];
            //               setState(() {
            //                 cityon = true;
            //               });
            //             }
            //           }
            //         },
            //         selectedItemBuilder: (BuildContext context) {
            //           return nnn;
            //         },
            //         items: mmm,
            //         onTap: () {},
            //       )),
            // //        }),
            // if (widget.supx && widget.koko == false)
            //   ListTile(
            //     leading: Text(
            //       _category == ''
            //           ? names2.isEmpty
            //               ? ''
            //               : names2[0]
            //           : _category,
            //       style: TextStyle(
            //           color: caton == false ? Colors.grey : Colors.deepPurple),
            //     ),
            //     trailing: DropdownButton(
            //       underline: Text(
            //         'category',
            //         style: TextStyle(
            //             color:
            //                 caton == false ? Colors.grey : Colors.tealAccent),
            //       ),
            //       icon: Icon(Icons.category_outlined,
            //           color: caton == false ? Colors.grey : Colors.deepPurple),
            //       onChanged: (value) {
            //         for (var l = 0; l < names2.length; l++) {
            //           if (value == names2[l]) {
            //             _category = names2[l];
            //             setState(() {
            //               caton = true;
            //             });
            //           }
            //         }
            //       },
            //       selectedItemBuilder: (BuildContext context) {
            //         return nnn2;
            //       },
            //       items: mmm2,
            //     ),
            //     onTap: () {},
            //   ),
            // if (widget.supx && widget.koko == false)
            //   ListTile(
            //     leading: Text(
            //       area,
            //       style: TextStyle(
            //           color: aron == false ? Colors.grey : Colors.deepPurple),
            //     ),
            //     trailing: DropdownButton(
            //       underline: Text(
            //         'area',
            //         style: TextStyle(
            //             color: aron == false ? Colors.grey : Colors.blueGrey),
            //       ),
            //       icon: Icon(Icons.location_on,
            //           color: aron == false ? Colors.grey : Colors.deepPurple),
            //       onChanged: (value) {
            //         for (var m = 0; m < names3.length; m++) {
            //           if (value == names3[m]) {
            //             area = names3[m];
            //             setState(() {
            //               aron = true;
            //             });
            //           }
            //         }
            //       },
            //       selectedItemBuilder: (BuildContext context) {
            //         return nnn3;
            //       },
            //       items: mmm3,
            //     ),
            //     onTap: () {},
            //   ),

            const SizedBox(height: 17),
            // (widget.isLoading || loading == true)
            //     ? const CircularProgressIndicator()
            //     : const SizedBox(),

            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Color.fromARGB(255, 253, 202, 0))),
                onPressed: () {
                  setState(() {
                    loading == true;
                    oldo = true;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                  //  Future.delayed(const Duration(seconds: 2), (() {
                  _trySubmit();
                  //    }));
                  Future.delayed(const Duration(seconds: 6), (() {
                    setState(() {
                      loading = false;
                    });
                  }));
                },
                child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        !widget.supx ? 'دخول إلى الحساب' : 'حفظ البيانات',
                        style: TextStyle(
                            fontFamily: 'Tajawal', color: Colors.black),
                        //  style: TextStyle(color: Colors.black),
                      ),
                    ))),
            (!widget.supx) && widget.userx != 'result.user!.uidx'
                ? TextButton(
                    child: const Text(
                      'إنشاء حساب',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 59, 53, 53)),
                    ),
                    onPressed: () {
                      print('check');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginScreen('business', false)));
                    },
                  )
                : SizedBox(),

            !widget.koko && !widget.supx
                ? const SizedBox(
                    height: 15,
                  )
                : const SizedBox(),
            !widget.koko && !widget.supx
                ? TextButton(
                    child: const Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color.fromARGB(175, 59, 53, 53)),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginScreen('business', true)));
                    },
                  )
                : const SizedBox(),

            widget.koko || widget.supx || widget.userx == 'result.user!.uidx'
                ? TextButton(
                    child: const Text(
                      'الرجوع',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color.fromARGB(48, 0, 0, 0)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                  )
                : const SizedBox(),

            //  loading == true || widget.isLoading
            //       ? const CircularProgressIndicator()
            //       : const SizedBox(),
            oldo == true
                ? const Center(
                    child: LinearProgressIndicator(
                    color: Colors.amber,
                    backgroundColor: Colors.white,
                  ))
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
              repeatForever: true,
              onNext: (p0, p1) {
                if (widget.username != '') {
                  _userEmail = widget.username.toString().split('@').first;

                  _emailcontroller.text =
                      widget.username.toString().split('@').first;
                }
                if (!widget.supx && widget.userx != 'result.user!.uidx') {
                  if (mounted) {
                    // _phoneController.text.trim() == ''
                    //     ? _phoneController.text = '+20'
                    //     : null;
                  }
                }
                if (widget.supx || widget.userx == 'result.user!.uidx') {
                  _phoneController.text = widget.phone.startsWith('+')
                      ? widget.phone
                      : '+2${widget.phone}';
                }
              },
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
                  speed: const Duration(seconds: 3),
                )
              ],
              repeatForever: true,
              onNext: (p0, p1) {
                oldo = widget.isLoading;
              },
            ),
          ]),
        ),
      ),
    );
  }
}
