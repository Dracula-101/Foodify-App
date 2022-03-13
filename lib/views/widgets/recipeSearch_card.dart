import 'package:flutter/material.dart';
import 'package:foodify/loading/loader.dart';
import 'package:foodify/models/recipeSearch.api.dart';
import 'package:foodify/models/recipeSearch.dart';
import 'package:foodify/views/widgets/recipe_card.dart';

class RecipeSearchCard extends StatefulWidget {
  const RecipeSearchCard({Key? key}) : super(key: key);

  @override
  State<RecipeSearchCard> createState() => _RecipeSearchCardState();
}

class _RecipeSearchCardState extends State<RecipeSearchCard> {
  String title = "Butter Chicken";
  late List<RecipeSearch> _recipes;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeSearchApi.getRecipe(title);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? Center(child: Loader())
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  id: _recipes[index].id,
                  title: _recipes[index].title,
                  cookTime: _recipes[index].cookTime.toString() + " mins ",
                  thumbnailUrl: _recipes[index].image,
                  rating: _recipes[index].rating.toString() + " ",
                  description: "search",
                );
              },
            ),
    );
  }
}
