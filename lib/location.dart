import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<Location> {

  Future<void> _launched;

  Future<void> _textMe() async {
    // Android
    const uri = 'sms: 119?body=<긴급신고>%20발신인: 김OO\n'
        '위급합니다. 현 위치는';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms: 119?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    bool checked = false;

    return MaterialApp(
        title: 'connect',
        home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  ButtonTheme(
                    minWidth: 130.0,
                    height: 80.0,
                    buttonColor: Colors.brown[300],
                    child: RaisedButton(
                      onPressed: ()=> setState((){
                        _launched = _textMe();
                      }),

                      child: Text("위급상황 신고하기", textAlign: TextAlign.center, style: TextStyle( fontSize: 20)),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}