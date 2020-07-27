import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizzesfun/createquiz1.dart';
import 'package:quizzesfun/createquiz2.dart';
import 'package:quizzesfun/scan.dart';
import 'package:quizzesfun/splashscreen.dart';
import 'package:quizzesfun/getqr.dart';
import 'package:quizzesfun/homestudent.dart';
import 'package:quizzesfun/question.dart';
import 'package:quizzesfun/score.dart';
import 'package:quizzesfun/sign_up.dart';
import 'package:quizzesfun/table.dart';
import 'package:quizzesfun/user_profile.dart';
import 'package:quizzesfun/editprofile.dart';
import 'package:quizzesfun/find_quiz.dart';
import 'package:quizzesfun/drawer_summary.dart';
import 'package:quizzesfun/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;

class MyInfo {
  static String email = '';
  static String usertype = '';
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/',
      routes: {
        //'/': (context) => MyHomePage(),
        '/createquiz1': (context) => CreateQuiz1(),
        // '/createquiz2': (context) => CreateQuiz2(),
        '/signup': (context) => SignupPage(),
        '/homestudent': (context) => HomeStudent(),
        '/scanqr': (context) => ScanPage(),
        // '/question': (context) => QuestionStartPage(),
        '/drawer': (context) => ProfilePage(),
        '/getqr': (context) => GetQR(),
        '/profile': (context) => UserProfile(),
        '/editprofile': (context) => EditProfile(),
        '/setting': (context) => SettingPage(),
      },
      title: 'Quizzes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

enum ConfirmAction { CANCEL, OKAY }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: true, // user must tap button for close dialog!
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
            'Enter chunli@gmail.com for student login or rogayah@gmail.com for teacher login',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String email = '';
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _firestore = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  bool _success;
  String _userEmail;

  Widget buildFrontpage() {
    return Form(
      key: _formKey,
      child: Center(
        child: Stack(children: <Widget>[
          Positioned.fill(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/background.jpg',
                color: Color.fromRGBO(255, 255, 255, 1),
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
// logotext
              Container(
                  margin: EdgeInsetsDirectional.only(top: 100),
                  child: Image.asset('assets/frontlogo.png'),
                  width: 255,
                  height: 255),
// inputemail

              Column(
                children: [
                  Container(
                    width: 310,
                    alignment: Alignment.center,
                    height: 53.0,
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Colors.black54, width: 2.0),
                      borderRadius: new BorderRadius.circular(40),
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0.0, 10, 0),
                        child: new TextFormField(
                          controller: _emailController,
                          strutStyle: StrutStyle(
                            fontSize: 17,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration.collapsed(
                              hintText: "E-mail Address"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // inputpassword
              Column(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 10),
                    width: 310,
                    alignment: Alignment.center,
                    height: 53.0,
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Colors.black54, width: 2.0),
                      borderRadius: new BorderRadius.circular(40),
                    ),
                    child: new TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      strutStyle: StrutStyle(
                        fontSize: 17,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromRGBO(0, 0, 0, 0))),
                        hintText: 'Password',
                        labelStyle: new TextStyle(
                          decorationColor: Colors.black,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 17,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: MaterialButton(
                    onPressed: () async {
                      email = _emailController.value.text;
                      if (_formKey.currentState.validate()) {
                        _signin();
                      }
                      print('Sign In');
                    },
                    color: Color.fromRGBO(242, 182, 174, 1),
                    splashColor: Colors.purple,
                    child: Text('Log In'),
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: FlatButton(
                    onPressed: () async {
                      print('Sign Up');
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text("Don't have any account? Sign up here"),
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          backgroundColor: Color.fromRGBO(26, 37, 63, 1),
          body: buildFrontpage()),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signin() async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ));
    if (user != null) {
      setState(() async {
        _success = true;
        _userEmail = user.email;
        final currentuid = await getCurrentUID();
        final QuerySnapshot result =
            await _firestore.collection('Users').getDocuments();
        MyInfo.email = _emailController.text;

        _firestore
            .collection('Users')
            .document(currentuid)
            .get()
            .then((DocumentSnapshot ds) {
          //print(ds.data);
          MyInfo.email = ds.data['email'];
          MyInfo.usertype = ds.data['usertype'];
          print('${MyInfo.email}');
          print('${MyInfo.usertype}');
        });
        Timer(Duration(seconds: 3), () {
          if (MyInfo.usertype == 'Student') {
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new HomeStudent(email: _emailController.text),
                ));
          }
          if (MyInfo.usertype == 'Teacher') {
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new ProfilePage(email: _emailController.text),
                ));
          }
        });
      });
    } else {
      _success = false;
    }
  }
}
