import 'dart:ui';

import 'package:meta/meta.dart';

class Employees {
  final int id;
  final String name;
  final String empid;
  final String emailid;
  final String lvl;
  final String desig;
  final String image;
  final Color color;
  final String workarea;

  const Employees({
    @required this.color,
    @required this.name,
    @required this.image,
    @required this.id,
    @required this.lvl,
    @required this.empid,
    @required this.desig,
    @required this.workarea,
    @required this.emailid,
  })  : assert(color != null),
        assert(image != null),
        assert(name != null),
        assert(id != null),
        assert(lvl != null),
        assert(empid != null),
        assert(desig != null),
        assert(workarea != null),
        assert(emailid != null); 
  String get asset => "assets/images/$image";
  bool get isDark => color.computeLuminance() < 0.6;
}

final List<Employees> employees = [
  Employees(
      id: 1,
      name: 'Harjeet Singh',
      empid: '003319',
      lvl: 'E8',
      desig: 'GM',
      workarea: "C&I VSTPS",
      emailid: "harjeetsingh@ntpc.co.in",
      image: "hs.png",
      color: Color.fromRGBO(234, 188, 48, 1.0)),
  Employees(
      id: 2,
      name: 'Manish Khetrapal',
      empid: '006583',
      lvl: 'E8',
      desig: 'AGM',
      workarea: "C&I Stage 3 and stage 5",
      emailid: "manishkhetrapal@ntpc.co.in",
      image: "mk.png",
      color: Color.fromRGBO(167, 163, 156, 1.0)),
  Employees(
      id: 3,
      name: 'Neeraj Agarwal',
      empid: '006465',
      lvl: 'E8',
      desig: 'AGM',
      workarea: "C&I Stage 2",
      emailid: "neerajagrawal@ntpc.co.in",
      image: "na.png",
      color: Color.fromRGBO(200, 76, 42, 1.0)),
  Employees(
      id: 4,
      name: 'Ashish Agrawal',
      empid: '007157',
      lvl: 'E8',
      desig: 'AGM',
      workarea: "C&I Stage 4",
      emailid: "ashishagrawal@ntpc.co.in",
      image: "aa.png",
      color: Color.fromRGBO(237, 142, 47, 1.0)),
  Employees(
      id: 5,
      name: 'Rituraja Singh Rajput',
      empid: '007345',
      lvl: 'E7',
      desig: 'DGM',
      workarea: "C&I Stage 3 and Stage 5",
      emailid: "rsrajput@ntpc.co.in",
      image: "rs.png",
      color: Color.fromRGBO(88, 90, 59, 1.0)),
  Employees(
      id: 6,
      name: 'Rahul Balhara',
      empid: '103723',
      lvl: 'E5',
      desig: 'MGR',
      workarea: "C&I Stage 3 and Stage 5",
      emailid: "rahul01@ntpc.co.in",
      image: "rb.jpg",
      color: Color.fromRGBO(121, 118, 114, 1.0)),
];
