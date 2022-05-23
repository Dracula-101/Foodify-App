import 'package:flutter/material.dart';
import 'package:foodify/loading/loadingPlate.dart';
import 'package:foodify/main.dart';
import 'package:foodify/pages/Favourites/controller/favourites_controller.dart';
import 'package:foodify/pages/Login/loginpage.dart';
import 'package:foodify/views/widgets/searchbar.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  Widget buildFav(BuildContext context) {
    return GetX<FavouritesController>(
        init: FavouritesController(),
        builder: (controller) => controller.isLoading.value
            ? const Center(child: LoadingPlate())
            : Expanded(
                child: GetX<FavouritesController>(
                  init: FavouritesController(),
                  builder: (controller) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      itemCount: controller.favouritesList.length,
                      itemBuilder: (context, index) {
                        return FavouritesCard(
                          recipeName: controller.favouritesList
                              .elementAt(index)
                              .recipeName,
                          id: controller.favouritesList.elementAt(index).id,
                          imageUrl: controller.favouritesList
                              .elementAt(index)
                              .imageUrl,
                          rating:
                              controller.favouritesList.elementAt(index).rating,
                          cooktime: controller.favouritesList
                              .elementAt(index)
                              .cooktime,
                        );
                      },
                    );
                  },
                ),
              ));
  }

  Widget showNoFav(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
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
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.emoji_food_beverage_outlined,
                    size: 100,
                    color: Colors.amberAccent,
                  ),
                  Text(
                    "Add Favourites to see your recipes here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "lorabold700",
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      // decorationThickness: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ]),
          ),
        ),
      ],
    );
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
              color: Colors.black54,
              fontSize: 30,
              // decorationThickness: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Expanded(
        //   child: GetBuilder<FavouritesController>(
        //     init: FavouritesController(),
        //     builder: (controller) => controller.isLoading.value
        //         ? Center(child: const LoadingPlate())
        //         : buildFav(context),
        //   ),
        // ),
        Obx(
          () => controller.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : controller.favouritesList.isEmpty
                  ? showNoFav(context)
                  : buildFav(context),
        ),
      ],
    ));
  }

  static void removeFavourites(String string) {
    controller.removeFavourite(string);
    controller.removeFromDatabase(string);
  }

  static void updateFavourites(String recipeName, String id, String imageUrl,
      String rating, String cooktime) async {
    await controller.addToDatabase(recipeName, id, imageUrl, rating, cooktime);
  }

  static bool checkIfLiked(String id) {
    for (int i = 0; i < controller.favouritesList.length; i++) {
      if (controller.favouritesList[i].id == id) {
        return true;
      }
    }
    return false;
  }
}
