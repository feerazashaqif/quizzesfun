import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzesfun/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _usertypeController = TextEditingController();
  final _firestore = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  int total = 0;

  bool _success;
  String _userEmail;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Student',
        Icon(
          Icons.people,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Teacher',
        Icon(
          Icons.person,
          color: const Color(0xFF167F67),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.deepOrange[200],
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text("uizzes-Fun"),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Color.fromRGBO(26, 37, 63, 1),
        ),
        body: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ))),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                        hintText: "Full Name",
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.deepOrange[200],
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    controller: _ageController,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.sentiment_very_satisfied,
                                          color: Colors.deepOrange[200],
                                        ),
                                        hintText: "Age",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    controller: _classController,
                                    decoration: InputDecoration(
                                        hintText: "Class/Course Name",
                                        prefixIcon: Icon(
                                          Icons.unarchive,
                                          color: Colors.deepOrange[200],
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    controller: _schoolController,
                                    decoration: InputDecoration(
                                        hintText: "School/College/University",
                                        prefixIcon: Icon(
                                          Icons.school,
                                          color: Colors.deepOrange[200],
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        hintText: "Email",
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Colors.deepOrange[200],
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.deepOrange[200],
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.verified_user,
                                          color: Colors.deepOrange[200]),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      DropdownButton<Item>(
                                        hint: Text("User Type"),
                                        value: selectedUser,
                                        onChanged: (Item value) {
                                          setState(() {
                                            selectedUser = value;
                                            print(selectedUser.name);
                                          });
                                        },
                                        items: users.map((Item user) {
                                          return DropdownMenuItem<Item>(
                                            value: user,
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  user.name,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  // TextFormField(
                                  //   controller: _usertypeController,
                                  //   decoration: InputDecoration(
                                  //       hintText: "User Type",
                                  //       prefixIcon: Icon(
                                  //         Icons.verified_user,
                                  //         color: Colors.deepOrange[200],
                                  //       ),
                                  //       hintStyle:
                                  //           TextStyle(color: Colors.grey),
                                  //       border: InputBorder.none),
                                  //   style: TextStyle(color: Colors.black),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue,
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            onPressed: () async {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  Timer(Duration(seconds: 5), () {
                                    setState(() {
                                      _register();
                                      showSnackBar();
                                    });
                                  });
                                }
                                print('Sign up success');
                                //showDefaultSnackbar(context);
                              });
                            },
                            padding: EdgeInsets.all(12),
                            color: Colors.deepOrange[200],
                            splashColor: Color.fromRGBO(40, 20, 40, 10),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )))
          ],
        ));
  }

  void showSnackBar() {
    final snackBarContent = SnackBar(
      duration: const Duration(seconds: 15),
      content: Text("You have succesfully signed up!"),
      backgroundColor: Color.fromRGBO(26, 37, 63, 1),
      action: SnackBarAction(
          textColor: Colors.deepOrange[200],
          label: 'Go to login',
          onPressed: () {
            _scaffoldkey.currentState.hideCurrentSnackBar();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new MyHomePage();
            }));
          }),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ));
    if (user != null) {
      setState(() async {
        _success = true;
        _userEmail = user.email;
        final currentuid = await getCurrentUID();
        _firestore.collection('Users').document(currentuid).setData({
          'name': _nameController.text.toString(),
          'age': _ageController.text.toString(),
          'class': _classController.text.toString(),
          'school': _schoolController.text.toString(),
          'email': _emailController.text.toString(),
          'usertype': selectedUser.name,
          'total': total
        });
        Timer(Duration(seconds: 3), () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new MyHomePage()));
        });
      });
    } else {
      _success = false;
    }
  }
}
