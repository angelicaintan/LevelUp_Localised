class Record {
  Record(
      String username,
      String emailaddress,
      String location,
      String name,
      String description,
      String gender,
      String contact,
      String hkid,
      bool cssa,
      String dob,
      int age,
      bool reject,
      String heartrate,
      String bloodpressure,
      String bloodglucose,
      String bodyheight,
      String bodyweight,
      String bmi,
      String respirationrate,
      bool smoking,
      bool alcohol,
      bool drugs,
      String additionalinfo1,
      String wound,
      String mentalissues,
      String pastmedrecords,
      String additionalinfo2) {
    _username = username;
    _emailaddress = emailaddress;
    _location = location;
    _name = name;
    _description = description;
    _gender = gender;
    _contact = contact;
    _hkid = hkid;
    _cssa = cssa;
    _dob = dob;
    _age = age;
    _reject = reject;

    _heartrate = heartrate;
    _bloodpressure = bloodpressure;
    _bloodglucose = bloodglucose;
    _bodyweight = bodyweight;
    _bodyheight = bodyheight;
    _bmi = bmi;
    _respirationrate = respirationrate;
    _additionalinfo1 = additionalinfo1;

    _wound = wound;
    _mentalissues = mentalissues;
    _pastmedrecords = pastmedrecords;
    _additionalinfo2 = additionalinfo2;
  }

  // VARIABLES FOR USER IDENTITY, LOCATION, AND PATIENT'S PERSONAL PARTICULARS (part 1 of the record)
  String _username;
  String _emailaddress;
  String _location;
  String _name;
  String _description;
  String _contact;
  bool _cssa;
  String _hkid;
  String _gender;
  String _dob;
  int _age;
  bool _smoking = false;
  bool _alcohol = false;
  bool _drugs = false;
  bool _reject = false;

  // VARIABLES FOR THE HEALTH INFO OF THE PATIENT (part 2 of the record)
  String _heartrate;
  String _bloodpressure;
  String _bloodglucose;
  String _bodyheight;
  String _bodyweight;
  String _bmi;
  String _respirationrate;
  String _additionalinfo1;

  // VARIABLES FOR THE FURTHER DESCRIPTIONS OF THE PATIENT (part 3 of the record)
  String _wound;
  String _mentalissues;
  String _pastmedrecords;
  String _additionalinfo2;

  // GETTERS part 1
  String get_username() {
    return _username;
  }
  String get_emailaddress() {
    return _emailaddress;
  }
  String get_location() {
    return _location;
  }
  String get_name() {
    return _name;
  }
  String get_description() {
    return _description;
  }
  String get_contact() {
    return _contact;
  }
  bool get_cssa() {
    return _cssa;
  }
  String get_hkid() {
    return _hkid;
  }
  String get_gender() {
    return _gender;
  }
  String get_dob() {
    return _dob;
  }
  int get_age() {
    return _age;
  }
  bool get_smoking() {
    return _smoking;
  }
  bool get_alcohol() {
    return _alcohol;
  }
  bool get_drugs() {
    return _drugs;
  }
  bool get_reject() {
    return _reject;
  }

  // GETTERS part 2
  String get_heartrate() {
    return _heartrate;
  }
  String get_bloodpressure() {
    return _bloodpressure;
  }
  String get_bloodglucose() {
    return _bloodglucose;
  }
  String get_height() {
    return _bodyheight;
  }
  String get_weight() {
    return _bodyweight;
  }
  String get_bmi() {
    return _bmi;
  }
  String get_respirationrate() {
    return _respirationrate;
  }
  String get_additionalinfo1() {
    return _additionalinfo1;
  }

  // GETTERS part 3
  String get_wound() {
    return _wound;
  }
  String get_mentalissues() {
    return _mentalissues;
  }
  String get_pastmedrecords() {
    return _pastmedrecords;
  }
  String get_additionalinfo2() {
    return _additionalinfo2;
  }

  Map<String, dynamic> toMap() {
    return {
      'username': _username,
      // 'emailaddress': _emailaddress,
      // 'location': _location,
      'angelica': _name,
      // 'description': _description,
      // 'gender': _gender,
      //'contact': _contact,
      //'hkid': _hkid,
      //'cssa': _cssa,
      // 'dob': _dob,
      'intan': _age,
      //'reject': _reject,
      //'heartrate': _heartrate,
      //'bloodpressure': _bloodpressure,
      //'bloodglucose': _bloodglucose,
      //'bodyheight': _bodyheight,
      //'bodyweight': _bodyweight,
      //'bmi': _bmi,
      //'respirationrate': _respirationrate,
      //'smoking': _smoking,
      //'alcohol': _alcohol,
      //'drugs': _drugs,
      //'additionalinfo1': _additionalinfo1,
      //'wound': _wound,
      //'mentalissues': _mentalissues,
      //'pastmedrecords': _pastmedrecords,
      //'additionalinfo2': _additionalinfo2
    };
  }
 
}
