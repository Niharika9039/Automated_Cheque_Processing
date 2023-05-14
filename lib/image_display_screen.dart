import 'dart:io';
import 'package:flutter/material.dart';
import 'image_repository.dart';

class ImageDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ImageRepository imageRepository = ImageRepository();
    final File? selectedImage = imageRepository.getSelectedImage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Display'),
      ),
      body: Center(
        child: selectedImage != null
            ? Image.file(selectedImage)
            : Text('No image selected'),
      ),
    );
  }
}
