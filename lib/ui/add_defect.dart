import 'package:flutter/material.dart';
import 'package:powerlog/model/note.dart';
import 'package:powerlog/service/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDefect extends StatefulWidget {
  final Note note;
  AddDefect(this.note);

  @override
  State<StatefulWidget> createState() => new _AddDefectState();
}

class _AddDefectState extends State<AddDefect> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  String _unit;
  String _stage;
  String _area;
  String _jobstatus;
  String _jobtype;
  TextEditingController _jobdetailsController;
  TextEditingController _jobremarksController;
  TextEditingController _jobentrystampController;

  @override
  void initState() {
    super.initState();
    _jobdetailsController =
        new TextEditingController(text: widget.note.jobdetails);
    _jobremarksController =
        new TextEditingController(text: widget.note.jobremarks);
    _jobentrystampController =
        new TextEditingController(text: widget.note.jobentrystamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ADD DEFECT')),
      body: Container(
          margin: EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: ListView(shrinkWrap: true, children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: 100.0,
                          child: Material(
                            shadowColor: Colors.blue[50],
                            color: Colors.blue[100],
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'SELECT WORK AREA DETAILS',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding:
                              EdgeInsets.only(top: 0.0, left: 20.0, right: 5.0),
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection("STAGE")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                      child: CircularProgressIndicator());
                                //var length = snapshot.data.documents.length;
                                //DocumentSnapshot ds = snapshot.data.documents[length - 1];
                                return DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                      'Please choose a Stage'), // Not necessary for Option 1
                                  value: _stage,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _stage = newValue;
                                      print(_stage);
                                    });
                                  },
                                  items: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem(
                                        value: document.documentID,
                                        child: Container(
                                          child: new Text(document.documentID),
                                        ));
                                  }).toList(),
                                );
                              }),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding:
                              EdgeInsets.only(top: 0.0, left: 20.0, right: 5.0),
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection("UNIT")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                      child: CircularProgressIndicator());
                                //var length = snapshot.data.documents.length;
                                //DocumentSnapshot ds = snapshot.data.documents[length - 1];
                                return DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                      'Please choose a Unit'), // Not necessary for Option 1
                                  value: _unit,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _unit = newValue;
                                      print(_unit);
                                    });
                                  },
                                  items: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem(
                                        value: document.documentID,
                                        child: Container(
                                          child: new Text(document.documentID),
                                        ));
                                  }).toList(),
                                );
                              }),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding:
                              EdgeInsets.only(top: 0.0, left: 20.0, right: 5.0),
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection("AREA")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                      child: CircularProgressIndicator());
                                //var length = snapshot.data.documents.length;
                                //DocumentSnapshot ds = snapshot.data.documents[length - 1];

                                return DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                      'Please choose a Area'), // Not necessary for Option 1
                                  value: _area,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _area = newValue;
                                      print(_area);
                                    });
                                  },
                                  items: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem(
                                        value: document.documentID,
                                        child: Container(
                                          child: new Text(document.documentID),
                                        ));
                                  }).toList(),
                                );
                              }),
                        ),
                        Container(
                          height: 50.0,
                          width: 100.0,
                          child: Material(
                            shadowColor: Colors.blue[50],
                            color: Colors.blue[100],
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'ENTER DEFECT DETAILS',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding:
                              EdgeInsets.only(top: 0.0, left: 20.0, right: 5.0),
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection("JOBTYPE")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                      child: CircularProgressIndicator());
                                //var length = snapshot.data.documents.length;
                                //DocumentSnapshot ds = snapshot.data.documents[length - 1];

                                return DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                      'Please choose a Job Type'), // Not necessary for Option 1
                                  value: _jobtype,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _jobtype = newValue;
                                      print(_jobtype);
                                    });
                                  },
                                  items: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem(
                                        value: document.documentID,
                                        child: Container(
                                          child: new Text(document.documentID),
                                        ));
                                  }).toList(),
                                );
                              }),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding:
                              EdgeInsets.only(top: 0.0, left: 20.0, right: 5.0),
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection("JOBSTATUS")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                      child: CircularProgressIndicator());
                                //var length = snapshot.data.documents.length;
                                //DocumentSnapshot ds = snapshot.data.documents[length - 1];

                                return DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                      'Please choose a Job Status'), // Not necessary for Option 1
                                  value: _jobstatus,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _jobstatus = newValue;
                                      print(_jobstatus);
                                    });
                                  },
                                  items: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem(
                                        value: document.documentID,
                                        child: Container(
                                          child: new Text(document.documentID),
                                        ));
                                  }).toList(),
                                );
                              }),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.only(
                              top: 0.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                maxLines: null,
                                maxLengthEnforced: false,
                                keyboardType: TextInputType.multiline,
                                controller: _jobdetailsController,
                                decoration: InputDecoration(
                                    labelText: 'JOB DETAILS',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green))),

                                /* validator: (value) =>
                          value.isEmpty ? 'Details can\'t be empty' : null,
                        onSaved: (value) => _details = value,*/
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                maxLines: null,
                                maxLengthEnforced: false,
                                keyboardType: TextInputType.multiline,
                                controller: _jobremarksController,
                                decoration: InputDecoration(
                                    labelText: 'JOB REMARKS',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green))),
                                /* validator: (value) =>
                          value.isEmpty ? 'Details can\'t be empty' : null,
                        onSaved: (value) => _details = value,*/
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                maxLines: null,
                                maxLengthEnforced: false,
                                keyboardType: TextInputType.multiline,
                                controller: _jobentrystampController,
                                decoration: InputDecoration(
                                    labelText: 'JOB ENTRY STAMP',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green))),
                                /* validator: (value) =>
                          value.isEmpty ? 'Details can\'t be empty' : null,
                        onSaved: (value) => _details = value,*/
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 5.0, left: 20.0, right: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Container(
                                height: 40.0,
                                width: 150.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.blueAccent,
                                  color: Colors.blue,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      db
                                          .createNote(
                                              _unit,
                                              _stage,
                                              _area,
                                              _jobstatus,
                                              _jobtype,
                                              _jobdetailsController.text,
                                              _jobremarksController.text,
                                              _jobentrystampController.text)
                                          .then((_) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        'ADD',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
