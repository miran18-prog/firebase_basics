import 'package:firebase_basics/Auth/authentication.dart';
import 'package:firebase_basics/src/auth_pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Authentication();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'TutorialKart',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 20),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              //forgot password screen
            },
            child: const Text(
              'Forgot Password',
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('create account'),
                onPressed: () async {
                  await authentication.SignUp(
                      email: nameController.text,
                      password: passwordController.text);
                  print(nameController.text);
                  print(passwordController.text);
                },
              )),
          Row(
            // ignore: sort_child_properties_last
            children: <Widget>[
              const Text('Already have an account?'),
              TextButton(
                onPressed: () {
                  try {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
