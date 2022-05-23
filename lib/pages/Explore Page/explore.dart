import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:foodify/views/widgets/recipe_card.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import '../../models/recipe.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key? key, required this.recipes}) : super(key: key);
  List<Recipe> recipes;

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  static bool _isLoading = true;
  final _controller = ScrollController();

  Widget buildRecipes(BuildContext context) {
    return FadingEdgeScrollView.fromScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
        controller: _controller,
        itemCount: widget.recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            id: widget.recipes[index].id,
            title: widget.recipes[index].title,
            cookTime:
                widget.recipes[index].readyInMinutes.toString() + " mins ",
            rating: widget.recipes[index].rating.toString() + " ",
            thumbnailUrl: widget.recipes[index].image,
            description: "random",
            calories: "-1",
            caloriesUnit: "cal",
            vegetarian: widget.recipes[index].vegetarian,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recipes for you'),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: ListView(
          addAutomaticKeepAlives: true,
          cacheExtent: 2000,
          children: [buildRecipes(context), RandomRecipe()],
        ));
  }
}
