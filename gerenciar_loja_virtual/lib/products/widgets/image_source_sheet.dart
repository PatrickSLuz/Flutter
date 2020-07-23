import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final _piker = ImagePicker();

  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            child: Text("Câmera"),
            onPressed: () async {
              PickedFile img = await _piker.getImage(
                source: ImageSource.camera,
              );
              imageSelected(File(img.path));
            },
          ),
          FlatButton(
            child: Text("Galeria"),
            onPressed: () async {
              PickedFile img = await _piker.getImage(
                source: ImageSource.gallery,
              );
              imageSelected(File(img.path));
            },
          ),
        ],
      ),
    );
  }

  void imageSelected(File img) async {
    if (img != null) {
      File croppedImg = await ImageCropper.cropImage(
        sourcePath: img.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      );
      onImageSelected(croppedImg);
    }
  }
}
