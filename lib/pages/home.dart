// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:flutter/material.dart';
import 'package:foodify/views/widgets/randomRecipe.dart';
import 'package:foodify/views/widgets/recipeSearch_card.dart';

import 'package:foodify/constants/key.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool searched = false;
  String? searchedRecipe;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: TextField(
            controller: !searched
                ? TextEditingController(
                    text: '',
                  )
                : null,
            decoration: InputDecoration(
              suffixIcon: searched
                  ? IconButton(
                      icon: Icon(
                        Icons.cancel,
                      ),
                      onPressed: () {
                        setState(() {
                          searched = false;
                          print('Recipe cancelled');
                        });
                      },
                    )
                  : Icon(
                      Icons.search,
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: 'Search',
            ),
            onSubmitted: (value) {
              setState(() {
                searched = true;
                searchedRecipe = value;
                print('Recipe Searched');
              });
            },
          ),
        ),
        // SearchBar(),

        // Align(
        //   child: Stack(
        //     children: [
        //       // const Padding(
        //       //   padding: EdgeInsets.fromLTRB(80, 17, 10, 20),
        //       //   child: Align(
        //       //     child: Text(
        //       //       "Recipes for you",
        //       //       textDirection: TextDirection.ltr,
        //       //       textAlign: TextAlign.center,
        //       //       style: TextStyle(
        //       //         fontFamily: "lorabold700",
        //       //         color: Color.fromARGB(255, 0, 0, 0),
        //       //         fontSize: 26,
        //       //         // decorationThickness: 10,
        //       //         fontWeight: FontWeight.bold,
        //       //       ),
        //       //     ),
        //       //     alignment: Alignment.centerLeft,
        //       //   ),
        //       // ),
        //       // Padding(
        //       //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
        //       //   child: const Align(
        //       //       child: SearchBar(), alignment: Alignment.topLeft),
        //       // ),
        //     ],
        //   ),
        //   alignment: Alignment.topLeft,
        // ),
        getcards(),
      ],
    );
  }

  getcards() {
    if (searched && searchedRecipe != null) {
      print('Searched true');
      return RecipeSearchCard(
        title: searchedRecipe!,
      );
    } else {
      print('Searched false');
      return RandomRecipe();
    }
  }
}
