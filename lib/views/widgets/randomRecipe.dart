import 'package:flutter/material.dart';
import 'package:foodify/models/recipe.api.dart';
import 'package:foodify/models/recipe.dart';
import 'package:foodify/views/widgets/recipe_card.dart';

import '../../loading/loader.dart';

class RandomRecipe extends StatefulWidget {
  const RandomRecipe({Key? key}) : super(key: key);

  @override
  State<RandomRecipe> createState() => _RandomRecipeState();
}

class _RandomRecipeState extends State<RandomRecipe> {
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  late List<Recipe> _recipes;
  bool _isLoading = true;

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
    for (var i = 0; i < _recipes.length; i++) {
      if (_recipes.elementAt(i) == null) _recipes.remove(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: _isLoading
            ? Center(child: Loader())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    id: _recipes[index].id,
                    title: _recipes[index].title,
                    cookTime:
                        _recipes[index].readyInMinutes.toString() + " mins ",
                    rating: _recipes[index].rating.toString() + " ",
                    thumbnailUrl: _recipes[index].image,
                    description: "random",
                  );
                },
              ),
      ),
    );
  }
}
