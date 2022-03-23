import 'package:flutter/material.dart';
import 'package:foodify/models/removebg.dart';
import 'package:foodify/pages/imagePrediction.dart';
import 'package:foodify/views/widgets/recipeFind.dart';
import 'package:get/get.dart';
import 'pages/Favourites/favourites.dart';
import 'pages/Home/home.dart';
import 'pages/MyList/mylist.dart';
import 'pages/Settings/settings.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'dart:io';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  List? recognitions;
  XFile? ximage;
  String? name, confidence;

  List<XFile>? _imageFileList;
  dynamic _pickImageError;
  ImagePicker? _picker;

  @override
  initState() {
    super.initState();
    _picker = ImagePicker();
    loadModel().then((val) {
      print('Model Loaded');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Center(
          child: Text(
            'Foodify',
          ),
        ),
      ),
      body: CurvedNavBar(
        actionButton: CurvedActionBar(
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 37,
                color: Colors.blue,
              ),
            ),
            inActiveIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Colors.blue, shape: BoxShape.circle),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 37,
                  color: Colors.white,
                ),
                // onPressed: selectFromImagePicker,
                onPressed: () {
                  _onImageButtonPressed(ImageSource.gallery,
                      context: context, isMultiImage: true);
                },
              ),
            ),
            text: ""),
        activeColor: Colors.blue,
        navBarBackgroundColor: Colors.white,
        inActiveColor: Colors.black45,
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.house_outlined,
                color: Colors.blue,
              ),
              inActiveIcon: const Icon(
                Icons.house_outlined,
                color: Colors.black54,
              ),
              text: 'Home'),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.favorite_border,
                color: Colors.blue,
              ),
              inActiveIcon: const Icon(
                Icons.favorite_border,
                color: Colors.black54,
              ),
              text: 'Liked'),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.format_list_bulleted_sharp,
                color: Colors.blue,
              ),
              inActiveIcon: const Icon(
                Icons.format_list_bulleted_sharp,
                color: Colors.black54,
              ),
              text: 'My List'),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.settings_outlined,
                color: Colors.blue,
              ),
              inActiveIcon: const Icon(
                Icons.settings_outlined,
                color: Colors.black54,
              ),
              text: 'Settings'),
        ],
        bodyItems: [
          Home(),
          Favourites(),
          MyList(),
          Settings(),
        ],
        // actionBarView: Container(
        //   height: MediaQuery.of(context).size.height,
        //   color: Colors.black,
        // ),
      ),
    );
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
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  selectFromImagePicker() async {
    print('aaaa');
    ImagePicker imagepick = ImagePicker();
    ximage = await imagepick.pickImage(source: ImageSource.gallery);

    image = convertToFile(ximage!);
    print('image picked is ' + image!.path);
    // RemoveBgAPI.getImage(image!);
    predictImage(File(image!.path));
  }

  predictImage(File image) async {
    print('Predict image called');

    await applyModel(image);

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

  applyModel(File file) async {
    print('get Image called7');
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 5,
      threshold: 0.7,
      imageMean: 0.0,
      imageStd: 255.0,
    );
    print('reached mount');
    if (!mounted) return;
    print('Setstate true');

    if (res!.isEmpty) {
      print('returning 0');
      return;
    }
    String str = res[0]['label'];
    name = str.substring(2);
    double a = res[0]['confidence'] * 100.0;
    confidence = (a.toString().substring(0, 2)) + '%';
    print(res);
    // Get.to(
    //   () {
    //     Prediction(image: file, recognitions: res);
    //   },
    //   transition: Transition.upToDown,
    // );

    Get.to(() {
      return Prediction(images: _imageFileList, recognitions: res);
    }, transition: Transition.upToDown);
  }

  File convertToFile(XFile xFile) {
    return File(xFile.path);
  }

  _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final List<XFile>? pickedFileList = await _picker?.pickMultiImage(
        // maxWidth: maxWidth,
        // maxHeight: maxHeight,
        imageQuality: 1,
      );
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    Get.to(() {
      return Prediction(images: _imageFileList);
    }, transition: Transition.upToDown);
  }
}
