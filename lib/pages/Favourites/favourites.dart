import 'package:flutter/material.dart';
import 'package:foodify/main.dart';
import 'package:foodify/pages/Favourites/controller/favourites_controller.dart';
import 'package:foodify/pages/Login/loginpage.dart';
import 'package:foodify/views/widgets/searchbar.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Favourites extends StatelessWidget {
  Favourites({Key? key}) : super(key: key);
  final FavouritesController controller = Get.put(FavouritesController());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Text('Log Out'),
    );
  }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Stack(children: const [
  //     Image(image: AssetImage('assets/images/img_veggieimage.png')),
  //     ElevatedButton(
  //       onPressed: () {
  //         await FirebaseAuth.instance.signOut();
  //       },
  //       child: Text('Create Account'),
  //     )
  //   ]);
  // }
}
