import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:foodify/models/recipe_suggest.api.dart';
import 'package:foodify/models/video_finder.api.dart';
import 'package:foodify/views/widgets/video_widget.dart';

import '../../loading/loader.dart';

class VideoFinder extends StatefulWidget {
  const VideoFinder({Key? key}) : super(key: key);

  @override
  State<VideoFinder> createState() => _VideoFinderState();
}

class _VideoFinderState extends State<VideoFinder> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  List<Videos> _videos = [];
  bool isLoading = false;
  bool isCompleted = false;
  bool _isSearched = false;

  Future<void> getVideos(String query) async {
    _videos = await VideoFinderAPI.getVideos(query);
    setState(() {
      isCompleted = true;
      isLoading = !isLoading;
    });
  }

  TextEditingController controller = TextEditingController();
  List<String> list = [
    "Chicken soup",
    "Paneer tikka",
    "Chicken tikka",
  ];
  String searched = "";
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
                      searched = text;
                      setState(() {
                        _isSearched = !_isSearched;
                      });
                    },
                    onChanged: (text) async {
                      await RecipeSuggestionAPI.getSuggestion(text)
                          .then((value) => list = value);
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
                    searched = list.toString();
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
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ],
          ),
        ),
        !isCompleted && !_isSearched
            ? !_isSearched
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
                              image:
                                  AssetImage("assets/images/videofinder.png"),
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
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('Search for Recipes',
                          style: TextStyle(color: Colors.black54, fontSize: 20))
                    ],
                  )
                : const Loader()
            : _videos.isNotEmpty
                ? ListView.builder(
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
                  )
                : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          Container(
                            width: 250,
                            height: 250,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/notfound.jpg"),
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
                          const SizedBox(height: 30),
                          Text("No recipes found for " + searched,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ]),
                  )
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
