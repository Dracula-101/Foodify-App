import 'package:flutter/material.dart';
import 'package:foodify/pages/Favourites/controller/favourites_controller.dart';
import 'package:foodify/views/widgets/searchbar.dart';
import 'package:get/get.dart';

class Favourites extends StatelessWidget {
  Favourites({Key? key}) : super(key: key);
  final FavouritesController controller = Get.put(FavouritesController());

  @override
  Widget build(BuildContext context) {
    return Stack(children: const [
      Image(image: AssetImage('assets/images/img_veggieimage.png')),
    ]);
  }
}
