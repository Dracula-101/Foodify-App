import 'package:flutter/material.dart';
import 'package:foodify/models/recipe.api.dart';
import 'package:foodify/models/recipe.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:foodify/views/widgets/recipe_card.dart';
import 'package:getwidget/getwidget.dart';

import '../../loading/loader.dart';

class RandomRecipe extends StatefulWidget {
  RandomRecipe({Key? key}) : super(key: key);

  @override
  State<RandomRecipe> createState() => _RandomRecipeState();

  static late List<Recipe> recipes;
  static callFunction(context) {
    _RandomRecipeState.rebuildAllChildren(context);
  }
}

class _RandomRecipeState extends State<RandomRecipe> {
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  static bool _isLoading = true;

  Future<void> getRecipes() async {
    RandomRecipe.recipes = await RecipeApi.getRecipe();

    setState(() {
      _isLoading = false;
    });
  }

  static rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    if (!_isLoading) {
      return FadingEdgeScrollView.fromScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
          controller: _controller,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 55),
          itemCount: RandomRecipe.recipes.length,
          itemBuilder: (context, index) {
            return RecipeCard(
              id: RandomRecipe.recipes[index].id,
              title: RandomRecipe.recipes[index].title,
              cookTime: RandomRecipe.recipes[index].readyInMinutes.toString() +
                  " mins ",
              rating: RandomRecipe.recipes[index].rating.toString() + " ",
              thumbnailUrl: RandomRecipe.recipes[index].image,
              description: "random",
              calories: "-1",
              caloriesUnit: "cal",
              vegetarian: RandomRecipe.recipes[index].vegetarian,
            );
          },
        ),
      );
    } else {
      return FadingEdgeScrollView.fromScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
          controller: _controller,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 55),
          itemCount: 10,
          itemBuilder: (context, index) {
            return GFShimmer(
              mainColor: Colors.white,
              secondaryColor: Colors.grey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(color: Colors.white70, width: 5),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: MediaQuery.of(context).size.width,
                height: 180,
              ),
            );
          },
        ),
      );
    }
  }
}
