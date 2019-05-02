import 'package:flutter/material.dart';

class HelpPatientInfo3 extends StatefulWidget {
  @override
  _HelpPatientInfo3 createState() => _HelpPatientInfo3();
}

class _HelpPatientInfo3 extends State<HelpPatientInfo3> {

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
              'Type if there are any problems in the person’s physical and mental conditions through observation and conversation.\nDo take a photo by pressing the camera button and directly attach their consent form (paper) in the ‘Additional files or photos’ section.’ \nYou can add photos of the person’s physical ailments or previous medical appointments/referrals in the ‘Additional files or photos’ section.\nClicking “Finish record” will send your data (on the person you just recorded) to Salvation Army’s database',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}