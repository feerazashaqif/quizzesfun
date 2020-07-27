import 'package:flutter/material.dart';
import 'package:quizzesfun/main.dart';
import 'teacher_profile.dart';
import 'teacher_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String email;

  ProfilePage({Key key, this.email}) : super(key: key);
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<ProfilePage> {
  var data;
  String name, email, age, clasn, school;
  static String profilepic;
  int total;
  // static String profilepic;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  static FirebaseUser _loggedInUser;
  static String docID = _loggedInUser.uid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  void initState() {
    super.initState();
    loadData();
    getCurrentUser(_loggedInUser);
  }

  getCurrentUser(FirebaseUser loggedInUser) async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _loggedInUser = user;

        Firestore.instance.settings(
          persistenceEnabled: true,
        );

        final QuerySnapshot result =
            await _firestore.collection('Users').getDocuments();
        final List<DocumentSnapshot> documentsnapshot = result.documents;
        final List<Map<String, dynamic>> _otheruserinfo =
            new List<Map<String, dynamic>>();
        documentsnapshot.forEach((data) {
          if (data.documentID != docID) {
            _firestore
                .collection('Users')
                .document(data.documentID)
                .get()
                .then((DocumentSnapshot snap) {
              _otheruserinfo.add(snap.data);
            });
          }
        });

        _firestore
            .collection('Users')
            .document(docID)
            .get()
            .then((DocumentSnapshot ds) {
          setState(() {});
        });
      }
    } catch (e) {
      print(e);
    }
  }

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
          child: ListView(children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(26, 37, 63, 1)),
              accountName: Text(name ?? "Loading..."),
              accountEmail: Text(email ?? "Loading..."),
              currentAccountPicture: ClipOval(
                  child: (profilepic != null)
                      ? CircleAvatar(
                          radius: 40,
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Image.network(
                              profilepic.toString(),
                              fit: BoxFit.cover,
                            ),
                          ))
                      : CircleAvatar(
                          backgroundColor:
                              (Theme.of(context).platform == TargetPlatform.iOS)
                                  ? Color.fromRGBO(26, 37, 63, 1)
                                  : Colors.white,
                          child: Text(
                            name.toString().substring(0, 1) ?? 'Loading...',
                            style: TextStyle(fontSize: 40.0),
                          ),
                        )),
            ),
            GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, '/profile');
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new TeacherProfile();
                  },
                ));
              },
              child: ListTile(
                title: Text("My Profile"),
                trailing: Icon(Icons.person),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/setting');
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new TSettingPage();
                  },
                ));
              },
              child: ListTile(
                title: Text("Settings"),
                trailing: Icon(Icons.settings),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new MyHomePage();
                }));
                showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                        title: "Success",
                        description: "You have successfully Logout !"));
              },
              child: ListTile(
                title: Text("Log out"),
                trailing: Icon(Icons.keyboard_return),
              ),
            ),
          ]),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Total Quiz Created',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              total.toString() ?? "0",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
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

  Future<void> loadData() async {
    await Future.delayed(Duration(milliseconds: 0));
    final uid = await getCurrentUID();
    final map =
        await Firestore.instance.collection('Users').document(uid).get();
    print(map.data);

    setState(() {
      name = map.data['name'];
      email = map.data['email'];
      age = map.data['age'];
      clasn = map.data['class'];
      school = map.data['school'];
      profilepic = map.data['profilepic1'];
      total = map.data['total'];
    });
    return uid;
  }

  Widget myButton(btnName, icon) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, '/createquiz1');
      },
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

class CustomDialog extends StatelessWidget {
  final title, description, buttonText, images;
  CustomDialog({this.title, this.description, this.buttonText, this.images});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: Color.fromRGBO(26, 37, 63, 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              )
            ]),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ]),
      ),
      Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/success.gif')))),
          ))
    ]);
  }
}
