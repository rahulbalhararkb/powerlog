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
    final topContentText =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
      SizedBox(height: 10.0),
      Text(
        '${widget.note.stage}/${widget.note.unit}/${widget.note.area}',
        style: TextStyle(color: Colors.white, fontSize: 25.0),
      ),
      SizedBox(height: 10.0),
      Text('${widget.note.jobtype}/${widget.note.jobstatus}',
          style: new TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              color: Colors.white)),
      SizedBox(height: 25.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Text(
                '${widget.note.jobtimeday}-${widget.note.jobtimemonth}-${widget.note.jobtimeyear}/${widget.note.jobtimehr}:${widget.note.jobtimemin}:${widget.note.jobtimesec}',
                style: TextStyle(color: Colors.white),
              )),
        ],
      )
    ]);

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/PowerAppIcon.png"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
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
        )
      ],
    );

    final bottomContentText = Column(children: <Widget>[
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
    ]);

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );

    return Scaffold(
      body: Container(
        child: ListView(shrinkWrap: true, children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[topContent, bottomContent],
            ),
          ),
        ]),
      ),
    );
  }
}
