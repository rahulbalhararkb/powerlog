import 'package:flutter/material.dart';
import 'package:powerlog/ui/new_feature.dart';
import 'package:powerlog/ui/show_entries.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: new Text(widget.title)),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              height: 100.0,
              width: 100.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Colors.blue,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowEntries(title: widget.title)));
                  },
                  child: Center(
                    child: Text(
                      'LOGBOOK',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              height: 100.0,
              width: 100.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Colors.blue,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewFeature(title: widget.title)));
                  },
                  child: Center(
                    child: Text(
                      'NEW FEATURE',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
