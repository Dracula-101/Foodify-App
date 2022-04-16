// import 'package:flutter/material.dart';
// import 'package:foodify/models/recipe_suggest.api.dart';

// class ListSearch extends StatefulWidget {
//   const ListSearch({Key? key}) : super(key: key);

//   @override
//   ListSearchState createState() => ListSearchState();
// }

// class ListSearchState extends State<ListSearch> {
//   final TextEditingController _textController = TextEditingController();

//   static List<String> mainDataList = [
//     "Chicken Tikka Masala",
//     "Indian Chai",
//     "Butter Chicken",
//     "Samosas",
//     "Paneer Tikka",
//   ];

//   // Copy Main List into New List.
//   List<String> newDataList = List.from(mainDataList);

//   onItemChanged(String value) async {
//     await RecipeSuggestionAPI.getSuggestion(value).then((value) {
//       setState(() {
//         newDataList = value;
//       });
//     });
//     setState(() {
//       newDataList = mainDataList
//           .where((string) => string.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextField(
//               controller: _textController,
//               decoration: const InputDecoration(
//                 hintText: 'Search Here...',
//               ),
//               onChanged: onItemChanged,
//             ),
//           ),
//           // Expanded(
//           //   child: ListView(
//           //     padding: const EdgeInsets.all(12.0),
//           //     children: newDataList.map((data) {
//           //       return ListTile(
//           //         title: Text(data),
//           //         onTap: () => print(data),
//           //       );
//           //     }).toList(),
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }

// // Search bar in app bar flutter
// class SearchAppBar extends StatefulWidget {
//   const SearchAppBar({Key? key}) : super(key: key);

//   @override
//   _SearchAppBarState createState() => _SearchAppBarState();
// }

// class _SearchAppBarState extends State<SearchAppBar> {
//   Widget appBarTitle = const Text("AppBar Title");
//   Icon actionIcon = const Icon(Icons.search);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
//         IconButton(
//           icon: actionIcon,
//           onPressed: () {
//             setState(() {
//               if (actionIcon.icon == Icons.search) {
//                 actionIcon = const Icon(Icons.close);
//                 appBarTitle = const TextField(
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search, color: Colors.white),
//                       hintText: "Search...",
//                       hintStyle: TextStyle(color: Colors.white)),
//                 );
//               } else {
//                 actionIcon = const Icon(Icons.search);
//                 appBarTitle = const Text("AppBar Title");
//               }
//             });
//           },
//         ),
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:foodify/models/recipe_suggest.api.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<Search> {
  List<String> dishes = [
    "Chicken Tikka Masala",
    "Indian Chai",
    "Butter Chicken",
    "Samosas",
    "Paneer Tikka",
  ];
  List<String>? locationList;
  var locationDataList = <String>[];

  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  Icon _searchIcon = const Icon(Icons.search);

  void _searchPressed(String title) {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
      } else {
        _searchIcon = const Icon(Icons.search);
        _filter.clear();
      }
    });
  }

  setTextStyle() {
    return const TextStyle(color: Colors.white);
  }

  @override
  void initState() {
    super.initState();
    print("object");
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          updateFilter(_searchText);
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          updateFilter(_searchText);
        });
      }
    });
  }

  void updateFilter(String text) {
    print("updated Text: ${text}");
    filterSearchResults(text);
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(locationList!);
    print("List size : " + dummySearchList.length.toString());
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        locationDataList.clear();
        locationDataList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        locationDataList.clear();
        locationDataList.addAll(dishes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (locationList == null) {
      locationList = <String>[];
      locationList!.addAll(dishes);
      locationDataList.addAll(locationList!);
    }

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _filter,
              onChanged: (value) async {
                await RecipeSuggestionAPI.getSuggestion(value).then((value) {
                  setState(() {
                    locationList = value;
                    locationDataList.clear();
                    locationDataList.addAll(locationList!);
                  });
                });
                setState(() {
                  _searchText = value;
                  updateFilter(_searchText);
                });
              },
              decoration: InputDecoration(
                labelStyle: setTextStyle(),
                labelText: "Search",
                prefixIcon: IconButton(
                  icon: _searchIcon,
                  onPressed: () {
                    _searchPressed(context.widget.runtimeType.toString());
                  },
                ),
                hintText: 'Search for recipes',
                hintStyle: setTextStyle(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: locationDataList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 4.0),
                    child: Card(
                      child: ListTile(
                        title: Text(locationDataList[index]),
                        leading: const CircleAvatar(),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
