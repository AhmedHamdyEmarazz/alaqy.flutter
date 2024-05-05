import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/material.dart';

class koshkbuild extends StatefulWidget {
  static const routeName = '/koshkbuild';

  final String title;
  final String imageurl;
  final String description;
  final String link;
  const koshkbuild(this.title, this.imageurl, this.description, this.link,
      {super.key});
  @override
  koshkbuildState createState() => koshkbuildState();
}

class koshkbuildState extends State<koshkbuild> {
  final userx = FirebaseAuth.instance.currentUser!.uid;
  int badgoo = 0;
  String? mtoken = '';
  final fbm = FirebaseMessaging.instance;
  String? stop;
  bool stopp = false;
  bool slip = true;

  int iz = 0;

  dynamic turtlezz;
  dynamic titlemega;
  dynamic bodymega;
  dynamic busid2;
  dynamic username;
  dynamic store_name;
  dynamic busid;
  dynamic cusid;
  dynamic basicstore_name;
  dynamic basicusername;
  final _transformationController = TransformationController();

  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hightx = size.height;
    final userid = FirebaseAuth.instance.currentUser!.uid;

    return
// Center(
//       child: Text('koshkbuild from alaqy process'),
//     );
        GestureDetector(
            onTap: () {
              widget.imageurl == 'asset' ||
                      widget.imageurl ==
                          'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
                  ? null
                  : Navigator.of(context).pushReplacement(MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => GestureDetector(
                          onDoubleTapDown: _handleDoubleTapDown,
                          onDoubleTap: _handleDoubleTap,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                              child: InteractiveViewer(
                                  transformationController:
                                      _transformationController,
                                  child: Container(
                                      child: Image.network(
                                    widget.imageurl,
                                    fit: BoxFit.contain,
                                  )))))));
            },
            child: Container(
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
                    color: Color.fromARGB(255, 252, 250, 250),
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
                          width: 250,
                          height: 200,
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
                          child: Container(
                              height: 202,
                              width: 252,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 6,
                                    color: Colors.grey.shade300,
                                    strokeAlign: BorderSide.strokeAlignOutside),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Container(
                                height: 200,
                                width: 250,
                                child: widget.imageurl == 'asset' ||
                                        widget.imageurl ==
                                            'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
                                    ? Image.asset(
                                        'assets/alaqyp.jpeg',
                                        fit: BoxFit.contain,
                                      )
                                    : Image.network(
                                        widget
                                            .imageurl, //                                        loadedProduct.imageUrlxxxxxxxx,
                                        fit: BoxFit.fill,
                                      ),
                              ))),
                      Container(
                          width: 250,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                                color: Color.fromARGB(255, 252, 250, 250),
                                strokeAlign: BorderSide.strokeAlignOutside),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: SizedBox()),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 250,
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                              color: Colors.black),
                          //      )
                        ),
                      ),
                    ]))));
  }
}
