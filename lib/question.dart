import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzesfun/scan.dart';
import 'package:quizzesfun/fill_question.dart';

class QuestionStartPage extends StatefulWidget {
  final id;
  final email;
  QuestionStartPage(this.id, this.email);
  @override
  _QuestionStartPageState createState() => _QuestionStartPageState();
}

class _QuestionStartPageState extends State<QuestionStartPage> {
  String title, name;
  int totalq;

  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(Duration(milliseconds: 0));
    final map = await Firestore.instance
        .collection('Quizzes')
        .document(widget.id.toString())
        .get();
    print(map.data);

    setState(() {
      title = map.data['title'];
      name = map.data['name'];
      totalq = map.data['total question'];
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
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SingleChildScrollView(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(26, 37, 100, 0.7),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Spacer(),
                                      Spacer(),
                                      Text(
                                        title ?? "Loading...",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "by ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            name ?? "Loading...",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            totalq.toString() ?? "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            " Questions ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 200,
                                        height: 50,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return new QuestionFillPage(
                                                  widget.id.toString(),
                                                  widget.email.toString(),
                                                  1,
                                                  0);
                                            }));
                                          },
                                          padding: EdgeInsets.all(10),
                                          color: Colors.deepOrange[200],
                                          splashColor:
                                              Color.fromRGBO(40, 20, 40, 10),
                                          child: Center(
                                            child: Text(
                                              "Start quiz",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Spacer(),
                                    ]))),
                      ],
                    ))
              ])
        ]));
  }
}
