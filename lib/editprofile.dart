import 'package:flutter/material.dart';

import 'find_quiz.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

enum ConfirmAction { CANCEL, Okay }

class _EditProfileState extends State<EditProfile> {
  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          backgroundColor: Color.fromRGBO(26, 37, 63, 1),
          title: Text(
            'QUIZZES-FUN',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to update your profile?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text(
                'Yes & Submit.',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Navigator.pushNamed(context, '/homestudent');
              },
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
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
                                color: Colors.black,
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Full Name",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.deepOrange[200],
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.deepOrange[200],
                                    ),
                                    hintText: "Age",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Class/Course Name",
                                    prefixIcon: Icon(
                                      Icons.unarchive,
                                      color: Colors.deepOrange[200],
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "School/College/University",
                                    prefixIcon: Icon(
                                      Icons.school,
                                      color: Colors.deepOrange[200],
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                              ),
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 50,
                              offset: Offset(0, 10))
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue,
                      ),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        onPressed: () async {
                          _asyncConfirmDialog(context);
                        },
                        padding: EdgeInsets.all(12),
                        color: Colors.deepOrange[200],
                        splashColor: Color.fromRGBO(40, 20, 40, 10),
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }

  void showDefaultSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "You have succesfully edit your profile.",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(26, 37, 63, 1),
    ));
  }
}
