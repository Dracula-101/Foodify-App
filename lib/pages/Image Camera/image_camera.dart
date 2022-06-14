import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/pages/Image%20Camera/image_controller.dart';
import 'package:foodify/views/widgets/render_boxes.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';

import '../../loading/loader.dart';
import '../image_prediction.dart';

class ImageCamera extends StatefulWidget {
  final CameraDescription cameras;
  const ImageCamera({Key? key, required this.cameras}) : super(key: key);

  @override
  State<ImageCamera> createState() => _ImageCameraState();
}

class _ImageCameraState extends State<ImageCamera> {
  late CameraController _controller; //To control the camera
  late Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  final ImageCameraController controller = Get.put(ImageCameraController());
  bool isCaptured = false;
  double bottomPos = 20;
  bool isLoading = true;
  bool isDetecting = false;
  List? results;
  var tmp;
  double? screenH, screenW, previewH, previewW, screenRatio, previewRatio;

  @override
  void initState() {
    super.initState();
    loadModel();
    initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  initializeCamera() async {
    _controller = CameraController(
      widget.cameras,
      ResolutionPreset.low,
    );
    _initializeControllerFuture = _controller.initialize().then((value) async {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        startDetection();
      }

      return value;
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
        model: "assets/tflite/model_unquant.tflite",
        labels: "assets/tflite/labels.txt",
      );
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

  void startDetection() async {
    _controller.startImageStream((CameraImage img) {
      if (!isDetecting) {
        setState(() {
          isDetecting = true;
        });

        int startTime = DateTime.now().millisecondsSinceEpoch;
        Tflite.runModelOnFrame(
          bytesList: img.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: img.height,
          imageWidth: img.width,
          numResults: 2,
        ).then((recognitions) {
          int endTime = DateTime.now().millisecondsSinceEpoch;
          log("Detection took ${endTime - startTime}");
          results = recognitions;
          log(results.toString());
          // widget.setRecognitions(recognitions, img.height, img.width);

          setState(() {
            isDetecting = false;
          });
        });
      }
    });
  }

  FutureBuilder<void> displayCamera() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //TURN OFF FLASH
          _controller.setFlashMode(FlashMode.off);
          return buildCamera(context);
        } else {
          return const Center(child: Loader());
        }
      },
    );
  }

  Positioned buildCaptureButton() {
    return Positioned(
      bottom: bottomPos + (!isCaptured ? 0 : 30),
      right: MediaQuery.of(context).size.width * 0.5 - (!isCaptured ? 40 : 20),
      child: !isCaptured
          ? InkWell(
              child: const Icon(
                CupertinoIcons.camera_circle_fill,
                color: Colors.white,
                size: 80,
              ),
              onTap: () async {
                setState(() {
                  isCaptured = true;
                });
                Get.snackbar(
                  'Taking Picture',
                  'Hold still to capture picture perfectly',
                  icon: const Icon(
                    CupertinoIcons.camera_circle_fill,
                    size: 50,
                  ),
                );

                final XFile image =
                    await _controller.takePicture().then((value) async {
                  setState(() {
                    isCaptured = false;
                  });
                  return value;
                });
                setState(() {
                  controller.addImage(image);
                });
              },
            )
          : const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
    );
  }

  Positioned backButton() {
    return Positioned(
      top: 30,
      left: 10,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.6),
                spreadRadius: 2,
                blurRadius: 5)
          ],
        ),
        child: IconButton(
          onPressed: () {
            controller.dispose();
            Get.back();
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Positioned images() {
    return Positioned(
        bottom: bottomPos + 5,
        left: 20,
        child: Container(
          height: 70,
          width: 70,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5)
            ],
          ),
          child: InkWell(
            onTap: () {
              Get.bottomSheet(Container(
                height: MediaQuery.of(context).size.height * 0.7,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Obx(() => controller.images.isNotEmpty
                    ? GetX<ImageCameraController>(
                        init: ImageCameraController(),
                        initState: (_) {},
                        builder: (_) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: controller.images.length <= 4
                                ? const NeverScrollableScrollPhysics()
                                : const BouncingScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: controller.images.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                spreadRadius: 2,
                                                offset: const Offset(2, 5),
                                                blurRadius: 5)
                                          ],
                                          image: DecorationImage(
                                              image: FileImage(File(controller
                                                  .images[index].path)),
                                              fit: BoxFit.cover)),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.6),
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
                                                controller.deleteImage(index);
                                              });
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ),
                                      )),
                                ],
                              );
                            },
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'Start taking pictures of fruits and vegetables to see here',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
              ));
            },
            child: Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    color: controller.images.isEmpty
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white),
                child: controller.images.isNotEmpty
                    ? Image.file(
                        File(controller.images.last.path),
                        fit: BoxFit.cover,
                      )
                    : Container()),
          ),
        ));
  }

  Positioned doneButton() {
    return Positioned(
        bottom: bottomPos + 5,
        right: 20,
        child: Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5)
            ],
          ),
          child: IconButton(
            onPressed: () {
              if (controller.images.isEmpty) {
                Get.snackbar('Error', 'Please take atleast one picture',
                    icon: const Icon(Icons.error),
                    backgroundColor: Colors.redAccent.withOpacity(0.8));
                return;
              }
              Get.to(() {
                return Prediction(
                  images: controller.images,
                );
              });
            },
            icon: const Icon(FontAwesomeIcons.check,
                color: Colors.black, size: 50),
          ),
        ));
  }

  Positioned flashButton() {
    return Positioned(
      top: 30,
      right: 10,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.6),
                spreadRadius: 2,
                blurRadius: 5)
          ],
        ),
        child: IconButton(
            onPressed: () {
              controller.toogleFlash();
              setState(() {
                _controller.setFlashMode(
                    controller.hasFlash.value ? FlashMode.auto : FlashMode.off);
              });
            },
            icon: Obx(
              () => !controller.hasFlash.value
                  ? const Icon(
                      Icons.flash_off,
                      color: Colors.black,
                      size: 30,
                    )
                  : const Icon(
                      Icons.flash_auto,
                      color: Colors.black,
                      size: 30,
                    ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    tmp = MediaQuery.of(context).size;
    screenH = math.max(tmp.height, tmp.width);
    screenW = math.min(tmp.height, tmp.width);
    tmp = _controller.value.previewSize!;
    previewH = math.max(tmp.height, tmp.width);
    previewW = math.min(tmp.height, tmp.width);
    screenRatio = screenH! / screenW!;
    previewRatio = previewH! / previewW!;

    return Scaffold(
        body: Stack(
      children: [
        displayCamera(),
        backButton(),
        buildCaptureButton(),
        images(),
        flashButton(),
        doneButton(),
      ],
    ));
  }

  SizedBox buildCamera(BuildContext context) {
    return SizedBox(
      width: tmp.width,
      height: tmp.height,
      child: OverflowBox(
        maxHeight: screenRatio! > previewRatio!
            ? screenH
            : screenW! / previewW! * previewH!,
        maxWidth: screenRatio! > previewRatio!
            ? screenH! / previewH! * previewW!
            : screenW!,
        child: CameraPreview(_controller),
      ),
    );
  }

  Stack text(BuildContext context) {
    return Stack(
      children: [
        BndBox(
            results!, previewH!.toInt(), previewW!.toInt(), screenH!, screenW!)
      ],
    );
  }
}
