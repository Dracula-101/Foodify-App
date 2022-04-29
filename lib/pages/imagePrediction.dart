import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodify/constants/key.dart' as key;
import 'package:foodify/models/recipeFind.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
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
  List<bool> isFruitAdded = [];
  List<bool> isVegetableAdded = [];
  bool pantry = true;
  int ranking = 1;
  String dropdownValue = "Maximize Used Ingredients";
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
      String item = recognitions[i][0]["label"].toString();
      if (key.fruits.contains(item) && !fruits.contains(item)) {
        fruits.add(recognitions[i][0]["label"]);
        isFruitAdded.add(true);
      } else if (key.vegetables.contains(item) && !vegetables.contains(item)) {
        vegetables.add(recognitions[i][0]["label"]);
        isVegetableAdded.add(true);
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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Fruits',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: fruits.length,
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
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                fruits.elementAt(index),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          GFToggle(
                            enabledTrackColor: Colors.amber,
                            onChanged: (val) {
                              isFruitAdded[index] = (!val!);
                              print(isFruitAdded[index]);
                            },
                            value: true,
                            type: GFToggleType.ios,
                          )
                        ],
                      ),
                    ));
              }),
        ]);
  }

  Widget buildVegetables(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Vegetables',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
                    height: 55,
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
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 30,
                                child: CachedNetworkImage(
                                  imageUrl: key.labels[
                                          vegetables.elementAt(index)] ??
                                      'https://bitsofco.de/content/images/2018/12/broken-1.png',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.6),
                                          blurRadius: 30.0,
                                          spreadRadius: -5.0,
                                          offset: Offset(0.0, 40.0),
                                        ),
                                      ],
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      ShimmerWidget.rectangular(
                                          height: 300,
                                          br: BorderRadius.circular(0)),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              vegetables.elementAt(index),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        GFToggle(
                          enabledTrackColor: Colors.amber,
                          duration: Duration(milliseconds: 100),
                          onChanged: (val) {
                            isVegetableAdded[index] = (!val!);
                            print(isVegetableAdded[index]);
                          },
                          value: true,
                          type: GFToggleType.ios,
                        )
                      ],
                    ),
                  );
                })),
      ],
    );
  }

  String makeList() {
    String finalList = "";
    for (int i = 0; i < fruits.length; i++) {
      if (isFruitAdded[i]) finalList += fruits[i] + ",";
    }
    for (int i = 0; i < vegetables.length; i++) {
      if (isVegetableAdded[i]) finalList += vegetables[i] + ",";
    }
    finalList.substring(0, finalList.length - 2);
    return finalList;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(4),
            padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    side: const BorderSide(color: Colors.amber)))),
        onPressed: () {
          if (dropdownValue == "Maximize Used Ingredients")
            ranking = 1;
          else
            ranking = 2;
          Get.to(() {
            String bruh = makeList();
            print(bruh);
            return RecipeFindClass(
                ingredients: bruh, ranking: ranking.toString(), pantry: pantry);
          });
        },
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
          : ListView(
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
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 370,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.images!.isNotEmpty && recognitions != null
                                  ? recognitions.length
                                  : 0,
                          physics: const BouncingScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                for (int i = 0; i < recognitions.length; i++) {}
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
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
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
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
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
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4.0,
                              spreadRadius: 2.0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Include Pantry Items',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            GFToggle(
                              enabledTrackColor: Colors.amber,
                              value: pantry,
                              type: GFToggleType.ios,
                              onChanged: (value) {
                                setState(() {
                                  pantry = value!;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4.0,
                              spreadRadius: 2.0,
                            )
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            padding: const EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(15),
                            border: const BorderSide(
                                color: Colors.black12, width: 1),
                            dropdownButtonColor: Colors.white,
                            value: dropdownValue,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue = newValue.toString();
                              });
                            },
                            items: [
                              "Maximize Used Ingredients",
                              "Minimize Missing Ingredients",
                            ]
                                .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      if (fruits.isNotEmpty) buildFruits(context),
                      if (vegetables.isNotEmpty) buildVegetables(context),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
