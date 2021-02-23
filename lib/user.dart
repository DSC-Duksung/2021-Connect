import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  String myname = 'test';
  String myphone = '000-0000-0000';
  var myList = List<String>();

  String phone = '';
  String name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User'),
        ),
        body: Container(
            child: ListView(
          children: [
            Text(
              'User Information',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${myname}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Tel: ${myphone}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Family Information',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "지인의 이름",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  )),
              onChanged: (value) {
                name = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Tel",
                  hintText: "010-0000-0000",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  )),
              onChanged: (value) {
                phone = value;
              },
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                if (phone != '' && name != '') {
                  FirebaseFirestore.instance
                      .collection(myname)
                      .add({'name': name, 'phone': phone});
                  name = '';
                  phone = '';
                } else {}
              },
            )
          ],
        )));
  }
}
