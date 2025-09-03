import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Save the picked image to app documents directory
Future<String> saveLocally(XFile img) async {
  final directory = await getApplicationDocumentsDirectory();
  final String fileName = basename(img.path);
  final String localPath = '${directory.path}/$fileName';
  final File localImage = await File(img.path).copy(localPath);
  return localImage.path; // ✅ return saved path
}

/// Pick image from gallery
Future<String?> _pickImageFromGallery() async {
  final returnedImage =
  await ImagePicker().pickImage(source: ImageSource.gallery);
  if (returnedImage != null) {
    return await saveLocally(returnedImage);
  }
  return null;
}

/// Pick image from camera
Future<String?> _pickImageFromCamera() async {
  final returnedImage =
  await ImagePicker().pickImage(source: ImageSource.camera);
  if (returnedImage != null) {
    return await saveLocally(returnedImage);
  }
  return null;
}

/// Show bottom sheet and return the selected image path
Future<String?> imageSheet(BuildContext context) async {
  return await showModalBottomSheet<String>(
    context: context,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF454545),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () async {
                  final path = await _pickImageFromGallery();
                  Navigator.pop(context, path); // ✅ return image path
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: const ListTile(
                  leading: Icon(CupertinoIcons.photo, color: Colors.white),
                  title: Text(
                    'Gallery',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(height: 1, color: Colors.white24),
              TextButton(
                onPressed: () async {
                  final path = await _pickImageFromCamera();
                  Navigator.pop(context, path); // ✅ return image path
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: const ListTile(
                  leading: Icon(CupertinoIcons.camera, color: Colors.white),
                  title: Text(
                    'Camera',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
