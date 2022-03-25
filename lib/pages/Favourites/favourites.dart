// import 'dart:html';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:foodify/pages/Favourites/controller/favourites_controller.dart';
import 'package:get/get.dart';

import '../../views/widgets/fav_card.dart';

class Favourites extends StatelessWidget {
  Favourites({
    Key? key,
  }) : super(key: key);
  static FavouritesController controller = Get.put(FavouritesController());

  static addFavourites(String recipeName, String id, String imageUrl,
      String rating, String cooktime) {
    controller.addFavourites(recipeName, id, imageUrl, rating, cooktime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: const Text(
            "Favourites",
            style: TextStyle(
              fontFamily: "lorabold700",
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 30,
              // decorationThickness: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: GetX<FavouritesController>(
              init: FavouritesController(),
              builder: (controller) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemCount: controller.favouritesList.length,
                  itemBuilder: (context, index) {
                    return FavouritesCard(
                      recipeName:
                          controller.favouritesList.elementAt(index).recipeName,
                      id: controller.favouritesList.elementAt(index).id,
                      imageUrl:
                          controller.favouritesList.elementAt(index).imageUrl,
                      rating: controller.favouritesList.elementAt(index).rating,
                      cooktime:
                          controller.favouritesList.elementAt(index).cooktime,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
