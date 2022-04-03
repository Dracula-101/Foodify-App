// import 'dart:html';

import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/pages/Favourites/controller/favourites_controller.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:get/get.dart';

class FavouritesCard extends StatelessWidget {
  String recipeName, id, imageUrl, rating, cooktime;
  FavouritesCard({
    Key? key,
    required this.recipeName,
    required this.id,
    required this.imageUrl,
    required this.rating,
    required this.cooktime,
  }) : super(key: key);
  final FavouritesController controller = Get.put(FavouritesController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(110, 20, 25, 20),
          child: InkWell(
            onTap: () {
              Get.snackbar(
                recipeName,
                "Rating : $rating\tCooktime : $cooktime",
                icon: Icon(Icons.person, color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20, top: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(
                      recipeName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.schedule, size: 20),
                            Text(
                              cooktime.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.star_border, size: 20),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.rate_review, size: 20),
                            Text(
                              "4.5",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          // margin: const EdgeInsets.all(30),
        ),
        Container(
          width: 120,
          height: 120,
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
            shape: BoxShape.circle,
            color: Colors.amberAccent,
          ),
          child: Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.all(10),
            // padding: const EdgeInsets.all(10),
            // alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => ShimmerWidget.rectangular(
                  height: 180, br: BorderRadius.circular(15)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFe0f2f1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              controller.removeFavourite(id);
            },
            child: Container(
                // margin: const EdgeInsets.only(right: 20, top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                child: Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.red,
                  size: 35,
                )),
          ),
        ),
      ],
    );
  }
}
