import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/pages/Signup/signup.dart';

import '../../main.dart';

class LoginPage extends StatelessWidget {
  static String _email = '', _password = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Authentication'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      'Foodybite',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Icon(
                                  FontAwesomeIcons.envelope,
                                  size: 27,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white54,
                                  height: 1.5),
                            ),
                            style: TextStyle(
                                fontSize: 21, color: Colors.white, height: 1.5),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onChanged: (text) {
                              _email = text;
                            },
                          ),
                        ),
                      ),
                    ),
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white54,
                                  height: 1.5),
                            ),
                            obscureText: true,
                            style: TextStyle(
                                fontSize: 21, color: Colors.white, height: 1.5),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            onChanged: (text) {
                              _password = text;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          bool loggedIn = await login();
                          if (loggedIn) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeDrawer();
                            }), (route) => false);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Container(
                    child: Text(
                      'Create New Account',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Future<bool> login() async {
    if (_email == '') {
      Get.snackbar(
        "Email field empty",
        "Please enter your Details",
        colorText: Colors.black,
        duration: Duration(seconds: 2),
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (_password == '') {
      Get.snackbar(
        "Password field empty",
        "Please enter your Details",
        colorText: Colors.black,
        duration: Duration(seconds: 2),
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "No User found",
          "Please create a new account",
          colorText: Colors.black,
          duration: Duration(seconds: 2),
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Password Incorrect",
          "Please enter correct E-mail and Password",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Wrong password provided for that user.');
      } else if (e.code == 'too-many-requests') {
        Get.snackbar(
          "Too many wrong attempts",
          "Please try again later",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          "Invalid Email",
          "Please recheck your Email",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Wrong password provided for that user.');
      }

      print('User !logged in ...${e.code}');
      return false;
    }
    Get.snackbar(
      "Login successful",
      "Redirecting to Home Page",
      colorText: Colors.black,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
    print('User logged in ...');
    return true;
  }
}
