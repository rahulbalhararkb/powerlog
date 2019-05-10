import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:powerlog/model/emp.dart';
import 'home.dart';

class Detail extends StatefulWidget {
  final Employees employee;
  final VoidCallback onAction;
  final CurvedAnimation animation;

  Detail({this.employee, this.onAction, this.animation});
  @override
  _DetailOfPeople createState() => new _DetailOfPeople();
}

class _DetailOfPeople extends State<Detail> {
  bool _visible = false;

  @override
  void initState() {
    if (widget.employee.isDark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    Future.delayed(Duration(milliseconds: 250)).then((v) {
      setState(() {
        _visible = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Employees people = widget.employee;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Homeani(
                isHeader: true,
                employee: people,
                animation: widget.animation,
                onAction: widget.onAction,
              ),
              new Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          "Employee Number",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: people.color, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15.0),
                        child: Text(people.empid),
                      ),
                      Divider(
                        height: 10.0,
                        indent: 35.0,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text("Work Area",
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.body2),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 14.0, right: 14.0, bottom: 14.0),
                        child: Text(people.workarea),
                      ),
                      Divider(
                        height: 10.0,
                        indent: 35.0,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text("Email Id",
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.body2),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 14.0, right: 14.0, bottom: 14.0),
                        child: Text(people.emailid),
                      ),
                     SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new AnimatedPositioned(
            top: _visible ? 35.0 : 0.0,
            left: 10.0,
            height: 60.0,
            width: 50.0,
            duration: Duration(milliseconds: 150),
            curve: Curves.bounceInOut,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
              opacity: _visible ? 1.0 : 0.0,
              child: IconButton(
                icon: Icon(Icons.clear),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _visible = false;
                  });
                  //widget.onAction != null ? widget.onAction() : null;
                  widget.onAction();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
