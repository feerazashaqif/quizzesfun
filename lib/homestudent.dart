import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizzesfun/find_quiz.dart';
import 'package:quizzesfun/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class HomeStudent extends StatefulWidget {
  final String email;

  HomeStudent({Key key, this.email}) : super(key: key);
  @override
  HomeStudentState createState() => HomeStudentState();
}

class HomeStudentState extends State<HomeStudent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data;
  String name, email, age, clasn, school;
  static String profilepic;
  int total;

  // static String profilepic;
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
          setState(() {});
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(26, 37, 63, 1)),
              accountName: Text(
                name ?? 'Loading...',
              ),
              accountEmail: Text(
                email ?? 'Loading...',
              ),
              currentAccountPicture: ClipOval(
                  child: (profilepic != null)
                      ? CircleAvatar(
                          radius: 40,
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Image.network(
                              profilepic.toString(),
                              fit: BoxFit.cover,
                            ),
                          ))
                      : CircleAvatar(
                          backgroundColor:
                              (Theme.of(context).platform == TargetPlatform.iOS)
                                  ? Color.fromRGBO(26, 37, 63, 1)
                                  : Colors.white,
                          child: Text(
                            name.toString().substring(0, 1) ?? 'Loading...',
                            style: TextStyle(fontSize: 40.0),
                          ),
                        )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: ListTile(
                title: Text("My Profile"),
                trailing: Icon(Icons.person),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/setting');
              },
              child: ListTile(
                title: Text("Settings"),
                trailing: Icon(Icons.settings),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new MyHomePage();
                }));
                showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                        title: "Success",
                        description:
                            "You have successfully Logout !"));
              },
              child: ListTile(
                title: Text("Log out"),
                trailing: Icon(Icons.keyboard_return),
              ),
            ),
          ]),
        ),
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.more_horiz),
            onTap: () {
              print("on tap");
              // _scaffoldKey.currentState.openDrawer();
              // Scaffold.of(context).openDrawer();
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
              } else {
                _scaffoldKey.currentState.openDrawer();
              }
            },
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
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Join Quiz'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new FindquizPage(widget.email.toString());
            }));
          },
          backgroundColor: Color.fromRGBO(26, 37, 63, 1),
          icon: Icon(Icons.play_arrow),
        ),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ))),
          ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.white,
                height: 450.0,
                width: 400.0,
                padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'User profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: CircleAvatar(
                        radius: 70.0,
                        child: ClipOval(
                            child:
                                // new SizedBox(
                                //   width: 180.0,
                                //   height: 180.0,
                                //   child: (profilePic1 == null && profilepic != null)
                                //           ?
                                Container(
                          width: 140,
                          height: 140,
                          child: Image.network(
                            profilepic.toString(),
                            fit: BoxFit.cover,
                          ),
                        )
                            //           : Icon(
                            //               Icons.image,
                            //               size: 40,
                            //             ),
                            // ),
                            ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 40.0,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      name ?? 'Loading...',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Age',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      age ?? 'Loading...',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 18.0),
                    Text(
                      'Class/Course',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      clasn ?? 'Loading...',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.grey[800],
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          email ?? 'Loading...',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  height: 200.0,
                  width: 400.0,
                  padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Account Summary',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Total Quiz Attempted',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              total.toString() ?? "0",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        )
                      ]))
            ],
          ),
        ]));
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
      profilepic = map.data['profilepic1'];
      total = map.data['total'];
    });
    return uid;
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
