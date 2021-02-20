import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Swhome extends StatefulWidget {
  @override
  SwhomeState createState() => SwhomeState();
}

class SwhomeState extends State<Swhome> {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'connect',
        home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [

                ],
              ),
            )
        )
    );
  }
}