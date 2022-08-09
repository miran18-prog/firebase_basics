import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basics/Auth/authentication.dart';
import 'package:firebase_basics/database/database_services.dart';
import 'package:firebase_basics/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Authentication _authentication = Authentication();
  final User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("home screen"), centerTitle: true, actions: [
          IconButton(
            onPressed: _askedToLead,
            icon: Icon(Icons.edit),
          ),
          SizedBox(width: 50),
          IconButton(
            onPressed: () async {
              _authentication.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ]),
        body: Center(
          child: StreamBuilder<UserModel>(
              stream: DatabaseServices(uid: user.uid.toString()).userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "User Information",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      padding: EdgeInsets.fromLTRB(15, 12, 0, 0),
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Text(
                        "Username:     ${snapshot.data!.username} ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      padding: EdgeInsets.fromLTRB(15, 12, 0, 0),
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Text(
                        "Email:    ${snapshot.data!.email} ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      padding: EdgeInsets.fromLTRB(15, 12, 0, 0),
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Text(
                        "Gender:   ${snapshot.data!.gender}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      padding: EdgeInsets.fromLTRB(15, 12, 0, 0),
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Text(
                        "Skill:    ${snapshot.data!.skill} ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }

  _askedToLead() {
    TextEditingController usernamectrl = TextEditingController();
    TextEditingController genderctrl = TextEditingController();
    TextEditingController skillctrl = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Edit Profile'),
            children: <Widget>[
              Column(
                children: [
                  Container(
                      height: 50,
                      width: 250,
                      child: TextField(
                        controller: usernamectrl,
                        decoration: InputDecoration(hintText: 'username'),
                      )),
                  SizedBox(height: 15),
                  Container(
                      height: 50,
                      width: 250,
                      child: TextField(
                        controller: skillctrl,
                        decoration: InputDecoration(hintText: 'skill'),
                      )),
                  SizedBox(height: 15),
                  Container(
                      height: 50,
                      width: 250,
                      child: TextField(
                        controller: genderctrl,
                        decoration: InputDecoration(hintText: 'gender'),
                      )),
                  SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.green,
                        child: SimpleDialogOption(
                          onPressed: () async {
                            print(usernamectrl.text);
                            print(skillctrl.text);
                            print(genderctrl.text);
                            await DatabaseServices(uid: user.uid).updateUSer(
                                email: user.email.toString(),
                                username: usernamectrl.text,
                                gender: genderctrl.text,
                                skill: skillctrl.text);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green)),
                        child: SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        });
  }
}
