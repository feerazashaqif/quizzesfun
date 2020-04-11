import 'package:flutter/material.dart';
import 'package:quizzesfun/sign_up.dart';
import 'package:quizzesfun/main.dart';

class FindquizPage extends StatefulWidget {
  @override
  _FindquizPageState createState() => _FindquizPageState();
}

class _FindquizPageState extends State<FindquizPage> {
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
          SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.deepOrange[200],
                    ),
                    child: Text(
                      "Enter Quiz ID or Scan Quiz \nQR Code To Join Quiz",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 50,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Quiz ID",
                                        prefixIcon: Icon(
                                          Icons.code,
                                          color: Colors.deepOrange,
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
                          height: 70,
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
                                Navigator.pushNamed(context, '/question');
                              },
                              padding: EdgeInsets.all(12),
                              color: Colors.deepOrange[200],
                              splashColor: Color.fromRGBO(40, 20, 40, 10),
                              child: Center(
                                child: Text(
                                  "Enter Quiz",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Text("or",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 50,
                                    offset: Offset(0, 10))
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepOrange[200],
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    alignment: Alignment.topCenter,
                                    icon: Image.asset(
                                      "assets/qr.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                    onPressed: () async {
                                      Navigator.pushNamed(context, '/scanqr');
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Scan Now",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),)
                                ]))
                      ]))
                ]),
          )
        ]));
  }
}
