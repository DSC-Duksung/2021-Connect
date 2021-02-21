import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class Location extends StatefulWidget {
  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<Location> {


  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;


  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
//postalcode: 우편번호
      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}, ${place.administrativeArea}";
      });
    } catch (e) {
      print(e);
    }
  }


  Future<void> _launched;

  Future<void> _textMe() async {

    // Text txt=Text(_currentAddress??'default value(오류방지용)';
    // getValueFromtxt(){
    //   var value=txt.data;
    // }
    // Android

    String uri = 'sms: 119?body=<긴급신고>%20발신인: 김OO\n'
        '위급합니다. 현 위치는 $_currentAddress';
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
                        _getCurrentLocation();
                        if (_currentPosition != null){
                          _launched = _textMe();
                        }
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

