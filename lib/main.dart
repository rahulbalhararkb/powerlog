import 'package:flutter/material.dart';
import 'package:powerlog/ui/new_feature.dart';
import 'package:powerlog/ui/show_entries.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CNI LOGBOOK APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplaseScr());
  }
}

class SplaseScr extends StatefulWidget {
  @override
  _SplaseScrState createState() => _SplaseScrState();
}

class _SplaseScrState extends State<SplaseScr> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: new MyHomePage(title: 'CNI LOGBOOK APP'),
          title: new Text(
            'Welcome to CNI LOGBOOK APP',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          image: new Image.asset('assets/Sps.gif'),
          backgroundColor: Colors.white,
          loadingText: Text('App By RAHUL BALHARA'),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: () => print("Power App"),
          loaderColor: Colors.blueAccent),
    );
  }
}

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
