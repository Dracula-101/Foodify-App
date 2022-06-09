import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodify/pages/Login/loginpage.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/main.dart';
import 'dart:ui';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email = '', _password = '', _confirmpassword = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.webp'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.3,
                  ),
                  // Center(
                  //   child: ClipOval(
                  //     child: BackdropFilter(
                  //       filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  //       child: CircleAvatar(
                  //         radius: size.width * 0.14,
                  //         backgroundColor: Colors.grey[400]!.withOpacity(
                  //           0.4,
                  //         ),
                  //         child: Icon(
                  //           FontAwesomeIcons.user,
                  //           color: Colors.white,
                  //           size: size.width * 0.1,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const Text(
                    'Welcome to Foodify',
                    style: TextStyle(
                        fontFamily: "Amsterdam-ZVGqm",
                        fontSize: 27,
                        color: Colors.amberAccent),
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
                          child: const Center(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
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
                              style: const TextStyle(
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
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
                              style: const TextStyle(
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
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
                              style: const TextStyle(
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
                      const SizedBox(
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
                            if (_email == '') {
                              Get.snackbar(
                                "Email field empty",
                                "Please enter your Details",
                                colorText: Colors.black,
                                duration: const Duration(seconds: 2),
                                icon: const Icon(Icons.person,
                                    color: Colors.white),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            if (_password == '') {
                              Get.snackbar(
                                "Password field empty",
                                "Please enter your Details",
                                colorText: Colors.black,
                                duration: const Duration(seconds: 2),
                                icon: const Icon(Icons.person,
                                    color: Colors.white),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            if (_confirmpassword == '') {
                              Get.snackbar(
                                "Confirm Password Empty",
                                "Please enter your Password again",
                                colorText: Colors.black,
                                duration: const Duration(seconds: 2),
                                icon: const Icon(Icons.person,
                                    color: Colors.white),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            if (_password == _confirmpassword) {
                              bool userCreated =
                                  await createUser(_email, _password);
                              if (userCreated) {
                                Get.snackbar(
                                  "Account created successfuly",
                                  "Redirecting to Home Page",
                                  colorText: Colors.black,
                                  duration: const Duration(seconds: 2),
                                  icon: const Icon(Icons.person,
                                      color: Colors.white),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const MyHomePage()),
                                // );
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomeDrawer();
                                }), (route) => false);
                              }
                            } else {
                              Get.snackbar(
                                'Passwords don\'t match',
                                "Please verify your passwords",
                                colorText: Colors.black,
                                duration: const Duration(seconds: 2),
                                icon: const Icon(Icons.person,
                                    color: Colors.white),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                              // Navigator.pushNamed(context, '/');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
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
                      const SizedBox(
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

  Future<bool> createUser(String _email, String _password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Account already exists",
          "",
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          "Password too weak",
          "Minimum Password length is 6 characters",
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return false;
    }
    return true;
  }
}

class App {
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
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return user;
  }
}
