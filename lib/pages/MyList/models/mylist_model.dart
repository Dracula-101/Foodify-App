import 'package:flutter/material.dart';
import 'package:foodify/constants/key.dart';
import 'package:hexcolor/hexcolor.dart';

class MyListModel {
  final String title = "Hello";
  int number = 10;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  Widget _addItemButton(String item) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      onPressed: () => _insertSingleItem(item),
    );
  }

  void _insertSingleUndoItem() {
    if (deletedData != null && deletedData.isNotEmpty) {
      String deletedItem = deletedData.elementAt(0);
      data.add(deletedItem);
      deletedData.remove(deletedItem);
      _listKey.currentState!.insertItem(data.length - 1);
    }
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: const Color.fromARGB(248, 248, 255, 255),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        elevation: 5.0,
        borderOnForeground: true,
        child: ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.greenAccent,
              backgroundImage: AssetImage('assets/images/image 1.png')),
          title: Text(
            item,
            style: const TextStyle(fontSize: 20),
          ),
          trailing: GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: HexColor("#0C1E7F"),
                  child: Icon(
                    Icons.delete,
                    color: HexColor("#FFB085"),
                  ),
                ),
              ],
            ),
            onTap: () {
              _removeSingleItems(index);
            },
          ),
        ),
      ),
    );
  }

  /// Method to add an item to an index in a list
  Future<void> _insertSingleItem(String item) async {
    int insertIndex;
    if (data.length > 0) {
      insertIndex = data.length;
    } else {
      insertIndex = 0;
    }
    data.add(item); //
    _listKey.currentState!.insertItem(insertIndex);
  }

  /// Method to remove an item at an index from the list
  Future<void> _removeSingleItems(int removeAt) async {
    int removeIndex = removeAt;
    String removedItem = data.removeAt(removeIndex);
    deletedData.add(removedItem);
    // This builder is just so that the animation has something
    // to work with before it disappears from view since the original
    // has already been deleted.

    AnimatedListRemovedItemBuilder builder = (context, animation) {
      // A method to build the Card widget.
      return _buildItem(removedItem, animation, removeAt);
    };

    _listKey.currentState!.removeItem(removeIndex, builder);
  }
}
