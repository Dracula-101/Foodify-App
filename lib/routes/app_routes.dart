import 'package:foodify/pages/Favourites/bindings/favourites_bindings.dart';
import 'package:foodify/pages/Favourites/favourites.dart';
import 'package:foodify/pages/Home/bindings/home_binding.dart';
import 'package:foodify/pages/Home/home.dart';
import 'package:foodify/pages/RandomRecipe/bindings/random_recipe_bindings.dart';
import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:get/get.dart';

class AppRoutes {
  String recipeDetails = '/recipeDetails';

  String searchRecipes = '/searchRecipes';

  static List<GetPage> pages = [
    GetPage(
      name: "Random Recipe",
      page: () => const RandomRecipe(),
      bindings: [
        RandomRecipeBinding(),
      ],
    ),
    GetPage(
      name: "Home",
      page: () => const Home(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: "Favourites",
      page: () => const Favourites(),
      bindings: [
        FavouritesBinding(),
      ],
    ),
    // GetPage(
    //   name: "Recipe Details",
    //   page: () => RecipeDetails(),
    //   bindings: [],
    // ),
  ];
}
