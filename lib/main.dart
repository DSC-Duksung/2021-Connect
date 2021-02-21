
import 'package:connect/sharediary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connect/login.dart';
import 'home.dart';
import 'location.dart';

// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //rest of the code
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


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int _currentIndex = 0;

  final List<Widget> _children = [Home(), Location(), ShareDiary()];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            currentIndex: _currentIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('홈'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                title: Text('내 위치'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.photo),
                title: Text('공유일기'),
              ),
            ]
        )
    );
  }
}
