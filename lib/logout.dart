import 'package:flutter/material.dart';
import 'main.dart';
import 'newrecord.dart';
import 'app_translations.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
      ),
      body: ListView(
        children: <Widget> [
          Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
              child: Text(AppTranslations.of(context).text("thank_you_for_contribution"),
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center
              ),
            ),
             Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Image.asset('assets/images/icon@2x.png', height: 150),
            ),
            RaisedButton(
              child: Text(
                AppTranslations.of(context).text("logout")
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocalisedApp()),
                );
              },
            ),
            RaisedButton(
              child: Text(
                AppTranslations.of(context).text("new_record")
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewRecord()),
                );
              },
            ),
          ],
        ),
        ],
      )
    );
  }
}