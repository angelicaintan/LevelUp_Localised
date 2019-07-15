import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'app_translations.dart';
import 'records.dart';
import 'helpfiles.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserFiles extends StatefulWidget {
  @override
  _UserFilesState createState() => _UserFilesState();
}

class _UserFilesState extends State<UserFiles> {
  @override
  Widget build(BuildContext context) {

    //  FUNCTION THAT RETRIEVES THE RECORDS
    Future<Null> getRecords() async {
      final Future<Database> database = openDatabase(
        // Set the path to the database.
        path.join(await getDatabasesPath(), 'records_database.db'),
      );

      // Get a reference to the database.
      final Database db = await database;

      // Query the table for all The Records.
      final List<Map<String, dynamic>> maps = await db.query('records');

      // test upload to firebase
      var records = Firestore.instance
        .collection('Records')
        .document(); 
      
      int length = (maps.length);
      for (int i=0; i<length; ++i) {
         records.setData(maps[0]);
      }
      
      /*
      // Convert the List<Map<String, dynamic> into a List<Record>.
      return List.generate(maps.length, (i) {
        return Record(
          maps[i]['record_no'],
          maps[1]['accesscode'],
          maps[i]['username'],
          maps[i]['emailaddress'],
          maps[i]['location'],
          maps[i]['name'],
          maps[i]['description'],
          maps[i]['gender'],
          maps[i]['contact'],
          maps[i]['hkid'],
          maps[i]['cssa'] == 0 ? false : true,
          maps[i]['dob'],
          maps[i]['age'],
          maps[i]['reject'] == 0 ? false : true,
          maps[i]['heartrate'],
          maps[i]['bloodpressure'],
          maps[i]['bloodglucose'],
          maps[i]['bodyheight'],
          maps[i]['bodyweight'],
          maps[i]['bmi'],
          maps[i]['respirationrate'],
          maps[i]['smoking'] == 0 ? false : true,
          maps[i]['alcohol'] == 0 ? false : true,
          maps[i]['drugs'] == 0 ? false : true,
          maps[i]['additionalinfo1'],
          maps[i]['wound'],
          maps[i]['mentalissues'],
          maps[i]['pastmedrecords'],
          maps[i]['additionalinfo2'],
        );
      });
    
    */
    }

    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          // LOG OUT BUTTON
          FlatButton(
            child: Text(AppTranslations.of(context).text("logout"),
                style: TextStyle(fontSize: 18, color: Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocalisedApp()),
              );
            },
          ),

          // HELP BUTTON
          IconButton(
            icon: Icon(Icons.help_outline, size: 29),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpFiles()),
              );
            },
          ),
        ]),
        body: ListView(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: 24, right: 24, top: 30, bottom: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlatButton(
                            child: Text("upload"),
                            onPressed: () {
                              getRecords();
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
