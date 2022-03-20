import 'package:foodify/pages/RandomRecipe.dart/randomRecipe.dart';
import 'package:get/get.dart';

class RandomRecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => const RandomRecipe());
  }
}
