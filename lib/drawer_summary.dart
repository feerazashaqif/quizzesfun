import 'package:flutter/material.dart';
import 'package:quizzesfun/main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<ProfilePage> {
  //String profileUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        drawer: Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color.fromRGBO(26, 37, 63, 1)),
  accountName: Text("Rogayah Ahmad"),
  accountEmail: Text("rogayah@gmail.com"),
  currentAccountPicture: CircleAvatar(
    backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Color.fromRGBO(26, 37, 63, 1)
            : Colors.white,
    child: Text(
      "R",
      style: TextStyle(fontSize: 40.0),
    ),
  ),
),
          GestureDetector(
   onTap: (){
     //Navigator.pushNamed(context, '/profile');
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
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ))),
          Column(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  height: 300.0,
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
                        SizedBox(height: 40.0),
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
                        SizedBox(height: 40.0),
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
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                        SizedBox(height: 20.0),
                      ])),
              SizedBox(height: 100.0),
              Padding(
                //eventhough we put mainaxis.center the childrens weren't centered. So we decideed to put padding left to make center
                padding: const EdgeInsets.only(left: 22.0),
                child: myButton(
                  'Create Quiz',
                  Icon(Icons.exit_to_app),
                ),
              ),
            ],
          )
        ]));
  }

  Widget myButton(btnName, icon) {
  return FloatingActionButton.extended(
    onPressed: (){Navigator.pushNamed(context, '/createquiz1');},
    label: Text(btnName),
    icon: icon,
  );
}
}



class Tiles extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  Tiles(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black))),
        child: InkWell(
          splashColor: Colors.deepOrange,
          onTap: onTap,
          //to implement the tiles
          child: Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
