import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodify/pages/Signup/signup.dart';

import '../../main.dart';

class LoginPage extends StatelessWidget {
  static String? _email, _password;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Authentication'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            onChanged: (text) {
              _email = text;
            },
          ),
          TextField(
            controller: passwordController,
            onChanged: (text) {
              _password = text;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
              // bool loggedIn = await login();
              // if (loggedIn) {
              //   // Navigator.pop(context);

              // }
            },
            child: Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () async {
              bool loggedIn = await login();
              if (loggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              }
            },
            child: Text('Create Account'),
          )
        ],
      ),
    );
  }

  static Future<bool> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email!, password: _password!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print('User !logged in ...');
      return false;
    }
    print('User logged in ...');
    return true;
  }
}
