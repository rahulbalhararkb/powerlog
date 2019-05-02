import 'package:flutter/material.dart';
import 'package:powerlog/model/note.dart';
import 'package:powerlog/service/firebase_firestore_service.dart';

class DisplayDefect extends StatefulWidget {
  final Note note;
  DisplayDefect(this.note);

  @override
  State<StatefulWidget> createState() => new _DisplayDefectState();
}

class _DisplayDefectState extends State<DisplayDefect> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DEFECT DETAILS')),
      body: Container(
          margin: EdgeInsets.all(15.0),
          //alignment: Alignment.center,
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
                            padding: EdgeInsets.only(
                                top: 0.0, left: 20.0, right: 5.0),
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Divider(height: 5.0),
                                  ListTile(
                                    title: Text(
                                      'AREA DETAILS',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${widget.note.jobtimeday}-${widget.note.jobtimemonth}-${widget.note.jobtimeyear}/${widget.note.jobtimehr}:${widget.note.jobtimemin}:${widget.note.jobtimesec}/${widget.note.stage}/${widget.note.unit}/${widget.note.area}',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    leading: const Icon(Icons.directions),
                                  ),
                                ],
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 20.0, right: 5.0),
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Divider(height: 5.0),
                                  ListTile(
                                    title: Text(
                                      'JOB TYPE/STATUS',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${widget.note.jobtype}/${widget.note.jobstatus}',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    leading: const Icon(Icons.directions),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: 15.0),
                        Container(
                          padding: EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 5.0),
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    Divider(height: 5.0),
                                    ListTile(
                                      title: Text(
                                        'JOB DETAILS',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${widget.note.jobdetails}',
                                        style: new TextStyle(
                                          fontSize: 18.0,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      leading: const Icon(Icons.directions),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    Divider(height: 5.0),
                                    ListTile(
                                      title: Text(
                                        'JOB REMARKS',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${widget.note.jobremarks}',
                                        style: new TextStyle(
                                          fontSize: 18.0,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      leading: const Icon(Icons.directions),
                                    ),
                                  ],
                                ),
                              )
                              
                              
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
