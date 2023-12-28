import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nil/nil.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({
    required Key key,
    this.text = '',
    this.onTab,
    this.imageFile,
  }) : super(key: key);

  final String text;
  final Function? onTab;
  final XFile? imageFile;
  @override
  Widget build(BuildContext context) {
    File? file;
    if (imageFile != null) {
      file = File(imageFile!.path);
    }
    return GestureDetector(
      onTap: (){
        onTab!();
      },
      child: Container(
        height: MediaQuery.of(context).size.width * 0.25,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          image: imageFile != null
              ? DecorationImage(image: FileImage(file!), fit: BoxFit.cover)
              : null,
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: imageFile == null
            ? Icon(
                CupertinoIcons.cloud_upload,
                color: Colors.grey,
              )
            : nil,
      ),
    );
  }
}
