// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:flutter/material.dart';
import 'package:foodify/loading/loadingPlate.dart';
import 'package:foodify/pages/RandomRecipe/random_recipe.dart';
import 'package:foodify/views/widgets/searchbar.dart';
import 'package:foodify/views/widgets/trending.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //
      SearchBar(
        text: "Recipes for you",
      ),
      Expanded(
        child: ListView(
          addAutomaticKeepAlives: true,
          children: [
            const TrendingWidget(),
            const RandomRecipe(),
          ],
        ),
      )
    ]);
  }
}
