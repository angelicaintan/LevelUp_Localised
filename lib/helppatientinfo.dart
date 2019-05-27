import 'package:flutter/material.dart';

class HelpPatientInfo extends StatefulWidget {
  @override
  _HelpPatientInfo createState() => _HelpPatientInfo();
}

class _HelpPatientInfo extends State<HelpPatientInfo> {

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
              'Please fill in the personal info you got from the person you have approached through conversation.\n\nRemarks:\nLocation: Please type the location or closest landmark of the person.\nName:  Record the name that they introduced themself with\nDescription: Can be location “man living under a bridge” or based on their physical trait “woman wearing a blue cap” “pregnant woman” \nThis will help later volunteers to approach the right person if he/she needs a follow up.\nCSSA (Comprehensive Social Security Assistance (CSSA) Scheme)\nEntering their date of birth will automatically calculate their age.\nTick the reject button if the person does not want your help or  their health to be checked\n\nRecord the values of the ones you checked (based on the medical equipment available on the outreach)\nWrite additional notes if the person shows any worrying values or health problems that should be checked again or thoroughly\n\nType if there are any problems in the person’s physical and mental conditions through observation and conversation.\nDo take a photo by pressing the camera button and directly attach their consent form (paper) in the ‘Additional files or photos’ section.’ \nYou can add photos of the person’s physical ailments or previous medical appointments/referrals in the ‘Additional files or photos’ section.\nClicking “Finish record” will send your data (on the person you just recorded) to Salvation Army’s database', style: TextStyle(fontSize: 21),
            ),
          ),
        ],
      ),
    );
  }
}