import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/models/image_analysis.dart';
import 'package:foodify/pages/Procedure/procedure.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageAnalysisWidget extends StatelessWidget {
  ImageAnalysis imageAnalysis;
  ImageAnalysisWidget({Key? key, required this.imageAnalysis})
      : super(key: key);

  void urlLauncher(String url) async {
    print(url);
    if (!await launch(url, forceWebView: true, enableJavaScript: true)) {
      Get.snackbar(
        "Couldn't launch URL",
        "Please check your Internet connection",
        duration: const Duration(seconds: 3),
        icon: const Icon(FontAwesomeIcons.triangleExclamation,
            color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    if (imageAnalysis == null) return Container();
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          Text(
            imageAnalysis.category!.name != null
                ? 'Guess: ' + capitalize(imageAnalysis.category!.name!)
                : 'Guess: Not Found',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black54,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Probability: ${imageAnalysis.category!.probability ?? 0} %',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black54,
              fontWeight: FontWeight.normal,
            ),
          ),
          Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Suggested recipes: ',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: imageAnalysis.recipes!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (imageAnalysis.recipes?[index].id != null) {
                          ProcedurePage(
                            id: imageAnalysis.recipes![index].id.toString(),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4.0,
                              spreadRadius: 2.0,
                            )
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width * 0.77,
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  FontAwesomeIcons.utensils,
                                  color: Colors.black38,
                                ),
                              ],
                            ),
                            title: Text(
                              '${imageAnalysis.recipes![index].title}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        urlLauncher(imageAnalysis.recipes![index].url ??
                            "https://spoonacular.com");
                      },
                      child: const Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget a() {
    return SizedBox(
      height: 300,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Guess : ${imageAnalysis.category!.name ?? 'Not Found'}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${imageAnalysis.category?.probability ?? 0}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.percent,
                      color: Colors.black38,
                    ),
                  ],
                )
              ],
            ),
            const Text(
              'Suggested recipes: ',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (imageAnalysis.recipes != null)
              (ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: imageAnalysis.recipes!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (imageAnalysis.recipes?[index].id != null) {
                              ProcedurePage(
                                id: imageAnalysis.recipes![index].id.toString(),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 4.0,
                                  spreadRadius: 2.0,
                                )
                              ],
                            ),
                            child: Container(
                              height: 300,
                              child: ListTile(
                                leading: const Icon(
                                  FontAwesomeIcons.utensils,
                                  color: Colors.black38,
                                ),
                                title: Text(
                                  '${imageAnalysis.recipes![index].title}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            urlLauncher(imageAnalysis.recipes![index].url ??
                                "https://spoonacular.com");
                          },
                          child: const Icon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ))
          ],
        ),
      ),
    );
  }
}
