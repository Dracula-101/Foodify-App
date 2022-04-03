import 'package:foodify/models/recipeFind.dart';
import 'package:foodify/pages/RandomRecipe.dart/bindings/random_recipe_bindings.dart';
import 'package:foodify/pages/RandomRecipe.dart/random_recipe.dart';
import 'package:get/get.dart';

class AppRoutes {
  String recipeDetails = '/recipeDetails';

  String searchRecipes = '/searchRecipes';

  static List<GetPage> pages = [
    GetPage(
      name: "Random Recipe",
      page: () => RandomRecipe(),
      bindings: [
        RandomRecipeBinding(),
      ],
    ),
    // GetPage(
    //   name: "Recipe Details",
    //   page: () => RecipeDetails(),
    //   bindings: [],
    // ),
  ];
}
