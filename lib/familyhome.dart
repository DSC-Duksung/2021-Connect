import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Familyhome extends StatefulWidget {
  @override
  FamilyhomeState createState() => FamilyhomeState();
}

class FamilyhomeState extends State<Familyhome> {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'connect',
        home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
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
                        child: Text("Family Status", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  DataTable(
                    horizontalMargin: 120.0,
                    columnSpacing: 80.0,
                    dataRowHeight: 60,
                    columns: [
                      DataColumn(label: Text('To Do',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),)),
                      DataColumn(label: Text('O/X',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),),
                      ),
                    ]
                    ,
                    rows: [
                      DataRow(
                          cells: [
                            DataCell(Text('     A')),
                            DataCell(Text('     O')),
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(Text('     B')),
                            DataCell(Text('     O')),
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(Text('     C')),
                            DataCell(Text('     O')),
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(Text('     D')),
                            DataCell(Text('     O')),
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(Text('     E')),
                            DataCell(Text('     X')),
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(Text('     F')),
                            DataCell(Text('     X')),
                          ]
                      ),
                    ],
                  )
                  ]
              )
            )
        )
    );
  }
}