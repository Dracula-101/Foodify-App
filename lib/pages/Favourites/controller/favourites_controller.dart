// ignore_for_file: deprecated_member_use, unnecessary_overrides

import 'package:foodify/pages/Favourites/models/favourites_model.dart';
import 'package:foodify/views/widgets/fav_card.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController with StateMixin<dynamic> {
  var favouritesList = <FavouritesCard>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addFavourites(String recipeName, String id, String imageUrl,
      String rating, String cooktime) {
    favouritesList;
    favouritesList.add(FavouritesCard(
      recipeName: recipeName,
      id: id,
      imageUrl: imageUrl,
      rating: rating,
      cooktime: cooktime,
    ));
    update();
  }
}
