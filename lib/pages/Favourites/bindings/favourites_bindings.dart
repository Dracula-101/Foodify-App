import 'package:foodify/pages/Favourites/controller/favourites_controller.dart';
import 'package:get/get.dart';

class FavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouritesController());
  }
}
