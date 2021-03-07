import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Userpage extends StatefulWidget {
  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {

  final _formkey=new GlobalKey<FormState>();
  bool _loading = false;

  TextEditingController emailInputController = TextEditingController();
  TextEditingController swnumInputController = TextEditingController();
  TextEditingController familynumInputController = TextEditingController();


  DocumentSnapshot snapshot;


  var myList = List<String>();

  String phone = '';
  String name = '';
  final firestoreInstance = FirebaseFirestore.instance;

  familyemailupdate () async {

    var firebaseUser = FirebaseAuth.instance.currentUser;

    firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      "familyemail" : emailInputController.text

    });

  }

  socialworkerupdate () async {

    var firebaseUser = FirebaseAuth.instance.currentUser;

    firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      "sw" : swnumInputController.text

    });

  }

  familynumupdate () async {

    var firebaseUser = FirebaseAuth.instance.currentUser;

    firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      "familynum" : familynumInputController.text

    });

  }



  String swtel ;
  String familyemail ;

  void getData() async{ //use a Async-await function to get the data
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    final data =  await Firestore.instance.collection("users").doc(firebaseUser.uid).get(); //get the data
    snapshot = data;
    familyemail = snapshot.data()['family'].toString();
    swtel = snapshot.data()['sw'].toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
                SizedBox(height: 40),
                // family email
                Text(
                  'Family Email',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: 'font'),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Please enter family email',
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                    ),
                    controller: emailInputController,
                    validator: (value) {
                      if (value.isEmpty) return 'Enter family email';
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () async {
                    try {
                      setState(() => _loading = true);
                      familyemailupdate();
                    } catch (e) {
                      print(e);
                    } finally {
                      if (mounted) setState(() => _loading = false);
                    }

                    emailInputController.clear();
                  },
                ),
                SizedBox(height: 40),
                Text(
                  'Family Number',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: 'font'),
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Please enter family tel number',
                        labelText: 'Tel',
                        border: OutlineInputBorder()
                    ),
                    controller: familynumInputController,
                    validator: (value) {
                      if (value.isEmpty) return 'Enter tel number';
                      return null;
                    },
                  ),
                ),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () async {
                    try {
                      setState(() => _loading = true);
                      familynumupdate();
                    } catch (e) {
                      print(e);
                    } finally {
                      if (mounted) setState(() => _loading = false);
                    }

                    familynumInputController.clear();
                  },
                ),
                SizedBox(height: 40),
                Text(
                  'Social Worker Number',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: 'font'),
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Please enter Social Worker tel Number',
                      labelText: 'Tel',
                      border: OutlineInputBorder(),
                    ),
                    controller: swnumInputController,
                    validator: (value) {
                      if (value.isEmpty) return 'Enter tel Number';
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () async {
                    try {
                      setState(() => _loading = true);
                      socialworkerupdate();
                    } catch (e) {
                      print(e);
                    } finally {
                      if (mounted) setState(() => _loading = false);
                    }

                    swnumInputController.clear();
                  },
                ),
              ],
            )));
  }




}