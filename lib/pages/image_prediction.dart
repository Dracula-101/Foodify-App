import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/constants/key.dart' as key;
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:get/get.dart';
import "dart:io";
import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tflite/tflite.dart';
import '../views/widgets/recipe_find.dart';

class Prediction extends StatefulWidget {
  const Prediction({Key? key, required this.images}) : super(key: key);
  final List<XFile>? images;

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
  bool notFound = false;
  String dropdownValue = "Maximize Used Ingredients";
  @override
  initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
        model: "assets/tflite/model_unquant.tflite",
        labels: "assets/tflite/labels.txt",
      );
      predictImage();
      //
      // setState(() {
      //   print("Hwllo");
      //   isLoading = false;
      // });
    } on PlatformException {
      Get.snackbar(
        "Error",
        "Failed to load the model",
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  predictImage() async {
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
      String item = '';
      if (recognitions[i] == null) {
        item = 'Not Found';
      } else if (recognitions[i].isEmpty) {
        setState(() {
          notFound = true;
        });
      } else {
        item = recognitions[i][0]["label"].toString();
      }
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

  Widget showNothing(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
          Text(
            "Nothing Found",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ]));
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
                color: Colors.black54,
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
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 35,
                                  child: CachedNetworkImage(
                                    imageUrl: key
                                            .labels[fruits.elementAt(index)] ??
                                        'https://bitsofco.de/content/images/2018/12/broken-1.png',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        ShimmerWidget.rectangular(
                                            height: 300,
                                            br: BorderRadius.circular(0)),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )),
                              const SizedBox(
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
              color: Colors.black54,
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
                                backgroundColor: Colors.white,
                                radius: 35,
                                child: CachedNetworkImage(
                                  imageUrl: key.labels[
                                          vegetables.elementAt(index)] ??
                                      'https://bitsofco.de/content/images/2018/12/broken-1.png',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      ShimmerWidget.rectangular(
                                          height: 300,
                                          br: BorderRadius.circular(0)),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                            const SizedBox(
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
                          duration: const Duration(milliseconds: 100),
                          onChanged: (val) {
                            isVegetableAdded[index] = (val!);
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
    finalList = finalList.substring(0, finalList.length - 1);
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
      extendBody: true,
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
          if (dropdownValue == "Maximize Used Ingredients") {
            ranking = 1;
          } else {
            ranking = 2;
          }
          if (!notFound) {
            Get.to(() {
              String bruh = makeList();
              return RecipeFindClass(
                  ingredients: bruh,
                  ranking: ranking.toString(),
                  pantry: pantry);
            });
          } else {
            Get.back();
          }
        },
        child: Text(
          !notFound ? 'Get Recipes' : 'Try Again',
          style: const TextStyle(
            fontSize: 23,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Image Recognition",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    children: [
                      SizedBox(
                        height: 370,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.images!.isNotEmpty
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
                                                recognitions[index].isNotEmpty
                                                    ? Text(
                                                        'Predicted ' +
                                                            recognitions[index]
                                                                [0]['label'],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    : const Text(
                                                        'Not Found',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                recognitions[index].isNotEmpty
                                                    ? Text(
                                                        'Accuracy: ' +
                                                            (recognitions[index]
                                                                            [0][
                                                                        'confidence'] *
                                                                    100)
                                                                .toString()
                                                                .substring(
                                                                    0, 4) +
                                                            '%',
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    : const Text(
                                                        '0 %',
                                                        style: TextStyle(
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
                      if (!notFound)
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Details',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
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
                              if (vegetables.isNotEmpty)
                                buildVegetables(context),
                            ])
                      else
                        showNoPrediction()
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget showNoPrediction() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
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
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 2,
              ),
              Text(
                'No Predictions found',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Try to take the picture in these conditions:',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 3),
                leading: Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.black54,
                ),
                title: Text(
                  ' The object should be in the center of the screen',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 3),
                leading: Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.black54,
                ),
                title: Text(
                  ' The object should be taken from the front with some elevation.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 3),
                leading: Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.black54,
                ),
                title: Text(
                  ' Try to take the picture in good lightning.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 3),
                leading: Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.black54,
                ),
                title: Text(
                  ' The picture should be clear and focused.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
