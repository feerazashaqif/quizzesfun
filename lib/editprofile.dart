import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'find_quiz.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

enum ConfirmAction { CANCEL, Okay }

class _EditProfileState extends State<EditProfile> {
  dynamic namet;
  dynamic emailt;
  dynamic aget;
  dynamic clasnt;
  dynamic schoolt;

  String name, email, age, clasn, school;

  static String profilepic;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  static FirebaseUser _loggedInUser;
  static String docID = _loggedInUser.uid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  void initState() {
    super.initState();
    loadData();
    getCurrentUser(_loggedInUser);
  }

  Future<void> loadData() async {
    await Future.delayed(Duration(milliseconds: 0));
    final uid = await getCurrentUID();
    final map =
        await Firestore.instance.collection('Users').document(uid).get();
    print(map.data);

    setState(() {
      name = map.data['name'];
      email = map.data['email'];
      age = map.data['age'];
      clasn = map.data['class'];
      school = map.data['school'];
    });
    return uid;
  }

  getCurrentUser(FirebaseUser loggedInUser) async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _loggedInUser = user;

        Firestore.instance.settings(
          persistenceEnabled: true,
        );

        final QuerySnapshot result =
            await _firestore.collection('Users').getDocuments();
        final List<DocumentSnapshot> documentsnapshot = result.documents;
        final List<Map<String, dynamic>> _otheruserinfo =
            new List<Map<String, dynamic>>();
        documentsnapshot.forEach((data) {
          if (data.documentID != docID) {
            _firestore
                .collection('Users')
                .document(data.documentID)
                .get()
                .then((DocumentSnapshot snap) {
              _otheruserinfo.add(snap.data);
            });
          }
        });

        _firestore
            .collection('Users')
            .document(docID)
            .get()
            .then((DocumentSnapshot ds) {
          namet = ds.data['name'];
          emailt = ds.data['email'];
          aget = ds.data['age'];
          schoolt = ds.data['school'];
          clasnt = ds.data['class'];
          setState(() {});
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                _firestore
                    .collection('Users')
                    .document(_loggedInUser.uid)
                    .updateData({
                  'name': namet,
                  'age': aget,
                  'class': clasnt,
                  'school': schoolt,
                });
                Navigator.pushNamed(context, '/homestudent');
                showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                        title: "Success",
                        description:
                            "You have successfully Update your profile !"));
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
                                    hintText: "$name",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.deepOrange[200],
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                                onChanged: (text) => {namet = text},
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
                                    hintText: "$age",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                                onChanged: (text) => {aget = text},
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
                                    hintText: "$clasn",
                                    prefixIcon: Icon(
                                      Icons.unarchive,
                                      color: Colors.deepOrange[200],
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                                onChanged: (text) => {clasnt = text},
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "$school",
                                    prefixIcon: Icon(
                                      Icons.school,
                                      color: Colors.deepOrange[200],
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                                onChanged: (text) => {schoolt = text},
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

class CustomDialog extends StatelessWidget {
  final title, description, buttonText, images;
  CustomDialog({this.title, this.description, this.buttonText, this.images});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: Color.fromRGBO(26, 37, 63, 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              )
            ]),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ]),
      ),
      Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/success.gif')))),
          ))
    ]);
  }
}
