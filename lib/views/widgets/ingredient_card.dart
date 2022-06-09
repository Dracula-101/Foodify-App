import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodify/views/widgets/shimmer_widget.dart';
import 'package:hexcolor/hexcolor.dart';

class Ingredient_Card extends StatelessWidget {
  final String vegetableName;

  const Ingredient_Card({Key? key, required this.vegetableName})
      : super(key: key);

  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.all(10),
  //     height: 170,
  //     width: 170,
  //     decoration: BoxDecoration(
  //       borderRadius: const BorderRadius.all(Radius.circular(15)),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.6),
  //           offset: const Offset(
  //             0.0,
  //             10.0,
  //           ),
  //           blurRadius: 10.0,
  //           spreadRadius: -6.0,
  //         ),
  //       ],
  //     ),
  //     child: Stack(
  //       children: [
  //         Align(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: <Widget>[
  //               Text(vegetableName,
  //                   maxLines: 1,
  //                   style: TextStyle(
  //                       fontFamily: "playfairdisplaybold700", fontSize: 15)),
  //               Icon(Icons.delete_forever_outlined)
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      margin: const EdgeInsets.all(10),
      width: (MediaQuery.of(context).size.width) / 2.3,
      height: 180,
      child: (Column(
        children: [
          Container(
            child: CachedNetworkImage(
              imageUrl:
                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
              imageBuilder: (context, imageProvider) => Container(
                // width: 80.0,
                // height: 80.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    vegetableName,
                    style: TextStyle(fontSize: 19, color: HexColor("#ffffff")),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                alignment: Alignment.bottomLeft,
              ),
              Align(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    child: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 59, 160, 255),
                      size: 30,
                    ),
                    onTap: () {
                      print("Hellloe");
                    },
                  ),
                ),
                alignment: Alignment.bottomRight,
              ),
            ],
          )
        ],
      )),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
      ),
    );
    // return Container(
    //   height: 70,
    //   width: 70,
    //   child: Card(
    //       elevation: 2,
    //       clipBehavior: Clip.antiAlias,
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //       child: Column(
    //         children: [
    //           Expanded(
    //             flex: 2,
    //             child: SizedBox.expand(
    //               child: Image.network('https://source.unsplash.com/random'),
    //             ),
    //           ),
    //           Expanded(
    //             flex: 1,
    //             child: Container(
    //               child: Text("hello"),
    //             ),
    //           )
    //         ],
    //       )),
    // );
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
