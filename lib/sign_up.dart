import 'package:flutter/material.dart';
import 'package:quizzesfun/main.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
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
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
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
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "User Type",
                                        prefixIcon: Icon(
                                          Icons.verified_user,
                                          color: Colors.deepOrange[200],
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue,
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            onPressed: () async {
                              setState(() {
                                showSnackBar();
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
      duration: const Duration(seconds:15),
      content: Text("You have succesfully signed up!"),
      backgroundColor: Color.fromRGBO(26, 37, 63, 1),
      action: SnackBarAction(
        textColor: Colors.deepOrange[200],
          label: 'Go to login', onPressed:(){ _scaffoldkey.currentState.hideCurrentSnackBar();
          Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return new MyHomePage();
                              }));
          }),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

 
}


