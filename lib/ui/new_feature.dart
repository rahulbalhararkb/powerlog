import 'package:flutter/material.dart';

class NewFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Padding(
            padding: const EdgeInsets.only(left: 70.0),
            child: new Text(
              "New Feature",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
                height: 100.0,
                width: 100.0,
                child: Center(
                  child: Text(
                    'Comming Soon...',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
