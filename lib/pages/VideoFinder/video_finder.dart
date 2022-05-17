import 'dart:developer';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:foodify/models/recipe_suggest.api.dart';
import 'package:foodify/models/video_finder.api.dart';
import 'package:foodify/views/widgets/video_widget.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';

class VideoFinder extends StatefulWidget {
  const VideoFinder({Key? key}) : super(key: key);

  @override
  State<VideoFinder> createState() => _VideoFinderState();
}

class _VideoFinderState extends State<VideoFinder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  late List<Videos> _videos;
  bool _isSearched = false;
  bool isCompleted = false;

  Future<void> getVideos(String query) async {
    _videos = await VideoFinderAPI.getVideos(query);
    setState(() {
      _isSearched = true;
      isCompleted = true;
    });
  }

  TextEditingController controller = TextEditingController();
  List<String> list = [
    "Chicken soup",
    "Paneer tikka",
    "Chicken tikka",
  ];

  @override
  Widget build(BuildContext context) {
    log('vid rrrr');
    return ListView(
      children: [
        // Container(
        //   decoration: const BoxDecoration(
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black12,
        //           blurRadius: 10,
        //           spreadRadius: 5,
        //         ),
        //       ],
        //       borderRadius: BorderRadius.all(Radius.circular(15))),
        //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //   child: Row(
        //     children: <Widget>[
        //       IconButton(
        //         splashRadius: 20,
        //         splashColor: Colors.grey,
        //         icon: const Icon(Icons.search),
        //         onPressed: () {},
        //       ),
        //       Expanded(
        //           child: TextField(
        //         onTap: () {},
        //         controller: searchController,
        //         onChanged: (value) async {
        //           await RecipeSuggestionAPI.getSuggestion(value)
        //               .then((value) => list = value);
        //         },
        //         onSubmitted: (value) {
        //           getVideos(value);
        //           list.add(value);
        //           setState(() {
        //             _isSearched = !_isSearched;
        //           });
        //         },
        //         style: const TextStyle(
        //           fontSize: 17,
        //           color: Colors.black,
        //         ),
        //         cursorColor: Colors.black,
        //         decoration: const InputDecoration(
        //             border: InputBorder.none,
        //             focusedBorder: InputBorder.none,
        //             enabledBorder: InputBorder.none,
        //             errorBorder: InputBorder.none,
        //             disabledBorder: InputBorder.none,
        //             hintText: "Search Videos"),
        //         // onChanged: (text) {
        //         //   widget.searched = true;
        //         //   widget.searchedRecipe = text;
        //         //   print('Recipe Searched');
        //         // },
        //       )),
        //       IconButton(
        //         splashRadius: 20,
        //         splashColor: Colors.grey,
        //         icon: const Icon(Icons.close),
        //         onPressed: () {
        //           searchController.clear();
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              IconButton(
                splashRadius: 20,
                splashColor: Colors.grey,
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              Expanded(
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: searchController,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Search Videos",
                    ),
                    onSubmitted: (text) {
                      getVideos(text);
                      list.add(text);
                      setState(() {
                        _isSearched = !_isSearched;
                      });
                    },
                    onChanged: (text) async {
                      await RecipeSuggestionAPI.getSuggestion(text)
                          .then((value) => list = value);
                      print('Recipe Searched');
                    },
                  ),
                  suggestionsCallback: (pattern) async {
                    // await RecipeSuggestionAPI.getSuggestion(pattern)
                    //     .then((value) => list = value);
                    return list;
                  },
                  itemBuilder: (context, list) {
                    return ListTile(
                      title: Text(list.toString()),
                    );
                  },
                  onSuggestionSelected: (list) {
                    searchController.text = list.toString();
                    getVideos(list.toString());
                    setState(() {
                      _isSearched = !_isSearched;
                    });
                  },
                ),
              ),
              IconButton(
                splashRadius: 20,
                splashColor: Colors.grey,
                icon: const Icon(Icons.close),
                onPressed: () {
                  searchController.clear();
                },
              ),
            ],
          ),
        ),
        !isCompleted
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/videofinder.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          )
                        ]),
                  ),
                ],
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemCount: _videos.length,
                itemBuilder: (context, index) {
                  return VideoWidget(
                    title: _videos[index].title,
                    length: _videos[index].length,
                    thumbnail: _videos[index].thumbnail,
                    youtubeId: _videos[index].youtubeId,
                    views: _videos[index].views,
                  );
                },
              ),
      ],
    );
  }
}

// if (!_isLoading) {
// return ListView.builder(
//   shrinkWrap: true,
//   physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
//   itemCount: _videos.length,
//   itemBuilder: (context, index) {
//     return VideoWidget(
//       title: _videos[index].title,
//       length: _videos[index].length,
//       thumbnail: _videos[index].thumbnail,
//       youtubeId: _videos[index].youtubeId,
//       views: _videos[index].views,
//     );
//   },
// );
//     } else {
//       return Container();
//     }
