import 'package:flutter/material.dart';
import 'package:quizzesfun/editprofile.dart';
import 'main.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingPageState createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          body: Stack(
            children: <Widget>[
              ListView(
                // padding: EdgeInsets.all(20),
                children: <Widget>[
                  // UserAccountsDrawerHeader(
                  //   accountName: Text("Apai"),
                  //   accountEmail: Text("afiqikmal98@gmail.com"),
                  //   currentAccountPicture: CircleAvatar(
                  //     backgroundColor:
                  //         Theme.of(context).platform == TargetPlatform.iOS
                  //             ? Colors.blue
                  //             : Colors.white,
                  //     child: Text(
                  //       "A",
                  //       style: TextStyle(fontSize: 40.0),
                  //     ),
                  //   ),
                  // ),
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.person),
                    title: Text(
                      'Edit Profile',
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return new EditProfile();
                      }));
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.lock),
                    title: Text(
                      'Change Password',
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.delete),
                    title: Text(
                      'Delete Account',
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading:Icon(Icons.track_changes), 
                    title: Text("Dark Theme"),
                    trailing: Switch(
                      value: darkTheme,
                      onChanged: (changed) {
                        setState(() {
                          darkTheme = changed;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.lock_open),
                    title: Text('Logout'),
                    onTap: () {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return new Llogou();
                      // }));
                    },
                  ),
                ],
              )
            ],
          )),
      theme: darkTheme ? ThemeData.dark() : ThemeData.light(),
    );
  }
}