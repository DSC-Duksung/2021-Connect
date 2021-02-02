import 'package:flutter/cupertino.dart';

class Location extends StatefulWidget {
  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('지도'),
    );
  }
}