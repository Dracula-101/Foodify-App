import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'express.dart';
import 'favourites.dart';
import 'home.dart';
import 'mylist.dart';
import 'settings.dart';

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
  int _currentTab = 0;
  final List screens = [Home(), Favourites(), MyList(), Settings()];

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
      body: Center(
        child: screens.elementAt(_currentTab),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                textStyle: TextStyle(
                  fontSize: 16,
                ),
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.blue[900],
                iconSize: 25,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black54,
                tabs: [
                  GButton(icon: Icons.house_outlined, text: 'Home'),
                  GButton(
                    icon: Icons.favorite_border,
                    // iconSize: 23,
                    text: 'Liked',
                  ),
                  GButton(
                    icon: Icons.format_list_bulleted_sharp,
                    // iconSize: 25,
                    // icon: Icons.checklist_rounded,
                    text: 'My List',
                  ),
                  GButton(
                    // iconSize: 25,
                    icon: Icons.settings_outlined,
                    text: 'Settings',
                  ),
                ],
                selectedIndex: _currentTab,
                onTabChange: (index) {
                  setState(
                    () {
                      _currentTab = index;
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
