import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:foodify/pages/Image%20Picker/image_picker_controller.dart';
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
  ImagePicker _picker = ImagePicker();
  final ImagePickerController _controller = Get.put(ImagePickerController());
  @override
  void initState() {
    if (widget.images != null) {
      _controller.images.addAll(widget.images!);
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.images?.clear();
    widget.images?.addAll(_controller.images);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Food recognition",
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: "OpenSans-Regular"),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: GetX<ImagePickerController>(
                    init: _controller,
                    builder: (controller) {
                      return GridView.builder(
                        dragStartBehavior: DragStartBehavior.start,
                        itemCount: controller.images.length,
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
                                  File(controller.images.elementAt(index).path),
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
                                    ),
                                    margin: const EdgeInsets.all(5),
                                    child: IconButton(
                                      iconSize: 30,
                                      onPressed: () {
                                        setState(() {
                                          controller.images.removeAt(index);
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
                      );
                    },
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
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
                              _controller.getImage(context);
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  ' Add Images',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "OpenSans-Regular",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
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
                                  images: _controller.images,
                                );
                              });
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  'Predict Images',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "OpenSans-Regular",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )))
          ],
        ));
  }
}
