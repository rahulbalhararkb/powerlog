import 'package:flutter/material.dart';
import 'package:powerlog/auth/auth.dart';
import 'package:powerlog/ui/employee.dart';
import 'package:powerlog/ui/filter_list.dart';
import 'package:powerlog/ui/note_list.dart';
import 'package:powerlog/ui/new_feature.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final String userId;
  final VoidCallback onSignedOut;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Center(
              child: new Text(
            "C&I LOGBOOK APP",
            style: TextStyle(color: Colors.white),
          )),
          actions: <Widget>[
            IconButton(
                icon: new Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 35.0,
                ),
                onPressed: () {
                  _signOut();
                }),
          ],
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
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowFilterEntries(
                                  uid: widget.userId,
                                )));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.library_books,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'LOGBOOK',
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
              height: 100.0,
              width: 100.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NoteList()));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.note_add,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'NOTEBOOK',
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
              height: 100.0,
              width: 100.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Employeeworld()));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.contact_phone,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'EMPLOYEES',
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
              height: 100.0,
              width: 100.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Color.fromRGBO(64, 75, 96, .9),
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewFeature()));
                  },
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'NEW FEATURE',
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
