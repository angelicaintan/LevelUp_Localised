import 'package:flutter/material.dart';

class HelpLocation extends StatefulWidget {
  @override
  _HelpLocation createState() => _HelpLocation();
}

class _HelpLocation extends State<HelpLocation> {

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
              'You can get your access code from your team leader or Salvation Army Staff  to use the app. \nPlease fill in your name and email address in case we need verification on the records that you input\nClick on the gear icon to switch between English and Cantonese',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}