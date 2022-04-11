import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/constants/key.dart';
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
  RecipeDetails? details;
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
        icon: const Icon(FontAwesomeIcons.triangleExclamation,
            color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipeDetails(widget.id);
    stepsCard = [
      if (details?.analyzedInstructions != null)
        for (int i = 0; i < details!.analyzedInstructions!.length.toInt(); i++)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                details?.analyzedInstructions![i]?.step,
                style: const TextStyle(
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
          ),
    ];

    sourceUrl =
        'https://fullbellysisters.blogspot.com/2012/06/pasta-with-garlic-scallions-cauliflower.html';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 70),
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 10.0,
              spreadRadius: -20.0,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: launchURL,
          child: const Text(
            'Get Procedure',
            style: TextStyle(
              fontSize: 25,
            ),
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
                IconButton(
                    onPressed: () {
                      return Get.back();
                    },
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.black,
                    )),
                !isLoading
                    ? CachedNetworkImage(
                        imageUrl: details?.image ??
                            'https://bitsofco.de/content/images/2018/12/broken-1.png',
                        height: 300,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 300.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 30.0,
                                spreadRadius: -5.0,
                                offset: Offset(0.0, 40.0),
                              ),
                            ],
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            ShimmerWidget.rectangular(
                                height: 300, br: BorderRadius.circular(0)),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : buildShimmer(
                        context, 300, MediaQuery.of(context).size.width, 0.0),
                Column(
                  children: [
                    const SizedBox(
                      height: 220,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
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
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Flexible(
                                          child: Text(details!.title.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 27,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(details!.extendedIngredients!.length
                                            .toString() +
                                        " Ingredients"),
                                    const SizedBox(height: 15),
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
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                details!.readyInMinutes!
                                                            .toInt() <
                                                        60
                                                    ? details!.readyInMinutes
                                                            .toString() +
                                                        " mins"
                                                    : (details!.readyInMinutes!
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
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                ((details!.healthScore!) / 20.0)
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
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text('${details!.servings} serves',
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isLoading
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ShimmerWidget.rectangular(
                        height: MediaQuery.of(context).size.height * 0.6,
                        br: BorderRadius.circular(20)),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0;
                            i < details!.extendedIngredients!.length;
                            i++)
                          Column(
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    child: CachedNetworkImage(
                                      imageUrl: Image_URL +
                                          details!.extendedIngredients![i].image
                                              .toString(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          ShimmerWidget.rectangular(
                                              height: 180,
                                              br: BorderRadius.circular(50)),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      details!.extendedIngredients![i].original
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
            isLoading
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ShimmerWidget.rectangular(
                        height: 200, br: BorderRadius.circular(20)),
                  )
                : Container(
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              details!.vegetarian ?? false
                                  ? Image.asset(
                                      'assets/images/veg.png',
                                      height: 30,
                                      width: 30,
                                    )
                                  : Image.asset(
                                      'assets/images/non-veg.png',
                                      height: 30,
                                      width: 30,
                                    ),
                              const SizedBox(width: 4),
                              Text(
                                details!.vegetarian ?? false
                                    ? ' Vegetarian'
                                    : 'Non Vegetarian',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                details!.veryHealthy ?? false
                                    ? const Icon(
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        CupertinoIcons.clear_thick_circled,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                const SizedBox(width: 10),
                                Text(
                                  details!.veryHealthy ?? false
                                      ? ' Very Healthy'
                                      : 'Not Healthy',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(children: [
                              details!.cheap ?? false
                                  ? const Icon(
                                      CupertinoIcons.checkmark_alt_circle_fill,
                                      color: Colors.green,
                                      size: 30,
                                    )
                                  : const Icon(
                                      CupertinoIcons.clear_thick_circled,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                              const SizedBox(width: 10),
                              Text(
                                details!.cheap ?? false
                                    ? ' Ketogenic'
                                    : 'Not Ketogenic',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ]),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                details!.dairyFree ?? false
                                    ? const Icon(
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        CupertinoIcons.clear_thick_circled,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                const SizedBox(width: 10),
                                Text(
                                  details!.dairyFree ?? false
                                      ? ' Dairy Free'
                                      : 'Not Dairy Free',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                details!.glutenFree ?? false
                                    ? const Icon(
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        CupertinoIcons.clear_thick_circled,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                const SizedBox(width: 10),
                                Text(
                                  details!.glutenFree ?? false
                                      ? ' Gluten Free'
                                      : 'Not Gluten Free',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                details!.vegan ?? false
                                    ? const Icon(
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        CupertinoIcons.clear_thick_circled,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                const SizedBox(width: 10),
                                Text(
                                  details!.vegan ?? false
                                      ? ' Vegan'
                                      : 'Non Vegan',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
            if (details?.dishTypes != null)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: (Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dish Types',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        children: details!.dishTypes!.map((dishType) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.amberAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7, // changes position of shadow
                                ),
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Center(
                                child: Text(
                                  dishType,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ])),
              ),
            if (details?.analyzedInstructions != null)
              (Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                ],
              )),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Html(
                      data: details?.summary ?? 'Summary not available',
                    ),
                  ),
                ],
              ),
            )
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
