import 'package:flutter/material.dart';
import 'package:powerlog/detail.dart';
import 'package:powerlog/home.dart';
import 'package:powerlog/peoples.dart';
import 'dart:async';
//import 'package:people/peoples.dart';
// if we use package to import and it will give error

class Peopleworld extends StatefulWidget {
  @override
  _Peopleworldstate createState() => new _Peopleworldstate();
}

//Calls its callback once per animation frame.
//To create an AnimationController in a class that uses this mixin,
// pass vsync: this to the animation controller constructor whenever you create a new animation controller.
class _Peopleworldstate extends State<Peopleworld>
    with TickerProviderStateMixin {
  Map<int, AnimationController> controllerMaps = new Map();
  Map<int, CurvedAnimation> animationMaps = new Map();

  @override
  void initState() {
    peoples.forEach((Peoples people) {
      AnimationController _animationController = AnimationController(
          duration: Duration(milliseconds: 200), vsync: this);
      CurvedAnimation _animation = new CurvedAnimation(
          parent: _animationController, curve: Curves.easeIn);
      controllerMaps[people.id] = _animationController;
      _animationController.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          detailHero(people);
        }
      });
      animationMaps[people.id] = _animation;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey.shade300,
      ),
      child: Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Employees',
              //    style: TextStyle(fontSize: 16.0, color: Colors.grey.shade500),
            ),
            elevation: 0.0,
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              Peoples people = peoples[index];
              AnimationController _controller = controllerMaps[people.id];
              CurvedAnimation _animation = animationMaps[people.id];
              return Homeani(
                people: people,
                isHeader: false,
                animation: _animation,
                onAction: () {
                  _controller.forward();
                },
              );
            },
            itemCount: peoples.length,
          )),
    );
  }

  void detailHero(Peoples people) {
    AnimationController _controller = controllerMaps[people.id];
    CurvedAnimation _curvedAnimation = animationMaps[people.id];
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return Detail(
                    people: people,
                    animation: _curvedAnimation,
                    onAction: () {
                      Navigator.pop(context);
                    },
                  );
                },
                fullscreenDialog: true))
        .then((value) {
      Future.delayed(Duration(milliseconds: 500)).then((v) {
        _controller.reverse();
      });
    });
  }
}
