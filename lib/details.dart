import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<dynamic> _ch = [false, false, false, false, false, false, false, false];
  DocumentSnapshot ds;
  void getdata() async {
    final data = await FirebaseFirestore.instance
        .collection('test')
        .doc('checkbox')
        .get();
    ds = data;
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
                Text('0'),
                Checkbox(
                    value: _ch[0],
                    onChanged: (value) {
                      setState(() {
                        _ch[0] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text('1'),
                new Checkbox(
                    value: _ch[1],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[1] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text('2'),
                new Checkbox(
                    value: _ch[2],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[2] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text('3'),
                new Checkbox(
                    value: _ch[3],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[3] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text('4'),
                new Checkbox(
                    value: _ch[4],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[4] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text('5'),
                new Checkbox(
                    value: _ch[5],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[5] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text('6'),
                new Checkbox(
                    value: _ch[6],
                    onChanged: (bool value) {
                      setState(() {
                        _ch[6] = value;
                      });
                    })
              ]),
              Row(children: <Widget>[
                Text('7'),
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
                  FirebaseFirestore.instance
                      .collection("test")
                      .doc("checkbox")
                      .update({"ch": _ch});
                },
              )
            ],
          ),
        ));
  }
}
