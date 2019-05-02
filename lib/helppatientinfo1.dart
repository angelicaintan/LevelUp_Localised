import 'package:flutter/material.dart';

class HelpPatientInfo1 extends StatefulWidget {
  @override
  _HelpPatientInfo1 createState() => _HelpPatientInfo1();
}

class _HelpPatientInfo1 extends State<HelpPatientInfo1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Text(
              'Please fill in the personal info you got from the person you have approached through conversation.\nRemarks:\nName:  Record the name that they introduced themself with\nDescription: Can be location “man living under a bridge” or based on their physical trait “woman wearing a blue cap” “pregnant woman” \nThis will help later volunteers to approach the right person if he/she needs a follow up.\nCSSA (Comprehensive Social Security Assistance (CSSA) Scheme)\nEntering their date of birth will automatically calculate their age.\nTick the reject button if the person does not want your help or  their health to be checked', style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}