import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class emailpass extends StatefulWidget {
  const emailpass({Key? key}) : super(key: key);

  @override
  State<emailpass> createState() => _emailpassState();
}

class _emailpassState extends State<emailpass> {

  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email Password"),),
      body: Column(
        children: [
          TextField(controller: temail,),
          TextField(controller: tpassword,),
          ElevatedButton(onPressed: () async {

            String email = temail.text;
            String password = tpassword.text;

            try {
              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );

              print(credential);

            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }

          }, child: Text("Register")),
          ElevatedButton(onPressed: () async {
            try {
              String email = temail.text;
              String password = tpassword.text;
              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password
              );

              print("Okkkkk");
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          }, child: Text("Login"))
        ],
      ),
    );
  }
}
