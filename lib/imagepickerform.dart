import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserImagePickerForm extends StatefulWidget {
  static const routeName = '/UserImagePicker';
  final void Function(dynamic pickedImage) imagePickFn;
  final dynamic pik;
  final bool click;
  const UserImagePickerForm(this.imagePickFn, this.pik, this.click);

  @override
  _UserImagePickerFormState createState() => _UserImagePickerFormState();
}

class _UserImagePickerFormState extends State<UserImagePickerForm> {
  dynamic _pickedImage;
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  Permission? _permission;
  void checkServiceStatus(
      BuildContext context, PermissionWithService permission) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text((await permission.serviceStatus).toString()),
    ));
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }

  void _pickImage() async {
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

    // final pickedImages = await ImagesPicker.pick(quality: 0.5);

    // dynamic pickedImageFile;
    // pickedImages != null
    //     ? pickedImageFile = File(pickedImages.first.path)
    //     : null;

    // setState(() {
    //   pickedImages != null ? _pickedImage = pickedImageFile : null;
    // });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImagex() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      // final pickedImageFile = await ImagePicker.platform.pickImage(
//.pickImage(

      source: ImageSource.camera,
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

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Text(
        'إرفاق صورة للمنتج المراد',
        style: TextStyle(
            fontFamily: 'Tajawal', color: Color.fromARGB(48, 0, 0, 0)),
      ),
      Container(
        width: 100,
        height: 100,
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
          child: _pickedImage == null
              ? widget.pik == null
                  ? const SizedBox()
                  : widget.pik !=
                          'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
                      ? Image.network(
                          widget.pik,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          'assets/alaqyp.jpeg',
                          fit: BoxFit.contain,
                        )
              : _pickedImage !=
                      'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image%2FHI7A9RLmLTVnUn4UxqjAM92Gcwc2.jpg?alt=media&token=a4b20826-9003-4538-b1a5-41b3b1245169'
                  ? Image.file(
                      _pickedImage,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      'assets/alaqyp.jpeg',
                      fit: BoxFit.contain,
                    ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          top: 3,
          right: 35,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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

              TextButton.icon(
                  label: Icon(
                    Icons.image,
                    color: Color.fromARGB(255, 253, 202, 0),
                  ),
                  icon: Text(
                    'معرض الصور',
                    style: TextStyle(color: Colors.black26, fontSize: 8),
                  ),
                  onPressed: () {
                    // widget.click == true
                    //     ? null
                    //     : checkServiceStatus(
                    //         context, _permission as PermissionWithService);
                    // widget.click == true
                    //     ? null
                    //     : requestPermission(_permission!);
                    widget.click == true ? null : _pickImage();
                  },
                  style: ButtonStyle(alignment: Alignment.centerLeft)),
              // SizedBox(
              //   width: 30,
              // ),
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
              // SizedBox(
              //   width: 30,
              // ),
            ]),
      )
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
