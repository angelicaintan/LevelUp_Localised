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
import 'dart:convert';
import 'dart:typed_data';
import 'listfiles.dart';
import 'dart:io';
import 'dart:async';
import 'newrecord.dart';
import 'patientinfo.dart';

class UserFiles extends StatefulWidget {
  @override
  _UserFilesState createState() => _UserFilesState();
}

class _UserFilesState extends State<UserFiles> {
  @override
  Widget build(BuildContext context) {
    void _showDialog() async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Error! Unable to upload files"),
              content: new Text("Please try again when device is connected to the internet."),
                  // CircularProgressIndicator(),
              actions: <Widget>[
                new FlatButton(
                  child: Text("ok"),
                    onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    }

    List<Record> mock = new List(5);

    Future<List<Record>> getRecords() async {
      final Future<Database> database = openDatabase(
        // Set the path to the database.
        path.join(await getDatabasesPath(), 'records_database.db'),
      );

      // Get a reference to the database.
      final Database db = await database;

      // Query the table for all The Records.
      final List<Map<String, dynamic>> maps = await db.query('records');

      // Convert the List<Map<String, dynamic> into a List<Record>.
      return List.generate(maps.length, (i) {
        return Record(
            maps[i]['record_no'],
            maps[1]['accesscode'],
            maps[i]['username'],
            maps[i]['emailaddress'],
            maps[i]['accessdate'],
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
            maps[i]['']);
      });
    }

    //  FUNCTION THAT RETRIEVES THE RECORDS
    Future<Null> _uploadRecords() async {
      final Future<Database> database = openDatabase(
        // Set the path to the database.
        path.join(await getDatabasesPath(), 'records_database.db'),
      );

      // Get a reference to the database.
      final Database db = await database;

      // Query the table for all The Records.
      final List<Map<String, dynamic>> maps = await db.query('records');

      // test upload to firebase
      var records = Firestore.instance.collection('Records').document();

      int length = maps.length;

      print(length);

      for (int i = 0; i < length; ++i) {
        print("i = $i");

        Map<String, dynamic> recordMap = {
          'accessCode': maps[i]['accesscode'] ?? 0,
          'b. user-name': maps[i]['username'] ?? 0,
          'c. user-contact': maps[i]['emailaddress'] ?? 0,
          'accessDate': maps[i]['accessdate'] ?? 0,
          'd. location': maps[i]['location'] ?? 0,
          'name': maps[i]['name'] ?? 0,
          'f. description': maps[i]['description'] ?? 0,
          'g. gender': maps[i]['gender'] ?? 0,
          'h. contact': maps[i]['contact'] ?? 0,
          'HKID': maps[i]['hkid'] ?? 0,
          'j. CSSA': maps[i]['cssa'] ?? 0,
          'k. birthday': maps[i]['dob'] ?? 0,
          'l. age': maps[i]['age'] ?? 0,
          'm. reject': maps[i]['reject'] ?? 0,
          'n. heart-rate': maps[i]['heartrate'] ?? 0,
          'o. blood-pressure': maps[i]['bloodpressure'] ?? 0,
          'p. blood-glucose': maps[i]['bloodglucose'] ?? 0,
          'q. body-height': maps[i]['bodyheight'] ?? 0,
          'r. body-weight': maps[i]['bodyweight'] ?? 0,
          's. bmi': maps[i]['bmi'] ?? 0,
          't. respiration-rate': maps[i]['respirationrate'] ?? 0,
          'u. smoking': maps[i]['smoking'] ?? 0,
          'v. alcohol': maps[i]['alcohol'] ?? 0,
          'w. drugs': maps[i]['drugs'] ?? 0,
          'x. additional-info1': maps[i]['additionalinfo1'] ?? 0,
          'y. wound': maps[i]['wound'] ?? 0,
          'z. mental-issues': maps[i]['mentalissues'] ?? 0,
          'za. past-med-records': maps[i]['pastmedrecords'] ?? 0,
          'zb. additional-info2': maps[i]['additionalinfo2'] ?? 0,
        };

        records.setData(maps[i]);

        /*
        // upload photos
        List<File> photos = new List(5);

        String accesscode = maps[i]['accesscode'];
        String username = maps[i]['username'];
        String patientname = maps[i]['patientname'];
        String accessdate = maps[i]['accessdate'];

        print('here');
        print(maps[i]['name']);

        for (int j = 0; maps[i]['image$j'] != null; ++j) {
          print('here$j');

          // Image temp = Image.memory(base64.decode(maps[i]['image$i']));

          // photos[i] = temp;

          /*
          final StorageReference firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child(
                  '$accessdate-$accesscode-$username-$patientname-image$i.jpeg');

           print('here4');
          
          final StorageUploadTask task =
              firebaseStorageRef.putData(base64.decode(maps[i]['image$i']));
          */

          print('here5');
        }

        print('here6');
        */
      }

      /*
      // Convert the List<Map<String, dynamic> into a List<Record>.
      List.generate(maps.length, (i) {
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
          maps[i]['']
        );
      });
      */
    }

    return Scaffold(
        appBar: AppBar(leading: Container(), actions: <Widget>[
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
        body: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 24),
            ),
            new Expanded(
                child: new ListView.builder(
                    itemCount: mock.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text("2019-07-22-19:31:0$index-2046"),
                              ),
                              ButtonTheme(
                                minWidth: 30.0,
                                height: 20.0,
                                child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Text("delete"),
                                    onPressed: () {
                                      setState(() {
                                        mock.remove(mock[index]);
                                        // make it disappear from the interface
                                      });
                                    }),
                              ),
                            ],
                          ));
                    })),
            Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: RaisedButton(
                        child: Text("Upload Records"),
                        onPressed: () {
                          _showDialog();
                          // _uploadRecords();
                          
                        },
                      ),
                    ),
                    RaisedButton(
                        child: Text("Return"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewRecord()),
                          );
                        },
                      ),
                  ],
                ))
          ],
        ));
  }
}
