import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodify/pages/Favourites/controller/favourites_controller.dart';
import 'package:foodify/pages/Procedure/procedure.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:get/get.dart';

class FavouritesCard extends StatelessWidget {
  final String recipeName, id, imageUrl, rating, cooktime;
  final FavouritesController controller = Get.put(FavouritesController());
  FavouritesCard({
    Key? key,
    required this.recipeName,
    required this.id,
    required this.imageUrl,
    required this.rating,
    required this.cooktime,
  }) : super(key: key);

  showAlertDialog(BuildContext dialogContext, String recipeName) {
    // set up the button
    actionButton(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                controller.removeFavourite(id);
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Text("Yes",
                    style: TextStyle(color: Colors.black, fontSize: 17)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Text("No",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ))),
            ),
          ],
        ),
      );
    }

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      title: const Text("Delete from favourites"),
      content: Text("Are you sure you want to delete " + recipeName + "?"),
      actions: [
        actionButton(dialogContext),
      ],
    );

    // show the dialog
    showDialog(
      context: dialogContext,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(110, 20, 25, 20),
          child: InkWell(
            onTap: () {
              Get.to(
                () {
                  return ProcedurePage(
                    id: id.toString(),
                  );
                },
                transition: Transition.cupertino,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20, top: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(
                      recipeName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            RatingBarIndicator(
                              rating: double.parse(rating),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.schedule, size: 20),
                            Text(
                              cooktime.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          // margin: const EdgeInsets.all(30),
        ),
        Container(
          width: 120,
          height: 120,
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
            shape: BoxShape.circle,
            color: Colors.amberAccent,
          ),
          child: Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.all(10),
            // padding: const EdgeInsets.all(10),
            // alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => ShimmerWidget.rectangular(
                  height: 180, br: BorderRadius.circular(15)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFe0f2f1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            radius: 20,
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              showAlertDialog(context, recipeName);
              // showAlertDialog(
              //     context, recipeName);
              //g // controller.removeFavourite(id);
            },
            child: Container(
                // margin: const EdgeInsets.only(right: 20, top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                child: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.red,
                  size: 35,
                )),
          ),
        ),
      ],
    );
  }
}
