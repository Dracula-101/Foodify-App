import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "dart:io";

import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../views/widgets/recipeFind.dart';

class Prediction extends StatelessWidget {
  List<XFile>? images;
  var recognitions;
  Prediction({Key? key, required this.images, this.recognitions})
      : super(key: key);
  String returnResult() {
    return recognitions![0]['label'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
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
            Expanded(
              child: ListView(children: [
                GridView.builder(
                    padding: EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    clipBehavior: Clip.antiAlias,
                    addRepaintBoundaries: false,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 170,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: images?.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 0.2,
                              ),
                            ],
                            color: Colors.white,
                          ),
                          // height: 352,
                          // width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 100,
                                width: 120,
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/img_mtzzd5z720.png'),
                                  fit: BoxFit.cover,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
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
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Hellllo',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ]),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                  child: Text("Add to cart".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    Get.to(() => RecipeFindClass(
                          ingredients: returnResult(),
                          ranking: '1',
                          pantry: true,
                        ));
                  }),
            ),
          ],
        ));
  }
}
