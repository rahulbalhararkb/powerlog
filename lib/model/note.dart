class Note {
  String _id;
  String _unit;
  String _stage;
  String _area;
  String _jobstatus;
  String _jobtype;
  String _jobdetails;
  String _jobremarks;
  String _jctday;
  String _jctmonth;
  String _jctyear;
  String _jcthr;
  String _jctmin;
  String _jctsec;
  String _jtimestamp;
  

  Note(this._id, this._unit, this._stage, this._area, this._jobstatus, this._jobtype, this._jobdetails, this._jobremarks, this._jctday,this._jctmonth,this._jctyear,this._jcthr,this._jctmin,this._jctsec,this._jtimestamp);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._unit = obj['unit'];
    this._stage = obj['stage'];
    this._area = obj['area'];
    this._jobstatus = obj['jobstatus'];
    this._jobtype = obj['jobtype'];
    this._jobdetails = obj['jobdetails'];
    this._jobremarks = obj['jobremarks'];
    this._jctday = obj['jobtimeday'];
    this._jctmonth = obj['jobtimemonth'];
    this._jctyear = obj['jobtimeyear'];
    this._jcthr = obj['jobtimehr'];
    this._jctmin = obj['jobtimemin'];
    this._jctsec = obj['jobtimesec'];
    this._jtimestamp = obj['jobtimestamp'];
    
  }

  String get id => _id;
  String get unit => _unit;
  String get stage => _stage;
  String get area => _area;
  String get jobstatus => _jobstatus;
  String get jobtype => _jobtype;
  String get jobdetails => _jobdetails;
  String get jobremarks => _jobremarks;
  String get jobtimeday => _jctday;
  String get jobtimemonth => _jctmonth;
  String get jobtimeyear => _jctyear;
  String get jobtimehr => _jcthr;
  String get jobtimemin => _jctmin;
  String get jobtimesec => _jctsec;
  String get jobtimestamp => _jtimestamp;
  

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['unit'] = _unit;
    map['stage'] = _stage;
    map['area'] = _area;
    map['jobstatus'] = _jobstatus;
    map['jobtype'] = _jobtype;
    map['jobdetails'] = _jobdetails;
    map['jobremarks'] = _jobremarks;
    map['jobtimeday'] = _jctday;
    map['jobtimemonth'] = _jctmonth;
    map['jobtimeyear'] = _jctyear;
    map['jobtimehr'] = _jcthr;
    map['jobtimemin'] = _jctmin;
    map['jobtimesec'] = _jctsec;
    map['jobtimestamp'] = _jtimestamp;
    

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._unit = map['unit'];
    this._stage = map['stage'];
    this._area = map['area'];
    this._jobstatus = map['jobstatus'];
    this._jobtype = map['jobtype'];
    this._jobdetails = map['jobdetails'];
    this._jobremarks = map['jobremarks'];
    this._jctday = map['jobtimeday'];
    this._jctmonth = map['jobtimemonth'];
    this._jctyear = map['jobtimeyear'];
    this._jcthr = map['jobtimehr'];
    this._jctmin = map['jobtimemin'];
    this._jctsec = map['jobtimesec'];
    this._jtimestamp = map['jobtimestamp'];
    
  }
}
