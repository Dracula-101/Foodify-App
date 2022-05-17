import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:get/get.dart';
import '../../constants/key.dart';

class Instructions extends StatelessWidget {
  List<dynamic> instructions;
  String title, url;
  Instructions(
      {Key? key,
      required this.instructions,
      required this.title,
      required this.url})
      : super(key: key);

  int findSapcing(int index) {
    if (instructions[0].steps[index].ingredients.length > 1) {
      return 2;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 2;
    // print(size);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 5)
                          ]),
                      child: IconButton(
                          onPressed: () {
                            return Get.back();
                          },
                          icon: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        // fit: BoxFit.scaleDown,
                        width: size,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                    // scrollBehavior: ScrollBehavior(),
                    // physics: BouncingScrollPhysics(),
                    controller: PageController(viewportFraction: 1),
                    children: [
                      for (int i = 0; i < instructions[0].steps.length; i++)
                        showInstructions(context, i, size)
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container showInstructions(BuildContext context, int index, double size) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.amberAccent, Colors.orange],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Step no. ${index + 1}',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    instructions[0].steps[index].step,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            if (instructions[0].steps[index].ingredients != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (instructions[0].steps[index].ingredients.length > 0)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ingredients(index, size),
                ],
              ),
            const SizedBox(
              height: 5,
            ),
            if (instructions[0].steps[index].equipment != null)
              equipments(index, size),
            if (index == instructions[0].steps.length - 1)
              Column(
                children: [
                  const SizedBox(width: 20),
                  Center(
                    child: Text(
                      'Enjoy your $title!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Center(
                    child: Icon(
                      FontAwesomeIcons.handsClapping,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.amberAccent, Colors.orange],
                        ),
                      ),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: size * 2,
                      ))
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget makeIngredientTiles(int index, double size, int i) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 10.0,
                spreadRadius: -8.0,
              ),
            ],
          ),
          child: FittedBox(
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Container(
                  width: size,
                  // padding: const EdgeInsets.all(10),
                  // margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.6),
                        blurRadius: 10.0,
                        spreadRadius: -8.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: Image_URL +
                          instructions[0].steps[index].ingredients[i].image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => ShimmerWidget.rectangular(
                        height: findSapcing(index) * 100,
                        br: BorderRadius.circular(15),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    instructions[0].steps[index].ingredients?[i].name ?? "(-)",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget makeEquipmentTile(int index, double size, int i) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 10.0,
                spreadRadius: -8.0,
              ),
            ],
          ),
          child: FittedBox(
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Container(
                  width: size,
                  // padding: const EdgeInsets.all(10),
                  // margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.6),
                        blurRadius: 10.0,
                        spreadRadius: -8.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: Image_URL +
                          instructions[0].steps[index].equipment[i].image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => ShimmerWidget.rectangular(
                        height: findSapcing(index) * 100,
                        br: BorderRadius.circular(15),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    instructions[0].steps[index].equipment?[i].name ?? "(-)",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column ingredients(int index, double size) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      // mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0;
            i < instructions[0].steps[index].ingredients.length;
            i++)
          makeIngredientTiles(index, size, i)
      ],
    );
  }

  Column equipments(int index, double size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (instructions[0].steps[index].equipment.length > 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Equiments",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        for (int i = 0; i < instructions[0].steps[index].equipment.length; i++)
          makeEquipmentTile(index, size, i)
      ],
    );
  }
}

// CachedNetworkImage(
//                                       imageUrl: Image_URL +
//                                           instructions[0]
//                                               .steps[index]
//                                               .ingredients[i]
//                                               .image,
//                                       imageBuilder: (context, imageProvider) =>
//                                           Container(
//                                         decoration: BoxDecoration(
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.black.withOpacity(0.6),
//                                               blurRadius: 30.0,
//                                               spreadRadius: -5.0,
//                                               offset: const Offset(0.0, 40.0),
//                                             ),
//                                           ],
//                                           image: DecorationImage(
//                                               image: imageProvider,
//                                               fit: BoxFit.cover),
//                                         ),
//                                       ),
//                                       placeholder: (context, url) =>
//                                           ShimmerWidget.rectangular(
//                                               height: 100,
//                                               width: 100,
//                                               br: BorderRadius.circular(0)),
//                                       errorWidget: (context, url, error) =>
//                                           const Icon(Icons.error),
//                                     )
