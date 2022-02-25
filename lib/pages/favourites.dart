import 'package:flutter/material.dart';
import 'package:foodify/models/recipe.api.dart';
import 'package:foodify/models/recipe.dart';
import 'package:foodify/views/recipeDetails.dart';
import 'package:foodify/views/widgets/recipe_card.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  void initState() {
    super.initState();
    getRecipes();
  }

  //const Favourites({Key? key}) : super(key: key);
  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _recipes[index].title,
                      cookTime:
                          _recipes[index].readyInMinutes.toString() + " mins",
                      rating:
                          _recipes[index].weightWatcherSmartPoints.toString() +
                              " ",
                      thumbnailUrl: _recipes[index].image);
                },
              ));
  }
}
