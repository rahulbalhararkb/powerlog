import 'package:flutter/material.dart';
import 'package:powerlog/ui/login.dart';
import 'package:powerlog/ui/show_entries.dart';
import 'package:powerlog/ui/splase_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   /* routes: <String, WidgetBuilder>{
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/first': (BuildContext context) => LoginPage(),
      // When we navigate to the "/second" route, build the SecondScreen Widget
      '/second': (BuildContext context) => ShowEntries(),
    },*/
        debugShowCheckedModeBanner: false,
        title: 'CNI LOGBOOK APP',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: SplaseScr()
    );}
}
