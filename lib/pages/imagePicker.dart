import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:foodify/pages/imagePrediction.dart';
import 'package:get/get.dart';
import "dart:io";

import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final List<XFile>? images;
  const ImageSelector({Key? key, required this.images}) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Food recognition",
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: "OpenSans-Regular"),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: GridView.builder(
                    dragStartBehavior: DragStartBehavior.start,
                    itemCount: widget.images?.length ?? 0,
                    itemBuilder: (context, index) => Card(
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Image.file(
                              File(widget.images!.elementAt(index).path),
                              fit: BoxFit.cover,
                              height: size.height,
                              width: size.width,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 10.0,
                                      spreadRadius: -6.0,
                                    ),
                                  ],
                                  // image: DecorationImage(
                                  //   colorFilter: ColorFilter.mode(
                                  //     Colors.black.withOpacity(0.5),
                                  //     BlendMode.multiply,
                                  //   ),
                                  //   image: ),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                margin: const EdgeInsets.all(5),
                                child: IconButton(
                                  iconSize: 30,
                                  onPressed: () {
                                    setState(() {
                                      widget.images!.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                  )),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    // height: 100,\

                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.9),
                          // blurRadius: 4.0,
                          // spreadRadius: -6.0,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 70),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: Colors.amberAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 10.0,
                            spreadRadius: -6.0,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() {
                            return Prediction(
                              images: widget.images,
                            );
                          });
                        },
                        child: const Text(
                          'Predict Images',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontFamily: "OpenSans-Regular",
                          ),
                        ),
                      ),
                    )))
          ],
        ));
  }
}
