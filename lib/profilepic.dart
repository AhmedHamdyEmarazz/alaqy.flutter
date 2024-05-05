import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class profilepic extends StatefulWidget {
  static const routeName = '/profilepic';
  final void Function(dynamic pickedImage) imagePickFn;
  final dynamic pik;
  final bool click;
  const profilepic(this.imagePickFn, this.pik, this.click);

  @override
  _profilepicState createState() => _profilepicState();
}

class _profilepicState extends State<profilepic> {
  dynamic _pickedImage;

  void _pickImage() async {
//     final pickedImage = await ImagesPicker.pick(quality: 0.5);
// // await picker.pickImage(
// //            source: ImageSource.gallery,
// //       imageQuality: 40,
// //     );
//     dynamic pickedImageFile;
//     pickedImage != null ? pickedImageFile = File(pickedImage.first.path) : null;

//     setState(() {
//       pickedImage != null ? _pickedImage = pickedImageFile : null;
//     });
//     widget.imagePickFn(pickedImageFile);
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(
      // final pickedImageFile = await ImagePicker.platform.pickImage(
//.pickImage(

      source: ImageSource.gallery,
      imageQuality: 40,
      //   maxWidth: 150,
    );
    dynamic pickedImageFile;
    pickedImage != null ? pickedImageFile = File(pickedImage.path) : null;

    setState(() {
      pickedImage != null ? _pickedImage = pickedImageFile : null;
    });
    widget.imagePickFn(pickedImageFile);
  }

  void _pickImagex() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    dynamic pickedImageFile;
    pickedImage != null ? pickedImageFile = File(pickedImage.path) : null;

    setState(() {
      pickedImage != null ? _pickedImage = pickedImageFile : null;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Text(
        'ارفاق صورة !',
        style: TextStyle(
            fontFamily: 'Tajawal', color: Color.fromARGB(48, 0, 0, 0)),
      ),
      (_pickedImage ==
                      'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169' ||
                  _pickedImage == null ||
                  _pickedImage == 'asset') &&
              (widget.pik ==
                      'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169' ||
                  widget.pik == null ||
                  widget.pik == 'asset')
          ? SizedBox(
              height: 100,
              width: 100,
              child: ClipOval(
                  child: Image.asset(
                'assets/alaqyw.jpeg',
                fit: BoxFit.contain,
              )))
          : SizedBox(
              height: 100,
              width: 100,
              child: ClipOval(
                child: _pickedImage == null
                    ? widget.pik == null
                        ? Image.asset(
                            'assetsw/alaqy.jpeg',
                            fit: BoxFit.contain,
                          )
                        : Image.network(
                            widget.pik,
                            fit: BoxFit.contain,
                          )
                    : Image.file(
                        _pickedImage,
                        fit: BoxFit.contain,
                      ),
              )),
      // CircleAvatar(
      //     radius: 40,
      //     backgroundColor: Colors.grey,
      //     backgroundImage: _pickedImage == null
      //         ? widget.pik == null
      //             ? FileImage('assets/alaqy.jpeg' as File)
      //             : FileImage(widget.pik as File)
      //         : FileImage(_pickedImage as File)
      //     ,  child: _pickedImage == null
      //           ? widget.pik == null
      //               ? Image.asset(
      //                   'assets/alaqy.jpeg',
      //                   fit: BoxFit.contain,
      //                 )
      //               : Image.network(widget.pik,
      //                   fit: BoxFit.contain, )
      //           : Image.file(
      //               _pickedImage,
      //               fit: BoxFit.contain,
      //             ),
      //     ),
//       Container(
//         width: 100,
//         height: 100,
//         margin: const EdgeInsets.only(
//           top: 8,
//           right: 10,
//         ),
//         decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black12
// //  borderRadius: BorderRadius.all(Radius.circular(12))
//             // border: Border.all(
//             //   width: 1,
//             //   color: Colors.grey,
//             // ),
//             ),
//         child: FittedBox(
//           child: _pickedImage == null
//               ? widget.pik == null
//                   ? const SizedBox()
//                   : Image.network(
//                       widget.pik,
//                       fit: BoxFit.fill,
//                     )
      // : Image.file(
      //     _pickedImage,
      //     fit: BoxFit.fill,
      //   ),
//         ),
//       ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
        // IconButton(
        //   color: Colors.blue, // Color.fromARGB(255, 253, 202, 0),
        //   onPressed: widget.click == true ? null : _pickImage,
        //   icon: const Icon(
        //     Icons.image,
        //     color: Color.fromARGB(255, 253, 202, 0),
        //   ),
        //   // label: const Text('Add Logo'),
        // ),
        // IconButton(
        //   color: Colors.blue, // Color.fromARGB(255, 253, 202, 0),
        //   onPressed: widget.click == true
        //       ? null
        //       :
        //       _pickImagex,

        //   icon: const Icon(
        //     Icons.camera_alt,
        //     color: Color.fromARGB(255, 253, 202, 0),
        //   ),
        //   // label: const Text('Add Logo'),
        // ),
        SizedBox(
          width: 5,
        ),
        TextButton.icon(
            label: Icon(
              Icons.image,
              color: Color.fromARGB(255, 253, 202, 0),
            ),
            icon: Text(
              'معرض الصور',
              style: TextStyle(color: Colors.black26, fontSize: 8),
            ),
            onPressed: widget.click == true ? null : _pickImage,
            style: ButtonStyle(alignment: Alignment.centerLeft)),
        SizedBox(
          width: 30,
        ),
        TextButton.icon(
            icon: Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 253, 202, 0),
            ),
            label: Text(
              'كاميرا',
              style: TextStyle(color: Colors.black26, fontSize: 8),
            ),
            onPressed: widget.click == true ? null : _pickImagex,
            style: ButtonStyle(alignment: Alignment.centerLeft)),
        SizedBox(
          width: 30,
        ),
      ]),
    ]);
  }
}

//  Container(
//                                         width: 100,
//                                         height: 100,
//                                         margin: EdgeInsets.only(
//                                           top: 8,
//                                           right: 10,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             width: 1,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         child: _imageUrlController.text.isEmpty
//                                             ? Text('Enter a URL')
//                                             : FittedBox(
//                                                 child: Image.network(
//                                                   _imageUrlController.text,
//                                                   fit: BoxFit.fill,
//                                                 ),
//                                               ),
//                                       ),

//  CircleAvatar(
//           radius: 40,
//           backgroundColor: Colors.grey,
//           backgroundImage:
//               _pickedImage != null ? FileImage(_pickedImage as File) : null,
//         ),
