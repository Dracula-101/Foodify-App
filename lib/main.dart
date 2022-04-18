import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/models/removebg.dart';
import 'package:foodify/pages/DrawerItems/AboutUs.dart';
import 'package:foodify/pages/Login/loginpage.dart';
import 'package:foodify/pages/Procedure/procedure.dart';
import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:foodify/pages/VideoFinder/video_finder.dart';
import 'package:foodify/pages/imagePicker.dart';
import 'package:foodify/pages/imagePrediction.dart';
import 'package:foodify/views/widgets/recipeFind.dart';
import 'package:foodify/views/widgets/trending.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fancy_drawer/fancy_drawer.dart';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static Future<Widget> checkUser() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    // return user != null ? const MyHomePage() : LoginPage();
    return user != null ? const HomeDrawer() : LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // showPerformanceOverlay: true,
      title: 'Foodify',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: const MyHomePage(),
      // home: LandingPage,
      home: FutureBuilder<Widget>(
        future: checkUser(), // async work
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              return snapshot.hasError ? Container() : snapshot.data!;
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>
    with SingleTickerProviderStateMixin {
  late FancyDrawerController _controller;
  List<Widget> screens = [
    const MyHomePage(),
    const VideoFinder(),
    const AboutUs()
  ];

  Widget selectedWidget = const MyHomePage();

  String toMailId = 'projectapp2024@gmail.com',
      subject = 'Feedback/Query on Foodify';

  setSelectedWidget(int i) {
    setState(() {
      selectedWidget = screens[i];
      _controller.close();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = FancyDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {}); // Must call setState
      }); // This chunk of code is important
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: const Color.fromRGBO(47, 48, 68, 1),
        controller: _controller,
        itemGap: 13,
        cornerRadius: 15,
        drawerItems: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 55,
              width: 200,
              child: FittedBox(
                child: ElevatedButton(
                  child: Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    setSelectedWidget(0);
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 55,
              width: 200,
              child: FittedBox(
                child: ElevatedButton(
                  child: Text(
                    "Recipe Videos",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    setSelectedWidget(1);
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 55,
              width: 200,
              child: FittedBox(
                child: ElevatedButton(
                  child: Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    String url = 'mailto:$toMailId?subject=$subject';
                    if (!await launch(url, enableJavaScript: true)) {
                      Get.snackbar(
                        "Couldn't launch URL",
                        "Please check your Internet connection",
                        duration: const Duration(seconds: 2),
                        icon: const Icon(FontAwesomeIcons.triangleExclamation,
                            color: Colors.white),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 55,
              width: 200,
              child: FittedBox(
                child: ElevatedButton(
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    logout();
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: Colors.transparent,
              height: 55,
              width: 200,
              child: InkWell(
                child: const Center(
                  child: Text(
                    "Close",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  print('closed');
                  _controller.close();
                },
              ),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: const Text(
              "Foodify",
              style: TextStyle(
                fontSize: 25,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                _controller.toggle();
              },
            ),
          ),
          body: selectedWidget,
        ),
      ),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }), (route) => false);
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
      // appBar: AppBar(
      //   elevation: 5,
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   title: const Center(
      //     child: Text(
      //       'Foodify',
      //       'Foodify',
      //       style: TextStyle(
      //         fontSize: 30,
      //         fontFamily: "OpenSans",
      //         fontWeight: FontWeight.bold,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
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
                color: Colors.amber,
              ),
            ),
            inActiveIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Colors.amber, shape: BoxShape.circle),
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
        activeColor: Colors.amber,
        navBarBackgroundColor: Colors.white,
        inActiveColor: Colors.black45,
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.house_outlined,
                color: Colors.amber,
              ),
              inActiveIcon: const Icon(
                Icons.house_outlined,
                color: Colors.black54,
              ),
              text: 'Home'),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.favorite_border,
                color: Colors.amber,
              ),
              inActiveIcon: const Icon(
                Icons.favorite_border,
                color: Colors.black54,
              ),
              text: 'Liked'),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.format_list_bulleted_sharp,
                color: Colors.amber,
              ),
              inActiveIcon: const Icon(
                Icons.format_list_bulleted_sharp,
                color: Colors.black54,
              ),
              text: 'My List'),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.settings_outlined,
                color: Colors.amber,
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
          const Settings(),
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
    ximage = await imagepick.pickImage(source: ImageSource.camera);

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

  _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    List<XFile>? images;
    try {
      images = await _picker?.pickMultiImage(
        // maxWidth: maxWidth,
        // maxHeight: maxHeight,
        imageQuality: 100,
      );
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    print("Hello this is a point");
    if (images!.isEmpty) return;
    Get.to(() {
      return ImageSelector(
        images: images,
      );
    }, transition: Transition.upToDown);
  }
}
