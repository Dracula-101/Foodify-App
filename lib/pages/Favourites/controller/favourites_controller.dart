// ignore_for_file: deprecated_member_use, unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodify/views/widgets/fav_card.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController with StateMixin<dynamic> {
  var favouritesList = <FavouritesCard>[].obs;
  var isLoading = true.obs;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getFromDatabase().then((value) => changeLoading());
  }

  void deleteDuplicates() {
    //delete duplicates
    List<FavouritesCard> list = favouritesList;
    List<FavouritesCard> newList = <FavouritesCard>[];
    for (int i = 0; i < list.length; i++) {
      if (!newList.contains(list[i])) {
        newList.add(list[i]);
      }
    }
    favouritesList.value = newList;
  }

  void addFavourites(String recipeName, String id, String imageUrl,
      String rating, String cooktime) {
    favouritesList.add(FavouritesCard(
        recipeName: recipeName,
        id: id,
        imageUrl: imageUrl,
        rating: rating,
        cooktime: cooktime));
    favouritesList = favouritesList.toSet().toList().obs;
    update();
  }

  void removeFavourite(String id) {
    favouritesList.removeWhere((element) => element.id == id);
    update();
  }

  void removeFromDatabase(String id) {
    FirebaseFirestore.instance
        .collection('favourites')
        .doc(user!.uid)
        .collection('favourites')
        .doc(id)
        .delete();
  }

  Future<void> addToDatabase(String recipeName, String id, String imageUrl,
      String rating, String cooktime) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favourites')
        .doc(id)
        .set({
      'recipeName': recipeName,
      'id': id,
      'cookTime': cooktime,
      'rating': rating,
      'imageUrl': imageUrl
    });
  }

  void changeLoading() {
    isLoading.value = false;
    update();
  }

  Future<void> getFromDatabase() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favourites')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        favouritesList.add(FavouritesCard(
            recipeName: value.docs[i].data()['recipeName'],
            id: value.docs[i].data()['id'],
            imageUrl: value.docs[i].data()['imageUrl'],
            rating: value.docs[i].data()['rating'],
            cooktime: value.docs[i].data()['cookTime']));
      }
      favouritesList = favouritesList.toSet().toList().obs;
      update();
    });
  }
}
