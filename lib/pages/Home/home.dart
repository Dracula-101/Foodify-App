// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:flutter/material.dart';
import 'package:foodify/pages/RandomRecipe.dart/random_recipe.dart';
import 'package:foodify/views/widgets/searchbar.dart';
import 'package:foodify/views/widgets/trending.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        SearchBar(
          text: "Recipes for you",
        ),
        Expanded(
          child: ListView(
            children: [
              const TrendingWidget(),
              const RandomRecipe(),
            ],
          ),
        )
      ],
    );
  }
}
