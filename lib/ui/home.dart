import 'package:flutter/material.dart';
import 'package:powerlog/model/emp.dart';

class Homeani extends AnimatedWidget {
  final Employees employee;
  final VoidCallback onAction;
  final bool isHeader;
  final int delay;
  Homeani({
    Key key,
    Animation<double> animation,
    this.employee,
    this.delay: 200,
    this.isHeader: false,
    this.onAction,
  }) : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
  
    return Container(
      width: double.infinity,
      height: _height,
      child: Stack(
        children: <Widget>[
          _employeeinfo(context),
          _makeemployees(context),



        ],
      ),
    );
  }

  _makeemployees(BuildContext context) {
    final Animation<double> animation = listenable;
    final double _width = MediaQuery.of(context)
        .size
        .width; //to obtain the size of the current window, use MediaQuery.of(context).size.
    Tween<double> tween = Tween(
        begin: _width - 120,
        end:
            0.0); //help to move left stack in screen hint color ,name and image
//A linear interpolation between a beginning and ending value.
    //A widget that controls where a child of a Stack is positioned.
    return new Positioned(
      top: isHeader ? 0.0 : 10.0,//for image size according their informantion
      width: _width,
      bottom: 0.0,
      right: isHeader ? 0.0 : tween.evaluate(animation),//change  image in detail page
       child: Hero(
        tag: employee.image,
        child: new Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              if (!isHeader) {
               // onAction == null ? null : onAction();
               onAction();
              }
            },
            //This class is useful if you want to overlap several children in a simple way,
            // for example having some text and an image, overlaid with a gradient and a button attached to the bottom.
            child: Stack(
              children: <Widget>[
                new Positioned(
                  top: isHeader ? 0.0 : 10.0,
                  bottom: isHeader ? 0.0 : 10.0,
                  left: 0.0,
                  right: isHeader ? 0.0 : 1.0,
                  child: new Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: employee.color,
                    child: Text(
                      employee.name,
                      style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: "Times",
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(
                      bottom: 30.0,
                      left: 15.0,
                      right: 150.0,
                    ),
                  ),
                ),
               //for image in detail page and home page
                new Positioned(
                  top: isHeader ? 20.0 : 0.0,
                  bottom: isHeader ? -10.0 : 0.0,
                  left: isHeader ? _width - 142 : _width - 140,
                  width: 160.0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(employee.asset),
                        //fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _employeeinfo(BuildContext context) {
    return isHeader
        ? Container()
        : Positioned(
            top: 0.0,
            bottom: 0.0,
            left: 130.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    employee.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(color: employee.color),
                  ),
                ),
                Row(
                  children: <Widget>[
                    new Chip(
                      label: Text(employee.desig),
                      avatar: new CircleAvatar(
                        backgroundColor: Colors.grey.shade50,
                        child: new Text(employee.lvl),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: new Chip(
                        label: new Text(employee.empid),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: new OutlineButton.icon(
                      icon: const Icon(Icons.devices, size: 18.0),
                      label: const Text('Hit Me'),
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return new Container(
                                  child: new Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: new Text(
                                          'Welcome to C&I app',
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 24.0))));
                            });
                      }),
                )
              ],
            ),
          );
  }

  double get _height {
    if (isHeader) {
      return 275.0;
    } else {
      return 200.0;
    }
  }
}
