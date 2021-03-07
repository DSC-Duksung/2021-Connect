import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {

  final _formkey=new GlobalKey<FormState>();
  bool _loading = false;

  TextEditingController emailInputController = TextEditingController();
  TextEditingController telInputController = TextEditingController();


  DocumentSnapshot snapshot;


  var myList = List<String>();

  String phone = '';
  String name = '';
  final firestoreInstance = FirebaseFirestore.instance;

  familyupdate () async {

    var firebaseUser = FirebaseAuth.instance.currentUser;

    firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      "family" : emailInputController.text

    });

  }

  socialworkerupdate () async {

    var firebaseUser = FirebaseAuth.instance.currentUser;

    firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      "sw" : telInputController.text

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
               Text(
                 'User Information',
                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
               ),
               SizedBox(height: 20),
                Text(
                  'Name: ${familyemail}',
                  style: TextStyle(fontSize: 16),
                ),
               Text(
                 'Tel: ${swtel}',
                 style: TextStyle(fontSize: 16),
               ),
              SizedBox(
              height: 50,
            ),
              Text(
              'Family Information',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
               Container(
                 child: TextFormField(
                   decoration: InputDecoration(
                       hintText: 'Please enter family email',
                       labelText: 'Email',
                       border: OutlineInputBorder()
                   ),
                   controller: emailInputController,
                   validator: (value) {
                     if (value.isEmpty) return 'Enter family email';
                     return null;
                   },
                 ),
               ),
              RaisedButton(
               child: Text('Add'),
               onPressed: () async {
                 try {
                   setState(() => _loading = true);
                   familyupdate();
                 } catch (e) {
                   print(e);
                 } finally {
                   if (mounted) setState(() => _loading = false);
                 }

                 emailInputController.clear();
               },
            ),
               Text(
                 'Social Worker Information',
                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
               ),
               Container(
                 child: TextFormField(
                   decoration: InputDecoration(
                       hintText: 'Please enter Social Worker tel number',
                       labelText: 'Tel',
                       border: OutlineInputBorder()
                   ),
                   controller: telInputController,
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
                     socialworkerupdate();
                   } catch (e) {
                     print(e);
                   } finally {
                     if (mounted) setState(() => _loading = false);
                   }

                   telInputController.clear();
                 },
               )
          ],
        )));
  }




}