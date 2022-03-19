import '../../../models/recipe.api.dart';
import '../../../models/recipe.dart';

class FavouritesModels {
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
    if (filter.isNotEmpty) {
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

  //const Favourites({Key? key}) : super(key: key);
  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    _isLoading = false;
  }
}
