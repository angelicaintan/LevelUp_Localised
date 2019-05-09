import 'dart:io';
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

  _persistPatientInfo2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
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
                
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
