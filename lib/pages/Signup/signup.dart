import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/main.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  String? _email, _password, _confirmpassword;

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
          // BackgroundImage(image: 'assets/images/register_bg.png'),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400]!.withOpacity(
                                0.4,
                              ),
                              child: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                                size: size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        left: size.width * 0.56,
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            FontAwesomeIcons.arrowUp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
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
                                    FontAwesomeIcons.user,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: 'User',
                                hintStyle: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    height: 1.5),
                              ),
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  height: 1.5),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                String name = text;
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
                                    FontAwesomeIcons.envelope,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    height: 1.5),
                              ),
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  height: 1.5),
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
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    height: 1.5),
                              ),
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  height: 1.5),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                _password = text;
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
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    height: 1.5),
                              ),
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  height: 1.5),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              onChanged: (text) {
                                _confirmpassword = text;
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
                          onPressed: () async {
                            if (_password == _confirmpassword) {
                              bool userCreated = await createUser();
                              if (userCreated) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage()),
                                );
                              }
                            } else {
                              print('Passwords don\'t match');
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontSize: 22, color: Colors.white, height: 1.5),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> createUser() async {
    try {
      final newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email!, password: _password!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Account already exists",
          "",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Account already exists');
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          "Password too weak",
          "Minimum Password length is 6 characters",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Minimum length of the password should be 6 characters');
      }
      return false;
    }
    return true;
  }
}

class a {
  static String? _email, _password;
  static Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: _email!,
        password: _password!,
      );
      user = userCredential.user;
      await user!.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }
}
