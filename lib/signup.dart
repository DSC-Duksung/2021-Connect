import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  static const routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPage> {
  final _formkey=new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController confirmPasswordInputController = TextEditingController();
  bool _loading = false;

  final firestoreInstance = FirebaseFirestore.instance;
  String selectedItem = 'GENERAL';
  var firebaseUser = FirebaseAuth.instance.currentUser;

  signedUp () async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailInputController.text,
        password: passwordInputController.text)
        .then((user) {
          user.user.sendEmailVerification();
          firestoreInstance
              .collection("users")
              .doc(firebaseUser.uid)
              .set({
            "name" : nameInputController.text,
            "email" : emailInputController.text,
            "type" : selectedItem

              }).then((_) {
            print("success!");
          });
      print('signed in');


      Navigator.of(context).pop();
      Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new LoginPage(),
          ));
    }).catchError((e) {
      print(e);
    });

    firestoreInstance
        .collection("storage")
        .doc(firebaseUser.uid)
        .set({
      "user" : emailInputController.text

    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _loading ? _loadingWidget() : _signupformWidget()
          ],)),
    );
  }

  Widget _signupformWidget() {



    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: double.infinity,
              ),
              SizedBox(height: 10),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Please enter your name',
                    labelText: 'Name',
                      border: OutlineInputBorder()
                  ),
                  controller: nameInputController,
                  validator: (value) {
                    if (value.isEmpty) return 'Enter your name';
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Please enter your email',
                        labelText: 'Email',
                        border: OutlineInputBorder()
                    ),
                    controller: emailInputController,
                    validator: (value) {
                      if (value.isEmpty) return 'Enter your email';
                      return null;
                    },
                  )),
                ],
              ),
              SizedBox(height: 10),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Please enter a password',
                      labelText: 'Password',
                      border: OutlineInputBorder()
                  ),
                  controller: passwordInputController,
                  validator: (value) {
                    if (value.length < 4) return 'enter a password of at least 4 characters';
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Please enter a password',
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder()
                  ),
                  controller: confirmPasswordInputController,
                  validator: (value) {
                    if (value != passwordInputController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30),
              Text("Please select a member type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black38),),
              CustomRadioButton(
                elevation: 0,
                absoluteZeroSpacing: false,
                unSelectedColor: Theme.of(context).canvasColor,
                buttonLables: [
                  'General',
                  'Family',
                ],
                buttonValues: [
                  "GENERAL",
                  "FAMILY",
                ],
                buttonTextStyle: ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.black,
                    textStyle: TextStyle(fontSize: 16)),
                radioButtonValue: (value) {
                  print(value);
                  selectedItem = value;
                },
                spacing: 3,
                defaultSelected: "GENERAL",
                horizontal: false,
                enableButtonWrap: false,
                width: 140,
                padding: 10,
                enableShape: true,

                selectedColor: Theme.of(context).accentColor,
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(top: 32.0),
                width: double.infinity,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.brown,
                  //elevation: 5.0,
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    if (!_formkey.currentState.validate())  return;
                    try {
                      setState(() => _loading = true);
                      signedUp();
                    } catch (e) {
                      print(e);
                    } finally {
                      if (mounted) setState(() => _loading = false);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget () {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
