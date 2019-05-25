import 'package:flutter/material.dart';
import 'package:powerlog/ui/show_entries.dart';

class ShowFilterEntries extends StatefulWidget {
  ShowFilterEntries({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  State<StatefulWidget> createState() => _ShowFilterEntriesState();
}

class _ShowFilterEntriesState extends State<ShowFilterEntries> {
//Build our ShowFilterEntries widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Text(
              "LOGBOOK FILTER",
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
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListJob(widget.uid,'ALL')));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'ALL JOB',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListJob(widget.uid,'STAGE')));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'STAGE',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListJob(widget.uid,'UNIT')));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'UNIT',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListJob(widget.uid,'AREA')));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'AREA',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListJob(widget.uid,'JOBTYPE')));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'JOB TYPE',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListJob(widget.uid,'JOBSTATUS')));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'JOB STATUS',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ]),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
