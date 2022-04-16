import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodify/models/recipeFind.dart';
import 'package:get/get.dart';
import "dart:io";

import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tflite/tflite.dart';

import '../views/widgets/recipeFind.dart';

class Prediction extends StatefulWidget {
  List<XFile>? images;
  Prediction({Key? key, required this.images}) : super(key: key);

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  List recognitions = [];
  bool isLoading = true;
  @override
  initState() {
    super.initState();
    loadModel().then((val) {
      print('Model Loaded');
    });
  }

  loadModel() async {
    Tflite.close();
    print('Loadmodel called 2');
    try {
      String res;

      res = (await Tflite.loadModel(
        model: "assets/tflite/model_unquant.tflite",
        labels: "assets/tflite/labels.txt",
      ))!;
      print('Result is $res');

      print(res);
      debugPrint('Model Loaded, res is ' + res);
      predictImage();
      //
      // setState(() {
      //   print("Hwllo");
      //   isLoading = false;
      // });
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  predictImage() async {
    print('Predict image called');

    // await applyModel(image);

    for (var i = 0; i < widget.images!.length; i++) {
      var image = widget.images![i];
      var rec = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 0,
        imageStd: 255.0,
      );
      print('recccc is ');
      print(rec);

      recognitions.add(rec);
    }
    print("THe recognition is : ");
    print(recognitions);
    setState(() {
      isLoading = false;
    });

    // FileImage(image).resolve(ImageConfiguration()).addListener(
    //       (ImageStreamListener(
    //         (ImageInfo info, bool _) {
    //           // setState(() {
    //           //   _imageWidth = info.image.width.toDouble();
    //           //   _imageHeight = info.image.height.toDouble();
    //           // });
    //           _imageWidth = info.image.width.toDouble();
    //           _imageHeight = info.image.height.toDouble();
    //         },
    //       )),
    //     );
  }

  // applyModel(File file) async {
  //   print('get Image called7');
  //   var res = await Tflite.runModelOnImage(
  //     path: file.path,
  //     numResults: 5,
  //     threshold: 0.7,
  //     imageMean: 0.0,
  //     imageStd: 255.0,
  //   );
  //   print('reached mount');
  //   if (!mounted) return;
  //   print('Setstate true');

  //   if (res!.isEmpty) {
  //     print('returning 0');
  //     return;
  //   }
  //   String str = res[0]['label'];
  //   String name = str.substring(2);
  //   double a = res[0]['confidence'] * 100.0;
  //   String confidence = (a.toString().substring(0, 2)) + '%';
  //   print(res);
  //   // Get.to(
  //   //   () {
  //   //     Prediction(image: file, recognitions: res);
  //   //   },
  //   //   transition: Transition.upToDown,
  //   // );
  // }

  File convertToFile(XFile xFile) {
    return File(xFile.path);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Image Prediction'),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(4),
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      side: BorderSide(color: Colors.amber)))),
          onPressed: () {},
          child: const Text(
            'Get Recipes',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: widget.images!.isNotEmpty && recognitions != null
                    ? recognitions.length
                    : 0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print('Tapped');
                      // Get.to(
                      //   () {
                      //     Prediction(image: convertToFile(widget.images![index]));
                      //   },
                      //   transition: Transition.upToDown,
                      // );
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              height: 280,
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 280,
                                  width: size.width * 0.8,
                                  child: Image.file(
                                    File(widget.images!.elementAt(index).path),
                                    fit: BoxFit.cover,
                                    height: size.height,
                                    width: size.width,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1),
                              height: 280,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 70,
                                  alignment: Alignment.bottomLeft,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey.shade200
                                          .withOpacity(0.8)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Predicted Label: ' +
                                            recognitions[index][0]['label'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Predicted Confidence: ' +
                                            (recognitions[index][0]
                                                        ['confidence'] *
                                                    100)
                                                .toString()
                                                .substring(0, 4) +
                                            '%',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  );
                },
              ));

    //  SizedBox(
    //     height: size.height,
    //     width: size.width,
    //     child: ListView.builder(
    //       itemCount: widget.images!.isNotEmpty && recognitions != null
    //           ? recognitions?.length
    //           : 0,
    //       itemBuilder: (context, index) {
    //         return GestureDetector(
    //           onTap: () {
    //             print('Tapped');
    //             // Get.to(
    //             //   () {
    //             //     Prediction(image: convertToFile(widget.images![index]));
    //             //   },
    //             //   transition: Transition.upToDown,
    //             // );
    //           },
    //           child: Stack(
    //             children: [
    //               SizedBox(
    //                 height: size.height * 0.3,
    //                 width: size.width * 0.9,
    //                 child: Image.file(
    //                   File(widget.images!.elementAt(index).path),
    //                   fit: BoxFit.cover,
    //                   height: size.height,
    //                   width: size.width,
    //                 ),
    //               ),
    //               Positioned(
    //                 top: size.height * 0.3,
    //                 left: size.width * 0.05,
    //                 child: SizedBox(
    //                   height: size.height * 0.2,
    //                   width: size.width * 0.9,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Text(
    //                         'Predicted Label: ' +
    //                             recognitions?[index][0]['label']
    //                                 .substring(2),
    //                         style: const TextStyle(
    //                           fontSize: 15,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 5,
    //                       ),
    //                       Text(
    //                         'Predicted Confidence: ' +
    //                             (recognitions?[index][0]['confidence'] *
    //                                     100)
    //                                 .toString()
    //                                 .substring(0, 2) +
    //                             '%',
    //                         style: const TextStyle(
    //                           fontSize: 15,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     ),
    //   ),
  }
}

// TextButton(
//                   child: Text("Add to cart".toUpperCase(),
//                       style: TextStyle(fontSize: 14)),
//                   style: ButtonStyle(
//                       padding: MaterialStateProperty.all<EdgeInsets>(
//                           EdgeInsets.all(15)),
//                       foregroundColor:
//                           MaterialStateProperty.all<Color>(Colors.red),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                               side: BorderSide(color: Colors.red)))),
//                   onPressed: () {
//                     Get.to(() => RecipeFindClass(
//                           ingredients: returnResult(),
//                           ranking: '1',
//                           pantry: true,
//                         ));
//                   }),
