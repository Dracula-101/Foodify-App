// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:flutter/material.dart';
import 'package:foodify/views/widgets/randomRecipe.dart';
import 'package:foodify/views/widgets/searchbar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // scrollDirection: Axis.vertical,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          // child:
          // TextField(
          //   controller: !searched
          //       ? TextEditingController(
          //           text: '',
          //         )
          //       : null,
          //   decoration: InputDecoration(
          //     suffixIcon: searched
          //         ? IconButton(
          //             icon: const Icon(
          //               Icons.cancel,
          //             ),
          //             onPressed: () {
          //               setState(() {
          //                 searched = false;
          //                 print('Recipe cancelled');
          //               });
          //             },
          //           )
          //         : const Icon(
          //             Icons.search,
          //           ),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(20.0),
          //     ),
          //     hintText: 'Search',
          //   ),
          //   onSubmitted: (value) {
          //     setState(() {
          //       searched = true;
          //       searchedRecipe = value;
          //       print('Recipe Searched');
          //     });
          //   },
          // ),
        ),
        Align(
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(80, 17, 10, 20),
                child: Align(
                  child: Text(
                    "Recipes for you",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "lorabold700",
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 26,
                      // decorationThickness: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
                child: Align(child: SearchBar(), alignment: Alignment.topLeft),
              ),
            ],
          ),
          alignment: Alignment.topLeft,
        ),
        RandomRecipe()
      ],
    );
  }
}
