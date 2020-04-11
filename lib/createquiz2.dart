import 'package:flutter/material.dart';
import 'package:quizzesfun/main.dart';

class CommonThings {
  static Size size;
}

class CreateQuiz2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateQuiz2State();
}

class CreateQuiz2State extends State<CreateQuiz2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ans1Controller = TextEditingController();
  final TextEditingController _ans2Controller = TextEditingController();
  final TextEditingController _ans3Controller = TextEditingController();
  final TextEditingController _ans4Controller = TextEditingController();
  int no = 1;
  int _radioValue = -1;
  var correctans = 'A';
  int correctScore = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
  
      switch (_radioValue) {
        case 0:
          correctans = 'A';
          break;
        case 1:
          correctans = 'B';
          break;
        case 2:
          correctans = 'C';
          break;
        case 3:
          correctans = 'D';
          break;
      }
    });
  }

  Widget buildFrontpage(){
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
                  Row(
                    children: <Widget>[
                      Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width*0.65,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          color: Colors.deepOrange[200]),
                      child: Container(
                        padding: EdgeInsets.only(top: 5, left: 5),
                        width: 200,
                        height: 35,
                        child: Text("Enter question and answer",
                            style: const TextStyle(
                                color: const Color(0xff1a253f),
                                fontWeight: FontWeight.w400,
                                fontFamily: "MyriadHebrew-It",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                            textAlign: TextAlign.left),
                      ),
                ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left:20, top: 20),
                        child: Text("Current question: $no", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),)),
                    ],
                  ),
// inputquiztitle

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 310,
                            alignment: Alignment.center,
                            height: 80.0,
                            padding: const EdgeInsets.only(left: 20, top: 0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border:
                                  new Border.all(color: Colors.black54, width: 2.0),
                              borderRadius: new BorderRadius.circular(20),
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
                                      hintText: "Question"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[

                              Container(
                                margin: EdgeInsets.only(right:20),
                                child: Text("Correct\nAnswer", style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),)),
                              Container(
                                margin: EdgeInsets.only(bottom:10, right: 20),
                                child: Radio(
                                  activeColor: Colors.deepOrange[200],
                                  focusColor: Colors.deepOrange[200],
                                  value: 0,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, right:15),
                            width: 310,
                            alignment: Alignment.center,
                            height: 80.0,
                            padding: const EdgeInsets.only(left: 20, top: 0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border:
                                  new Border.all(color: Colors.black54, width: 2.0),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0.0, 10, 0),
                                child: new TextFormField(
                                  controller: _ans1Controller,
                                  strutStyle: StrutStyle(
                                    fontSize: 17,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Answer A"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 20, top: 10),
                            child: Radio(
                              activeColor: Colors.deepOrange[200],
                              focusColor: Colors.deepOrange[200],
                              value: 1,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 15),
                            width: 310,
                            alignment: Alignment.center,
                            height: 80.0,
                            padding: const EdgeInsets.only(left: 20, top: 0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border:
                                  new Border.all(color: Colors.black54, width: 2.0),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0.0, 10, 0),
                                child: new TextFormField(
                                  controller: _ans2Controller,
                                  strutStyle: StrutStyle(
                                    fontSize: 17,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Answer B"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right:20, top: 10),
                            child: Radio(
                              activeColor: Colors.deepOrange[200],
                              focusColor: Colors.deepOrange[200],
                              value: 2,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 15),
                            width: 310,
                            alignment: Alignment.center,
                            height: 80.0,
                            padding: const EdgeInsets.only(left: 20, top: 0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border:
                                  new Border.all(color: Colors.black54, width: 2.0),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0.0, 10, 0),
                                child: new TextFormField(
                                  controller: _ans3Controller,
                                  strutStyle: StrutStyle(
                                    fontSize: 17,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Answer C"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right:20, top: 10),
                            child: Radio(
                              activeColor: Colors.deepOrange[200],
                              focusColor: Colors.deepOrange[200],
                              value: 3,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 15),
                            width: 310,
                            alignment: Alignment.center,
                            height: 80.0,
                            padding: const EdgeInsets.only(left: 20, top: 0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border:
                                  new Border.all(color: Colors.black54, width: 2.0),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0.0, 10, 0),
                                child: new TextFormField(
                                  controller: _ans4Controller,
                                  strutStyle: StrutStyle(
                                    fontSize: 17,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Answer D"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 100, top: 20, bottom: 20),
                        child: FloatingActionButton.extended(onPressed: (){
                          setState(() {
                            no = no + 1;
                          });
                        }, backgroundColor: Colors.blue[700], label: Text('Add Question'), icon: Icon(Icons.add),)),
                      Container(
                      margin: EdgeInsets.only(top: 10, right: 20, bottom: 20),
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, '/getqr');
                        },
                        color: Colors.green[200],
                        splashColor: Colors.purple,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.done, color: Colors.white,),
                            Text('Finish', style: TextStyle(color: Colors.white),),
                          ],
                        ),
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                    ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        );
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
                  padding: const EdgeInsets.only(left:2),
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
