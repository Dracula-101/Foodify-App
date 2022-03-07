import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodify/models/recipeDetails.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:hexcolor/hexcolor.dart';

class RecipeCard extends StatelessWidget {
  final int id;
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;

  RecipeCard({
    required this.id,
    required this.title,
    required this.cookTime,
    required this.rating,
    required this.thumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          // getRecipeDetails(id.toString());
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: thumbnailUrl,
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
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              // CachedNetworkImage(
              //   fit: BoxFit.fitWidth,
              //   imageUrl: thumbnailUrl,
              //   placeholder: (context, url) => buildShimmer(context),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
              // FadeInImage.memoryNetwork(
              //     fit: BoxFit.scaleDown,
              //     width: MediaQuery.of(context).size.width,
              //     height: 180,
              //     // fit: BoxFit.fitWidth,
              //     // fadeInDuration: Duration(microseconds: 500),
              //     placeholder: kTransparentImage,
              //     image: thumbnailUrl),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 19, color: HexColor("#ffffff")),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                alignment: Alignment.center,
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
                            rating,
                            style: TextStyle(
                                fontSize: 12, color: HexColor("#ffffff")),
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                            cookTime,
                            style: TextStyle(
                                fontSize: 12, color: HexColor("#ffffff")),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
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
