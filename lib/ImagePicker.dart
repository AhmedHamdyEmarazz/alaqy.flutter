import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:path_provider/path_provider.dart';

class UserImagePicker extends StatefulWidget {
  static const routeName = '/UserImagePicker';

  const UserImagePicker(this.imagePickFn);

  final void Function(File? pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  File? focusz;
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    setState(() async {
      focusz = file;
    });
    return file;
  }

  void _pickImage() async {
    // File focusz = await getImageFileFromAssets('assets/alaqyw.jpeg');
    final picker = ImagePicker();
    final pickedImage = await ImagesPicker.pick(quality: 0.5);
// await picker.pickImage(
//            source: ImageSource.gallery,
//       imageQuality: 40,
//     );
    dynamic pickedImageFile;
    pickedImage != null ? pickedImageFile = File(pickedImage.first.path) : null;

    setState(() {
      pickedImage != null ? _pickedImage = pickedImageFile : null;
    });
    widget.imagePickFn(pickedImageFile);
//     final pickedImage = await picker.getImage(
//       // final pickedImageFile = await ImagePicker.platform.pickImage(
// //.pickImage(

//       source: ImageSource.gallery,
//       imageQuality: 40,
//       //   maxWidth: 150,
//     );
//     File? pickedImageFile;
//     pickedImage != null ? pickedImageFile = File(pickedImage.path) : null;

//     setState(() {
//       pickedImage != null ? _pickedImage = pickedImageFile : null;
//     });
//     widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    getImageFileFromAssets('alaqyw.jpeg');

    return Column(
      children: <Widget>[
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
            totalRepeatCount: 3,
            //  repeatForever: true,
            onNext: (p0, p1) {
              setState(() {
                getImageFileFromAssets('alaqyw.jpeg');
              });
            }),
//         CircleAvatar(
//             radius: 40,
//             backgroundColor: Colors.grey,
//             backgroundImage:
//                 _pickedImage != null ? FileImage(_pickedImage as File) : null
// //Image.file(await getImageFileFromAssets('assets/alaqyw.jpeg')),
//             ),
        focusz != null
            ? CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage: _pickedImage != null
                    ? FileImage(_pickedImage as File)
                    : FileImage(focusz as File)
//Image.file(await getImageFileFromAssets('assets/alaqyw.jpeg')),
                )
            : SizedBox(),
        TextButton(
          //     textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          //  icon: const Icon(Icons.image),
          child: const Text(
            'اضافة صورة',
            style: TextStyle(
                fontFamily: 'Tajawal', color: Color.fromARGB(48, 0, 0, 0)),
          ),
        ),
      ],
    );
  }
}
