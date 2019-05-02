import 'package:flutter/material.dart';
import 'helppatientinfo2.dart';
import 'patientinfo3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'patientinfo1.dart';
import 'app_translations.dart';

class PatientInfo2 extends StatefulWidget {
  @override
  _PatientInfo2State createState() => _PatientInfo2State();
}

class _PatientInfo2State extends State<PatientInfo2> {
  @override
  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

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

  _persistPatientInfo2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        IconButton(
          icon: Icon(Icons.help_outline, size: 29),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpPatientInfo2()),
            );
          },
        ),
      ]),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () => _dismissKeyboard(),
            child: Column(
              children: <Widget>[
                
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
                        labelText: AppTranslations.of(context).text("heart_rate"),
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
                        labelText: AppTranslations.of(context).text("blood_pressure"),
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
                        labelText: AppTranslations.of(context).text("blood_glucose"),
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
                        labelText: AppTranslations.of(context).text("body_height"),
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
                        labelText: AppTranslations.of(context).text("body_weight"),
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
                        labelText: AppTranslations.of(context).text("respiration_rate"),
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
                          Text(AppTranslations.of(context).text("smoking"), style: TextStyle(fontSize: 16)),
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
                          Text(AppTranslations.of(context).text("alcohol"), style: TextStyle(fontSize: 16)),
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
                          Text(AppTranslations.of(context).text("drug_abuse"), style: TextStyle(fontSize: 16)),
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
                  child: Text(AppTranslations.of(context).text("additional_information1"),
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
                        labelText: AppTranslations.of(context).text("e.g._lost_weight"),
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(AppTranslations.of(context).text("back")),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientInfo1()),
                        );
                      },
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    RaisedButton(
                      child: Text(AppTranslations.of(context).text("next")),
                      onPressed: () {
                        _persistPatientInfo2();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientInfo3()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
