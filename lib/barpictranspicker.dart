import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Barpictranspicker extends StatefulWidget {
  Barpictranspicker(
    this.imagePickFn,
  );
  final void Function(File? pickedImage) imagePickFn;

  @override
  _BarpictranspickerState createState() => _BarpictranspickerState();
}

class _BarpictranspickerState extends State<Barpictranspicker> {
  File? _pickedImage;

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

    // final pickedImage = await ImagesPicker.pick(quality: 0.5);

    // File? pickedImageFile;
    // pickedImage != null ? pickedImageFile = File(pickedImage.first.path) : null;

    // setState(() {
    //   pickedImage != null ? _pickedImage = pickedImageFile : null;
    // });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImagex() async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    File? pickedImageFile;
    pickedImage != null ? pickedImageFile = File(pickedImage.path) : null;

    setState(() {
      pickedImage != null ? _pickedImage = pickedImageFile : null;
    });
    widget.imagePickFn(pickedImageFile);
    //   setState(() {
    //     _pickedImage = pickedImageFile;
    //   });
    //   widget.imagePickFn(pickedImageFile);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      IconButton(
        onPressed: _pickImage,
        icon: const Icon(Icons.image),
        color: Color.fromARGB(255, 255, 168, 7),
      ),
      IconButton(
        icon: const Icon(Icons.camera_alt_rounded),
        color: Color.fromARGB(255, 255, 168, 7),
        onPressed: _pickImagex,
      ),
    ]));
  }
}
