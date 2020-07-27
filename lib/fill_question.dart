import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzesfun/score.dart';

// ignore: must_be_immutable
class QuestionFillPage extends StatefulWidget {
  dynamic id;

  dynamic email;
  dynamic no;
  dynamic score;
  QuestionFillPage(this.id, this.email, this.no, this.score);

  @override
  _QuestionFillPageState createState() => _QuestionFillPageState();
}

class _QuestionFillPageState extends State<QuestionFillPage> {
  String name, q, ansa, ansb, ansc, ansd, corrAns, chooseAns, email;
  int totalq;
  int question;
  int curr;
  int score;
  bool answered = false;

  void initState() {
    super.initState();
    curr = widget.no;
    score = widget.score;
    email = widget.email;
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
      totalq = map.data['total question'];
      q = map.data['question$curr'];
      ansa = map.data['ans${curr}a'];
      ansb = map.data['ans${curr}b'];
      ansc = map.data['ans${curr}c'];
      ansd = map.data['ans${curr}d'];
      corrAns = map.data['correct answer q$curr'];
    });
  }

  Color _color = Colors.red;
  get color => _color;
  set color(values) => setState(() => _color = values);

  void wrong() {
    setState(() {
      _color = Colors.red;
    });
  }

  void right() {
    setState(() {
      _color = Colors.green;
    });
  }

  checkAns() {
    answered = true;
    setState(() {
      if (chooseAns == corrAns) {
        score += 1;
        right();
      } else {
        wrong();
      }
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
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(26, 37, 100, 0.7),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Question ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              curr.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              "/",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              totalq.toString() ?? 0,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          child: AutoSizeText(
                                            q ?? "Loading",
                                            maxLines: 5,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: RaisedButton(
                                            child: Row(
                                              children: <Widget>[
                                                new Text('a)  ',
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                new Text(ansa ?? "Loading...",
                                                    style:
                                                        TextStyle(fontSize: 20))
                                              ],
                                            ),
                                            textColor: Colors.black,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                            color: pressAttention
                                                ? _color
                                                : Colors.blue[100],
                                            onPressed: !answered
                                                ? () {
                                                    setState(() {
                                                      pressAttention = true;
                                                      chooseAns = 'A';
                                                      checkAns();
                                                    });
                                                  }
                                                : () {},
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: RaisedButton(
                                            child: Row(
                                              children: <Widget>[
                                                new Text('b)  ',
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                new Text(ansb ?? "Loading...",
                                                    style:
                                                        TextStyle(fontSize: 20))
                                              ],
                                            ),
                                            textColor: Colors.black,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                            color: pressAttention
                                                ? _color
                                                : Colors.blue[100],
                                            onPressed: !answered
                                                ? () {
                                                    setState(() {
                                                      pressAttention = true;
                                                      chooseAns = 'B';
                                                      checkAns();
                                                    });
                                                  }
                                                : () {},
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: RaisedButton(
                                            child: Row(
                                              children: <Widget>[
                                                new Text('c)  ',
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                new Text(ansc ?? "Loading...",
                                                    style:
                                                        TextStyle(fontSize: 20))
                                              ],
                                            ),
                                            textColor: Colors.black,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                            color: pressAttention
                                                ? _color
                                                : Colors.blue[100],
                                            onPressed: !answered
                                                ? () {
                                                    setState(() {
                                                      pressAttention = true;
                                                      chooseAns = 'C';
                                                      checkAns();
                                                    });
                                                  }
                                                : () {},
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: RaisedButton(
                                            child: Row(
                                              children: <Widget>[
                                                new Text('d)  ',
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                new Text(ansd ?? "Loading...",
                                                    style:
                                                        TextStyle(fontSize: 20))
                                              ],
                                            ),
                                            textColor: Colors.black,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                            color: pressAttention
                                                ? _color
                                                : Colors.blue[100],
                                            onPressed: !answered
                                                ? () {
                                                    setState(() {
                                                      pressAttention = true;
                                                      chooseAns = 'D';
                                                      checkAns();
                                                    });
                                                  }
                                                : () {},
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Spacer(),
                                      Spacer(),
                                      Spacer(),
                                      Spacer(),
                                      Spacer(),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: 90,
                                          height: 4,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            onPressed: () async {
                                              curr = curr + 1;
                                              if (curr <= totalq) {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return new QuestionFillPage(
                                                      widget.id.toString(),
                                                      email,
                                                      curr,
                                                      score);
                                                }));

                                                print('curr = $curr');
                                              } else {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return new ScorePage(
                                                      widget.email.toString(),
                                                      widget.id.toString(),
                                                      score);
                                                }));
                                              }
                                            },
                                            padding: EdgeInsets.all(2),
                                            color: Colors.deepOrange[200],
                                            splashColor:
                                                Color.fromRGBO(40, 20, 40, 10),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Spacer(),
                                    ]))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ])
        ]));
  }
}
