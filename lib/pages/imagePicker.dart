import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import "dart:io";

import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  List<XFile>? images;
  var recognitions;
  ImageSelector({Key? key, required this.images, this.recognitions})
      : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
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
                      child: InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              //could change this to Color(0xFF737373),
                              //so you don't have to change MaterialApp canvasColor
                              child: Column(
                                children: [
                                  // Container(
                                  //   height: size.height,
                                  //   width: size.width,
                                  //   padding: const EdgeInsets.all(20),
                                  //   margin: const EdgeInsets.all(20),
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white,
                                  //     borderRadius:
                                  //         BorderRadius.all(Radius.circular(10)),
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: Colors.black.withOpacity(0.6),
                                  //         blurRadius: 10.0,
                                  //         spreadRadius: -6.0,
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   child:
                                  // ),
                                  Expanded(
                                    child: CustomScrollView(
                                      slivers: [
                                        const SliverAppBar(
                                          backgroundColor: Colors.white,
                                          shape: ContinuousRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30))),
                                          flexibleSpace: FlexibleSpaceBar(
                                            titlePadding: EdgeInsets.fromLTRB(
                                                50, 10, 0, 10),
                                            title: Text(
                                              "Selected image",
                                              textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: "OpenSans-Regular",
                                              ),
                                            ),
                                          ),
                                          pinned: true,
                                        ),
                                        SliverList(
                                          delegate: SliverChildListDelegate(
                                            [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                margin:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      blurRadius: 10.0,
                                                      spreadRadius: -6.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Image.file(
                                                  File(widget.images!
                                                      .elementAt(index)
                                                      .path),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // showModalBottomSheet(
                            //       context: context,
                            //       builder: (builder) {
                            //         return Container(
                            //           height: 350.0,
                            //           color: Colors
                            //               .transparent, //could change this to Color(0xFF737373),
                            //           //so you don't have to change MaterialApp canvasColor
                            //           child: Container(
                            //             decoration: const BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius: BorderRadius.only(
                            //                     topLeft: Radius.circular(10.0),
                            //                     topRight: Radius.circular(10.0))),
                            //             child: Image.file(
                            //               File(widget.images!
                            //                   .elementAt(index)
                            //                   .path),
                            //               fit: BoxFit.cover,
                            //               height: size.height,
                            //               width: size.width,
                            //             ),
                            //           ),
                            // );
                            // }
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 10.0,
                                spreadRadius: -6.0,
                              ),
                            ],
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
                                    iconSize: 20,
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
