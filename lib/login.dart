import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainpage.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: LoginPage(title: ''),
    );
  }
}

class LoginPage extends StatefulWidget {


  LoginPage({Key key, this.title=''}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin{
  final formKey = GlobalKey<FormState>();

  TextEditingController _emailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            emailField(),
            Container(margin: EdgeInsets.only(bottom: 25.0)),
            passwordField(),
            Container(margin: EdgeInsets.only(bottom: 50.0)),
            submitButton(),
            signupButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // 텍스트필드의 상단에 출력되는 레이블 텍스트
        labelText: 'Email',
        // 텍스트필드상에 출력되는 텍스트. 실제 값이 되진 않음
        hintText: 'dsc@connect.com',
      ),
      validator: validateEmail,
      controller: _emailInputController,

    );
  }
  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
      ),
      validator: validatePassword,
      controller: _passwordInputController,

    );
  }

  Widget submitButton() {

    String type= "GENERAL";

    DocumentSnapshot snapshot;

    void getData() async{ //use a Async-await function to get the data
      var firebaseUser =  FirebaseAuth.instance.currentUser;
      final data =  await Firestore.instance.collection("users").doc(firebaseUser.uid).get(); //get the data

      snapshot = data;
      type = snapshot.data()['type'].toString();
    }

    return RaisedButton(
      color: Colors.brown,
      child: Text('submit'),
      onPressed: () async {
        getData();
        //if (!formKey.currentState.validate()) return;
        FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailInputController.text, password: _passwordInputController.text)
            .then((user) async {
          if(user.user.emailVerified) {
            print("signed in");
            Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new MainPage(type),));
          }
          else {
            loginAlert(context);
          }


        }).catchError((e){
          print(e);
        });
      },
    );
  }

  Widget signupButton() {
    return RaisedButton(
      color: Colors.brown,
      child: Text('회원가입'),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
    );
  }

  void loginAlert(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login denied'),
          content: Text("Complete email verification"),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }
}

class ValidationMixin {
  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 4) {
      return 'Enter 4 more char';
    }
    return null;
  }
}