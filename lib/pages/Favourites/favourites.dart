import 'package:flutter/material.dart';
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
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Log Out'),
          ),
        ),
      ],
    ));
  }
}





  //
  // @override
  // Widget build(BuildContext context) {
  //   return Stack(children: const [
  //     Image(image: AssetImage('assets/images/img_veggieimage.png')),
  //     ElevatedButton(
  //       onPressed: () {
  //         await FirebaseAuth.instance.signOut();
  //       },
  //       child: Text('Create Account'),
  //     )
  //   ]);
  // }

