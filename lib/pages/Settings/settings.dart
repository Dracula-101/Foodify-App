import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/constants/key.dart';
import 'package:foodify/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:foodify/views/widgets/recipeSearch_card.dart';
import 'package:foodify/views/widgets/scrolling_parallax.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    getCuisine('rice');
  }

  static Future<String> getCuisine(String title) async {
    var uri = Uri.https(BASE_URL, '/recipes/cuisine', {
      "title": title,
      "apiKey": apiKey.first,
    });
    print('okat');
    print(uri);

    final response =
        await http.get(uri, headers: {"Content-Type": "application/json"});

    Map data = jsonDecode(response.body);

    if (data['code'] == 402) {
      changeAPiKey();
      return getCuisine(title);
    }

    if (data['code'] == 200) {
      print(data);
    }

    return "";
  }

  TextEditingController controller = TextEditingController();
  List<String> list = [
    "Chicken soup",
    "Paneer tikka",
    "Chicken tikka",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: size.height * 0.08,
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.grey[500]!.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      FontAwesomeIcons.envelope,
                      size: 27,
                      color: Colors.white,
                    ),
                  ),
                  hintText: 'Enter Your Dish name',
                  hintStyle: TextStyle(
                      fontSize: 21, color: Colors.white54, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 21, color: Colors.white, height: 1.5),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (text) {
                  if (text == '') return;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Colors.white,
  //       body: Column(
  //         children: [
  //           GFSearchBar(
  //             controller: controller,
  //             searchList: list,
  //             searchQueryBuilder: (query, list) {
  //               return list
  //                   .where((item) => item
  //                       .toString()
  //                       .toLowerCase()
  //                       .contains(query.toLowerCase()))
  //                   .toList();
  //             },
  //             noItemsFoundWidget: Container(),
  //             overlaySearchListHeight: 200,
  //             searchBoxInputDecoration: InputDecoration(
  //               hintText: "Search Videos",
  //               hintStyle: const TextStyle(color: Colors.white),
  //               suffixIcon: IconButton(
  //                 icon: const Icon(
  //                   Icons.search,
  //                   color: Colors.amberAccent,
  //                 ),
  //                 onPressed: () async {
  //                   // getVideos();
  //                   list.add(controller.text);
  //                   setState(() {
  //                     // _isSearched = true;
  //                   });
  //                 },
  //               ),
  //             ),
  //             overlaySearchListItemBuilder: (item) {
  //               return Container(
  //                 padding: const EdgeInsets.all(8),
  //                 child: Text(
  //                   item.toString(),
  //                   style: const TextStyle(fontSize: 18),
  //                 ),
  //               );
  //             },
  //             onItemSelected: (item) {
  //               setState(() {
  //                 print('$item');
  //               });
  //             },
  //           ),
  //           Column(
  //             children: [
  //               SizedBox(
  //                 height: 100,
  //               ),
  //               Container(
  //                 width: 300,
  //                 height: 300,
  //                 margin: const EdgeInsets.all(10),
  //                 padding: const EdgeInsets.all(10),
  //                 decoration: BoxDecoration(
  //                     image: const DecorationImage(
  //                       image: AssetImage("assets/images/videofinder.png"),
  //                       fit: BoxFit.cover,
  //                     ),
  //                     borderRadius: BorderRadius.all(Radius.circular(90)),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.grey.withOpacity(0.5),
  //                         spreadRadius: 5,
  //                         blurRadius: 7,
  //                         offset: Offset(0, 3), // changes position of shadow
  //                       )
  //                     ]),
  //               ),
  //             ],
  //           )
  //           // _isSearched
  //           //     ? Container(
  //           //         margin: const EdgeInsets.all(10),
  //           //         padding: const EdgeInsets.all(10),
  //           //         child: Image.asset(
  //           //           'assets/images/videofinder.png',
  //           //           fit: BoxFit.cover,
  //           //         ))
  //           //     : _isLoading
  //           //         ? Center(
  //           //             child: CircularProgressIndicator(),
  //           //           )
  //           //         : Expanded(
  //           //             child: FadingEdgeScrollView.fromScrollView(
  //           //                 child: ListView.builder(
  //           //               shrinkWrap: true,
  //           //               physics: const BouncingScrollPhysics(
  //           //                   parent: BouncingScrollPhysics()),
  //           //               itemCount: _videos.length,
  //           //               itemBuilder: (context, index) {
  //           //                 return VideoWidget(
  //           //                   title: _videos[index].title,
  //           //                   length: _videos[index].length,
  //           //                   thumbnail: _videos[index].thumbnail,
  //           //                   youtubeId: _videos[index].youtubeId,
  //           //                   views: _videos[index].views,
  //           //                 );
  //           //               },
  //           //             )),
  //           //           ),
  //         ],
  //       ));
  // }
}
