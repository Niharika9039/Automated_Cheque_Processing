import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> predictImage(File imageFile) async {
  var url = Uri.parse('https://3f02-34-86-3-98.ngrok.io/image');

  var request = http.MultipartRequest('POST', url,);
  request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  var response = await request.send();
  if (response.statusCode == 200) {
    // return "Hi";
    var responseBody = await response.stream.bytesToString();
    // log(1);
    var json = jsonDecode(responseBody);
    return json['result'];
  } else {
    return "null";
  }

}


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedImagePath = '';
  String predictedClass = '';

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImagePath = pickedFile!.path;
      predictedClass = '';
    });
  }

  Future<void> _predictImage() async {
    if (selectedImagePath != '') {
      var imageFile = File(selectedImagePath);
      var result = await predictImage(imageFile);
      setState(() {
        predictedClass = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedImagePath == ''
                ? Image.asset(
              'assets/image_placeholder.png',
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            )
                : Image.file(
              File(selectedImagePath),
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
            Text(
              'Select Image',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 20),
                ),
              ),
              onPressed: _selectImage,
              child: Text('Select Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 20),
                ),
              ),
              onPressed: _predictImage,
              child: Text('Predict'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Prediction Result: $predictedClass',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future selectImage() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Select Image From !',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          selectedImagePath =
                          await selectImageFromGallery();
                          if (selectedImagePath != '') {
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("No Image Selected !"),
                              ),
                            );
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/gallery.png',
                                  height: 60,
                                  width: 60,
                                ),
                                Text('Gallery'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          selectedImagePath = await selectImageFromCamera();
                          if (selectedImagePath != '') {
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("No Image Captured !"),
                              ),
                            );
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/camera.png',
                                  height: 60,
                                  width: 60,
                                ),
                                Text('Camera'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }


  saveImage(String path) async {
    final bytes = await File(path).readAsBytes();
    await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
  }


  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
