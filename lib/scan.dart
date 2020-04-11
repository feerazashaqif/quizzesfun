import 'package:flutter/material.dart';
import 'package:quizzesfun/sign_up.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
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
                 
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(children: <Widget>[
                        
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                            height: 300,
                            width: 500,
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return new SignupPage();
                                }));
                              },
                              padding: EdgeInsets.all(12),
                              color: Colors.deepOrange[200],
                              splashColor: Color.fromRGBO(40, 20, 40, 10),
                              child: Center(
                                child:Image.asset(
                                      "assets/qr.png",
                                      width: 100,
                                      height: 100,
                                    ),
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                       
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            height: 120,
                            width: 120,
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
                                    onPressed: () async {},
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Scan Now")
                                ]))
                      ]))
                ]),
          )
        ]));
  }
}
