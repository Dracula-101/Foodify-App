import 'package:flutter/material.dart';
import 'pages/Favourites/favourites.dart';
import 'pages/Home/home.dart';
import 'pages/MyList/mylist.dart';
import 'pages/Settings/settings.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 37,
                color: Colors.blue,
              ),
            ),
            inActiveIcon: Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 37,
                color: Colors.white,
              ),
            ),
            text: ""),
        activeColor: Colors.blue,
        navBarBackgroundColor: Colors.white,
        inActiveColor: Colors.black45,
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.house_outlined,
                color: Colors.blue,
              ),
              inActiveIcon: Icon(
                Icons.house_outlined,
                color: Colors.black54,
              ),
              text: 'Home'),
          FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.favorite_border,
                color: Colors.blue,
              ),
              inActiveIcon: Icon(
                Icons.favorite_border,
                color: Colors.black54,
              ),
              text: 'Liked'),
          FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.format_list_bulleted_sharp,
                color: Colors.blue,
              ),
              inActiveIcon: Icon(
                Icons.format_list_bulleted_sharp,
                color: Colors.black54,
              ),
              text: 'My List'),
          FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.settings_outlined,
                color: Colors.blue,
              ),
              inActiveIcon: Icon(
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
        actionBarView: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
        ),
      ),
    );
  }
}
