import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/models/removebg.dart';
import 'package:foodify/pages/DrawerItems/AboutUs.dart';
import 'package:foodify/pages/Login/loginpage.dart';
import 'package:foodify/pages/Procedure/procedure.dart';
import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:foodify/pages/VideoFinder/video_finder.dart';
import 'package:foodify/pages/imagePicker.dart';
import 'package:foodify/pages/imagePrediction.dart';
import 'package:foodify/routes/app_routes.dart';
import 'package:foodify/views/widgets/recipeFind.dart';
import 'package:foodify/views/widgets/recipeSearch_card.dart';
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
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
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
      // getPages: AppRoutes.pages,
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
  final PageStorageBucket bucket = PageStorageBucket();
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
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber, Colors.amberAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.95],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: FancyDrawerWrapper(
            backgroundColor: Colors.transparent,
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
                            icon: const Icon(
                                FontAwesomeIcons.triangleExclamation,
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
                backgroundColor: Colors.white12,
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
  @override
  // TODO: implement wantKeepAlive
  File? image;
  List? recognitions;
  XFile? ximage;
  String? name, confidence;
  int currentTab = 0;

  dynamic _pickImageError;
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
        // Search(),pub
        // GFSearchBar(
        //   searchList: list,
        //   searchQueryBuilder: (query, list) {
        //     return list
        //         .where((item) =>
        //             item.toString().toLowerCase().contains(query.toLowerCase()))
        //         .toList();
        //   },
        //   noItemsFoundWidget: Container(),
        //   searchBoxInputDecoration: InputDecoration(
        //     iconColor: Colors.amberAccent,
        //     hintText: "Search for a recipe",
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.amberAccent),
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     suffix: InkWell(
        //         onTap: () {
        //           RecipeSearchCard(
        //               title: searchController.text, isCuisine: false);
        //         },
        //         child: Icon(Icons.search)),
        //   ),
        //   overlaySearchListItemBuilder: (item) {
        //     return Container(
        //       padding: const EdgeInsets.all(10),
        //       child: Text(
        //         item.toString(),
        //         style: const TextStyle(fontSize: 20),
        //       ),
        //     );
        //   },
        //   onItemSelected: (item) {
        //     print('$item');
        //   },
        // ),
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
    loadModel().then((val) {
      print('Model Loaded');
    });
    createdHome = createHome(context);
  }

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: IndexedStack(
        index: currentTab,
        children: [const Home(), Favourites(), MyList(), const Settings()],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 32,
        ),
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
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(0),
        decoration: ShapeDecoration(
          color: Colors.black,
          shape: MyBorderShape(),
          shadows: [
            BoxShadow(
                color: Colors.black38, blurRadius: 8.0, offset: Offset(1, 1)),
          ],
        ),
        child: BottomNavigationBar(
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
                  color: Colors.white,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.format_list_bulleted_sharp,
                  // color: Colors.black54,
                  size: 27,
                ),
                label: 'My List'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  // color: Colors.black54,
                  size: 27,
                ),
                label: 'Settings'),
          ],
        ),
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
}

class MyBorderShape extends ShapeBorder {
  const MyBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  final double holeSize = 200;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    print(rect.height);
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
