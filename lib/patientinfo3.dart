
import 'main.dart';
import 'package:flutter/material.dart';
import 'helppatientinfo3.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'logout.dart';
import 'app_translations.dart';

class PatientInfo3 extends StatefulWidget {
  @override
  _PatientInfo3State createState() => _PatientInfo3State();
}

class _PatientInfo3State extends State<PatientInfo3> {
  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

/*
  

  
  */

  

  _persistPatientInfo3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
  }

  

/*
  
  */

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
                

              ],
            ),
          ),
        ]));
  }
}
