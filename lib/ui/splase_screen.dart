import 'package:flutter/material.dart';
import 'package:powerlog/ui/home_page.dart';
import 'package:splashscreen/splashscreen.dart';




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

