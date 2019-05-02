import 'dart:io';
import 'main.dart';
import 'package:flutter/material.dart';
import 'helppatientinfo3.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'logout.dart';
import 'app_translations.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class PatientInfo3 extends StatefulWidget {
  @override
  _PatientInfo3State createState() => _PatientInfo3State();
}

class _PatientInfo3State extends State<PatientInfo3> {
  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

/*
  var records = Firestore.instance.collection('Records').document();

  Future<Null> _saveRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> recordMap = {
      'a. access-code': prefs.getString('access-code') ?? 0,
      'b. user-name': prefs.getString('user-name') ?? 0,
      'c. user-contact': prefs.getString('user-contact') ?? 0,
      'd. access-date': prefs.getString('accessdate') ?? 0,
      'd. location': prefs.getString('location') ?? 0,
      'e. name': prefs.getString('name') ?? 0,
      'f. gender': prefs.getString('gender') ?? 0,
      'g. contact': prefs.getString('contact') ?? 0,
      'h. HKID': prefs.getString('HKID') ?? 0,
      'i. CSSA': prefs.getBool('cssa') ?? 0,
      'j. birthday': prefs.getString('birthday') ?? 0,
      'k. age': prefs.getString('age') ?? 0,
      'l. reject:': prefs.getBool('reject') ?? 0,
      'm. heart-rate': prefs.getString('heart-rate') ?? 0,
      'n. blood-pressure': prefs.getString('blood-pressure') ?? 0,
      'o. blood-glucose': prefs.getString('blood-glucose') ?? 0,
      'p. body-height': prefs.getString('body-height') ?? 0,
      'q. body-weight': prefs.getString('body-weight') ?? 0,
      'r. bmi': prefs.getString('BMI') ?? 0,
      's. respiration-rate': prefs.getString('respiration-rate') ?? 0,
      't. smoking': prefs.getBool('smoking') ?? 0,
      'u. alcohol': prefs.getBool('alcohol') ?? 0,
      'v. drugs': prefs.getBool('drugs') ?? 0,
      'w. additional-info1': prefs.getString('additional-info1') ?? 0,
      'x. wound': prefs.getString('wound') ?? 0,
      'y. mental-issues': prefs.getString('mental-issues') ?? 0,
      'z. past-med-records': prefs.getString('past-med-records') ?? 0,
      'zz. additional-info2': prefs.getString('additional-info2') ?? 0,
    };
    records.setData(recordMap);
  }
  */

  final woundController = TextEditingController();
  final mentalissuesController = TextEditingController();
  final prevmedrecordsController = TextEditingController();
  final additionalinfo2Controller = TextEditingController();

  _persistPatientInfo3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('wound', woundController.text);
    prefs.setString('mental-issues', mentalissuesController.text);
    prefs.setString('past-med-records', prevmedrecordsController.text);
    prefs.setString('additional-info2', additionalinfo2Controller.text);
  }

  List<File> images = new List(5);

  String wound;
  String mentalissues;
  String pastmedrecords;
  String additionalinfo2;

  int numfiles = 0;

  Future _takePicture() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera) ?? null;

    if (image != null) {
      setState(() {
        switch (numfiles) {
          case 0:
            images[0] = image;
            ++numfiles;
            break;
          case 1:
            images[1] = image;
            ++numfiles;
            break;
          case 2:
            images[2] = image;
            ++numfiles;
            break;
          case 3:
            images[3] = image;
            ++numfiles;
            break;
          case 4:
            images[4] = image;
            ++numfiles;
            break;
          case 5:
            _showErrorDialog();
        }
      });
    }
  }

  Future _selectPicture() async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.gallery) ?? null;

    if (image != null) {
      setState(() {
        switch (numfiles) {
          case 0:
            images[0] = image;
            ++numfiles;
            break;
          case 1:
            images[1] = image;
            ++numfiles;
            break;
          case 2:
            images[2] = image;
            ++numfiles;
            break;
          case 3:
            images[3] = image;
            ++numfiles;
            break;
          case 4:
            images[4] = image;
            ++numfiles;
            break;
          case 5:
            _showErrorDialog();
        }
      });
    }
  }

/*
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> _uploadPicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accesscode = prefs.getString('access-code');
    String username = prefs.getString('user-name');
    String patientname = prefs.getString('name');
    String accessdate = prefs.getString('accessdate');

    for (int i = 0; i < numfiles; i++) {
      final StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('$accessdate-$accesscode-$username-$patientname-image$i.jpeg');
      final StorageUploadTask task = firebaseStorageRef.putFile(images[i]);
    }
  }
  */

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(AppTranslations.of(context).text("send_to")),
          content:
              new Text(AppTranslations.of(context).text("you_cant_edit")),
          actions: <Widget>[
            new FlatButton(
                child: Text(AppTranslations.of(context).text("send")),
                onPressed: () {
                  /*
                  _saveRecord();
                  _uploadPicture();
                  */
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogOut()),
                  );
                }),
            new FlatButton(
              child: Text(AppTranslations.of(context).text("cancel")),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(AppTranslations.of(context).text("error_photos")),
          content: new Text(AppTranslations.of(context).text("remove_photo")),
          actions: <Widget>[
            new FlatButton(
                child: Text(AppTranslations.of(context).text("ok")),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  void _deletePic(int i) {
    setState(() {
      images[i] = null;
      for (; i != numfiles - 1; ++i) images[i] = images[i + 1];
      --numfiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline, size: 29),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPatientInfo3()),
              );
            },
          ),
        ]),
        body: ListView(children: <Widget>[
          GestureDetector(
            onTap: () => _dismissKeyboard(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(top: 24, bottom: 5, left: 28, right: 24),
                  child: Text(AppTranslations.of(context).text("wound"), style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 24, right: 24),
                  child: TextField(
                      controller: woundController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          labelText: '',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      maxLines: null),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 28),
                  child: Text(AppTranslations.of(context).text("mental_issues"), style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 20, left: 24, right: 24),
                  child: TextField(
                      controller: mentalissuesController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: '',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      maxLines: null),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 28, right: 24),
                  child: Text(AppTranslations.of(context).text("previous_medical_records"),
                      style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 20, left: 24, right: 24),
                  child: TextField(
                      controller: prevmedrecordsController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          labelText: '',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      maxLines: null),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 28),
                  child: Text(AppTranslations.of(context).text("additional_information2"),
                      style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 20, left: 24, right: 24),
                  child: TextField(
                      controller: additionalinfo2Controller,
                      onChanged: (text) {
                        additionalinfo2 = text;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: '',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      maxLines: null),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 24, bottom: 5),
                      child: Text(AppTranslations.of(context).text("additional_files_photos"),
                          style: TextStyle(fontSize: 16)),
                    ),
                    IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.photo_camera),
                      color: Colors.black,
                      onPressed: () {
                        _takePicture();
                      },
                    ),
                    IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.attach_file),
                      color: Colors.black,
                      onPressed: () {
                        _selectPicture();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 28, bottom: 20),
                      child: SizedBox(
                        width: 80,
                        child: Text(
                            AppTranslations.of(context).text("you_can_upload"),
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Text('$numfiles/5'),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, top: 24, bottom: 24, right: 96),
                  child: new ListView.builder(
                      shrinkWrap: true,
                      itemCount: numfiles,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new Row(children: <Widget>[
                          Image.file(images[index],
                              height: 100.0, width: 100.0),
                          FlatButton(
                              child: Text(AppTranslations.of(context).text("delete")),
                              onPressed: () {
                                _deletePic(index);
                              }),
                        ]);
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    child: Text(AppTranslations.of(context).text("finish_record")),
                    onPressed: () {
                      _persistPatientInfo3();
                      _showDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
