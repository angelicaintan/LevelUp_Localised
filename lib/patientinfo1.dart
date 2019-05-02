import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'app_translations.dart';
import 'patientinfo2.dart';
import 'helppatientinfo1.dart';

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
                  }),
              new FlatButton(
                child: Text(AppTranslations.of(context).text("logout")),
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

  _persistPatientInfo1() async {
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
  }

  _printLatestValue() {
    print(age);
  }

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final contactController = TextEditingController();
  final hkidController = TextEditingController();
  final ageController = TextEditingController();
  final birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ageController.addListener(_printLatestValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          FlatButton(
            child: Text(AppTranslations.of(context).text("logout"),
                style: TextStyle(fontSize: 18, color: Colors.white)),
            onPressed: () {
              
            },
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
                    controller: nameController,
                    onChanged: (text) {
                      name = text;
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
                        labelText: AppTranslations.of(context).text("description"),
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
                    Text(AppTranslations.of(context).text("male"), style: TextStyle(fontSize: 16)),
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
                    Text(AppTranslations.of(context).text("no"), style: TextStyle(fontSize: 16)),
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
                  child: Text(AppTranslations.of(context).text("date_of_birth"), style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: RaisedButton(
                    onPressed: () => _showDatePicker(),
                    child: Text(AppTranslations.of(context).text("select_date")),
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
                    
                      setState(() {
                        reject = true;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(AppTranslations.of(context).text("back")),
                      onPressed: () {
              
                      },
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    RaisedButton(
                      child: Text(AppTranslations.of(context).text("next")),
                      onPressed: () {
                        _persistPatientInfo1();
                       Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientInfo2()),
              );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
