import 'package:flutter/material.dart';
import 'package:powerlog/ui/detail.dart';
import 'package:powerlog/ui/home.dart';
import 'package:powerlog/model/emp.dart';
import 'dart:async';
//import 'package:people/peoples.dart';
// if we use package to import and it will give error

class Employeeworld extends StatefulWidget {
  @override
  _Employeeworldstate createState() => new _Employeeworldstate();
}

//Calls its callback once per animation frame.
//To create an AnimationController in a class that uses this mixin,
// pass vsync: this to the animation controller constructor whenever you create a new animation controller.
class _Employeeworldstate extends State<Employeeworld>
    with TickerProviderStateMixin {
  Map<int, AnimationController> controllerMaps = new Map();
  Map<int, CurvedAnimation> animationMaps = new Map();

  @override
  void initState() {
    employees.forEach((Employees employee) {
      AnimationController _animationController = AnimationController(
          duration: Duration(milliseconds: 200), vsync: this);
      CurvedAnimation _animation = new CurvedAnimation(
          parent: _animationController, curve: Curves.easeIn);
      controllerMaps[employee.id] = _animationController;
      _animationController.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          detailHero(employee);
        }
      });
      animationMaps[employee.id] = _animation;
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
              Employees employee = employees[index];
              AnimationController _controller = controllerMaps[employee.id];
              CurvedAnimation _animation = animationMaps[employee.id];
              return Homeani(
                employee: employee,
                isHeader: false,
                animation: _animation,
                onAction: () {
                  _controller.forward();
                },
              );
            },
            itemCount: employees.length,
          )),
    );
  }

  void detailHero(Employees employee) {
    AnimationController _controller = controllerMaps[employee.id];
    CurvedAnimation _curvedAnimation = animationMaps[employee.id];
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return Detail(
                    employee: employee,
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
