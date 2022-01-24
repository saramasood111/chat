import 'package:flutter/material.dart';

import '../constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  String? msg;
  bool spin = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Flexible(
                //   child: Hero(
                //     tag: 'logo',
                //     child: Container(
                //       height: 40.0,
                //       child: Image.asset('images/logo.png'),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password.'),
                ),
                SizedBox(
                  height: 2.0,
                ),

                Text('$msg'),
                SizedBox(
                  height: 2.0,
                ),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: () async {
                    setState(() {
                      spin = true;
                    });
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email.toString(), password: password.toString());

                    setState(() {
                      spin = false;
                    });
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    } else {
                      setState(() {
                        msg = "login failed";
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
