import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizzesfun/main.dart';

class HomeStudent extends StatefulWidget {
  @override
  HomeStudentState createState() => HomeStudentState();
}

class HomeStudentState extends State<HomeStudent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color.fromRGBO(26, 37, 63, 1)),
  accountName: Text("Chun-Li"),
  accountEmail: Text("chunli@gmail.com"),
  currentAccountPicture: CircleAvatar(
    backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Color.fromRGBO(26, 37, 63, 1)
            : Colors.white,
    child: Text(
      "C",
      style: TextStyle(fontSize: 40.0),
    ),
  ),
),
 GestureDetector(
   onTap: (){
     Navigator.pushNamed(context, '/profile');
   },
   child: ListTile(
          title: Text("My Profile"),
          trailing: Icon(Icons.person),
        ),
 ),
          GestureDetector(
            onTap: (){
     Navigator.pushNamed(context, '/setting');
   },
            child: ListTile(
        title: Text("Settings"),
        trailing: Icon(Icons.settings),
      ),
          ),
      GestureDetector(
        onTap: (){
     Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return new MyHomePage();
                              }));
   },
        child: ListTile(
          title: Text("Log out"),
          trailing: Icon(Icons.keyboard_return),
        ),
      ),
        ]
      ),
    ),
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.more_horiz),
  onTap: () {
    print("on tap");
    // _scaffoldKey.currentState.openDrawer();
    // Scaffold.of(context).openDrawer();
    if (_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openEndDrawer();
    } else {
      _scaffoldKey.currentState.openDrawer();
    }
  },
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
        floatingActionButton: FloatingActionButton.extended(
          label:Text('Join Quiz'),
          onPressed: () {
            Navigator.pushNamed(context, '/findquiz');

          },
          backgroundColor: Color.fromRGBO(26, 37, 63, 1),
          icon: Icon(Icons.play_arrow),
        ),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ))),
          ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.white,
                height: 450.0,
                width: 400.0,
                padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'User profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage('assets/thumb.png'),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 40.0,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Chun-Li',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Age',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '23',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 18.0),
                    Text(
                      'Class/Course',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'SCSJ_XYZ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.grey[800],
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'chunli@gmail.com',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  height: 200.0,
                  width: 400.0,
                  padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Account Summary',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Text(
                              'Total Quiz Attempted',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                            SizedBox(width: 50.0),
                            Text(
                              'Average percentage',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 60.0),
                            Text(
                              '4',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                            SizedBox(width: 140.0),
                            Text(
                              '79%',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            )
                          ],
                        )
                      ]))
            ],
          ),
        ]));
  }  }
