import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodify/models/recipeFind.dart';
import 'package:get/get.dart';
import "dart:io";

import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';

import '../views/widgets/recipeFind.dart';

class Prediction extends StatefulWidget {
  List<XFile>? images;
  var recognitions;
  Prediction({Key? key, required this.images, this.recognitions})
      : super(key: key);

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  String returnResult() {
    return widget.recognitions![0]['label'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Food recognition",
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: "OpenSans-Regular"),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(30.0),
            //   child: Container(
            //     padding: const EdgeInsets.all(20),
            //     child: image,
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
            //       // image: DecorationImage(
            //       //   colorFilter: ColorFilter.mode(
            //       //     Colors.black.withOpacity(0.5),
            //       //     BlendMode.multiply,
            //       //   ),
            //       //   image: NetworkImage(thumbnailUrl),
            //       //   fit: BoxFit.cover,
            //       // ),
            //     ),
            //   ),
            // ),
            // Expanded(
            //   child: ListView(children: [
            //     GridView.builder(
            //         padding: const EdgeInsets.all(0),
            //         physics: const NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         clipBehavior: Clip.antiAlias,
            //         addRepaintBoundaries: false,
            //         gridDelegate:
            //             const SliverGridDelegateWithMaxCrossAxisExtent(
            //                 maxCrossAxisExtent: 20),
            //         itemCount: images?.length,
            //         itemBuilder: (BuildContext ctx, index) {
            //           return Padding(
            //             padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(20),
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.white,
            //                     offset: const Offset(
            //                       0.0,
            //                       0.0,
            //                     ),
            //                     // blurRadius: 1.0,
            //                     // spreadRadius: 0.2,
            //                   ),
            //                 ],
            //                 // color: Colors.white,
            //               ),
            //               // height: 352,
            //               // width: 140,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   Container(
            //                     height: 100,
            //                     width: 120,
            //                     child: const Image(
            //                       image: const AssetImage(
            //                           'assets/images/img_mtzzd5z720.png'),
            //                       fit: BoxFit.cover,
            //                     ),
            //                     decoration: BoxDecoration(
            //                       color: Colors.amber,
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.black.withOpacity(0.6),
            //                           offset: const Offset(
            //                             0.0,
            //                             10.0,
            //                           ),
            //                           blurRadius: 10.0,
            //                           spreadRadius: -6.0,
            //                         ),
            //                       ],
            //                       borderRadius: BorderRadius.circular(15),
            //                     ),
            //                   ),
            //                   Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceAround,
            //                     children: [
            //                       const Text(
            //                         'Hellllo',
            //                         style: const TextStyle(
            //                           fontSize: 20,
            //                         ),
            //                       ),
            //                       IconButton(
            //                         onPressed: () {},
            //                         icon: const Icon(Icons.delete),
            //                       ),
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             ),
            //           );
            //         }),
            //   ]),
            // ),
            // const SizedBox(height: 10),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: GridView.builder(
                    dragStartBehavior: DragStartBehavior.start,
                    itemCount: widget.images?.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Image.file(
                              File(widget.images!.elementAt(index).path),
                              fit: BoxFit.cover,
                              height: size.height,
                              width: size.width,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 10.0,
                                      spreadRadius: -6.0,
                                    ),
                                  ],
                                  // image: DecorationImage(
                                  //   colorFilter: ColorFilter.mode(
                                  //     Colors.black.withOpacity(0.5),
                                  //     BlendMode.multiply,
                                  //   ),
                                  //   image: ),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                margin: const EdgeInsets.all(5),
                                child: IconButton(
                                  iconSize: 30,
                                  onPressed: () {
                                    setState(() {
                                      widget.images!.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                  )),
            ),

            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    // height: 100,\

                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.9),
                          // blurRadius: 4.0,
                          // spreadRadius: -6.0,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 70),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: Colors.amberAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 10.0,
                            spreadRadius: -6.0,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          print("object");
                        },
                        child: const Text(
                          'Predict Images',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontFamily: "OpenSans-Regular",
                          ),
                        ),
                      ),
                    )))
          ],
        ));
  }
}




// TextButton(
//                   child: Text("Add to cart".toUpperCase(),
//                       style: TextStyle(fontSize: 14)),
//                   style: ButtonStyle(
//                       padding: MaterialStateProperty.all<EdgeInsets>(
//                           EdgeInsets.all(15)),
//                       foregroundColor:
//                           MaterialStateProperty.all<Color>(Colors.red),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                               side: BorderSide(color: Colors.red)))),
//                   onPressed: () {
//                     Get.to(() => RecipeFindClass(
//                           ingredients: returnResult(),
//                           ranking: '1',
//                           pantry: true,
//                         ));
//                   }),
