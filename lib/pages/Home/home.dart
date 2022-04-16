// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:flutter/material.dart';
import 'package:foodify/loading/loadingPlate.dart';
import 'package:foodify/models/recipe_suggest.api.dart';
import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:foodify/views/widgets/recipeSearch_card.dart';
import 'package:foodify/views/widgets/search.dart';
import 'package:foodify/views/widgets/searchbar.dart';
import 'package:foodify/views/widgets/trending.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  List<String> list = [
    "Chicken Tikka Masala",
    "Indian Chai",
    "Butter Chicken",
    "Samosas",
    "Paneer Tikka",
  ];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
              splashColor: Colors.grey,
              icon: const Icon(Icons.close),
              onPressed: () {
                searchController.clear();
              },
            ),
          ],
        ),
      ), //Searchbar
      // Search(),pub
      // GFSearchBar(
      //   searchList: list,
      //   searchQueryBuilder: (query, list) {
      //     return list
      //         .where((item) =>
      //             item.toString().toLowerCase().contains(query.toLowerCase()))
      //         .toList();
      //   },
      //   noItemsFoundWidget: Container(),
      //   searchBoxInputDecoration: InputDecoration(
      //     iconColor: Colors.amberAccent,
      //     hintText: "Search for a recipe",
      //     border: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.amberAccent),
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //     suffix: InkWell(
      //         onTap: () {
      //           RecipeSearchCard(
      //               title: searchController.text, isCuisine: false);
      //         },
      //         child: Icon(Icons.search)),
      //   ),
      //   overlaySearchListItemBuilder: (item) {
      //     return Container(
      //       padding: const EdgeInsets.all(10),
      //       child: Text(
      //         item.toString(),
      //         style: const TextStyle(fontSize: 20),
      //       ),
      //     );
      //   },
      //   onItemSelected: (item) {
      //     print('$item');
      //   },
      // ),
      Expanded(
        child: ListView(
          cacheExtent: 10000,
          addAutomaticKeepAlives: true,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                "Trending",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const TrendingWidget(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                "Recipes for you",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const RandomRecipe(),
          ],
        ),
      )
    ]);
  }
}
