import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_basics/model/user_model.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseServices {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  final String? uid;
  DatabaseServices({this.uid});

  Future updateUSer({
    required String username,
    required String email,
    required String gender,
    required String skill,
  }) async {
    return await _collectionReference.doc(uid).set({
      'username': username,
      'email': email,
      'gender': gender,
      'skill': skill
    });
  }

  Stream<UserModel> get userData {
    return _collectionReference.doc(uid).snapshots().map(dataFromUserModel);
  }

  UserModel dataFromUserModel(DocumentSnapshot snapshot) {
    return UserModel(
        username: snapshot['username'],
        email: snapshot['email'],
        gender: snapshot['gender'],
        skill: snapshot['skill']);
  }
}
