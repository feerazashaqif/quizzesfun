import 'package:flutter/material.dart';
import 'package:quizzesfun/score.dart';


class QuestionFillPage extends StatefulWidget {
 
  @override
  _QuestionFillPageState createState() => _QuestionFillPageState();
}

class _QuestionFillPageState extends State<QuestionFillPage> {
 
  Color _color = Colors.red;
  get color => _color;
  set color(values) => setState(() => _color = values);
  
  void wrong(){
    setState(() {
     _color = Colors.red;
    });
  }
  bool pressAttention = false;
  
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                  Expanded(flex: 7,child:Text("Question 1/10",style: TextStyle(color: Colors.white, fontSize: 15,fontStyle: FontStyle.italic),), ),
                                  Expanded(flex: 7,
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    child :Text("Who is the first Prime Minister of Malaysia ?",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),),), 
                                  
                                  Expanded(
                                    flex: 2 ,
                                  child:  Container(
                                  
                                    width: 250,
                                    height: 80,
                                    child:  RaisedButton(
                                          child: new Text('a) Lim Guan Eng                '),
                                           textColor: Colors.black,
                                           shape: new RoundedRectangleBorder(
                                           borderRadius: new BorderRadius.circular(30.0),
                                            ),
                                           color: pressAttention ? Colors.red : Colors.blue[100],
                                           onPressed: () => setState(() => pressAttention = !pressAttention),
                                            ),
                                  ),),
                                 Spacer(),
                                  
                                  Expanded(
                                    flex: 2,
                                  child:  Container(
                                  
                                    width: 250,
                                    height: 80,
                                    child:  RaisedButton(
                                          child: new Text('b) Tun Dr Mahatir               '),
                                           textColor: Colors.black,
                                           shape: new RoundedRectangleBorder(
                                           borderRadius: new BorderRadius.circular(30.0),
                                            ),
                                           color: pressAttention ? Colors.red : Colors.blue[100],
                                           onPressed: () => setState(() => pressAttention = !pressAttention),
                                            ),
                                  ),),
                                 Spacer(),
                                  
                                  Expanded(
                                    flex: 2 ,
                                  child:  Container(
                                  
                                    width: 250,
                                    height: 80,
                                    child:  RaisedButton(
                                          child: new Text('c) Tun Abdul Razak           '),
                                           textColor: Colors.black,
                                           shape: new RoundedRectangleBorder(
                                           borderRadius: new BorderRadius.circular(30.0),
                                            ),
                                           color: pressAttention ? Colors.red : Colors.blue[100],
                                           onPressed: () => setState(() => pressAttention = !pressAttention),
                                            ),
                                  ),),
                                 Spacer(),
                                  
                                  Expanded(
                                    flex: 2 ,
                                  child:  Container(
                                  
                                    width: 250,
                                    height: 80,
                                    child:  RaisedButton(
                                          child: new Text('d) Tunku Abdul Rahman  '),
                                           textColor: Colors.black,
                                           shape: new RoundedRectangleBorder(
                                           borderRadius: new BorderRadius.circular(30.0),
                                            ),
                                           color: pressAttention ? Colors.green : Colors.blue[100],
                                           onPressed: () => setState(() => pressAttention = !pressAttention),
                                            ),
                                  ),),
                                  
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),

                                  Expanded(
                                   
                                    flex: 3 ,
                                    
                                  child:  Container(
                                   
                                    width: 90,
                                    height: 4,
                                    child:  RaisedButton(
                                          shape: RoundedRectangleBorder(
                                           
                                           borderRadius: BorderRadius.circular(20)),
                                           onPressed: () async {
                                           Navigator.push(context,
                                           MaterialPageRoute(builder: (context) {
                                          return new ScorePage();
                                          }));
                                         },

                                          padding: EdgeInsets.all(2),
                                          color: Colors.deepOrange[200],
                                         splashColor: Color.fromRGBO(40, 20, 40, 10),
                                          
                                          child: Center(
                                           child: Icon(
                                             Icons.arrow_forward_ios,
                                             color: Colors.black,
                                           ),
                                        ),
                                         ),
                                  ),),
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
