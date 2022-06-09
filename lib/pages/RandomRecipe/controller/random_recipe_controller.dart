import 'package:foodify/models/recipe.api.dart';
import 'package:foodify/models/recipe.dart';
import 'package:get/get.dart';

class RandomRecipeController extends GetxController with StateMixin<dynamic> {
  List<Recipe> recipes = <Recipe>[];
  final _recipes = <Recipe>[].obs;
  var isLoading = false.obs;

  isLoaded() {}

  Future<void> getRecipes() async {
    recipes = await RecipeApi.getRecipe();
    _recipes.value = recipes;
    isLoading.value = false;
  }
}
