class Note {
  String _id;
  String _unit;
  String _stage;
  String _area;
  String _jobstatus;
  String _jobtype;
  String _jobdetails;
  String _jobremarks;
  

  Note(this._id, this._unit, this._stage, this._area, this._jobstatus, this._jobtype, this._jobdetails, this._jobremarks);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._unit = obj['unit'];
    this._stage = obj['stage'];
    this._area = obj['area'];
    this._jobstatus = obj['jobstatus'];
    this._jobtype = obj['jobtype'];
    this._jobdetails = obj['jobdetails'];
    this._jobremarks = obj['jobremarks'];
    
  }

  String get id => _id;
  String get unit => _unit;
  String get stage => _stage;
  String get area => _area;
  String get jobstatus => _jobstatus;
  String get jobtype => _jobtype;
  String get jobdetails => _jobdetails;
  String get jobremarks => _jobremarks;
  

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
    
  }
}
