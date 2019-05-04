import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerlog/auth/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _repassword;
  String _name;
  String _mobile;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print('Register user: $userId');

          Firestore.instance.collection("userdata").document(userId).setData({
            'userid': userId,
            'email': _email,
            'name': _name,
            'mobilenumber': _mobile,
            'password': _password,
            'repassword': _repassword
          });
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Container(
                      child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new Form(
                      key: formKey,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: displayText() +
                            buildInputs() +
                            buildSubmitButtons(),
                      ),
                    ),
                  )),
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> displayText() {
    if (_formType == FormType.login) {
      return [
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                child: Text('Hello',
                    style: TextStyle(
                        fontSize: 80.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 80.0, 0.0, 0.0),
                child: Text('There',
                    style: TextStyle(
                        fontSize: 80.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(220.0, 80.0, 0.0, 0.0),
                child: Text('.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent)),
              )
            ],
          ),
        ),
      ];
    } else {
      return [
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Signup',
                  style: TextStyle(
                      fontSize: 80.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(260.0, 15.0, 0.0, 0.0),
                child: Text(
                  '.',
                  style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent),
                ),
              )
            ],
          ),
        ),
      ];
    }
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (value) =>
                            value.isEmpty ? 'Email can\'t be empty' : null,
                        onSaved: (value) => _email = value,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        validator: (value) =>
                            value.isEmpty ? 'Password can\'t be empty' : null,
                        onSaved: (value) => _password = value,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ])
      ];
    } else {
      return [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (value) =>
                            value.isEmpty ? 'Email can\'t be empty' : null,
                        onSaved: (value) => _email = value,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Name ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (value) =>
                            value.isEmpty ? 'Name can\'t be empty' : null,
                        onSaved: (value) => _name = value,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Mobile Number ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (value) => value.isEmpty
                            ? 'Mobile Number can\'t be empty'
                            : null,
                        onSaved: (value) => _mobile = value,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        validator: (value) =>
                            value.isEmpty ? 'Password can\'t be empty' : null,
                        onSaved: (value) => _password = value,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Retype Password ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        validator: (value) => value.isEmpty
                            ? 'Retype Password can\'t be empty'
                            : null,
                        onSaved: (value) => _repassword = value,
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        Container(
            padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 5.0),
                /* Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),*/
                SizedBox(height: 20.0),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        validateAndSubmit();
                      },
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                /* Container(
                  height: 40.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: ImageIcon(AssetImage('assets/facebook.png')),
                        ),
                        SizedBox(width: 10.0),
                        Center(
                          child: Text('Log in with facebook',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        )
                      ],
                    ),
                  ),
               )*/
              ],
            )),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New to POWERLOG ?',
              style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
            ),
            SizedBox(width: 5.0),
            InkWell(
              onTap: () {
                moveToRegister();
              },
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        )
      ];
    } else {
      return [
        Container(
            padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        validateAndSubmit();
                      },
                      child: Center(
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already POWERLOG Member ?',
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.white),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        moveToLogin();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            )),
      ];
    }
  }
}
