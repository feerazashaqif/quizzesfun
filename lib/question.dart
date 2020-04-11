import 'package:flutter/material.dart';
import 'package:quizzesfun/scan.dart';
import 'package:quizzesfun/fill_question.dart';

class QuestionStartPage extends StatefulWidget {
  @override
  _QuestionStartPageState createState() => _QuestionStartPageState();
}

class _QuestionStartPageState extends State<QuestionStartPage> {
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
                              color: Color.fromRGBO(26, 37, 100, 0.7),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              Spacer(),    
                              Spacer(),    
                                  Text("SEJARAH 101",style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic ),),
                                  Text("by Rogayah Ahmad",style: TextStyle(color: Colors.white, fontSize: 20),),
                                  Spacer(),
                                  Text("10 QUESTIONS ",style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.w600),),
                            
                            Spacer(),
                          Container(
                            width: 200,
                            height: 50,
                            child:   RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return new QuestionFillPage();
                              }));
                            },
                            padding: EdgeInsets.all(10),
                            color: Colors.deepOrange[200],
                            splashColor: Color.fromRGBO(40, 20, 40, 10),
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
                                                   ]
                                ))
                                )
                                )
              ])
        ]));
  }
}
