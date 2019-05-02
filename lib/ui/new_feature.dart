import 'package:flutter/material.dart';

class NewFeature extends StatelessWidget {
  NewFeature({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: new Text(title)),
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
                        color: Colors.black87,
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
