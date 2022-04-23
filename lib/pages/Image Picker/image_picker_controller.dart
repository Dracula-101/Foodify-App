import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  var images = <XFile>[].obs;
  ImagePicker _picker = ImagePicker();

  getImage(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 112,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: Colors.amberAccent,
                  ),
                  title: const Text('Take a photo'),
                  onTap: () async {
                    final image =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      images.add(image);
                      update();
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library,
                      color: Colors.amberAccent),
                  title: const Text('Pick from gallery'),
                  onTap: () async {
                    final image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      images.add(image);
                      update();
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  deleteImage(int index){
    images.removeAt(index);
    update();
  }
}
