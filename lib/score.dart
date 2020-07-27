import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzesfun/homestudent.dart';
import 'package:quizzesfun/main.dart';
import 'package:quizzesfun/question.dart';

class ScorePage extends StatefulWidget {
  final score;
  dynamic id;
  final String email;
  ScorePage(this.email, this.id, this.score);

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int score;
  int total, userTotal;
  String name, studName, email;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int arr;
  final _firestore = Firestore.instance;
  static FirebaseUser _loggedInUser;
  static String docID = _loggedInUser.uid;
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  void initState() {
    super.initState();
    score = widget.score;
    email = widget.email;
    loadQuizData();
    loadUserData();
    print('Student name is $studName');
  }

  Future<void> loadQuizData() async {
    await Future.delayed(Duration(milliseconds: 0));
    final map = await Firestore.instance
        .collection('Quizzes')
        .document(widget.id.toString())
        .get();
    print(map.data);

    setState(() {
      total = map.data['total question'];
      name = map.data['title'];
      arr = map.data['scores'.length] + 1;
    });
  }

  Future<void> loadUserData() async {
    await Future.delayed(Duration(milliseconds: 0));
    final uid = await getCurrentUID();
    final map =
        await Firestore.instance.collection('Users').document(uid).get();
    print(map.data);

    setState(() {
      studName = map.data['name'];
      email = map.data['email'];
      userTotal = map.data['total'] + 1;
    });

    await _firestore
        .collection('Users')
        .document(uid)
        .updateData({'total': userTotal});
    return uid;
  }

  void updateScore() async {
    await _firestore
        .collection('Quizzes')
        .document(widget.id.toString())
        .updateData({
      'scores': FieldValue.arrayUnion([
        {'name': studName, 'score': score}
      ]),
      // [
      //   {'name': studName, 'score': score}
      // ],
      'merge': true
    });
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
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ))),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(50),
                    child: SingleChildScrollView(
                        child: Container(
                            height: 500,
                            width: 900,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(26, 37, 63, 0.7),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Spacer(),
                                  Text(
                                    "$name",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Text(
                                    "Your score is ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    "$score/$total" ?? "Calculating...",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      onPressed: () async {
                                        updateScore();
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return new HomeStudent(
                                            email: MyInfo.email,
                                          );
                                        }));
                                      },
                                      padding: EdgeInsets.all(10),
                                      color: Colors.deepOrange[200],
                                      splashColor:
                                          Color.fromRGBO(40, 20, 40, 10),
                                      child: Center(
                                        child: Text(
                                          "Go To Home",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                ]))))
              ])
        ]));
  }
}
