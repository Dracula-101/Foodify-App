// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:foodify/constants/key.dart';
// import 'package:foodify/models/recipe.dart';
// import 'package:foodify/pages/ImageCapture/TakePictureScreen.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:foodify/views/widgets/recipeSearch_card.dart';
// import 'package:foodify/views/widgets/scrolling_parallax.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
//
// class Settings extends StatefulWidget {
//   const Settings({Key? key}) : super(key: key);
//
//   @override
//   State<Settings> createState() => _SettingsState();
// }
//
// class _SettingsState extends State<Settings> {
//   List<CameraDescription>? cameras;
//   bool isLoaded = false;
//   @override
//   void initState() {
//     super.initState();
//     // getCuisine('buter chicken');
//     WidgetsFlutterBinding.ensureInitialized();
//     // Obtain a list of the available cameras on the device.
//     loadCameras().then((value) {
//       setState(() {
//         isLoaded = true;
//       });
//     });
//   }
//
//   Future<void> loadCameras() async {
//     cameras = await availableCameras();
//   }
//
//   static Future<void> getCuisine(String title) async {
//     String API_KEY = "664e310b980b4b82bbd717d835edf3fd";
//     final uri = Uri.parse(
//         'https://api.spoonacular.com/recipes/cuisine?apiKey=$API_KEY');
//     final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
//     Map<String, String> body = {
//       '0': 't',
//       '1': 'i',
//       '2': 't',
//       '3': 'l',
//       '4': 'e',
//       '5': '='
//     };
//     for (int i = 0; i < title.length; i++) {
//       body.putIfAbsent((i + 6).toString(), () => title[i]);
//     }
//     print(body);
//     String jsonBody = json.encode(body);
//     final encoding = Encoding.getByName('utf-8');
//
//     http.Response response = await http.post(
//       uri,
//       headers: headers,
//       body: jsonBody,
//       encoding: encoding,
//     );
//
//     int statusCode = response.statusCode;
//     if (statusCode == 200) {
//       print(response.body);
//     } else {
//       print(response.body);
//     }
//     String responseBody = response.body;
//     print(responseBody);
//     // final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
//   }
//
//   TextEditingController controller = TextEditingController();
//   List<String> list = [
//     "Chicken soup",
//     "Paneer tikka",
//     "Chicken tikka",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return !isLoaded
//         ? const CupertinoActivityIndicator()
//         : CameraScreen(cameras: cameras!);
//     // return Column(
//     //   mainAxisAlignment: MainAxisAlignment.start,
//     //   crossAxisAlignment: CrossAxisAlignment.center,
//     //   children: [
//     //     Padding(
//     //       padding: const EdgeInsets.symmetric(vertical: 10.0),
//     //       child: Container(
//     //         height: size.height * 0.08,
//     //         width: size.width * 0.8,
//     //         decoration: BoxDecoration(
//     //           color: Colors.grey[500]!.withOpacity(0.5),
//     //           borderRadius: BorderRadius.circular(16),
//     //         ),
//     //         child: Center(
//     //           child: TextField(
//     //             decoration: const InputDecoration(
//     //               border: InputBorder.none,
//     //               prefixIcon: Padding(
//     //                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//     //                 child: Icon(
//     //                   FontAwesomeIcons.envelope,
//     //                   size: 27,
//     //                   color: Colors.white,
//     //                 ),
//     //               ),
//     //               hintText: 'Enter Your Dish name',
//     //               hintStyle: TextStyle(
//     //                   fontSize: 21, color: Colors.white54, height: 1.5),
//     //             ),
//     //             style: const TextStyle(
//     //                 fontSize: 21, color: Colors.white, height: 1.5),
//     //             keyboardType: TextInputType.emailAddress,
//     //             textInputAction: TextInputAction.next,
//     //             onSubmitted: (text) {
//     //               if (text == '') return;
//     //             },
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //   ],
//     // );
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //       backgroundColor: Colors.white,
//   //       body: Column(
//   //         children: [
//   //           GFSearchBar(
//   //             controller: controller,
//   //             searchList: list,
//   //             searchQueryBuilder: (query, list) {
//   //               return list
//   //                   .where((item) => item
//   //                       .toString()
//   //                       .toLowerCase()
//   //                       .contains(query.toLowerCase()))
//   //                   .toList();
//   //             },
//   //             noItemsFoundWidget: Container(),
//   //             overlaySearchListHeight: 200,
//   //             searchBoxInputDecoration: InputDecoration(
//   //               hintText: "Search Videos",
//   //               hintStyle: const TextStyle(color: Colors.white),
//   //               suffixIcon: IconButton(
//   //                 icon: const Icon(
//   //                   Icons.search,
//   //                   color: Colors.amberAccent,
//   //                 ),
//   //                 onPressed: () async {
//   //                   // getVideos();
//   //                   list.add(controller.text);
//   //                   setState(() {
//   //                     // _isSearched = true;
//   //                   });
//   //                 },
//   //               ),
//   //             ),
//   //             overlaySearchListItemBuilder: (item) {
//   //               return Container(
//   //                 padding: const EdgeInsets.all(8),
//   //                 child: Text(
//   //                   item.toString(),
//   //                   style: const TextStyle(fontSize: 18),
//   //                 ),
//   //               );
//   //             },
//   //             onItemSelected: (item) {
//   //               setState(() {
//   //                 print('$item');
//   //               });
//   //             },
//   //           ),
//   //           Column(
//   //             children: [
//   //               SizedBox(
//   //                 height: 100,
//   //               ),
//   //               Container(
//   //                 width: 300,
//   //                 height: 300,
//   //                 margin: const EdgeInsets.all(10),
//   //                 padding: const EdgeInsets.all(10),
//   //                 decoration: BoxDecoration(
//   //                     image: const DecorationImage(
//   //                       image: AssetImage("assets/images/videofinder.png"),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                     borderRadius: BorderRadius.all(Radius.circular(90)),
//   //                     boxShadow: [
//   //                       BoxShadow(
//   //                         color: Colors.grey.withOpacity(0.5),
//   //                         spreadRadius: 5,
//   //                         blurRadius: 7,
//   //                         offset: Offset(0, 3), // changes position of shadow
//   //                       )
//   //                     ]),
//   //               ),
//   //             ],
//   //           )
//   //           // _isSearched
//   //           //     ? Container(
//   //           //         margin: const EdgeInsets.all(10),
//   //           //         padding: const EdgeInsets.all(10),
//   //           //         child: Image.asset(
//   //           //           'assets/images/videofinder.png',
//   //           //           fit: BoxFit.cover,
//   //           //         ))
//   //           //     : _isLoading
//   //           //         ? Center(
//   //           //             child: CircularProgressIndicator(),
//   //           //           )
//   //           //         : Expanded(
//   //           //             child: FadingEdgeScrollView.fromScrollView(
//   //           //                 child: ListView.builder(
//   //           //               shrinkWrap: true,
//   //           //               physics: const BouncingScrollPhysics(
//   //           //                   parent: BouncingScrollPhysics()),
//   //           //               itemCount: _videos.length,
//   //           //               itemBuilder: (context, index) {
//   //           //                 return VideoWidget(
//   //           //                   title: _videos[index].title,
//   //           //                   length: _videos[index].length,
//   //           //                   thumbnail: _videos[index].thumbnail,
//   //           //                   youtubeId: _videos[index].youtubeId,
//   //           //                   views: _videos[index].views,
//   //           //                 );
//   //           //               },
//   //           //             )),
//   //           //           ),
//   //         ],
//   //       ));
//   // }
// }
//
// // Map<String, dynamic> body = {
// //   '0': 't',
// //   '1': 'i',
// //   '2': 't',
// //   '3': 'l',
// //   '4': 'e',
// //   '5': '=',
// //   '6': 'P',
// //   '7': 'o',
// //   '8': 'r',
// //   '9': 'k',
// //   '10': ' ',
// //   '11': 'r',
// //   '12': 'o',
// //   '13': 'a',
// //   '14': 's',
// //   '15': 't',
// //   '16': ' ',
// //   '17': 'w',
// //   '18': 'i',
// //   '19': 't',
// //   '20': 'h',
// //   '21': ' ',
// //   '22': 'g',
// //   '23': 'r',
// //   '24': 'e',
// //   '25': 'e',
// //   '26': 'n',
// //   '27': ' ',
// //   '28': 'b',
// //   '29': 'e',
// //   '30': 'a',
// //   '31': 'n',
// //   '32': 's',
// //   '33': '&',
// //   '34': 'i',
// //   '35': 'n',
// //   '36': 'g',
// //   '37': 'r',
// //   '38': 'e',
// //   '39': 'd',
// //   '40': 'i',
// //   '41': 'e',
// //   '42': 'n',
// //   '43': 't',
// //   '44': 'L',
// //   '45': 'i',
// //   '46': 's',
// //   '47': 't',
// //   '48': '=',
// //   '49': '3',
// //   '50': ' ',
// //   '51': 'o',
// //   '52': 'z',
// //   '53': ' ',
// //   '54': 'p',
// //   '55': 'o',
// //   '56': 'r',
// //   '57': 'k',
// //   '58': ' ',
// //   '59': 's',
// //   '60': 'h',
// //   '61': 'o',
// //   '62': 'u',
// //   '63': 'l',
// //   '64': 'd',
// //   '65': 'e',
// //   '66': 'r'
// // };
// // final response =
// //     await http.post(Uri.parse(uri), body: body, headers: headers);
// // print(response.body);
// // if (response.statusCode == 200) {
// //   final jsonResponse = json.decode(response.body);
// //   print(jsonResponse);
// // } else {
// //   throw Exception('Failed to load post');
// // }
// ignore_for_file: unnecessary_const

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodify/models/image_analysis.api.dart';
import 'package:foodify/models/image_analysis.dart';
import 'package:foodify/views/widgets/image_analysis_widget.dart';
import 'package:getwidget/components/loader/gf_loader.dart';

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
  String? link;
  XFile? image;
  late ImageAnalysis imageAnalysis;

  Future<void> uploadFile(XFile _image) async {
    var link;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("Image: " + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(_image.path));
    uploadTask.then((res) async {
      link = await res.ref.getDownloadURL();
      return link;
    });
  }

  getImageAnalysis() async {
    imageAnalysis = await ImageAnalysisAPI.getAnalysis(link!);
    setState(() {
      isLoaded = true;
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
    return Scaffold(
        body: ListView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Image Analysis",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isLoaded)
                (InkWell(
                  onTap: () {
                    setState(() {
                      isLoaded = false;
                    });
                  },
                  child: const Icon(
                    FontAwesomeIcons.arrowRotateLeft,
                    color: Colors.black54,
                  ),
                ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        !isLoaded ? displayCamera() : displayImage(),
        !isLoaded
            ? Container(
                width: 50,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(horizontal: 60),
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () async {
                      if (isLoaded)
                        setState(() {
                          isLoaded = false;
                        });
                      try {
                        await _initializeControllerFuture;
                        image = await _controller.takePicture();
                        print("Image Uploading");
                        link = uploadFile(image!).toString();
                        getImageAnalysis();
                      } catch (e) {
                        print(e);
                      }
                    },
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
                    )),
              )
            :
            //button to trye again
            imageAnalysis.recipes == null
                ? ImageAnalysisWidget(
                    imageAnalysis: imageAnalysis,
                  )
                : Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'No recipes found',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
      ],
    ));
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
                image: FileImage(File(
                  image!.path,
                )),
                fit: BoxFit.cover,
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
          // Otherwise, display a loading indicator.
          return const Center(child: Loader());
        }
      },
    );
  }

  Container buildCamera() {
    return Container(
        // clipBehavior: Clip.hardEdge,
        // height: MediaQuery.of(context).size.height * 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
            child: CameraPreview(_controller)));
  }
}
