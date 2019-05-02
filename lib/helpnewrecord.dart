import 'package:flutter/material.dart';

class HelpNewRecord extends StatefulWidget {
  @override
  _HelpNewRecord createState() => _HelpNewRecord();
}

class _HelpNewRecord extends State<HelpNewRecord> {

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
              'To start a new record (encountering a new person to assess), please press the “New Record” button\nIf there is no more data to be inputted, please press the “Finish Outreach” button\nRemarks: Once you press “Finish Outreach” button, you cannot add more entry!',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}