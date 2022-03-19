import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  bool? searched = false;
  String? searchedRecipe;
  SearchBar({Key? key}) : super(key: key);

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
      margin: const EdgeInsets.all(5),
      child: Align(
        child: AnimatedContainer(
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
                                controller: widget.searched == false
                                    ? TextEditingController(
                                        text: '',
                                      )
                                    : null,
                                onSubmitted: (value) {
                                  setState(() {
                                    widget.searched = true;
                                    widget.searchedRecipe = value;
                                    print('Recipe Searched');
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
        alignment: Alignment.topLeft,
      ),
    );
  }
}
