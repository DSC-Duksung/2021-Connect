import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



class Location extends StatefulWidget {
  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<Location> {

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null) Text(_currentAddress??'default value(오류방지용)'),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

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


}

//if (_currentPosition != null)
//Text(
//"LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
//FlatButton(
//child: Text("Get location"),
//onPressed: () {
//_getCurrentLocation();
//},
//),
