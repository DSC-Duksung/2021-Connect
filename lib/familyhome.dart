import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Familyhome extends StatefulWidget {
  @override
  FamilyhomeState createState() => FamilyhomeState();
}

class FamilyhomeState extends State<Familyhome> {
  List<dynamic> _ch = ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'];
  DocumentSnapshot ds;
  void getdata() async {
    final data = await FirebaseFirestore.instance
        .collection('test')
        .doc('checkbox')
        .get();
    ds = data;
    _ch = ds.data()['ch'].toList();

    for (int i = 0; i < _ch.length; i++) {
      if (_ch[i] == true) _ch[i] = 'O';
      if (_ch[i] == false) _ch[i] = 'X';
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    //getdata();
    return MaterialApp(
        title: 'connect',
        home: Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      Container(
                        width: 300,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.brown,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.brown[200],
                              offset: new Offset(10.0, 10.0),
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text("Family Status",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ),
                      const SizedBox(height: 20.0),
                      DataTable(
                        horizontalMargin: 120.0,
                        columnSpacing: 80.0,
                        dataRowHeight: 60,
                        columns: [
                          DataColumn(
                              label: Text(
                                'To Do',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.brown),
                              )),
                          DataColumn(
                            label: Text(
                              'O/X',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.brown),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('     A')),
                            DataCell(Text('     ${_ch[0]}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('     B')),
                            DataCell(Text('     ${_ch[1]}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('     C')),
                            DataCell(Text('     ${_ch[2]}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('     D')),
                            DataCell(Text('     ${_ch[3]}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('     E')),
                            DataCell(Text('     ${_ch[4]}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('     F')),
                            DataCell(Text('     ${_ch[5]}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('     G')),
                            DataCell(Text('     ${_ch[6]}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('     H')),
                            DataCell(Text('     ${_ch[7]}')),
                          ]),
                        ],
                      )
                    ]))));
  }
}