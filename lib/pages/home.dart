// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:flutter/material.dart';
import 'package:foodify/views/widgets/randomRecipe.dart';
import 'package:foodify/views/widgets/searchbar.dart';
import 'package:foodify/constants/key.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       suffixIcon: Icon(
          //         Icons.search,
          //       ),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(20.0),
          //       ),
          //       hintText: 'Search',
          //     ),
          //   ),
          // ),
          // SearchBar(),
          // SizedBox(
          //   height: 5,
          // ),
          Align(
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 90),
                  child: Align(
                    child: Text(
                      "Recipes for you",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "lorabold700",
                        color: Colors.amber,
                        fontSize: 30,
                        // decorationThickness: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
                  child: const Align(
                      child: SearchBar(), alignment: Alignment.topLeft),
                ),
              ],
            ),
            alignment: Alignment.topLeft,
          ),
          RandomRecipe()
        ],
      ),
    );
  }
}
