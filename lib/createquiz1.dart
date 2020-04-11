import 'main.dart';
import 'package:flutter/material.dart';
import 'package:quizzesfun/createquiz2.dart';

class CommonThings {
  static Size size;
}

class CreateQuiz1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateQuiz1State();
}

class CreateQuiz1State extends State<CreateQuiz1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

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
                      width: MediaQuery.of(context).size.width*0.8,
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
                        child: Text("Enter quiz title to create a new quiz",
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
// inputquiztitle

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 200),
                        width: 310,
                        alignment: Alignment.center,
                        height: 50.0,
                        padding: const EdgeInsets.only(left: 20, top: 0),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          border:
                              new Border.all(color: Colors.black54, width: 2.0),
                          borderRadius: new BorderRadius.circular(40),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0.0, 10, 0),
                            child: new TextFormField(
                              controller: _titleController,
                              strutStyle: StrutStyle(
                                fontSize: 17,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Quiz Title"),
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
                          Navigator.pushNamed(context, '/createquiz2');
                          if (_formKey.currentState.validate()) {
                            //_signin();
                          }
                          print('Sign In');
                        },
                        color: Colors.deepOrange[200],
                        splashColor: Colors.purple,
                        child: Text('Create Quiz'),
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
