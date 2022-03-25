import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodify/main.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  String? _email, _password, _confirmpassword;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
          TextField(
            controller: confirmPasswordController,
            onChanged: (text) {
              _confirmpassword = text;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_password == _confirmpassword) {
                bool userCreated = await createUser();
                if (userCreated) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                }
              } else {
                print('Passwords don\'t match');
              }
            },
            child: Text('Submit'),
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
        print('Account already exists');
      } else if (e.code == 'weak-password') {
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
