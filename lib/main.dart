import 'package:demo_firebase_6to8/database_realtime/insertpage.dart';
import 'package:demo_firebase_6to8/database_realtime/viewpage.dart';
import 'package:demo_firebase_6to8/emailpass.dart';
import 'package:demo_firebase_6to8/googlelogindemo.dart';
import 'package:demo_firebase_6to8/otpdemo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // to connect project with firebase console
  runApp(MaterialApp(home: viewpage(),));
}
