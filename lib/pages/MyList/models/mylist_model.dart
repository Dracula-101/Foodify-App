class MyListModel {
  final String title = "Hello";
  int number = 10;
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // Widget _buildItem(String item, Animation<double> animation, int index) {
  //   return SizeTransition(
  //     sizeFactor: animation,
  //     child: Card(
  //       color: const Color.fromARGB(248, 248, 255, 255),
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: Colors.white70, width: 1),
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
  //       elevation: 5.0,
  //       borderOnForeground: true,
  //       child: ListTile(
  //         leading: const CircleAvatar(
  //             backgroundColor: Colors.white,
  //             foregroundColor: Colors.greenAccent,
  //             backgroundImage: AssetImage('assets/images/image 1.png')),
  //         title: Text(
  //           item,
  //           style: const TextStyle(fontSize: 20),
  //         ),
  //         trailing: GestureDetector(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               CircleAvatar(
  //                 backgroundColor: HexColor("#0C1E7F"),
  //                 child: Icon(
  //                   Icons.delete,
  //                   color: HexColor("#FFB085"),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           onTap: () {
  //             _removeSingleItems(index);
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// Method to remove an item at an index from the list
  // Future<void> _removeSingleItems(int removeAt) async {
  //   int removeIndex = removeAt;
  //   String removedItem = data.removeAt(removeIndex);
  //   deletedData.add(removedItem);
  // This builder is just so that the animation has something
  // to work with before it disappears from view since the original
  // has already been deleted.

  //   AnimatedListRemovedItemBuilder builder = (context, animation) {
  //     // A method to build the Card widget.
  //     return _buildItem(removedItem, animation, removeAt);
  //   };

  //   _listKey.currentState!.removeItem(removeIndex, builder);
  // }
}
