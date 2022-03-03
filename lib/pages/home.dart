import 'package:flutter/material.dart';
import 'package:foodify/loading/loader.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:foodify/constants/key.dart';

import '../models/recipe.api.dart';
import '../models/recipe.dart';
import '../views/widgets/recipe_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  void initState() {
    super.initState();
    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Search',
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          const Text(
            "Recipes for you",
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: "playfairdisplaybold700",
              color: Colors.greenAccent,
              fontSize: 30,
              decorationThickness: 10,
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: Loader())
                : ListView.builder(
                    itemCount: _recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(
                          id: _recipes[index].id,
                          title: _recipes[index].title,
                          cookTime: _recipes[index].readyInMinutes.toString() +
                              " mins ",
                          rating: _recipes[index].rating.toString() + " ",
                          thumbnailUrl: _recipes[index].image);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildFoodShimmer() => ListTile(
        title: ShimmerWidget.rectangular(
          height: 180,
          br: BorderRadius.circular(15),
        ),
      );
}
