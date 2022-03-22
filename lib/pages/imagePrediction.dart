import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "dart:io";

import 'package:get/get_core/src/get_main.dart';

import '../views/widgets/recipeFind.dart';

class Prediction extends StatelessWidget {
  final Image image;
  var recognitions;
  Prediction({Key? key, required this.image, required this.recognitions})
      : super(key: key);
  String returnResult() {
    return recognitions![0]['label'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Food recognition",
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: "OpenSans-Regular"),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: image,
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
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                  child: Text("Add to cart".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    Get.to(() => RecipeFindClass(
                          ingredients: returnResult(),
                          ranking: '1',
                          pantry: true,
                        ));
                  }),
            ),
          ],
        ));
  }
}
