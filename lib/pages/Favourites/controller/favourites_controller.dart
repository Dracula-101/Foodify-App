// ignore_for_file: deprecated_member_use

import 'package:foodify/pages/Favourites/models/favourites_model.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController with StateMixin<dynamic> {
  Rx<FavouritesModels> favouriteModels = FavouritesModels().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
