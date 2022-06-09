import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/models/image_analysis.dart';
import 'package:foodify/pages/Procedure/procedure.dart';
import 'package:get/get.dart';
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
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Guess',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  imageAnalysis.category?.name != null
                      ? capitalize(imageAnalysis.category!.name!)
                      : 'Not Found',
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Probability ",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ((imageAnalysis.category?.probability ?? 0) * 100)
                          .toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(FontAwesomeIcons.percent,
                        size: 30, color: Colors.black54)
                  ],
                ),
              )
            ],
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 15,
          ),
          if (imageAnalysis.recipes != null)
            const Text(
              'Suggested recipes: ',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: imageAnalysis.recipes?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print(imageAnalysis.recipes?[index].id);
                  if (imageAnalysis.recipes?[index].id != null) {
                    Get.to(() {
                      return ProcedurePage(
                        id: imageAnalysis.recipes![index].id.toString(),
                      );
                    });
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
                  child: FittedBox(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width,
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
                        trailing: InkWell(
                          onTap: () {
                            urlLauncher(imageAnalysis.recipes![index].url!);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber, width: 2),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amberAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 4.0,
                                  spreadRadius: 2.0,
                                )
                              ],
                            ),
                            child: const Icon(
                              FontAwesomeIcons.rightFromBracket,
                              color: Colors.black38,
                            ),
                          ),
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
              );
            },
          ),
        ],
      ),
    );
  }
}
