import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basics/src/auth_pages/sign_in_page.dart';
import 'package:firebase_basics/src/home/home_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return SignInPage();
          return HomeScreen();
        });
  }
}
