import 'package:quizzesfun/drawer_summary.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:quizzesfun/createquiz2.dart';

class CommonThings {
  static Size size;
}

class GetQR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetQRState();
}

class GetQRState extends State<GetQR> {
  Widget buildFrontpage() {
    return Stack(children: <Widget>[
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
                                  Container(
                                    width: 250,
                                    height: 250,
                                    child: Image.asset(
            'assets/qrcode.png',
            color: Color.fromRGBO(255, 255, 255, 1),
            colorBlendMode: BlendMode.modulate,
            fit: BoxFit.cover,
          ),
                                  ),
                            
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
                                return new ProfilePage();
                              }));
                            },
                            padding: EdgeInsets.all(10),
                            color: Colors.deepOrange[200],
                            splashColor: Color.fromRGBO(40, 20, 40, 10),
                            child: Center(
                              child: Text(
                                "Back to Home",
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
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
        backgroundColor: Color.fromRGBO(26, 37, 63, 1),
        body: buildFrontpage());
  }
}
