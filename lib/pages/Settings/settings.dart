import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodify/views/widgets/recipeSearch_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

const String ssd = "SSD MobileNet";
const String yolo = "Tiny Yolov2";

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _model = yolo;
  File? _image;

  double? _imageWidth;
  double? _imageHeight;
  bool _busy = false;

  List? _recognitions;
  XFile? image;

  @override
  void initState() {
    super.initState();
    _busy = true;
    print("Loaded mode");
    loadModel().then((val) {
      _busy = false;
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      if (_model == yolo) {
        res = (await Tflite.loadModel(
          model: "assets/tflite/yolov2_tiny.tflite",
          labels: "assets/tflite/yolov2_tiny.txt",
        ))!;
      } else {
        res = (await Tflite.loadModel(
          model: "assets/tflite/model.tflite",
          labels: "assets/tflite/dict.txt",
        ))!;
      }
      // print(res);
    } on PlatformException {
      if (kDebugMode) {
        print("Failed to load the model");
      }
    }
  }

  selectFromImagePicker() async {
    ImagePicker imagepick = ImagePicker();
    image = await imagepick.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    // _busy = true;
    predictImage(File(image!.path));
  }

  predictImage(File image) async {
    if (_model == yolo) {
      await yolov2Tiny(image);
    } else {
      await ssdMobileNet(image);
    }

    FileImage(image)
        .resolve(const ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          // setState(() {
          //   _imageWidth = info.image.width.toDouble();
          //   _imageHeight = info.image.height.toDouble();
          // });
          _imageWidth = info.image.width.toDouble();
          _imageHeight = info.image.height.toDouble();
        })));

    setState(() {
      _image = image;
      _busy = false;
    });
    // _image = image;
    // _busy = false;
  }

  yolov2Tiny(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        model: "YOLO",
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0,
        numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions!;
    });
    // _recognitions = recognitions!;
  }

  ssdMobileNet(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions!;
    });
    // _recognitions = recognitions!;
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight! / _imageHeight! * screen.width;

    Color appColour = const Color.fromARGB(255, 241, 169, 1);

    return _recognitions!.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: appColour,
                width: 3,
              )),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = appColour,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null
          ? const Text("No Image Selected")
          : Image.file(_image!),
    ));

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(const Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Food recognition."),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.image),
          tooltip: "Pick Image from gallery",
          onPressed: selectFromImagePicker,
        ),
        // body: (_image != null) ? Image.file(_image!) : Text("No Image"));
        body: Stack(
          children: stackChildren,
        ));
  }
}
