
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

<<<<<<< HEAD
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int _currentIndex = 0;

  final List<Widget> _children = [Home(), Location()];
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
              )
            ]));
  }
}
=======
>>>>>>> 86db60c9efedd5103e37932b72c346493c9cea9f
