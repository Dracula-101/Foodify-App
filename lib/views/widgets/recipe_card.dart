import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/pages/Procedure/procedure.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:foodify/pages/Favourites/favourites.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class RecipeCard extends StatefulWidget {
  final int id;
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;
  final bool vegetarian;
  final String calories;
  final String caloriesUnit;
  final String description;

  RecipeCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.rating,
      required this.cookTime,
      required this.thumbnailUrl,
      required this.vegetarian,
      required this.calories,
      required this.caloriesUnit,
      required this.description})
      : super(key: key);

  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          Get.to(() {
            return ProcedurePage(id: widget.id.toString());
          }, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'location-img-' + widget.id.toString(),
                child: CachedNetworkImage(
                  imageUrl: widget.thumbnailUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.multiply,
                          ),
                          image: imageProvider,
                          fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => ShimmerWidget.rectangular(
                      height: 180, br: BorderRadius.circular(15)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 19, color: HexColor("#ffffff")),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                alignment: Alignment.center,
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    if (!isLiked) {
                      Favourites.addFavourites(
                          widget.title,
                          widget.id.toString(),
                          widget.thumbnailUrl,
                          widget.rating,
                          widget.cookTime);
                      Favourites.updateFavourites(
                        widget.title,
                        widget.id.toString(),
                        widget.thumbnailUrl,
                        widget.rating,
                        widget.cookTime,
                      );
                    } else {
                      Favourites.removeFavourites(widget.id.toString());
                    }

                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            !isLiked
                                ? const Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.redAccent,
                                    size: 18,
                                  )
                                : const Icon(
                                    CupertinoIcons.heart_solid,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                            const SizedBox(width: 6),
                            Text(
                              "Like  ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: HexColor("#ffffff")),
                            ),
                          ])),
                ),
              ),
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              widget.rating,
                              style: TextStyle(
                                  fontSize: 12, color: HexColor("#ffffff")),
                            ),
                          ],
                        )),
                    widget.description == "search"
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/fire.png',
                                    height: 18,
                                    width: 18,
                                  ),
                                  const SizedBox(width: 9),
                                  Text(
                                    widget.calories + " " + widget.caloriesUnit,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor("#ffffff")),
                                  ),
                                ]))
                        : Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.schedule,
                                    color: Colors.yellow,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 9),
                                  Text(
                                    widget.cookTime,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor("#ffffff")),
                                  ),
                                ])),
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
              Align(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(15)),
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
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 7),
                      child: widget.vegetarian
                          ? Image.asset(
                              'assets/images/veg.png',
                              height: 40,
                              width: 40,
                            )
                          : Image.asset(
                              'assets/images/non-veg.png',
                              height: 40,
                              width: 40,
                            ),
                    )),
                alignment: Alignment.topLeft,
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            // color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.6),
                offset: const Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            // image: DecorationImage(
            //   colorFilter: ColorFilter.mode(
            //     Colors.black.withOpacity(0.5),
            //     BlendMode.multiply,
            //   ),
            //   image: NetworkImage(thumbnailUrl),
            //   fit: BoxFit.cover,
            // ),
          ),
        ));
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
