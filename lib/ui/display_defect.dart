import 'package:flutter/material.dart';
import 'package:powerlog/model/note.dart';
import 'package:powerlog/service/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerlog/ui/update_defect.dart';

class DisplayDefect extends StatefulWidget {
  final Note note;
  final String uid;
  DisplayDefect(this.note,this.uid);

  @override
  State<StatefulWidget> createState() => new _DisplayDefectState();
}

class _DisplayDefectState extends State<DisplayDefect> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Container(
        child: ListView(shrinkWrap: true, children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(40.0),
                      child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Icon(
                                Icons.description,
                                color: Colors.white,
                                size: 40.0,
                              ),
                              Container(
                                width: 90.0,
                                child: new Divider(color: Colors.green),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                '${widget.note.stage}/${widget.note.unit}/${widget.note.area}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0),
                              ),
                              Container(
                                width: 120.0,
                                child: new Divider(color: Colors.green),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                  '${widget.note.jobtype}/${widget.note.jobstatus}',
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white)),
                              SizedBox(height: 10.0),
                              Text(
                                  '${widget.note.jobdate}     ${widget.note.jobtime}',
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                  child: new StreamBuilder(
                                      stream: Firestore.instance
                                          .collection('userdata')
                                          .document(widget.note.uid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData)
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        return Row(children: <Widget>[
                                          new Text(
                                            snapshot.data["employeenumber"],
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Text(
                                            snapshot.data["name"],
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          )
                                        ]);
                                      })),
                            ]),
                      ),
                    ),
                    Positioned(
                      left: 8.0,
                      top: 30.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      right: 20.0,
                      top: 30.0,
                      child: InkWell(
                        onTap: () {
                          _deleteNote(context, widget.note);
                        },
                        child: widget.uid == widget.note.uid ? Icon(Icons.delete_forever, color: Colors.white) : null,
                      ),
                    ),
                    Positioned(
                      right: 80.0,
                      top: 30.0,
                      child: InkWell(
                        onTap: () {
                          _navigateToEditNote(context, widget.note);
                        },
                        child: widget.uid == widget.note.uid ? Icon(Icons.edit, color: Colors.white) : null,
                      ),
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Column(children: <Widget>[
                          Card(
                            child: Column(
                              children: <Widget>[
                                Divider(height: 5.0),
                                ListTile(
                                  title: Text(
                                    '${widget.note.jobdetails}',
                                    style: new TextStyle(
                                      fontSize: 18.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  leading: const Icon(Icons.linear_scale),
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
                                    '${widget.note.jobremarks}',
                                    style: new TextStyle(
                                      fontSize: 18.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  leading: const Icon(Icons.link),
                                ),
                              ],
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _navigateToEditNote(BuildContext context, Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateDefect(note)),
    );
  }

  void _deleteNote(BuildContext context, Note note) async {
    db.deleteNote(note.id).then((notes) {
      Navigator.pop(context);
    });
  }
}
