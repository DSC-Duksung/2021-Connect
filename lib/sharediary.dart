
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';

// 삭제 기능: 밀어서 삭제 --> okay!
// 공유다이어리 데이터 유지 --> okay!
// 공유다이어리 데이터 업로드 --> okay!
// 공유다이어리에 사진만? 아니면 text나 User name 집어넣어야하나? --> 고민!
//날짜별로

// 참고: firebase_storage 버전 향상시 메소드 name이 바뀜 (구버전 사용)
//https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_storage/firebase_storage/CHANGELOG.md#500-dev1

class ShareDiary extends StatefulWidget {

  @override
  ShareDiaryState createState() => ShareDiaryState();


}

class ShareDiaryState extends State<ShareDiary> {


  var firebaseUser = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Text('how was your today😀?',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'cafe'),),
            new Flexible(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      // ignore: deprecated_member_use
      //수정
      stream: Firestore.instance.collection('storage').doc(firebaseUser.uid).collection('picture').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(

        padding: const EdgeInsets.only(top: 20.0),
        children: snapshot.map((data) => _buildListItem(context, data)).toList()
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);


    return Dismissible(
        key: ValueKey(record.url),
    onDismissed: (direction){
    _deleteData(record.reference);
    },
      child: Padding(
        key: ValueKey(record.location),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.brown),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListTile(
            title: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    record.location,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Image.network(record.url),
              ],
            ),
          ),
        ),


      ),
    );

  }

  Future getImage() async {
    // Get image from gallery.
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadImageToFirebase(image);
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {

      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'diary/image${randomNumber}.jpg';

      // Upload image to firebase.

      final StorageReference storageReference = FirebaseStorage().ref().child(imageLocation);
      final StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      _addPathToDatabase(imageLocation);
    }catch(e){
      print(e.message);
    }
  }

  Future<void> _addPathToDatabase(String text) async {


    try {
      // Get image URL from firebase
      final ref = FirebaseStorage().ref().child(text);
      var imageString = await ref.getDownloadURL();

      // Add location and url to database
      await Firestore.instance.collection('storage').doc(firebaseUser.uid).collection('picture').document().setData({'url':imageString , 'location':text});
    }catch(e){
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          }
      );
    }
  }

  //삭제
  Future<void> _deleteData(DocumentReference reference) async{
    try {
      await Firestore.instance.runTransaction((Transaction myTransaction) async {
        await myTransaction.delete(reference);
      });
    }catch(e){
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          }
      );
    }
  }



}

class Record {
  final String location;
  final String url;
  final DocumentReference reference;


  //Location을 User의 name으로 대신할까 생각중..~
  //text도 넣으면 좋을것같은데..


  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['url'] != null),
        location = map['location'],
        url = map['url'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$location:$url>";
}