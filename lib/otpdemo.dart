import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class otpdemo extends StatefulWidget {
  const otpdemo({Key? key}) : super(key: key);

  @override
  State<otpdemo> createState() => _otpdemoState();
}

class _otpdemoState extends State<otpdemo> {

  TextEditingController tnumber = TextEditingController();
  TextEditingController tcode = TextEditingController();

  String mverificationId="";
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify Mobile Number"),),
      body: Column(
        children: [
          TextField(
            controller: tnumber,
          ),
          ElevatedButton(onPressed: () async {

            String phoneno = tnumber.text;

            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+91$phoneno',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {
                mverificationId = verificationId;
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );

          }, child: Text("Send Otp")),
          TextField(
            controller: tcode,
          ),
          ElevatedButton(onPressed: () async {

            String smscode = tcode.text;
            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: mverificationId, smsCode: smscode);

            // Sign the user in (or link) with the credential
            await auth.signInWithCredential(credential).then((value) {
              print(value);

              String? number = value.user!.phoneNumber;

            });

          }, child: Text("Verify Otp")),
        ],
      ),
    );
  }
}
