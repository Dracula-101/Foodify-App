import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodify/constants/key.dart';
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
  bool isError = false;
  bool isTakingTime = false;
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
      isLoaded = !isLoaded;
      isSearching = !isSearching;
    });
  }

  startTimer() {
    Timer(const Duration(seconds: 30), () {
      setState(() {
        // isLoaded = false;
        isError = !isError;
      });
    });
  }

  takeTime() {
    Timer(const Duration(seconds: 5), () {
      setState(() {
        // isLoaded = false;
        isTakingTime = !isTakingTime;
      });
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
              : isSearching && !isError
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      //cancel button
                      if (isTakingTime)
                        (InkWell(
                          onTap: () {
                            setState(() {
                              isLoaded = !isLoaded;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: FittedBox(
                                child: Row(
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
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
              : ListView(
                  shrinkWrap: true,
                  children: [
                    const Padding(
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
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Try taking picture of these food items',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(
                        classes.join(', '),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
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
                    startTimer();
                    takeTime();
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
                startTimer();
                takeTime();
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
