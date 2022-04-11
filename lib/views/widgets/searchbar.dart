import 'package:flutter/material.dart';
import 'package:foodify/views/widgets/recipeSearch_card.dart';
import 'package:get/get.dart';

class SearchBar extends StatefulWidget {
  String text;
  bool? searched = false;
  String? searchedRecipe;
  TextEditingController searchController = TextEditingController();
  SearchBar({Key? key, required this.text}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
  }

  bool _folded = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Align(
        child: Wrap(
          children: [
            AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: _folded ? 56 : 350,
                // alignment: Alignment.topRight,
                height: 56,
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                  boxShadow: kElevationToShadow[6],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: !_folded
                                ? TextField(
                                    controller: widget.searched! == false
                                        ? widget.searchController
                                        : null,
                                    style: TextStyle(
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
                                    onSubmitted: (value) {
                                      setState(() {
                                        Get.to(() => RecipeSearchCard(
                                              title: value,
                                              isCuisine: false,
                                            ));
                                      });
                                    },
                                  )
                                : null)),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(_folded ? 32 : 0),
                              topRight: const Radius.circular(32),
                              bottomLeft: Radius.circular(_folded ? 32 : 0),
                              bottomRight: const Radius.circular(32),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Icon(
                                    _folded ? Icons.search : Icons.close,
                                    color: Colors.blue[900],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                widget.searched = false;
                                print('Recipe cancelled');
                                _folded = !_folded;
                              });
                            },
                          ),
                        )),
                  ],
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                widget.text,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "lorabold700",
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 30,
                  // decorationThickness: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        alignment: Alignment.topLeft,
      ),
    );
  }
}
