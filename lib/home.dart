import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:connect/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _launched;
  //사회복지사님한테 연결
  String _phone = '01077777777';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _textMe() async {
    // Android
    const uri = 'sms:+82 10 1234 5678?body=[앱수신알림]%20발신인: 김OO\n'
        '김OO님의 상태: 양호';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:+82 10 1234 5678?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print('token: $token');
    });
  }


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



  Future<void> _EmergencyReport() async {

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

                  const SizedBox(height: 10.0),
                  IconButton(
                    icon: Icon(Icons.account_circle_rounded),
                    iconSize: 200,
                    color: Colors.brown[900],
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => User()));
                    },
                  ),


                  Text('Registering user information \nby pressing a icon', textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), ),

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
                  const SizedBox(height: 30.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      ButtonTheme(
                        minWidth: 40.0,
                        height: 80.0,
                        buttonColor: Colors.brown[300],
                        child: RaisedButton(
                          onPressed: () => setState(() {
                            _launched = _makePhoneCall('tel:$_phone');
                          }),
                          child: Text("Call a \nsocial worker",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                        ),


                      ),
                      const SizedBox(width: 10.0),
                      ButtonTheme(
                        minWidth: 40.0,
                        height: 80.0,
                        buttonColor: Colors.brown[300],
                        child: RaisedButton(
                          onPressed: () => setState(() {
                            _launched = _textMe();
                          }),
                          child: Text("Send \nMessage",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      ButtonTheme(
                        minWidth: 40.0,
                        height: 80.0,
                        buttonColor: Colors.brown[300],
                        child: RaisedButton(
                          onPressed: ()=> setState((){
                            _getCurrentLocation();
                            if (_currentPosition != null){
                              _launched = _EmergencyReport();
                            }
                          }),
                          child: Text("Emergency\nReport", textAlign: TextAlign.center, style: TextStyle( fontSize: 17)),
                        ),
                      ),
                      // FutureBuilder<void>(future: _launched, builder: _launchStatus),
                    ],
                  ),
            ],
          ),
        )));
  }
}
