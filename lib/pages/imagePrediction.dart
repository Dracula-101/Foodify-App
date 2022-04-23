import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodify/constants/key.dart' as key;
import 'package:foodify/models/recipeFind.dart';
import 'package:get/get.dart';
import "dart:io";
import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tflite/tflite.dart';
import 'package:loop_page_view/loop_page_view.dart';
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
  List<String> fruits = [];
  List<String> vegetables = [];
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

      recognitions.add(rec);
      if (key.fruits.contains(recognitions[i][0]["label"].toString())) {
        fruits.add(recognitions[i][0]["label"]);
      } else if (key.vegetables
          .contains(recognitions[i][0]["label"].toString())) {
        vegetables.add(recognitions[i][0]["label"]);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  File convertToFile(XFile xFile) {
    return File(xFile.path);
  }

  Widget buildFruits(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Fruits',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vegetables.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius:
                                10.0, // has the effect of softening the shadow
                            spreadRadius:
                                5.0, // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            fruits.elementAt(index),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ));
              })),
    ]);
  }

  Widget buildVegetables(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Vegetables',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vegetables.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius:
                              10.0, // has the effect of softening the shadow
                          spreadRadius:
                              5.0, // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          vegetables.elementAt(index),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  );
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(4),
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      side: const BorderSide(color: Colors.amber)))),
          onPressed: () {},
          child: const Text(
            'Get Recipes',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Image Recognition",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          fontFamily: "OpenSans",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      children: [
                        SizedBox(
                          height: 450,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.images!.isNotEmpty &&
                                    recognitions != null
                                ? recognitions.length
                                : 0,
                            physics: const BouncingScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  for (int i = 0;
                                      i < recognitions.length;
                                      i++) {}
                                  // Get.to(
                                  //   () {
                                  //     Prediction(image: convertToFile(widget.images![index]));
                                  //   },
                                  //   transition: Transition.upToDown,
                                  // );
                                },
                                child: Stack(
                                  // fit: StackFit.passthrough,
                                  children: [
                                    Container(
                                        height: 400,
                                        width: size.width * 0.8,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 4.0,
                                              spreadRadius: 2.0,
                                            )
                                          ],
                                          image: DecorationImage(
                                            image: FileImage(
                                              convertToFile(
                                                  widget.images![index]),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: FittedBox(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.8)),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Predicted ' +
                                                        recognitions[index][0]
                                                            ['label'],
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Accuracy: ' +
                                                        (recognitions[index][0][
                                                                    'confidence'] *
                                                                100)
                                                            .toString()
                                                            .substring(0, 4) +
                                                        '%',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        if (fruits.isNotEmpty) buildFruits(context),
                        if (vegetables.isNotEmpty) buildVegetables(context),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
