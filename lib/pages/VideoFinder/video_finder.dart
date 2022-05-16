import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
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

  late List<Videos> _videos;
  bool _isLoading = true;
  bool _isSearched = false;

  Future<void> getVideos(String query) async {
    _videos = await VideoFinderAPI.getVideos(query);
    print(_videos.length);

    print("Id is hellllllll");
    setState(() {
      _isLoading = false;
      _isSearched = true;
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
    return Column(
      children: [
        GFSearchBar(
          controller: controller,
          searchList: list,
          searchQueryBuilder: (query, list) {
            return list
                .where((item) =>
                    item.toString().toLowerCase().contains(query.toLowerCase()))
                .toList();
          },
          noItemsFoundWidget: Container(),
          searchBoxInputDecoration: InputDecoration(
            fillColor: Colors.white,
            focusColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
              gapPadding: 6,
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.amberAccent,
              ),
            ),
            hintText: "Search Videos",
            hintStyle:
                const TextStyle(color: Colors.black54, fontFamily: 'OpenSans'),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.amberAccent,
              ),
              onPressed: () async {
                getVideos(controller.text);
                list.add(controller.text);
                setState(() {
                  _isSearched = true;
                });
              },
            ),
          ),
          overlaySearchListItemBuilder: (item) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                item.toString(),
                style: const TextStyle(fontSize: 18, fontFamily: 'OpenSans'),
              ),
            );
          },
          onItemSelected: (item) {
            // getVideos();
          },
        ),
        _isSearched
            ? Container(
                width: 300,
                height: 300,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/videofinder.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      )
                    ]),
              )
            : _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: FadingEdgeScrollView.fromScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemCount: _videos.length,
                        itemBuilder: (context, index) {
                          print(_videos.length);
                          return VideoWidget(
                            title: _videos[index].title,
                            length: _videos[index].length,
                            thumbnail: _videos[index].thumbnail,
                            youtubeId: _videos[index].youtubeId,
                            views: _videos[index].views,
                          );
                        },
                      ),
                    ),
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
