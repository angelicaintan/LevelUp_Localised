import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'app_translations.dart';
import 'patientinfo2.dart';
import 'helppatientinfo1.dart';
import 'logout.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'newrecord.dart';

class PatientInfo1 extends StatefulWidget {
  @override
  _PatientInfo1State createState() => _PatientInfo1State();
}

class _PatientInfo1State extends State<PatientInfo1> {
  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String location;
  String name;
  String description;
  String contact;
  bool cssa;
  String hkid;
  String gender;
  String dob = ' ';
  String agestring;
  int age;
  bool reject = false;

  double agefull;

  int _genderValue = -1;
  int _cssaValue = -1;

  bool _smoking = false;
  bool _alcohol = false;
  bool _drugs = false;

  String heartrate;
  String bloodpressure;
  String bloodglucose;
  String bodyheight;
  String bodyweight;
  String bmi;
  String respirationrate;
  String additionalinfo1;

  final heartrateController = TextEditingController();
  final bloodpressureController = TextEditingController();
  final bloodglucoseController = TextEditingController();
  final bodyheightController = TextEditingController();
  final bodyweightController = TextEditingController();
  final bmiController = TextEditingController();
  final respirationrateController = TextEditingController();
  final additionalinfo1Controller = TextEditingController();

  final locationController = TextEditingController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final contactController = TextEditingController();
  final hkidController = TextEditingController();
  final ageController = TextEditingController();
  final birthdayController = TextEditingController();

  final woundController = TextEditingController();
  final mentalissuesController = TextEditingController();
  final prevmedrecordsController = TextEditingController();
  final additionalinfo2Controller = TextEditingController();

  List<File> images = new List(5);

  String wound;
  String mentalissues;
  String pastmedrecords;
  String additionalinfo2;

  int numfiles = 0;

  void _genderChange(int value) {
    setState(() {
      _genderValue = value;

      switch (_genderValue) {
        case 0:
          gender = 'female';
          break;
        case 1:
          gender = 'male';
          break;
      }
    });
  }

  void _cssaChange(int value) {
    setState(() {
      _cssaValue = value;

      switch (_cssaValue) {
        case 0:
          cssa = true;
          break;
        case 1:
          cssa = false;
          break;
      }
    });
  }

  DateTime selectedDate = DateTime.now();
  DateTime dateNow = DateTime.now();

  void _showDatePicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 160,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  selectedDate = value;
                },
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: Text("select"),
                  onPressed: () {
                    setState(() {
                      dob = DateFormat('yyyy-MM-dd').format(selectedDate);
                      agefull = ((dateNow.year + (dateNow.month / 12)) -
                              (selectedDate.year + (selectedDate.month / 12)))
                          .toDouble();
                      age = agefull.toInt();
                      ageController.text = '$age';
                    });
                    Navigator.pop(context);
                  }),
              new FlatButton(
                child: Text(AppTranslations.of(context).text("cancel")),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  void _changeDatetime(int year, int month, int date) {
    setState(() {
      dob = '$year-$month-$date';
    });
  }

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

  var records = Firestore.instance.collection('Records').document();

  _persistPatientInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
    prefs.setString('name', name);
    prefs.setString('description', description);
    prefs.setString('gender', gender);
    prefs.setString('contact', contact);
    prefs.setBool('cssa', cssa);
    prefs.setString('HKID', hkid);
    prefs.setString('birthday', dob);
    prefs.setString('age', agestring);
    prefs.setBool('reject', reject);

    prefs.setString('heart-rate', heartrate);
    prefs.setString('blood-pressure', bloodpressure);
    prefs.setString('blood-glucose', bloodglucose);
    prefs.setString('body-height', bodyheight);
    prefs.setString('body-weight', bodyweight);
    prefs.setString('BMI', bmi);
    prefs.setString('respiration-rate', respirationrate);
    prefs.setBool('smoking', _smoking);
    prefs.setBool('alcohol', _alcohol);
    prefs.setBool('drugs', _drugs);
    prefs.setString('additional-info1', additionalinfo1);

    prefs.setString('wound', woundController.text);
    prefs.setString('mental-issues', mentalissuesController.text);
    prefs.setString('past-med-records', prevmedrecordsController.text);
    prefs.setString('additional-info2', additionalinfo2Controller.text);
  }

  Future<Null> _saveRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> recordMap = {
      'accessCode': prefs.getString('access-code') ?? 0,
      'b. user-name': prefs.getString('user-name') ?? 0,
      'c. user-contact': prefs.getString('user-contact') ?? 0,
      'accessDate': prefs.getString('accessdate') ?? 0,
      'd. location': prefs.getString('location') ?? 0,
      'name': prefs.getString('name') ?? 0,
      'f. description': prefs.getString('description') ?? 0,
      'g. gender': prefs.getString('gender') ?? 0,
      'h. contact': prefs.getString('contact') ?? 0,
      'HKID': prefs.getString('HKID') ?? 0,
      'j. CSSA': prefs.getBool('cssa') ?? 0,
      'k. birthday': prefs.getString('birthday') ?? 0,
      'l. age': prefs.getString('age') ?? 0,
      'm. reject': prefs.getBool('reject') ?? 0,
      'n. heart-rate': prefs.getString('heart-rate') ?? 0,
      'o. blood-pressure': prefs.getString('blood-pressure') ?? 0,
      'p. blood-glucose': prefs.getString('blood-glucose') ?? 0,
      'q. body-height': prefs.getString('body-height') ?? 0,
      'r. body-weight': prefs.getString('body-weight') ?? 0,
      's. bmi': prefs.getString('BMI') ?? 0,
      't. respiration-rate': prefs.getString('respiration-rate') ?? 0,
      'u. smoking': prefs.getBool('smoking') ?? 0,
      'v. alcohol': prefs.getBool('alcohol') ?? 0,
      'w. drugs': prefs.getBool('drugs') ?? 0,
      'x. additional-info1': prefs.getString('additional-info1') ?? 0,
      'y. wound': prefs.getString('wound') ?? 0,
      'z. mental-issues': prefs.getString('mental-issues') ?? 0,
      'za. past-med-records': prefs.getString('past-med-records') ?? 0,
      'zb. additional-info2': prefs.getString('additional-info2') ?? 0,
    };
    records.setData(recordMap);
  }

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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(AppTranslations.of(context).text("send_to")),
          content: new Text(AppTranslations.of(context).text("you_cant_edit")),
          actions: <Widget>[
            new FlatButton(
                child: Text(AppTranslations.of(context).text("send")),
                onPressed: () {
                  _saveRecord();
                  _uploadPicture();
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

/*
  @override
  void initState() {
    super.initState();
    ageController.addListener(_printLatestValue);
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          FlatButton(
            child: Text(AppTranslations.of(context).text("logout"),
                style: TextStyle(fontSize: 18, color: Colors.white)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.help_outline, size: 29),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPatientInfo1()),
              );
            },
          ),
        ]),
        body: ListView(children: <Widget>[
          GestureDetector(
            onTap: () => _dismissKeyboard(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 10),
                  child: TextField(
                    controller: locationController,
                    onChanged: (text) {
                      location = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: AppTranslations.of(context).text("location"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 10),
                  child: TextField(
                    controller: nameController,
                    onChanged: (text) {
                      name = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: AppTranslations.of(context).text("name"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 5),
                  child: TextField(
                    controller: descController,
                    onChanged: (text) {
                      description = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText:
                            AppTranslations.of(context).text("description"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text(AppTranslations.of(context).text("gender"),
                          style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Radio(
                        groupValue: _genderValue,
                        value: 0,
                        onChanged: _genderChange,
                      ),
                    ),
                    Text(AppTranslations.of(context).text("male"),
                        style: TextStyle(fontSize: 16)),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Radio(
                        groupValue: _genderValue,
                        value: 1,
                        onChanged: _genderChange,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: TextField(
                    controller: contactController,
                    onChanged: (text) {
                      contact = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: AppTranslations.of(context).text("contact"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: TextField(
                    controller: hkidController,
                    onChanged: (text) {
                      hkid = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: AppTranslations.of(context).text("hkid"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text(AppTranslations.of(context).text("cssa"),
                          style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Radio(
                        groupValue: _cssaValue,
                        value: 0,
                        onChanged: _cssaChange,
                      ),
                    ),
                    Text(AppTranslations.of(context).text("no"),
                        style: TextStyle(fontSize: 16)),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Radio(
                        groupValue: _cssaValue,
                        value: 1,
                        onChanged: _cssaChange,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text(AppTranslations.of(context).text("date_of_birth"),
                      style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: RaisedButton(
                    onPressed: () => _showDatePicker(),
                    child:
                        Text(AppTranslations.of(context).text("select_date")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(dob, style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: TextField(
                    controller: ageController,
                    onChanged: (text) {
                      print(agestring);
                      setState(() {
                        agestring = text;
                        
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: AppTranslations.of(context).text("age"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: RaisedButton(
                    child: Text(AppTranslations.of(context).text("reject")),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewRecord()),
                        );
                      setState(() {
                        reject = true;
                      });
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 5),
                  child: TextField(
                    controller: heartrateController,
                    onChanged: (text) {
                      heartrate = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText:
                            AppTranslations.of(context).text("heart_rate"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextField(
                    controller: bloodpressureController,
                    onChanged: (text) {
                      bloodpressure = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText:
                            AppTranslations.of(context).text("blood_pressure"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextField(
                    controller: bloodglucoseController,
                    onChanged: (text) {
                      bloodglucose = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText:
                            AppTranslations.of(context).text("blood_glucose"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextField(
                    controller: bodyheightController,
                    onChanged: (text) {
                      bodyheight = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText:
                            AppTranslations.of(context).text("body_height"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextField(
                    controller: bodyweightController,
                    onChanged: (text) {
                      bodyweight = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText:
                            AppTranslations.of(context).text("body_weight"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextField(
                    controller: bmiController,
                    onChanged: (text) {
                      bmi = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: AppTranslations.of(context).text("bmi"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextField(
                    controller: respirationrateController,
                    onChanged: (text) {
                      respirationrate = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: AppTranslations.of(context)
                            .text("respiration_rate"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(AppTranslations.of(context).text("smoking"),
                              style: TextStyle(fontSize: 16)),
                          new Checkbox(
                            value: _smoking,
                            onChanged: (bool newValue) {
                              setState(() {
                                _smoking = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(AppTranslations.of(context).text("alcohol"),
                              style: TextStyle(fontSize: 16)),
                          new Checkbox(
                            value: _alcohol,
                            onChanged: (bool newValue) {
                              setState(() {
                                _alcohol = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(AppTranslations.of(context).text("drug_abuse"),
                              style: TextStyle(fontSize: 16)),
                          new Checkbox(
                            value: _drugs,
                            onChanged: (bool newValue) {
                              setState(() {
                                _drugs = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: Text(
                      AppTranslations.of(context)
                          .text("additional_information1"),
                      style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextField(
                    controller: additionalinfo1Controller,
                    onChanged: (text) {
                      additionalinfo1 = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: AppTranslations.of(context)
                            .text("e.g._lost_weight"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: 10)),

                Divider(),
                
                Padding(
                  padding:
                      EdgeInsets.only(top: 24, bottom: 5, left: 28, right: 24),
                  child: Text(AppTranslations.of(context).text("wound"),
                      style: TextStyle(fontSize: 16)),
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
                  child: Text(AppTranslations.of(context).text("mental_issues"),
                      style: TextStyle(fontSize: 16)),
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
                  child: Text(
                      AppTranslations.of(context)
                          .text("previous_medical_records"),
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
                  child: Text(
                      AppTranslations.of(context)
                          .text("additional_information2"),
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
                      child: Text(
                          AppTranslations.of(context)
                              .text("additional_files_photos"),
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
                              child: Text(
                                  AppTranslations.of(context).text("delete")),
                              onPressed: () {
                                _deletePic(index);
                              }),
                        ]);
                      }),
                ),
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(AppTranslations.of(context).text("back")),
                      onPressed: () {},
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    RaisedButton(
                      child: Text(AppTranslations.of(context).text("next")),
                      onPressed: () {
                        _persistPatientInfo1();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientInfo2()),
                        );
                      },
                    ),
                  ],
                ),
                */
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    child:
                        Text(AppTranslations.of(context).text("finish_record")),
                    onPressed: () {
                      _persistPatientInfo();
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
