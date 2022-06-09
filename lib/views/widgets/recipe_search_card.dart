import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:foodify/loading/loader.dart';
import 'package:foodify/models/recipe_search.api.dart';
import 'package:foodify/models/recipe_search.dart';
import 'package:foodify/views/widgets/recipe_card.dart';

class RecipeSearchCard extends StatefulWidget {
  final String title;
  final bool isCuisine;
  const RecipeSearchCard({
    Key? key,
    required this.title,
    required this.isCuisine,
  }) : super(key: key);

  @override
  State<RecipeSearchCard> createState() => _RecipeSearchCardState();
}

class _RecipeSearchCardState extends State<RecipeSearchCard> {
  late List<RecipeSearch> _recipes;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    if (widget.isCuisine) {
      getCuisine();
    } else {
      getRecipes();
    }
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeSearchApi.getRecipe(widget.title);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getCuisine() async {
    _recipes = await RecipeSearchApi.getCuisine(widget.title);
    setState(() {
      _isLoading = false;
    });
  }

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        title: Text("Recipes for " + widget.title),
        elevation: 0.0,
      ),
      body: Container(
        child: _isLoading
            ? const Center(child: Loader())
            : _recipes.isEmpty
                ? Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/notfound.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  )
                                ]),
                          ),
                          const SizedBox(height: 30),
                          Text("No recipes found for " + widget.title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ]),
                  )
                : FadingEdgeScrollView.fromScrollView(
                    child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: _recipes.length,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return RecipeCard(
                        id: _recipes[index].id,
                        title: _recipes[index].title,
                        cookTime:
                            _recipes[index].cookTime.toString() + " mins ",
                        thumbnailUrl: _recipes[index].image,
                        rating: _recipes[index].rating.toString() + " ",
                        vegetarian: _recipes[index].vegetarian,
                        calories: _recipes[index].calories,
                        caloriesUnit: _recipes[index].caloriesUnit,
                        description: "search",
                      );
                    },
                  )),
      ),
    );
  }
}
