
import 'package:connect/familyhome.dart';
import 'package:flutter/material.dart';
import 'package:connect/sharediary.dart';
import 'home.dart';
import 'sharediary.dart';

class MainPage extends StatefulWidget {
  MainPage(@required this.type, {Key key, this.title}) : super(key: key);
  final String title;
  String type;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _currentIndex = 0;

  List<Widget> _childrenswitch;


  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(widget.type=='FAMILY')
      _childrenswitch = [Familyhome(), ShareDiary()];
    else if(widget.type=='GENERAL')
      _childrenswitch = [Home(), ShareDiary()];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text('CONNECT'),
        ),
        body: _childrenswitch[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            currentIndex: _currentIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                title: Text('Home'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.photo),
                title: Text('ShareDiary'),
              )
            ]));
  }
}