import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectimage;
  ImageInput(this.onSelectimage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takepicture() async {
    final picker = ImagePicker();
    final imagefile = await picker.pickImage(source: ImageSource.camera);
    if (imagefile == null) return;
    setState(() {
      _storedImage = File(imagefile.path);
    });
    final appdrr = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(imagefile.path);
    final savedimage = await File(
      imagefile.path,
    ).copy('${appdrr.path}/$filename');
    widget.onSelectimage(savedimage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('No image', textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takepicture,
            label: Text('open camera'),
            icon: Icon(Icons.camera),
          ),
        ),
      ],
    );
  }
}
