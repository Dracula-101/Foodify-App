import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:get/get.dart';

class RandomRecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RandomRecipe());
  }
}
