import 'package:flutter/material.dart';
import 'package:foodify/models/recipeFind.api.dart';
import 'package:foodify/models/recipeFind.dart';
import 'package:foodify/views/widgets/recipe_find_card.dart';

import '../../loading/loader.dart';

class RecipeFindClass extends StatefulWidget {
  final String ingredients;
  final String ranking;
  final bool pantry;
  const RecipeFindClass(
      {Key? key,
      required this.ingredients,
      required this.ranking,
      required this.pantry})
      : super(key: key);

  @override
  State<RecipeFindClass> createState() => _RecipeFindClassState();
}

class _RecipeFindClassState extends State<RecipeFindClass> {
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  late List<RecipeFind> _recipes;
  bool _isLoading = true;

  Future<void> getRecipes() async {
    _recipes = await RecipeFindApi.getRecipe(
        widget.ingredients, widget.ranking, widget.pantry);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? Loader()
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return RecipeFindCard(
                  id: _recipes[index].id,
                  title: _recipes[index].title,
                  image: _recipes[index].image,
                  likes: _recipes[index].usedIngredientCount,
                  missedIngredientCount: _recipes[index].missedIngredientCount,
                  usedIngredientCount: _recipes[index].usedIngredientCount,
                  missedIngredients: _recipes[index].missedIngredients,
                  usedIngredients: _recipes[index].usedIngredients,
                );
              },
            ),
    );
  }
}
