import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'recipeSearch_card.dart';

class Cuisines extends StatefulWidget {
  String cuisine, cuisineImage;
  Cuisines({Key? key, required this.cuisine, required this.cuisineImage})
      : super(key: key);

  @override
  State<Cuisines> createState() => _CuisinesState();
}

class _CuisinesState extends State<Cuisines> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          Get.to(() {
            return RecipeSearchCard(
              title: widget.cuisine,
              isCuisine: true,
            );
          },
              transition: Transition.cupertino,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Stack(
            children: [
              Align(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.shade200.withOpacity(0.9)),
                  child: Text(
                    widget.cuisine,
                    style: const TextStyle(fontSize: 23, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage(
                  widget.cuisineImage,
                ),
                fit: BoxFit.cover),
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
}
