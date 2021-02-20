
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connect/login.dart';
import 'package:connect/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Login(),
    );
  }
}

