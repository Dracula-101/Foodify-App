import 'package:cached_network_image/cached_network_image.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:foodify/models/recipe.api.dart';
import 'package:foodify/models/recipe.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:getwidget/components/loader/gf_loader.dart';

class TrendingWidget extends StatefulWidget {
  const TrendingWidget({Key? key}) : super(key: key);

  @override
  State<TrendingWidget> createState() => _TrendingWidgetState();
}

class _TrendingWidgetState extends State<TrendingWidget> {
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  late List<Recipe> _recipes;
  bool _isLoading = true;

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getTrending();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: Loader())
        : Container(
            height: 350,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics:
                  const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          child: CachedNetworkImage(
                            imageUrl: _recipes[index].image,
                            placeholder: (context, url) {
                              return ShimmerWidget.rectangular(
                                  height: 267, br: BorderRadius.circular(15));
                            },
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _recipes[index].title,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget buildShimmer(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
        ),
        child: ShimmerWidget.rectangular(
          height: 180,
          br: BorderRadius.circular(15),
        ),
      );
}
