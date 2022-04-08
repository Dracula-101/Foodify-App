import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodify/pages/imagePicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  testWidgets('Testing of machine learning model', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Machine Learning Model',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
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

  loadModel() async {
    Tflite.close();
    print('Loadmodel called 2');
    try {
      String res;

      res = (await Tflite.loadModel(
        model: "assets/tflite/model.tflite",
        labels: "assets/tflite/dict.txt",
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
  }

  File convertToFile(XFile xFile) {
    return File(xFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              selectFromImagePicker();
            },
            child: Text('Select Image'),
          ),
          Text('Name: $name'),
          Text('Confidence: $confidence'),
        ],
      ),
    );
  }
}
