import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'image_picker_handler.dart';
import 'photoview/clipped_photo_view_page.dart';
import 'homestudent.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with TickerProviderStateMixin, ImagePickerListener {
  String name, email, age, clasn, school, profile;

  static String profilepic;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  static FirebaseUser _loggedInUser;
  static String docID = _loggedInUser.uid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  int total;
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  var profilepic1;
  File profilePic1; //parameter untuk load gambar
  PhotoViewController controller;
  double scaleCopy;
  PhotoViewScaleStateController scaleStateController;
  ClippedPhotoViewPage clippedPhotoViewPage;

  void initState() {
    super.initState();
    loadData();
    getCurrentUser(_loggedInUser);
    controller = PhotoViewController()..outputStateStream.listen(listener);
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  void listener(PhotoViewControllerValue value) {
    scaleCopy = value.scale;
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
  //String profileUpdate;

  @override
  Widget build(BuildContext context) {
    getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        profilePic1 = image;
        uploadPic(profilePic1);
        print("Press2 profilepic1: $profilepic1");
      });
    }

    Future<bool> checkAndRequestPhotosPermissions() async {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.photos);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.photos]);
        return permissions[PermissionGroup.photos] == PermissionStatus.granted;
      } else {
        return true;
      }
    }

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.deepOrange[200],
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return new HomeStudent();
                },
              ));
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              //profileUpdate
              Navigator.pushNamed(context, '/editprofile');
            });
          },
          backgroundColor: Colors.grey[800],
          child: Icon(Icons.edit),
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
                child: SingleChildScrollView(
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
                        child: GestureDetector(
                          child: CircleAvatar(
                            radius: 70.0,
                            child: ClipOval(
                              child: Container(
                                width: 140,
                                height: 140,
                                child:
                                    (profilePic1 != null && profilepic != null)
                                        ? Image.file(
                                            profilePic1,
                                            fit: BoxFit.cover,
                                          )
                                        : (profilePic1 == null &&
                                                profilepic != null)
                                            ? Image.network(
                                                profilepic.toString(),
                                                fit: BoxFit.cover,
                                              )
                                            : Icon(
                                                Icons.image,
                                                size: 40,
                                              ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              getImage();
                              checkAndRequestPhotosPermissions();
                            });

                            print("ProfilePic1: $profilePic1");
                          },
                        ),
                      ),
                      (profilepic1 != null)
                          ? Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.cloud_upload,
                                          color: Colors.deepOrange[200],
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          _firestore
                                              .collection('Users')
                                              .document(_loggedInUser.uid)
                                              .updateData({
                                            'profilepic1': profilepic1,
                                          });
                                          Navigator.pushNamed(
                                              context, '/profile');
                                          showDialog(
                                              context: context,
                                              builder: (context) => CustomDialog(
                                                  title: "Success",
                                                  description:
                                                      "You have successfully Update your profile !"));
                                        }),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
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
                        name ?? "Loading...",
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
                        age ?? "Loading...",
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
                        clasn ?? "Loading...",
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
                            email ?? "Loading...",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18.0,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        ),
                        SizedBox(height: 20.0),
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
                        )
                      ]))
            ],
          ),
        ]));
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
      profilePic1 = _image;
      uploadPic(profilePic1);
    });
  }

  void uploadPic(File profilePic1) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Profile Picture/${Path.basename(profilePic1.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(profilePic1);
    await uploadTask.onComplete;
    print('File Uploaded 2');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        profilepic1 = fileURL;
      });
    });
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
