import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/pages/DrawerItems/about_us.dart';
import 'package:foodify/pages/Login/loginpage.dart';
import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:foodify/pages/Settings/settings.dart';
import 'package:foodify/pages/VideoFinder/video_finder.dart';
import 'package:foodify/pages/Image%20Picker/image_picker.dart';
import 'package:foodify/splashScreen/splash_screen.dart';
import 'package:foodify/views/widgets/recipe_search_card.dart';
import 'package:foodify/views/widgets/trending.dart';
import 'package:get/get.dart';
import 'pages/Favourites/favourites.dart';
import 'pages/Home/home.dart';
import 'pages/MyList/mylist.dart';
import 'pages/Guesser/guesser.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

late CameraDescription firstCamera;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  firstCamera = cameras.first;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  static Future<Widget> checkUser() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    // return user != null ? const MyHomePage() : LoginPage();
    return user != null ? const HomeDrawer() : LoginPage();
  }

  Widget app() {
    return GetMaterialApp(
      // showPerformanceOverlay: true,

      title: 'Foodify',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: const MyHomePage(),
      // home: LandingPage,
      // getPages: AppRoutes.pages,
      home: FutureBuilder<Widget>(
        future: checkUser(), // async work
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          // return const SplashScreen();
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return snapshot.data!;
            case ConnectionState.active:
              return const SplashScreen();
            default:
              return const SplashScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          duration: 4000,
          splash: const SplashScreen(),
          nextScreen: app(),
          splashIconSize: window.physicalSize.height,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white),
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
  List<Widget> screens = [
    const MyHomePage(),
    const VideoFinder(),
    const Settings(),
    const AboutUs()
  ];

  Widget selectedWidget = const MyHomePage();
  final PageStorageBucket bucket = PageStorageBucket();
  String toMailId = 'projectapp2024@gmail.com',
      subject = 'Feedback/Query on Foodify';
  setSelectedWidget(int i) {
    setState(() {
      selectedWidget = screens[i];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
          backgroundColor: Colors.white12,
        ),
        drawerDragStartBehavior: DragStartBehavior.down,
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 100,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Stack(
                children: [
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/img_videoimage_1.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const DrawerHeader(
                    decoration: BoxDecoration(),
                    child: Text('Foodify',
                        style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Amsterdam-ZVGqm")),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.home,
                        color: Colors.amberAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  setSelectedWidget(0);
                  //close drawer
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.video_library,
                        color: Colors.amberAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Recipe Videos",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  setSelectedWidget(1);
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.amberAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  setSelectedWidget(2);
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info,
                        color: Colors.amberAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
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
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.amberAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  logout();
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.developer_board,
                        color: Colors.amberAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Dev Team",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.snackbar(
                    "Developed by:",
                    "Dracula-101, Dilip Patel",
                    duration: const Duration(seconds: 2),
                    icon: const Icon(FontAwesomeIcons.handsClapping,
                        color: Colors.black54),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),

              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Container(
              //     color: Colors.transparent,
              //     height: 55,
              //     width: 200,
              //     child: InkWell(
              //       child: const Center(
              //         child: Text(
              //           "Close",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             fontSize: 22,
              //             color: Colors.white,
              //             fontWeight: FontWeight.normal,
              //           ),
              //         ),
              //       ),
              //       onTap: () {
              //         print('closed');
              //         _controller.close();
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        body: selectedWidget,
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
  int currentTab = 0;

  ImagePicker? _picker;
  TextEditingController searchController = TextEditingController();

  Widget? createdHome;

  Widget createHome(BuildContext context) {
    return PageStorage(
      bucket: bucket,
      child: Column(children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: <Widget>[
              IconButton(
                splashRadius: 20,
                splashColor: Colors.grey,
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              Expanded(
                  child: TextField(
                onTap: () {},
                controller: searchController,
                // onChanged: (value) async {
                //   await RecipeSuggestionAPI.getSuggestion(value)
                //       .then((value) => list = value);
                // },
                onSubmitted: (value) {
                  Get.to(RecipeSearchCard(
                    title: value,
                    isCuisine: false,
                  ));
                  searchController.clear();
                },
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Search Recipes"),
                // onChanged: (text) {
                //   widget.searched = true;
                //   widget.searchedRecipe = text;
                //   print('Recipe Searched');
                // },
              )),
              IconButton(
                splashRadius: 20,
                splashColor: Colors.grey,
                icon: const Icon(Icons.close),
                onPressed: () {
                  searchController.clear();
                },
              ),
            ],
          ),
        ), //Searchbar
        Expanded(
          child: ListView(
            cacheExtent: 10000,
            addAutomaticKeepAlives: true,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  "Trending",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TrendingWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  "Recipes for you",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RandomRecipe(),
            ],
          ),
        )
      ]),
    );
  }

  @override
  initState() {
    super.initState();
    _picker = ImagePicker();
    loadModel();
    createdHome = createHome(context);
  }

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: currentTab,
          children: [
            const Home(),
            const Favourites(),
            const MyList(),
            TakePictureScreen(
              camera: firstCamera,
            )
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.transparent,
          elevation: 4,
          onPressed: () async {
            List<XFile>? images =
                await _picker?.pickMultiImage(imageQuality: 100);
            setState(() {});
            if (images!.isEmpty) return;
            Get.to(() {
              return ImageSelector(
                images: images,
              );
            }, transition: Transition.upToDown);
          },
          isExtended: true,
          child: const Icon(
            Icons.camera_alt_outlined,
            size: 35,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              const CircularNotchedRectangle(), // ← carves notch for FAB in BottomAppBar
          elevation: 6,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            unselectedFontSize: 14,
            elevation: 4,
            selectedIconTheme: const IconThemeData(
              color: Colors.amber,
              size: 27,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.black54,
              size: 27,
            ),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: const TextStyle(
              color: Colors.black,
            ),
            currentIndex: currentTab,
            // fixedColor: Colors.amber,
            selectedItemColor: Colors.amber,
            onTap: (int index) {
              setState(() {
                currentTab = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.house_outlined,
                    // color: Colors.black54,
                    size: 27,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border,
                    // color: Colors.black54,
                    size: 27,
                  ),
                  label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.format_list_bulleted_sharp,
                    // color: Colors.black54,
                    size: 27,
                  ),
                  label: 'Cuisines'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.gesture,
                    // color: Colors.black54,
                    size: 27,
                  ),
                  label: 'Guesser'),
            ],
          ),
        ));
  }

  loadModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
          model: "assets/tflite/model_unquant.tflite",
          labels: "assets/tflite/labels.txt");
    } on PlatformException {
      Get.snackbar(
        'Error',
        'Failed to load the model',
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    }
  }

  selectFromImagePicker() async {
    ImagePicker imagepick = ImagePicker();
    ximage = await imagepick.pickImage(source: ImageSource.camera);

    image = convertToFile(ximage!);
    predictImage(File(image!.path));
  }

  predictImage(File image) async {
    await applyModel(image);
  }

  applyModel(File file) async {
    // print('get Image called7');
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 5,
      threshold: 0.7,
      imageMean: 0.0,
      imageStd: 255.0,
    );
    if (!mounted) return;

    if (res!.isEmpty) {
      return;
    }
    String str = res[0]['label'];
    name = str.substring(2);
    double a = res[0]['confidence'] * 100.0;
    confidence = (a.toString().substring(0, 2)) + '%';
  }

  File convertToFile(XFile xFile) {
    return File(xFile.path);
  }
}

class MyBorderShape extends ShapeBorder {
  const MyBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  final double holeSize = 200;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2)))
        ..close(),
      Path()
        ..addOval(Rect.fromCenter(
            center: rect.center.translate(0, -rect.height / 2),
            height: holeSize,
            width: holeSize))
        ..close(),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }
}
