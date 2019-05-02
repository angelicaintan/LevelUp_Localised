import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'helplocation.dart';
import 'patientinfo1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  
  final locationController = TextEditingController();
  String location;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kdefaultLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Position position;

  Future<void> _getCurrentPosition() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 18,
    )));
  }

   _persistLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
            child: Text('logout', style: TextStyle(fontSize: 18, color: Colors.white)),
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
                    MaterialPageRoute(builder: (context) => HelpLocation()),
                  );
                },
              ),
              
            ]
        ),
        body: ListView(children: <Widget>[
          GestureDetector(
            onTap: () => _dismissKeyboard(),
          child: Column(
            children: <Widget>[
              Padding (
                padding:EdgeInsets.only(top:30)
              ),
              SizedBox(
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                  child: TextField(
                    controller: locationController,
                    onChanged: (text) {
                      location = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelText: location ?? 'type location',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kdefaultLocation,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Locate me'),
                onPressed: () {
                  _getCurrentPosition();
                },
              ),
              RaisedButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientInfo1()),
                  );
                  _persistLocation();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            ],
          ),
          ),
        ]));
  }
}