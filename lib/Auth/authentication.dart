import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basics/database/database_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future SignUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      debugPrint(userCredential.user!.email);
      debugPrint(userCredential.user!.uid);
      await DatabaseServices(uid: userCredential.user!.uid).updateUSer(
          username: 'Unknown',
          email: email,
          gender: "Unknown",
          skill: 'Unkown');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future SignIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint(userCredential.user!.email);
      debugPrint(userCredential.user!.uid);
      return userCredential;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
