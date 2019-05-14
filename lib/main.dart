import 'package:flutter/material.dart';
import 'package:powerlog/ui/login.dart';
import 'package:powerlog/ui/show_entries.dart';
import 'package:powerlog/ui/splase_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'CNI LOGBOOK APP',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: SplaseScr()
    );}
}
