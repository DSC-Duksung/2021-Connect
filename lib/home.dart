import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    bool checked = false;

    return MaterialApp(
      title: 'connect',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              const SizedBox(height: 60.0),
              IconButton(
                icon: Icon(Icons.account_circle_rounded), iconSize: 200, color: Colors.brown[900],
                onPressed: () {
                  setState(() {});
                },
              ),
              Text('눌러서 사용자정보 등록하기', style: TextStyle(fontSize: 25),),
              const SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return new Transform.scale(
                        scale: 2.0,
                        child: new Checkbox(
                          activeColor: Colors.brown,
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return new Transform.scale(
                        scale: 2.0,
                        child: new Checkbox(
                          activeColor: Colors.brown,
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return new Transform.scale(
                        scale: 2.0,
                        child: new Checkbox(
                          activeColor: Colors.brown,
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return new Transform.scale(
                        scale: 2.0,
                        child: new Checkbox(
                          activeColor: Colors.brown,
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return new Transform.scale(
                        scale: 2.0,
                        child: new Checkbox(
                          activeColor: Colors.brown,
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return new Transform.scale(
                        scale: 2.0,
                        child: new Checkbox(
                          activeColor: Colors.brown,
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return new Transform.scale(
                        scale: 2.0,
                        child: new Checkbox(
                          activeColor: Colors.brown,
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return new Transform.scale(
                        scale: 2.0,
                        child: new Checkbox(
                          activeColor: Colors.brown,
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                ButtonTheme(
                  minWidth: 130.0,
                  height: 80.0,
                  buttonColor: Colors.brown[300],
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text("사회복지사님\n전화걸기",textAlign: TextAlign.center, style: TextStyle(fontFamily: "Cafe",fontSize: 20)),
                  ),
                ),
                  const SizedBox(width : 30.0),
                  ButtonTheme(
                    minWidth: 130.0,
                    height: 80.0,
                    buttonColor: Colors.brown[300],
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("문자하기", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Cafe", fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      )
      );
  }
}