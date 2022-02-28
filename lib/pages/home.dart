import 'package:flutter/material.dart';
import 'package:foodify/loading/loader.dart';

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
  }

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        TextField(
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
                              " mins",
                          rating: _recipes[index].rating.toString() + " ",
                          thumbnailUrl: _recipes[index].image);
                    },
                  )),
      ]),
    );
  }
}
