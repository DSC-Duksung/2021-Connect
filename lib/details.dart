import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<dynamic> _ch = [false, false, false, false, false, false, false, false];
  DocumentSnapshot ds;
  void getdata() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get();
    ds = data;

    if (!ds.data().containsKey("ch")) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .update({"ch": _ch});
    } else
      _ch = ds.data()['ch'].toList();
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('check what you did'),
        ),
        body: Container(
          child: Column(
            children: [
              Row(children: <Widget>[
                Text(
                  '     A     ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Checkbox(
                    value: _ch[0],
                    onChanged: (value) {
                      setState(() {
                        _ch[0] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text(
                  '     B     ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                new Checkbox(
                    value: _ch[1],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[1] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text(
                  '     C     ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                new Checkbox(
                    value: _ch[2],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[2] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text(
                  '     D     ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                new Checkbox(
                    value: _ch[3],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[3] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text(
                  '     E     ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                new Checkbox(
                    value: _ch[4],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[4] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text(
                  '     F     ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                new Checkbox(
                    value: _ch[5],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[5] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text(
                  '     G     ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                new Checkbox(
                    value: _ch[6],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[6] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text(
                  '     H     ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                new Checkbox(
                    value: _ch[7],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[7] = value;
                      });
                    })
              ]),
              RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  var firebaseUser = FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(firebaseUser.uid)
                      .update({"ch": _ch});
                },
              )
            ],
          ),
        ));
  }
}
