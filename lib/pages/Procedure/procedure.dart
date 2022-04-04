import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/models/recipeDetails.api.dart';
import 'package:foodify/models/recipeDetails.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../views/widgets/shimmer_widget.dart';

class ProcedurePage extends StatefulWidget {
  final String id;
  const ProcedurePage({Key? key, required this.id}) : super(key: key);

  @override
  _ProcedurePageState createState() => _ProcedurePageState();
}

class _ProcedurePageState extends State<ProcedurePage> {
  late RecipeDetails details;
  PageController controller = PageController();
  List<Widget>? stepsCard;
  String? sourceUrl;
  Widget? web;

  bool isLoading = true;

  Future<void> getRecipeDetails(String id) async {
    details = await RecipeDetailsAPI.getRecipeDetails(id.toString());

    setState(() {
      isLoading = false;
    });
  }

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
    getRecipeDetails(widget.id);
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
      floatingActionButton: ElevatedButton(
        onPressed: launchURL,
        child: const Text(
          'Get Procedure',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Container(
        child: ListView(
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                !isLoading
                    ? CachedNetworkImage(
                        imageUrl: details.image!,
                        height: 300,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 300.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            ShimmerWidget.rectangular(
                                height: 300, br: BorderRadius.circular(0)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : buildShimmer(
                        context, 300, MediaQuery.of(context).size.width, 0.0),
                Column(
                  children: [
                    SizedBox(
                      height: 220,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: isLoading
                              ? ShimmerWidget.rectangular(
                                  height: 200, br: BorderRadius.circular(20))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 1),
                                      alignment: Alignment.topCenter,
                                      child: Text(details.title.toString(),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis)),
                                    ),
                                    SizedBox(height: 15),
                                    Text(details.extendedIngredients!.length
                                            .toString() +
                                        " Ingredients"),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.clock,
                                                size: 25,
                                                color: HexColor("#b88c09")),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                details.readyInMinutes!
                                                            .toInt() <
                                                        60
                                                    ? details.readyInMinutes
                                                            .toString() +
                                                        " mins"
                                                    : (details.readyInMinutes!
                                                                    .toDouble() /
                                                                60.0)
                                                            .toPrecision(1)
                                                            .toString() +
                                                        " Hrs",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis)),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.star,
                                                size: 25,
                                                color: HexColor("#b88c09")),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                ((details.healthScore!) / 20.0)
                                                        .toString() +
                                                    ' Stars',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis)),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.bowlFood,
                                                size: 25,
                                                color: HexColor("#b88c09")),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('${details.servings} serves',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis)),
                                          ],
                                        ),
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
            Container(
              height: 600,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmer(
      BuildContext context, double height, double width, double radius) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.black,
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
      ),
      child: ShimmerWidget.rectangular(
        height: height,
        width: width,
        br: BorderRadius.circular(radius),
      ),
    );
  }
}
