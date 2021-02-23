
import 'package:connect/familyhome.dart';
import 'package:flutter/material.dart';
import 'package:connect/sharediary.dart';
import 'home.dart';
import 'location.dart';
import 'sharediary.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _childrenswitch = [Familyhome(), ShareDiary()];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color mycolor = const Color(0xff473732);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text('connect'),
        ),
        body: _childrenswitch[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            currentIndex: _currentIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                title: Text('홈'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.photo),
                title: Text('공유일기'),
              )
            ]));
  }
}