import 'package:flutter/material.dart';
import 'helpnewrecord.dart';
import 'location.dart';
import 'patientinfo1.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'app_translations.dart';

class NewRecord extends StatefulWidget {
  @override
  _NewRecordState createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {

  String accessdate;

   _persistaccessdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessdate', accessdate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          FlatButton(
            child: Text(AppTranslations.of(context).text("logout"), style: TextStyle(fontSize: 18, color: Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocalisedApp()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline, size: 29),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpNewRecord()),
              );
            },
          ),
        ]),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding:EdgeInsets.only(top:50),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: RaisedButton(
                  padding: EdgeInsets.all(20),
                  child: Text(AppTranslations.of(context).text("new_record"), style: TextStyle(fontSize: 21)),
                  onPressed: () {
                    setState(() {
                      accessdate = DateFormat('yyyy-MM-dd').format(DateTime.now());;
                    });
                    _persistaccessdate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientInfo1()),
                    );
                  },
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.all(20),
                child: Text(AppTranslations.of(context).text("finish_outreach"), style: TextStyle(fontSize: 21)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocalisedApp()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
