import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProcedurePage extends StatefulWidget {
  ProcedurePage({Key? key}) : super(key: key);

  @override
  _ProcedurePageState createState() => _ProcedurePageState();
}

class _ProcedurePageState extends State<ProcedurePage> {
  PageController controller = PageController();
  List<Widget>? stepsCard;
  String? sourceUrl;
  Widget? web;

  void launchURL() async {
    if (!await launch(sourceUrl!, forceWebView: true, enableJavaScript: true)) {
      Get.snackbar(
        "Couldn't launch URL",
        "Please check your Internet connection",
        duration: const Duration(seconds: 2),
        icon: Icon(FontAwesomeIcons.triangleExclamation, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  textContainer(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
          // image: DecorationImage(
          //   colorFilter: ColorFilter.mode(
          //     Colors.black.withOpacity(0.5),
          //     BlendMode.multiply,
          //   ),
          //   image: NetworkImage(thumbnailUrl),
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    stepsCard = [
      textContainer('Pg 1'),
      textContainer('Pg 2'),
      textContainer('Pg 3'),
    ];

    sourceUrl =
        'https://fullbellysisters.blogspot.com/2012/06/pasta-with-garlic-scallions-cauliflower.html';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  color: Colors.black,
                  child: Image.asset(
                    'assets/images/img_360linkimage.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 220,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                          height: 190,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Greek Salad',
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 15),
                              Text('6 ingredients'),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('30 min'),
                                  Text('234 Kcal'),
                                  Text('3 serves'),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Cooking Instructions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.all(8.0),
              child: PageView(
                /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                /// Use [Axis.vertical] to scroll vertically.
                controller: controller,
                children: stepsCard!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: launchURL,
                child: const Text(
                  'Get Procedure',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
