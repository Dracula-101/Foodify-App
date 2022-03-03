import 'package:flutter/material.dart';
import 'package:foodify/constants/key.dart';
import 'package:hexcolor/hexcolor.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // ignore: prefer_final_fields

  @override
  Widget build(BuildContext context) {
    initState() {
      //super.initState();
    }

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: AnimatedList(
              itemBuilder: (context, index, animation) {
                initState();
                return _buildItem(data[index], animation, index);
              },
              key: _listKey,
              initialItemCount: data.length,
            ),
          ),
          Positioned(
            bottom: 70,
            right: 15,
            child: FloatingActionButton(
              child: Icon(Icons.undo_rounded),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () => _insertSingleUndoItem(),
            ),
          )
        ],
      ),
    );
  }

  Widget _addItemButton(String item) {
    return FloatingActionButton(
      child: Icon(Icons.add),
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
        color: Color.fromARGB(248, 248, 255, 255),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        elevation: 5.0,
        borderOnForeground: true,
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.greenAccent,
              backgroundImage: AssetImage('assets/images/image 1.png')),
          title: Text(
            item,
            style: TextStyle(fontSize: 20),
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
