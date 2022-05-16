import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodify/loading/loader.dart';
import 'package:foodify/models/image_analysis.api.dart';
import 'package:foodify/models/image_analysis.dart';
import 'package:foodify/views/widgets/image_analysis_widget.dart';
import 'package:image_picker/image_picker.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isLoaded = false;
  bool isSearching = false;
  String? link;
  XFile? image;
  ImageAnalysis? imageAnalysis;

  Future<String> uploadFile(XFile _image) async {
    var link;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("Image: " + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(_image.path));
    await uploadTask.then((res) async {
      link = await res.ref.getDownloadURL();
      print('link op is ' + link);
      await getImageAnalysis(link);
      return link;
    });
    return '';
  }

  getImageAnalysis(String link) async {
    imageAnalysis = await ImageAnalysisAPI.getAnalysis(link);
    setState(() {
      isLoaded = true;
      isSearching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log('sett rebuild');
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                if (isLoaded)
                  (InkWell(
                    onTap: () {
                      setState(() {
                        isLoaded = false;
                      });
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Icon(
                        FontAwesomeIcons.arrowRotateLeft,
                        color: Colors.black54,
                        size: 35,
                      ),
                    ),
                  )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          !isLoaded && !isSearching
              ? displayCamera()
              : isSearching
                  ? Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Loader(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Searching for food',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'May take a while...',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ])
                  : displayImage(),
        ],
      ),
    );
  }

  SizedBox displayImage() {
    return SizedBox(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 5.0, // has the effect of extending the shadow
                )
              ],
              image: DecorationImage(
                image: FileImage(
                  File(
                    image!.path,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          imageAnalysis != null
              ? ImageAnalysisWidget(
                  imageAnalysis: imageAnalysis!,
                )
              : const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'No recipes found',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  FutureBuilder<void> displayCamera() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildCamera();
        } else {
          return Center(child: Loader());
        }
      },
    );
  }

  Column buildCamera() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                // padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 7, color: Colors.amber),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4.0,
                      spreadRadius: 4.0,
                    )
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    clipBehavior: Clip.hardEdge,
                    child: CameraPreview(_controller))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                    getImage();
                  },
                  child: const Text("Add From Gallery")),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (!isLoaded)
          Container(
            padding: const EdgeInsets.all(15.0),
            // margin: const EdgeInsets.symmetric(horizontal: 60),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isSearching = true;
                });
                try {
                  await _initializeControllerFuture;
                  image = await _controller.takePicture();
                  print("Image Uploading");
                  link = await uploadFile(image!);
                } catch (e) {
                  print(e);
                }
              },
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Take Picture",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.imagePortrait,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          )
        //button to trye again
      ],
    );
  }

  void getImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      isSearching = true;
    });
    if (image != null) {
      link = await uploadFile(image!);
      // getImageAnalysis(link!);
    }
  }
}
