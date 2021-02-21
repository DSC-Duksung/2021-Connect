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
              '사용자 정보',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              '이름: ${myname}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '전화번호: ${myphone}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '지인 전화번호',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "지인의 이름",
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
                  labelText: "지인의 전화번호",
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
              child: Text('추가'),
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
