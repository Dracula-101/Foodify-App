import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:foodify/models/recipe.api.dart';
import 'package:foodify/models/recipe.dart';
import 'package:foodify/views/widgets/recipe_card.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late List<Recipe> _recipes;
  bool _isLoading = false;
  static const historyLength = 5;
  late List<String> filteredSearchHistory;
  late String selectedTerm;
  bool _folded = true;

// The "raw" history that we don't access from the UI, prefilled with values
  final List<String> _searchHistory = [
    'fuchsia',
    'flutter',
    'widgets',
    'resocoder',
  ];

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      // This method will be implemented soon
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    //filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    //filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void initState() {
    super.initState();
    //filteredSearchHistory = filterSearchTerms(filter: null);
    //getRecipes();
  }

  //const Favourites({Key? key}) : super(key: key);
  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : AnimatedContainer(
                duration: Duration(milliseconds: 400),
                width: _folded ? 56 : 300,
                height: 56,
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                  boxShadow: kElevationToShadow[6],
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                      child: !_folded
                          ? TextField(
                              decoration: InputDecoration(
                                  hintText: 'Search Recipes',
                                  hintStyle: TextStyle(color: Colors.blue[300]),
                                  border: InputBorder.none),
                            )
                          : null,
                    )),
                    AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(_folded ? 32 : 0),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(_folded ? 32 : 0),
                              bottomRight: Radius.circular(32),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                _folded ? Icons.search : Icons.close,
                                color: Colors.blue[900],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _folded = !_folded;
                              });
                            },
                          ),
                        ))
                  ],
                )));
  }

  Widget _buildRecipeCard(BuildContext context, int index) {
    return Scaffold(
        body: ListView.builder(
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(
            title: _recipes[index].title,
            cookTime: _recipes[index].readyInMinutes.toString() + " mins",
            rating: _recipes[index].weightWatcherSmartPoints.toString() + " ",
            thumbnailUrl: _recipes[index].image);
      },
    ));
  }
}
