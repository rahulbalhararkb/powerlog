import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:powerlog/model/note.dart';
import 'package:powerlog/service/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDefect extends StatefulWidget {
  final String uid;
  final Note note;
  AddDefect(this.uid, this.note);

  @override
  State<StatefulWidget> createState() => new _AddDefectState();
}

class _AddDefectState extends State<AddDefect> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  final formKey = new GlobalKey<FormState>();

  String _unit;
  String _stage;
  String _area;
  String _jobstatus;
  String _jobtype;
  TextEditingController _jobdetailsController;
  TextEditingController _jobremarksController;

   bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }


  @override
  void initState() {
    super.initState();
    _jobdetailsController =
        new TextEditingController(text: widget.note.jobdetails);
    
    _jobremarksController =
        new TextEditingController(text: widget.note.jobremarks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Padding(
            padding: const EdgeInsets.only(left: 70.0),
            child: Text(
              'ADD DEFECT',
              style: TextStyle(color: Colors.white),
            ),
          ),
          leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),),
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
                    child: Form(key: formKey,
                                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            width: 100.0,
                            child: Material(
                              shadowColor: Colors.blue[50],
                              color: Colors.blueGrey,
                              elevation: 7.0,
                              child: Center(
                                child: Text(
                                  'WORK AREA DETAILS',
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
                                  return Center(
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.grey[500],
                                      ),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(
                                          'Please choose a Stage',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ), // Not necessary for Option 1
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
                                                child: new Text(
                                                  document.documentID,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
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
                                  return Center(
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.grey[500],
                                      ),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(
                                          'Please choose a Unit',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ), // Not necessary for Option 1
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
                                                child: new Text(
                                                  document.documentID,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
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

                                  return Center(
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.grey[500],
                                      ),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(
                                          'Please choose a Area',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ), // Not necessary for Option 1
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
                                                child: new Text(
                                                  document.documentID,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Container(
                            height: 40.0,
                            width: 100.0,
                            child: Material(
                              shadowColor: Colors.blue[50],
                              color: Colors.blueGrey,
                              elevation: 7.0,
                              child: Center(
                                child: Text(
                                  'JOB DETAILS',
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

                                  return Center(
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.grey[500],
                                      ),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(
                                          'Please choose a Job Type',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ), // Not necessary for Option 1
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
                                                child: new Text(
                                                  document.documentID,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
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

                                  return Center(
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.grey[500],
                                      ),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(
                                          'Please choose a Job Status',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ), // Not necessary for Option 1
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
                                                child: new Text(
                                                  document.documentID,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
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
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                  maxLines: null,
                                  maxLengthEnforced: false,
                                  keyboardType: TextInputType.multiline,
                                  controller: _jobdetailsController,
                                  decoration: InputDecoration(
                                      labelText: 'JOB DETAILS',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[300]),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),

                                   validator: (value) =>
                            value.isEmpty ? 'Job Details can\'t be empty' : null,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                  maxLines: null,
                                  maxLengthEnforced: false,
                                  keyboardType: TextInputType.multiline,
                                  controller: _jobremarksController,
                                  decoration: InputDecoration(
                                      labelText: 'JOB REMARKS',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[300]),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                   validator: (value) =>
                            value.isEmpty ? 'Job Remarks can\'t be empty' : null,
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
                                    shadowColor: Colors.lightBlueAccent,
                                    color: Color.fromRGBO(64, 75, 96, .9),
                                    elevation: 7.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        if(validateAndSave()&&(_unit!="null")&&(_stage!="null")&&(_area!="null")&&(_jobstatus!="null")&&(_jobtype!="null")){
                                         try{
                                            db
                                            .createNote(
                                                widget.uid,
                                                _unit,
                                                _stage,
                                                _area,
                                                _jobstatus,
                                                _jobtype,
                                                _jobdetailsController.text,
                                                _jobremarksController.text,
                                                DateTime.now().day.toString(),
                                                DateTime.now().month.toString(),
                                                DateTime.now().year.toString(),
                                                DateTime.now().hour.toString(),
                                                DateTime.now().minute.toString(),
                                                DateTime.now().second.toString(),
                                                DateTime.now().toString())
                                            .then((_) {
                                          Navigator.pop(context);
                                        });
                                         }catch(e){
                                           print('Error: $e');
                                         }
                                        }else{
                                          print("fill all fields");
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          'ADD JOB',
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
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
