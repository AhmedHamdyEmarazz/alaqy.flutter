import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alaqy/authScreenUser.dart';

import 'AuthScreenBusiness.dart';
import 'mainb.dart';
// import 'auth.dart';
// import 'http_exception.dart';
// import 'auth_screeeen.dart';
// import 'categoriesscreen.dart';
// import 'foundbyloc.dart';
// import 'fucks.dart';
// import 'products_overview_screen.dart';

// class Number extends StatefulWidget {
//   static const routeName = '/Number';
//   @override
//   State<Number> createState() => NumberState();
// }

// class NumberState extends State<Number> {
//   var isLoading = false;

//   void cat(context) async {
//     setState(() {
//       isLoading = true;
//     });
//     //  final oppas = Provider.of<Auth>(context, listen: false);

//     final oppa = FirebaseAuth.instance.currentUser!.email;
// //Provider.of<Auth>(context, listen: false).userId;

//     final user = FirebaseAuth.instance.currentUser;
//     final userData = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user?.uid)
//         .get();
//     FirebaseFirestore.instance.collection('welcome').doc(oppa).set({
//       'welcomed': oppa,
//       'marhab': user?.uid,
//     });
//     if (!mounted) return;
//     final userrr = FirebaseAuth.instance.currentUser!.email;
// //Provider.of<Auth>(context, listen: false).userId;
//     if (userrr != null) {
//       await FirebaseFirestore.instance.collection('chato').doc(oppa).set({
//         'pokeuser': 'x',
//       });
//       await FirebaseFirestore.instance.collection('chato').doc('${oppa}x').set({
//         'pokeuser': 'x',
//       });
//       setState(() {
//         isLoading = false;
//       });
//       Navigator.of(context).pushReplacementNamed(Foundbyloc.routeName);
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       Navigator.of(context).pushReplacementNamed(AuthScreenn.routeName);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'EL-koshk     -Welcome ',
//             style: TextStyle(
//               fontSize: 18,
//             ),
//           ),
//         ),
//         body: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Center(
//                   child: isLoading == true
//                       ? const CircularProgressIndicator()
//                       : ElevatedButton(
//                           child: const Text(
//                               'Press here if u r over 15 yrs old to continue'),
//                           onPressed: () async {
//                             cat(context);
//                           })),
//               SizedBox(
//                   width: double.infinity,
//                   height: 70,
//                   child: ElevatedButton(
//                       child: const Text('skip if u confirmed this before'),
//                       onPressed: () async {
//                         Navigator.of(context)
//                             .pushReplacementNamed(Foundbyloc.routeName);
//                       }))
//             ]));
//   }
// }
class LoginScreen extends StatefulWidget {
  static const routeName = '/Number';
  String accType;
  bool koke;
  LoginScreen(this.accType, this.koke);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  String kids = 'null';
  bool loading = false;
  bool loadingxx = false;

  bool sup = true;
  var _already = false;
  var _hold = false;

  var _usertobus = false;
  Map<String, String> _initValues = {
    'phone': '+20',
  };
  final _phoneController = TextEditingController();
  void need() async {
    print(widget.accType);
    print(kids);
    print('ffgfgfgfgfgfgfgfgfgfgfg');
    //   final mobile = _phoneController.text.trim();
    final mobile = _phoneController.text.trim().startsWith('+')
        ? _phoneController.text.trim()
        : '+2${_phoneController.text.trim()}';
    final numberState = kids == 'null'
        ? widget.accType == 'customer'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
        : kids == 'customer'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get();
    final numberStateinverse = kids == 'null'
        ? widget.accType == 'business'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
        : kids == 'business'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .where('activated', isEqualTo: true)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get();

    numberState.docs.isNotEmpty
        ? setState(() {
            _already = true;
          })
        : setState(() {
            _already = false;
          });
    numberStateinverse.docs.isNotEmpty
        ? setState(() {
            _hold = true;
          })
        : setState(() {
            _hold = false;
          });
    print(_already);
    print('already');
    print(mobile);
  }

  void hold(coxx) async {
    //  final mobile = _phoneController.text.trim();
    final mobile = _phoneController.text.trim().startsWith('+')
        ? _phoneController.text.trim()
        : '+2${_phoneController.text.trim()}';
    final usertobusx = kids == 'null'
        ? widget.accType == 'customer'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
        : kids == 'customer'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get();
    final usertobusxinverse = kids == 'null'
        ? widget.accType == 'business'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
        : kids == 'business'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get();
  }

  void need2(cox) async {
    final mobile = _phoneController.text.trim().startsWith('+')
        ? _phoneController.text.trim()
        : '+2${_phoneController.text.trim()}';
    // final mobile = _phoneController.text.trim();
    final usertobusx = kids == 'null'
        ? widget.accType == 'customer'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
        : kids == 'customer'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get();

    if (kids == 'null') {
      if (widget.accType == 'business' && _already == false) {
        print('shawn michaels');
        // final usertobusx = await FirebaseFirestore.instance
        //     .collection('customer_details')
        //     .where('phone_num', isEqualTo: mobile)
        //     .get();
        usertobusx.docs.isNotEmpty
            ? setState(() {
                _usertobus = true;
              })
            : setState(() {
                _usertobus = false;
              });
        // usertobusx.docs.isNotEmpty
        //     ? MaterialPageRoute(
        //         builder: (context) => UserToBusinessScreen(
        //             _phoneController.toString(),
        //             usertobusx.docs.first.id,
        //             usertobusx.docs.first.data()['second_uid'],
        //             mobile))
        //     : null;
      }
    } else {
      if (kids == 'business' && _already == false) {
        print('shawn michaels');
        // final usertobusx = await FirebaseFirestore.instance
        //     .collection('customer_details')
        //     .where('phone_num', isEqualTo: mobile)
        //     .get();
        usertobusx.docs.isNotEmpty
            ? setState(() {
                _usertobus = true;
              })
            : setState(() {
                _usertobus = false;
              });
        // usertobusx.docs.isNotEmpty
        //     ? MaterialPageRoute(
        //         builder: (context) => UserToBusinessScreen(
        //             _phoneController.toString(),
        //             usertobusx.docs.first.id,
        //             usertobusx.docs.first.data()['second_uid'],
        //             mobile))
        //     : null;
      }
    }

    // print(usertobusx.docs.first.data()['username']);
    _usertobus == true
        ? Navigator.pushReplacement(
            cox,
            MaterialPageRoute(
                builder: (context) => AuthScreenBusiness(
                    mobile,
                    usertobusx.docs.first.id,
                    true,
                    usertobusx.docs.first.data()['username'],
                    false)))
        : null;
  }

  final _passController = TextEditingController();
//   void already_customergobus(BuildContext context) { setState(() {
//       loading = true;
//     });
//  MaterialPageRoute(
//             builder: (context) =>  UserToBusinessScreen(
//                     _phoneController.toString(), 'result.user!.uid', false));

// }

  void already_registered(BuildContext context) {
    setState(() {
      loading = true;
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => kids == 'null'
                ? widget.accType == 'customer'
                    ? AuthScreenUser(_phoneController.text, 'result.user!.uidx',
                        false, false)
                    : AuthScreenBusiness(_phoneController.text,
                        'result.user!.uidx', false, '', false)
                : kids == 'customer'
                    ? AuthScreenUser(_phoneController.text, 'result.user!.uidx',
                        false, false)
                    : AuthScreenBusiness(_phoneController.text,
                        'result.user!.uidx', false, '', false)));
    // print('result.user!.uidx');
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              '',
              textStyle: const TextStyle(
                fontSize: 20,
                fontFamily: 'Tajawal',
                color: Colors.white,
                overflow: TextOverflow.visible,
              ),
              speed: const Duration(milliseconds: 90),
            )
          ],
          repeatForever: true,
          onNext: (p0, p1) {
            setState(() {
              loadingxx = false;
            });
          },
        ),
        title: const Text('محاولة فاشلة'),
        content: Text(message.contains('a')
            ? "لم نتمكن من إدخالك ..الرجاء المحاولة لاحقا أو إدخال رقم صحيح"
            : message),
        actions: <Widget>[
          TextButton(
            child: const Text('موافق'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future registerUser(String mobilex, BuildContext context) async {
    setState(() {
      loading = true;
      loadingxx = true;
    });
    print(mobilex);

    final mobile = mobilex.startsWith('+') ? mobilex : '+2${mobilex}';
    print(mobile);
    try {
      var _credential;
      var smsCode;
      final _codeController = TextEditingController();
      FirebaseAuth _auth = FirebaseAuth.instance;
      if (widget.koke == true) {
        final numberState = widget.accType == 'customer'
            ? await FirebaseFirestore.instance
                .collection('customer_details')
                .where('phone_num', isEqualTo: mobile)
                .get()
            : await FirebaseFirestore.instance
                .collection('business_details')
                .where('phone_num', isEqualTo: mobile)
                .get();
        if (numberState.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('هذا الرقم لا ينتمي لأي حساب '),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
          setState(() {
            loading = false;
          });
          return;
        }
      }
      //if (widget.koke == false) {
      (widget.koke == false)
          ? _auth.verifyPhoneNumber(
              phoneNumber: mobile,
              timeout: const Duration(seconds: 60),
              verificationCompleted: (AuthCredential authCredential) {
                try {
                  setState(() {
                    loading = true;
                  });

                  // FirebaseAuth.instance
                  //     .setSettings(appVerificationDisabledForTesting: true);
                  _auth
                      .signInWithCredential(authCredential)
                      .then((UserCredential result) {
                    try {
                      Navigator.of(context).pop(false);
                      setState(() {
                        loading = false;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => kids == 'null'
                                  ? widget.accType == 'customer'
                                      ? AuthScreenUser(_phoneController.text,
                                          result.user!.uid, true, false)
                                      : AuthScreenBusiness(
                                          _phoneController.text,
                                          result.user!.uid,
                                          true,
                                          '',
                                          false)
                                  : kids == 'customer'
                                      ? AuthScreenUser(_phoneController.text,
                                          result.user!.uid, true, false)
                                      : AuthScreenBusiness(
                                          _phoneController.text,
                                          result.user!.uid,
                                          true,
                                          '',
                                          false)));
                    } on HttpException catch (err) {
                      var errMessage = 'فشل المحاولة';
                      if (err.toString().contains('incorrect') ||
                          err.toString().contains('format')) {
                        errMessage = 'من فضلك قم بادخال رقم صحيح';
                      } else if (err.toString().contains('TOO_LONG')) {
                        errMessage = 'من فضلك قم بادخال رقم صحيح';
                      } else {
                        errMessage =
                            'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                      }

                      _showErrorDialog(errMessage);
                    } catch (err) {
                      if (err.toString().isEmpty) {
                        null;
                      } else {
                        final errMessage = err.toString();
                        _showErrorDialog(errMessage);

                        print(err);
                      }
                    }
                  }).catchError((e) {
                    var errMessage = 'فشل المحاولة';
                    if (e.toString().contains('incorrect') ||
                        e.toString().contains('format')) {
                      errMessage = 'من فضلك قم بادخال رقم صحيح';
                    } else if (e.toString().contains('TOO_LONG')) {
                      errMessage = 'من فضلك قم بادخال رقم صحيح';
                    } else {
                      errMessage =
                          'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                    }

                    _showErrorDialog(errMessage);
                    print(e);
                  });
                } on HttpException catch (err) {
                  var errMessage = 'فشل المحاولة';
                  if (err.toString().contains('incorrect')) {
                    errMessage = 'من فضلك قم بادخال رقم صحيح';
                  } else if (err.toString().contains('TOO_LONG')) {
                    errMessage = 'من فضلك قم بادخال رقم صحيح';
                  } else {
                    errMessage =
                        'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                  }

                  _showErrorDialog(errMessage);
                } catch (err) {
                  if (err.toString().isEmpty) {
                    null;
                  } else {
                    final errMessage = err.toString();
                    _showErrorDialog(errMessage);

                    print(err);
                  }
                }
              },
              verificationFailed: (FirebaseAuthException authException) {
                _showErrorDialog(authException.message.toString());
                setState(() {
                  loading = false;
                });
                print(authException.message);
              },
              codeSent: (String verificationId, [int? forceResendingToken]) {
                //show dialog to take input from the user
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                          icon: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                '',
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Tajawal',
                                  color: Colors.white,
                                  overflow: TextOverflow.visible,
                                ),
                                speed: const Duration(milliseconds: 90),
                              )
                            ],
                            repeatForever: true,
                            onNext: (p0, p1) {
                              setState(() {
                                loadingxx = false;
                              });
                            },
                          ),
                          title: const Text(
                              " sms  قم بادخال رمز التحقق المرسل اليك عبر رسالة نصية"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: _codeController,
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                FirebaseAuth auth = FirebaseAuth.instance;

                                smsCode = _codeController.text.trim();

                                _credential = PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: smsCode);
                                auth
                                    .signInWithCredential(_credential)
                                    .then((UserCredential result) {
                                  try {
                                    Navigator.of(context).pop(false);
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => kids == 'null'
                                                ? widget.accType == 'customer'
                                                    ? AuthScreenUser(
                                                        _phoneController.text,
                                                        result.user!.uid,
                                                        true,
                                                        false)
                                                    : AuthScreenBusiness(
                                                        _phoneController.text,
                                                        result.user!.uid,
                                                        true,
                                                        '',
                                                        false)
                                                : kids == 'customer'
                                                    ? AuthScreenUser(
                                                        _phoneController.text,
                                                        result.user!.uid,
                                                        true,
                                                        false)
                                                    : AuthScreenBusiness(
                                                        _phoneController.text,
                                                        result.user!.uid,
                                                        true,
                                                        '',
                                                        false)));
                                  } on HttpException catch (err) {
                                    var errMessage = 'فشل المحاولة';
                                    if (err.toString().contains('Incorrect')) {
                                      errMessage = 'رمز التحقق غير صحيح';
                                    } else if (err
                                        .toString()
                                        .contains('Wrong')) {
                                      errMessage = 'رمز التحقق غير صحيح';
                                    } else {
                                      errMessage =
                                          'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                                    }
                                    //     if (err.toString().isEmpty) {
                                    //     null;
                                    //    } else {
                                    //       errMessage = err.message;
//      }

                                    //    ScaffoldMessenger.of(ctx).showSnackBar(
                                    //       SnackBar(
//          content: Text(errMessage),
                                    //         backgroundColor: Theme.of(ctx).errorColor,
                                    //      ),
                                    //    );
                                    // setState(() {
                                    //   _isLoading = false;
                                    //    });
                                    _showErrorDialog(errMessage);
                                  } catch (err) {
                                    if (err.toString().isEmpty) {
                                      null;
                                    } else {
                                      final errMessage = err.toString();
                                      _showErrorDialog(errMessage);

                                      print(err);
                                    }
                                  }
                                }).catchError((e) {
                                  var errMessage = 'فشل المحاولة';
                                  if (e.toString().contains('incorrect')) {
                                    errMessage = 'رمز التحقق غير صحيح';
                                  } else if (e
                                      .toString()
                                      .contains('Incorrect validation code')) {
                                    errMessage = 'رمز التحقق غير صحيح';
                                  } else {
                                    errMessage =
                                        'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                                  }
                                  //     if (err.toString().isEmpty) {
                                  //     null;
                                  //    } else {
                                  //       errMessage = err.message;
//      }

                                  //    ScaffoldMessenger.of(ctx).showSnackBar(
                                  //       SnackBar(
//          content: Text(errMessage),
                                  //         backgroundColor: Theme.of(ctx).errorColor,
                                  //      ),
                                  //    );
                                  // setState(() {
                                  //   _isLoading = false;
                                  //    });
                                  _showErrorDialog(errMessage);
                                  print(e);
                                });

                                // Navigator.of(context).pop();
                                // setState(() {
                                //   loading = false;
                                // });
                              },
                              child: const Text(
                                "موافق",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ));
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                verificationId = verificationId;
                print(verificationId);
                print("Timout");
              })
          : _auth.verifyPhoneNumber(
              phoneNumber: mobile,
              timeout: const Duration(seconds: 60),
              verificationCompleted: (AuthCredential authCredential) {
                try {
                  setState(() {
                    loading = true;
                  });
                  // FirebaseAuth.instance
                  //     .setSettings(appVerificationDisabledForTesting: true);
                  _auth
                      .signInWithCredential(authCredential)
                      .then((UserCredential result) {
                    try {
                      Navigator.of(context).pop(false);
                      setState(() {
                        loading = false;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => kids == 'null'
                                  ? widget.accType == 'customer'
                                      ? AuthScreenUser(
                                          mobile, result.user!.uid, true, true)
                                      : AuthScreenBusiness(mobile,
                                          result.user!.uid, true, '', true)
                                  : kids == 'customer'
                                      ? AuthScreenUser(
                                          mobile, result.user!.uid, true, true)
                                      : AuthScreenBusiness(mobile,
                                          result.user!.uid, true, '', true)));
                    } on HttpException catch (err) {
                      var errMessage = 'فشل المحاولة';
                      if (err.toString().contains('incorrect') ||
                          err.toString().contains('format')) {
                        errMessage = 'من فضلك قم بادخال رقم صحيح';
                      } else if (err.toString().contains('TOO_LONG')) {
                        errMessage = 'من فضلك قم بادخال رقم صحيح';
                      } else {
                        errMessage =
                            'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                      }

                      _showErrorDialog(errMessage);
                    } catch (err) {
                      if (err.toString().isEmpty) {
                        null;
                      } else {
                        final errMessage = err.toString();
                        _showErrorDialog(errMessage);

                        print(err);
                      }
                    }
                  }).catchError((e) {
                    var errMessage = 'فشل المحاولة';
                    if (e.toString().contains('incorrect') ||
                        e.toString().contains('format')) {
                      errMessage = 'من فضلك قم بادخال رقم صحيح';
                    } else if (e.toString().contains('TOO_LONG')) {
                      errMessage = 'من فضلك قم بادخال رقم صحيح';
                    } else {
                      errMessage =
                          'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                    }

                    _showErrorDialog(errMessage);
                    print(e);
                  });
                } on HttpException catch (err) {
                  var errMessage = 'فشل المحاولة';
                  if (err.toString().contains('incorrect') ||
                      err.toString().contains('format')) {
                    errMessage = 'من فضلك قم بادخال رقم صحيح';
                  } else if (err.toString().contains('TOO_LONG')) {
                    errMessage = 'من فضلك قم بادخال رقم صحيح';
                  } else {
                    errMessage =
                        'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                  }

                  _showErrorDialog(errMessage);
                } catch (err) {
                  if (err.toString().isEmpty) {
                    null;
                  } else {
                    final errMessage = err.toString();
                    _showErrorDialog(errMessage);

                    print(err);
                  }
                }
              },
              verificationFailed: (FirebaseAuthException authException) {
                _showErrorDialog(authException.message.toString());
                setState(() {
                  loading = false;
                });
                print(authException.message);
              },
              codeSent: (String verificationId, [int? forceResendingToken]) {
                //show dialog to take input from the user
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                          icon: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                '',
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Tajawal',
                                  color: Colors.white,
                                  overflow: TextOverflow.visible,
                                ),
                                speed: const Duration(milliseconds: 90),
                              )
                            ],
                            repeatForever: true,
                            onNext: (p0, p1) {
                              setState(() {
                                loadingxx = false;
                              });
                            },
                          ),
                          title: const Text(
                              " sms  قم بادخال رمز التحقق المرسل اليك عبر رسالة نصية"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: _codeController,
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                FirebaseAuth auth = FirebaseAuth.instance;

                                smsCode = _codeController.text.trim();

                                _credential = PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: smsCode);
                                auth
                                    .signInWithCredential(_credential)
                                    .then((UserCredential result) {
                                  try {
                                    Navigator.of(context).pop(false);
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => kids == 'null'
                                                ? widget.accType == 'customer'
                                                    ? AuthScreenUser(
                                                        _phoneController.text,
                                                        result.user!.uid,
                                                        true,
                                                        true)
                                                    : AuthScreenBusiness(
                                                        _phoneController.text,
                                                        result.user!.uid,
                                                        true,
                                                        '',
                                                        true)
                                                : kids == 'customer'
                                                    ? AuthScreenUser(
                                                        _phoneController.text,
                                                        result.user!.uid,
                                                        true,
                                                        true)
                                                    : AuthScreenBusiness(
                                                        _phoneController.text,
                                                        result.user!.uid,
                                                        true,
                                                        '',
                                                        true)));
                                  } on HttpException catch (err) {
                                    var errMessage = "فشل المحاولة";
                                    if (err.toString().contains('Incorrect')) {
                                      errMessage = 'رمز التحقق غير صحيح';
                                    } else if (err
                                        .toString()
                                        .contains('Wrong')) {
                                      errMessage = 'رمز التحقق غير صحيح';
                                    } else {
                                      errMessage =
                                          'لم نتمكن من ادخالك ..من فضلك اعد المحاولة لاحقا';
                                    }
                                    //     if (err.toString().isEmpty) {
                                    //     null;
                                    //    } else {
                                    //       errMessage = err.message;
//      }

                                    //    ScaffoldMessenger.of(ctx).showSnackBar(
                                    //       SnackBar(
//          content: Text(errMessage),
                                    //         backgroundColor: Theme.of(ctx).errorColor,
                                    //      ),
                                    //    );
                                    // setState(() {
                                    //   _isLoading = false;
                                    //    });
                                    _showErrorDialog(errMessage);
                                  } catch (err) {
                                    if (err.toString().isEmpty) {
                                      null;
                                    } else {
                                      final errMessage = err.toString();
                                      _showErrorDialog(errMessage);

                                      print(err);
                                    }
                                  }
                                }).catchError((e) {
                                  var errMessage = 'فشل المحاولة';
                                  if (e.toString().contains('incorrect')) {
                                    errMessage = 'رمز التحقق غير صحيح';
                                  } else if (e
                                      .toString()
                                      .contains('Incorrect validation code')) {
                                    errMessage = 'رمز التحقق غير صحيح';
                                  } else {
                                    errMessage =
                                        'فشل المحاولة .. الرجاء اعادة المحاولة لاحقا';
                                  }
                                  //     if (err.toString().isEmpty) {
                                  //     null;
                                  //    } else {
                                  //       errMessage = err.message;
//      }

                                  //    ScaffoldMessenger.of(ctx).showSnackBar(
                                  //       SnackBar(
//          content: Text(errMessage),
                                  //         backgroundColor: Theme.of(ctx).errorColor,
                                  //      ),
                                  //    );
                                  // setState(() {
                                  //   _isLoading = false;
                                  //    });
                                  _showErrorDialog(errMessage);
                                  print(e);
                                });

                                // Navigator.of(context).pop();
                                // setState(() {
                                //   loading = false;
                                // });
                              },
                              child: const Text(
                                "موافق",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ));
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                verificationId = verificationId;
                print(verificationId);
                print("Timout");
              });
    } on HttpException catch (err) {
      var errMessage = 'فشل المحاولة';
      if (err.toString().contains('incorrect') ||
          err.toString().contains('format')) {
        errMessage = ' من فضلك قم بادخال رقم صحيح';
      } else if (err.toString().contains('TOO_LONG')) {
        errMessage = ' من فضلك قم بادخال رقم صحيح';
      } else {
        errMessage = 'فشل المحاولة .. الرجاء اعادة المحاولة لاحقا';
      }
      //     if (err.toString().isEmpty) {
      //     null;
      //    } else {
      //       errMessage = err.message;
//      }

      //    ScaffoldMessenger.of(ctx).showSnackBar(
      //       SnackBar(
//          content: Text(errMessage),
      //         backgroundColor: Theme.of(ctx).errorColor,
      //      ),
      //    );
      // setState(() {
      //   _isLoading = false;
      //    });
      _showErrorDialog(errMessage);
    } catch (err) {
      if (err.toString().isEmpty) {
        null;
      } else {
        final errMessage = err.toString();
        _showErrorDialog(errMessage);

        print(err);
      }
    }

    // Navigator.of(context).pop(false);
    // setState(() {
    //   loadingxx = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hightx = size.height;
    final widthx = size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: const Text('alaqy auth'),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           Navigator.of(context).pushReplacementNamed('/');
        //         },
        //         icon: const Icon(
        //           Icons.swap_horizontal_circle_sharp,
        //           size: 40,
        //         ))
        //   ],
        // ),
        body: Container(
          //  padding: const EdgeInsets.all(32),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: SizedBox(
                        //   height: 100,
                        //   width: double.infinity,
                        child: Image.asset(
                  'assets/alaqy.jpeg',
                  fit: BoxFit.contain,
                ))),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    widget.koke ? 'بحث عن الحساب ' : "إنشاء حساب",
                    style:
                        TextStyle(fontFamily: 'Tajawal', color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Center(
                  child: Text(
                    kids == 'null'
                        ? widget.accType == 'customer'
                            ? "عميل"
                            : 'بيزنس'
                        : kids == 'customer'
                            ? "عميل"
                            : 'بيزنس',
                    style:
                        TextStyle(fontFamily: 'Tajawal', color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        //    color: Colors.white,
                        width: widthx,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Card(
                                      color: kids == 'null'
                                          ? widget.accType != 'business'
                                              ? Color.fromARGB(226, 0, 0, 0)
                                              : Color.fromARGB(
                                                  35, 158, 158, 158)
                                          : kids != 'business'
                                              ? Color.fromARGB(226, 0, 0, 0)
                                              : Color.fromARGB(
                                                  35, 158, 158, 158),
                                      shadowColor:
                                          Color.fromARGB(79, 117, 117, 117),
                                      elevation: kids == 'null'
                                          ? widget.accType != 'business'
                                              ? 20
                                              : 0
                                          : kids != 'business'
                                              ? 20
                                              : 0,
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: kids == 'null'
                                                ? widget.accType != 'business'
                                                    ? 3
                                                    : 0
                                                : kids != 'business'
                                                    ? 3
                                                    : 0,
                                            horizontal: kids == 'null'
                                                ? widget.accType != 'business'
                                                    ? 1
                                                    : 0
                                                : kids != 'business'
                                                    ? 1
                                                    : 0,
                                          ),
                                          //width: 120,
                                          height: kids == 'null'
                                              ? widget.accType != 'business'
                                                  ? 65
                                                  : 37
                                              : kids != 'business'
                                                  ? 65
                                                  : 37,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                                bottomRight:
                                                    Radius.circular(4)),
                                            color: kids == 'null'
                                                ? widget.accType != 'business'
                                                    ? Color.fromARGB(
                                                        226, 0, 0, 0)
                                                    : Color.fromARGB(
                                                        35, 158, 158, 158)
                                                : kids != 'business'
                                                    ? Color.fromARGB(
                                                        226, 0, 0, 0)
                                                    : Color.fromARGB(
                                                        35, 158, 158, 158),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 2,
                                          ),
                                          child: Container(
                                              alignment: Alignment.center,
                                              //   width: 120,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4)),
                                                color: kids == 'null'
                                                    ? widget.accType !=
                                                            'business'
                                                        ? Color.fromARGB(
                                                            226, 0, 0, 0)
                                                        : Color.fromARGB(
                                                            34, 255, 255, 255)
                                                    : kids != 'business'
                                                        ? Color.fromARGB(
                                                            226, 0, 0, 0)
                                                        : Color.fromARGB(
                                                            34, 255, 255, 255),
                                              ),
                                              child: TextButton.icon(
                                                  label:
//  Text(
//                                               '🏬',
//                                               style: TextStyle(
//                                                   // textBaseline:
//                                                   //     TextBaseline.alphabetic,
//                                                   // height: -0.01,
//                                                   fontSize: 12,
//                                                   //   fontStyle: FontStyle.italic,
//                                                   fontWeight: (bus == true) ? FontWeight.normal : FontWeight.bold,
//                                                   shadows: [
//                                                     Shadow(
//                                                         blurRadius: bus == false
//                                                             ? 3
//                                                             : 0)
//                                                   ]),
//                                             ),
                                                      //   Icon(
                                                      //   bus == true
                                                      //     ? Icons.person_outline_rounded
                                                      //     : Icons.person,
                                                      // size: 27,
                                                      SizedBox(
                                                          // height: 100,
                                                          // width: double.infinity,
                                                          child: Image.asset(
                                                    'assets/alaqyzz.jpeg',
                                                    fit: BoxFit.contain,
                                                  )),
                                                  icon: Text(
                                                    ' حساب عميل',
                                                    style: TextStyle(
                                                        fontFamily: 'Tajawal',
                                                        color: kids == 'null'
                                                            ? widget.accType ==
                                                                    'business'
                                                                ? Color.fromARGB(
                                                                    184, 0, 0, 0)
                                                                : Colors.white
                                                            : kids == 'business'
                                                                ? Color
                                                                    .fromARGB(
                                                                        184,
                                                                        0,
                                                                        0,
                                                                        0)
                                                                : Colors.white,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic,
                                                        height: -0.01,
                                                        fontSize: 12,
                                                        //      fontStyle: FontStyle.italic,
                                                        fontWeight: kids ==
                                                                'null'
                                                            ? (widget.accType ==
                                                                    'business')
                                                                ? FontWeight
                                                                    .normal
                                                                : FontWeight
                                                                    .bold
                                                            : (kids ==
                                                                    'business')
                                                                ? FontWeight
                                                                    .normal
                                                                : FontWeight
                                                                    .bold,
                                                        shadows: [
                                                          Shadow(
                                                              blurRadius: kids ==
                                                                      'null'
                                                                  ? widget.accType !=
                                                                          'business'
                                                                      ? 3
                                                                      : 0
                                                                  : kids !=
                                                                          'business'
                                                                      ? 3
                                                                      : 0)
                                                        ]),
                                                  ),
                                                  //        textColor: Theme.of(context).primaryColor,
                                                  onPressed: () async {
                                                    setState(() {
                                                      kids = 'customer';
                                                    });
                                                    print('user');
                                                    if (FirebaseAuth.instance
                                                            .currentUser !=
                                                        null) {
                                                      final active = await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'customer_details')
                                                          .where('second_uid',
                                                              isEqualTo:
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                          .get();
                                                      final usid = active
                                                              .docs.isNotEmpty
                                                          ? active.docs.first.id
                                                          : 'none';
                                                      active.docs.isNotEmpty
                                                          ? FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'customer_details')
                                                              .doc(usid)
                                                              .update({
                                                              'activated': true
                                                            })
                                                          : null;
                                                    }

                                                    print(widget.accType);

                                                    //  Navigator.of(context).pushNamed(userChoose.routeName);
                                                  })))),
                                  //   const Text('او'),
                                  const SizedBox(width: 9),
                                  Card(
                                      color: kids == 'null'
                                          ? widget.accType == 'business'
                                              ? Color.fromARGB(226, 0, 0, 0)
                                              : Color.fromARGB(
                                                  35, 158, 158, 158)
                                          : kids == 'business'
                                              ? Color.fromARGB(226, 0, 0, 0)
                                              : Color.fromARGB(
                                                  35, 158, 158, 158),
                                      shadowColor:
                                          Color.fromARGB(79, 117, 117, 117),
                                      elevation: kids == 'null'
                                          ? widget.accType == 'business'
                                              ? 20
                                              : 0
                                          : kids == 'business'
                                              ? 20
                                              : 0,
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: kids == 'null'
                                                ? widget.accType == 'business'
                                                    ? 3
                                                    : 0
                                                : kids == 'business'
                                                    ? 3
                                                    : 0,
                                            horizontal: kids == 'null'
                                                ? widget.accType == 'business'
                                                    ? 1
                                                    : 0
                                                : kids == 'business'
                                                    ? 1
                                                    : 0,
                                          ),
                                          //width: 120,
                                          height: kids == 'null'
                                              ? widget.accType == 'business'
                                                  ? 65
                                                  : 37
                                              : kids == 'business'
                                                  ? 65
                                                  : 37,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                                bottomRight:
                                                    Radius.circular(4)),
                                            color: kids == 'null'
                                                ? widget.accType == 'business'
                                                    ? Color.fromARGB(
                                                        226, 0, 0, 0)
                                                    : Color.fromARGB(
                                                        35, 158, 158, 158)
                                                : kids == 'business'
                                                    ? Color.fromARGB(
                                                        226, 0, 0, 0)
                                                    : Color.fromARGB(
                                                        35, 158, 158, 158),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 2,
                                          ),
                                          child: Container(
                                              alignment: Alignment.center,
                                              //   width: 120,
                                              //      height: 500,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4)),
                                                color: kids == 'null'
                                                    ? widget.accType ==
                                                            'business'
                                                        ? Color.fromARGB(
                                                            226, 0, 0, 0)
                                                        : Color.fromARGB(
                                                            34, 255, 255, 255)
                                                    : kids == 'business'
                                                        ? Color.fromARGB(
                                                            226, 0, 0, 0)
                                                        : Color.fromARGB(
                                                            34, 255, 255, 255),
                                              ),
                                              child: TextButton.icon(
                                                style: ButtonStyle(
                                                  alignment: Alignment.center,
                                                ),
                                                label:
// Icon(
//                                             bus == false
//                                                 ? Icons
//                                                     .store_mall_directory_outlined //Icons.business_center_outlined
//                                                 : Icons.store_rounded,
//                                             color: Colors.redAccent,
//                                             size: 27,
//                                           ),
                                                    SizedBox(
                                                        // height: 100,
                                                        // width: 20,
                                                        child: Image.asset(
                                                  'assets/alaqyz.jpeg',
                                                  fit: BoxFit.contain,
                                                )),
                                                icon: Text(
                                                  'حساب بيزنس',
                                                  style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      color: kids == 'null'
                                                          ? widget.accType !=
                                                                  'business'
                                                              ? Color.fromARGB(
                                                                  184, 0, 0, 0)
                                                              : Colors.white
                                                          : kids != 'business'
                                                              ? Color.fromARGB(
                                                                  184, 0, 0, 0)
                                                              : Colors.white,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      height: -0.01,
                                                      fontSize: 12,
                                                      //   fontStyle: FontStyle.italic,
                                                      fontWeight: kids == 'null'
                                                          ? (widget.accType !=
                                                                  'business')
                                                              ? FontWeight
                                                                  .normal
                                                              : FontWeight.bold
                                                          : (kids != 'business')
                                                              ? FontWeight
                                                                  .normal
                                                              : FontWeight.bold,
                                                      shadows: [
                                                        Shadow(
                                                            blurRadius: kids ==
                                                                    'null'
                                                                ? widget.accType ==
                                                                        'business'
                                                                    ? 3
                                                                    : 0
                                                                : kids ==
                                                                        'business'
                                                                    ? 3
                                                                    : 0)
                                                      ]),
                                                ),
                                                //          textColor: Theme.of(context).primaryColor,
                                                onPressed: () {
                                                  // print(FirebaseAuth.instance.currentUser!.phoneNumber);
                                                  // print(FirebaseAuth.instance.currentUser!.uid);
                                                  // Navigator.of(context)
                                                  //     .pushNamed(businessChoose.routeName);
                                                  setState(() {
                                                    kids = 'business';
                                                  });
                                                  print(widget.accType);
                                                },
                                              )))),
                                ])))),
                // widget.accType == 'customer'
                //     ? AnimatedTextKit(
                //         animatedTexts: [
                //           ColorizeAnimatedText('register as user',
                //               colors: [
                //                 Colors.tealAccent,
                //                 Colors.redAccent,
                //                 Colors.cyanAccent,
                //               ],
                //               textStyle: const TextStyle(
                //                 fontSize: 23,
                //               ),
                //               textAlign: TextAlign.center,
                //               speed: const Duration(milliseconds: 100)),
                //         ],
                //         repeatForever: true,
                //       )
                //     : AnimatedTextKit(
                //         animatedTexts: [
                //           ColorizeAnimatedText('register as business ',
                //               colors: [
                //                 Colors.tealAccent,
                //                 Colors.deepPurple,
                //                 Colors.cyanAccent,
                //               ],
                //               textStyle: const TextStyle(
                //                 fontSize: 23,
                //               ),
                //               textAlign: TextAlign.center,
                //               speed: const Duration(milliseconds: 100)),
                //         ],
                //         repeatForever: true,
                //       ),

                // const Text(
                //   "Register",
                //   style: TextStyle(
                //       color: Colors.lightBlue,
                //       fontSize: 36,
                //       fontWeight: FontWeight.w500),
                // ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: widthx - 30,
                    child: TextFormField(
                      //   initialValue: _initValues['phone'],
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,

                      decoration: InputDecoration(
                        prefix: Text('+2'),

                        label: Center(
                            child: Text(
                          'رقم الموبايل',
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              color: Color.fromARGB(48, 0, 0, 0)),
                        )),
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
                      controller: _phoneController,
                      validator: (value) {
                        if (value != null) {
                          return (value.isEmpty || value.length < 4)
                              ? 'من فضلك أدخل رقم موبايل'
                              : null;
                        }
                      },
                    ),
                  ),
                ),
                // TextFormField(
                //   //   initialValue: _initValues['phone'],
                //   keyboardType: TextInputType.phone,
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
                const SizedBox(
                  height: 8,
                ),
                loadingxx == true
                    ? Center(
                        child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'رجاء الإنتظار',
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Tajawal',
                              color: Colors.amber,
                              overflow: TextOverflow.visible,
                            ),
                            speed: const Duration(milliseconds: 90),
                          )
                        ],
                        repeatForever: true,
                      ))
                    : SizedBox(),
                loading == true
                    ? const Center(
                        child: LinearProgressIndicator(
                        color: Colors.amber,
                        backgroundColor: Colors.white,
                      ))
                    : const SizedBox(),
                const SizedBox(
                  height: 8,
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: const BorderRadius.all(Radius.circular(8)),
                //           borderSide: BorderSide(color: Colors.grey.shade200)),
                //       focusedBorder: OutlineInputBorder(
                //           borderRadius: const BorderRadius.all(Radius.circular(8)),
                //           borderSide: BorderSide(color: Colors.grey.shade300)),
                //       filled: true,
                //       fillColor: Colors.grey.shade100,
                //       hintText: "Password"),
                //   controller: _passController,
                // ),
                Center(
                    child: Container(
                  alignment: Alignment.center,
                  width: widthx - 30,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Color.fromARGB(255, 253, 202, 0))),
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        FocusManager.instance.primaryFocus?.unfocus();
                        Future.delayed(const Duration(seconds: 2), (() {
                          print('xoxo');
                          print(_already);

                          need();
                          need2(context);
                          print(_already);

                          //  final mobile = _phoneController.text.trim();
                          final mobile =
                              _phoneController.text.trim().startsWith('+')
                                  ? _phoneController.text.trim()
                                  : '+2${_phoneController.text.trim()}';

                          _hold && widget.koke == false
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                      kids == 'null'
                                          ? widget.accType == 'customer'
                                              ? 'هذا الرقم  ينتمي ل حساب بيزنس'
                                              : 'هذا الرقم  ينتمي ل حساب عميل'
                                          : kids == 'customer'
                                              ? 'هذا الرقم  ينتمي ل حساب بيزنس'
                                              : 'هذا الرقم  ينتمي ل حساب عميل',
                                    ),
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                  ),
                                )
                              : _already && widget.koke == false
                                  ? already_registered(context)
                                  : registerUser(mobile, context);
                          setState(() {
                            loading = false;
                          });
                        }));
                      },
                      child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'تأكيد',
                              style: TextStyle(
                                  fontFamily: 'Tajawal', color: Colors.black),
                              //  style: TextStyle(color: Colors.black),
                            ),
                          ))),
                )),
                // Container(
                //   width: double.infinity,
                //   child: TextButton(
                //     onPressed: () {
                //       setState(() {
                //         loading = true;
                //       });
                //       Future.delayed(const Duration(seconds: 2), (() {
                //         print('xoxo');
                //         print(_already);

                //         need();
                //         need2(context);
                //         print(_already);

                //         final mobile = _phoneController.text.trim();
                //         _already && widget.koke == false
                //             ? already_registered(context)
                //             : registerUser(mobile, context);
                //       }));
                //     },
                //     child: const Text(
                //       "submit",
                //       style: TextStyle(color: Colors.blue),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                    child: Container(
                  alignment: Alignment.center,
                  width: widthx - 30,
                  child: TextButton(
                    //            textColor: Theme.of(context).primaryColor, LoginScreen('customer')
                    child: Text(
                      !widget.koke ? ' بالفعل لدي حساب ؟' : "الرجوع",
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 59, 53, 53)),
                    ),
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      widget.accType == 'business'
                          ? Navigator.of(context)
                              .pushReplacementNamed(MyHomePagee.routeName)
                          : Navigator.of(context).pushReplacementNamed('/');
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => widget.accType == 'customer'
                      //             ? AuthScreenUser(_phoneController.text,
                      //                 'result.user!.uid', false, false)
                      //             : AuthScreenBusiness(_phoneController.text,
                      //                 'result.user!.uid', false, '')));
                    },
                  ),
                )),
                // Container(
                //   color: Colors.grey.shade100,
                //   width: double.infinity,
                //   child: TextButton(
                //     onPressed: () {
                //       setState(() {
                //         loading = true;
                //       });
                //       Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => widget.accType == 'customer'
                //                   ? AuthScreenUser(_phoneController.text,
                //                       'result.user!.uid', false, false)
                //                   : AuthScreenBusiness(_phoneController.text,
                //                       'result.user!.uid', false, '')));
                //     },
                //     child:
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
                    need();
                    //   need2();
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
                      speed: const Duration(milliseconds: 100),
                    )
                  ],
                  // totalRepeatCount: 2,
                  repeatForever: true,
                  onNext: (p0, p1) {
                    // _phoneController.text.trim() == ''
                    //     ? setState(() {
                    //         _phoneController.text = '+20';
                    //       })
                    //     : null;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
