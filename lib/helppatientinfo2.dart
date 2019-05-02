import 'package:flutter/material.dart';

class HelpPatientInfo2 extends StatefulWidget {
  @override
  _HelpPatientInfo2 createState() => _HelpPatientInfo2();
}

class _HelpPatientInfo2 extends State<HelpPatientInfo2> {

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
              'Record the values of the ones you checked (based on the medical equipment available on the outreach)\nWrite additional notes if the person shows any worrying values or health problems that should be checked again or thoroughly',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}