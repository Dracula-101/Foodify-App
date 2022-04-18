import 'package:cached_network_image/cached_network_image.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:foodify/models/recipe.api.dart';
import 'package:foodify/models/recipe.dart';
import 'package:foodify/pages/Procedure/procedure.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:get/get.dart';
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
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) {
      return SizedBox(
        height: 400,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: 3,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () {
                    return ProcedurePage(
                      id: _recipes[index].id.toString(),
                    );
                  },
                  transition: Transition.cupertino,
                );
              },
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          // offset: const Offset(
                          //   0.0,
                          //   10.0,
                          // ),
                          blurRadius: 10.0,
                          spreadRadius: -8.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        height: 400,
                        width: 300,
                        imageUrl: _recipes[index].image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            ShimmerWidget.rectangular(
                          height: 400,
                          br: BorderRadius.circular(15),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    width: 300,
                    margin: const EdgeInsets.all(20),
                    child: ClipRect(
                      // clipBehavior: Clip.antiAlias,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                        child: Container(
                          // clipBehavior: Clip.hardEdge,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          width: 400,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white12,
                              width: 2,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white70,
                                Colors.white70.withOpacity(0.1)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.1, 0.95],
                            ),
                          ),
                          child: Text(
                            _recipes[index].title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox(
        height: 400,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 5),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade200.withOpacity(0.9),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: -6.0,
                        color: Colors.white60)
                  ]),
            );
          },
        ),
      );
    }
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

// Positioned(
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 19.5, vertical: 66),
//                       padding: const EdgeInsets.all(10),
//                       // height: 50,
//                       // alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width * 0.75,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(15),
//                               bottomRight: Radius.circular(15)),
//                           color: Colors.grey.shade200.withOpacity(0.7)),
//                       child: Text(
//                           "Bruh this is the Title now\nBruh this is the Title now",
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: "PlayfairDisplay")),
//                     ),
//                   ),
//                 ),