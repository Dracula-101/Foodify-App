// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:foodify/loading/loadingPlate.dart';
import 'package:foodify/models/recipe.dart';
import 'package:foodify/models/recipe_suggest.api.dart';
import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:foodify/views/widgets/recipeSearch_card.dart';
import 'package:foodify/views/widgets/search.dart';
import 'package:foodify/views/widgets/searchbar.dart';
import 'package:foodify/views/widgets/trending.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> list = [
    "Chicken Tikka Masala",
    "Indian Chai",
    "Butter Chicken",
    "Samosas",
    "Paneer Tikka",
  ];
  late List<Recipe> _recipes;
  TextEditingController searchController = TextEditingController();
  Widget? trendingRecipes = const TrendingWidget(),
      randomRecipes = new RandomRecipe();

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      key: refreshIndicatorKey,
      onRefresh: () async {
        print("refreshing");
        setState(() {
          randomRecipes = new RandomRecipe();
        });
      },
      child: Column(children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: <Widget>[
              IconButton(
                splashRadius: 20,
                splashColor: Colors.grey,
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              Expanded(
                  child: TextField(
                onTap: () {},
                controller: searchController,
                // onChanged: (value) async {
                //   await RecipeSuggestionAPI.getSuggestion(value)
                //       .then((value) => list = value);
                // },
                onSubmitted: (value) {
                  Get.to(RecipeSearchCard(
                    title: value,
                    isCuisine: false,
                  ));
                  searchController.clear();
                },
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Search Recipes"),
                // onChanged: (text) {
                //   widget.searched = true;
                //   widget.searchedRecipe = text;
                //   print('Recipe Searched');
                // },
              )),
              IconButton(
                splashRadius: 20,
                splashColor: Colors.grey,
                icon: const Icon(Icons.close),
                onPressed: () {
                  searchController.clear();
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            cacheExtent: 10000,
            addAutomaticKeepAlives: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      "Trending",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              trendingRecipes!,
              // const TrendingWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Recipes for you",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "See All ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: Colors.amberAccent, size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              randomRecipes!,
              // const RandomRecipe(),
            ],
          ),
        )
      ]),
    );
  }
}
