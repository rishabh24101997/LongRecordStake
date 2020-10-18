import 'dart:async';
import 'dart:io';

import 'package:Manifest/Theme/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:Manifest/Widgets/toast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var box = Hive.box('goals');
  var boxDarkMode = Hive.box('darkMode');
  String email;
  TextEditingController emailController;
  bool isEmailVerified = false;
  bool isLoading = false;
  bool isSignedIn = false;
  String password;
  TextEditingController passwordController;
  String userEmail = "";

  CustomToast _toast = CustomToast();

  StreamSubscription subscription;

  int days;
  DateTime date;
  Map<int, dynamic> visionBoardMap = new Map();
  Map<int, String> affirmationsMap = new Map();
  Map<int, dynamic> goalsMap = new Map();

  Future<void> backupData() async {
    setState(() {
      isLoading = true;
    });
    int count = 0;
    // Hive.box("goals").clear();
    for (var i in Hive.box("affirmations").values.toList()) {
      // print(i);
      if (i != null) {
        // if (box.get(index) == i) {
        //   currAffirmation = count;
        // }
        // goals.add(i);
        // Hive.box("goals").put(count, [i["a"], i["b"]]);
        // affirmationsMap[count] = {};
        affirmationsMap[count] = i.toString();
        // print(affirmationsMap[count]);
        count++;
      }
    }
    count = 0;

    for (var i in Hive.box("goals").values.toList()) {
      // print(i);
      if (i != null) {
        // if (box.get(index) == i) {
        //   currAffirmation = count;
        // }
        // goals.add(i);
        // Hive.box("goals").put(count, [i["a"], i["b"]]);
        goalsMap[count] = {};
        goalsMap[count][0] = i[0];
        goalsMap[count][1] = i[1];
        print(goalsMap[count]);
        count++;
      }
    }
    count = 0;
    print(goalsMap);

    // Putting all the goals.

    // Putting progress Days and Date.
    days = Hive.box("progress").get(0);
    date = Hive.box("progress").get(1);

    for (var i in Hive.box("visionBoard").values.toList()) {
      // print(i);
      if (i != null) {
        // if (box.get(index) == i) {
        //   currAffirmation = count;
        // }
        // goals.add(i);
        // Hive.box("goals").put(count, [i["a"], i["b"]]);

        visionBoardMap[count] = {};
        visionBoardMap[count][0] = i[0];
        visionBoardMap[count][1] = i[1];
        print(goalsMap[count]);
        count++;
      }
    }
    count = 0;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    email = "";
    password = "";
    emailController.value = TextEditingValue(text: email);
    passwordController.value = TextEditingValue(text: password);

    backupData();

    subscription =
        FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isSignedIn = false;
        });
      } else {
        try {
          User user = FirebaseAuth.instance.currentUser;

          setState(() {
            isLoading = true;
          });
          // final snackBar = SnackBar(
          //     content: Text('Please wait while we fetch your data back :\)'));
          // Scaffold.of(context).showSnackBar(snackBar);

          _toast.showToast(context, Icons.done,
              "Please don't close the app while we fetch your data back :)", greenColor,
              duration: 4);

          await user.reload();
          print('User is currently signed in!');

          if (!user.emailVerified) {
            await user.sendEmailVerification();
            _toast.showToast(context, Icons.done, "Signed In! :)", greenColor,
                duration: 4);
          } else {
            setState(() {
              isLoading = true;
            });
            days = null;
            date = null;
            visionBoardMap = new Map();
            affirmationsMap = new Map();
            goalsMap = new Map();

            // Affirmation Section

            var affirmationsDBReference = FirebaseDatabase.instance.reference();
            setState(() {
              isLoading = true;
            });
            await affirmationsDBReference
                .child("backUpData")
                .child(user.uid)
                .child("affirmations")
                .once()
                .then((DataSnapshot affirmationsSnapshot) async {
              if (affirmationsSnapshot.value != null) {
                print(affirmationsSnapshot.value);
                int count = 0;
                // Hive.box("goals").clear();
                for (var i in affirmationsSnapshot.value) {
                  // print(i);
                  if (i != null) {
                    // if (box.get(index) == i) {
                    //   currAffirmation = count;
                    // }
                    // goals.add(i);
                    // Hive.box("goals").put(count, [i["a"], i["b"]]);
                    // affirmationsMap[count] = {};
                    affirmationsMap[count] = i.toString();
                    // print(affirmationsMap[count]);
                    count++;
                  }
                }
              }

              // print(affirmationsMap);
              // int affirmationsLength = affirmationsMap.length;
              // for (int i = 0;
              //     i < Hive.box("affirmations").length - affirmationsLength;
              //     i++) {
              //   affirmationsMap[i + affirmationsLength] = null;
              // }

              // Putting all the affirmations.
            });

            // Profile Section
            var profileDBReference = FirebaseDatabase.instance.reference();
            setState(() {
              isLoading = true;
            });
            await profileDBReference
                .child("backUpData")
                .child(user.uid)
                .child("profile")
                .once()
                .then((DataSnapshot profileSnapshot) async {
              print(profileSnapshot.value);
              int count = 0;
              // Hive.box("goals").clear();

              for (var i in profileSnapshot.value["a"]) {
                // print(i);
                if (i != null) {
                  // if (box.get(index) == i) {
                  //   currAffirmation = count;
                  // }
                  // goals.add(i);
                  // Hive.box("goals").put(count, [i["a"], i["b"]]);
                  goalsMap[count] = {};
                  goalsMap[count][0] = i["a"];
                  goalsMap[count][1] = i["b"];
                  print(goalsMap[count]);
                  count++;
                }
              }
              print(goalsMap);

              // Putting all the goals.

              // Putting progress Days and Date.
              days = profileSnapshot.value["b"];
              date = DateFormat("d/M/y", 'en_US')
                  .parse(profileSnapshot.value["c"]);
              // print("TAG_DATE" +
              //     DateFormat("dd/mm/yyyy")
              //         .parse(profileSnapshot.value["c"])
              //         .toString());
            });

            // Profile Section
            var visionBoardDBReference = FirebaseDatabase.instance.reference();
            setState(() {
              isLoading = true;
            });
            await visionBoardDBReference
                .child("backUpData")
                .child(user.uid)
                .child("visionBoard")
                .once()
                .then((DataSnapshot visionBoardSnapshot) async {
              if (visionBoardSnapshot.value != null) {
                print(visionBoardSnapshot.value);
                int count = 0;
                // Hive.box("goals").clear();

                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;

                setState(() {
                  isLoading = true;
                });

                for (var i in visionBoardSnapshot.value) {
                  // print(i);
                  if (i != null) {
                    // if (box.get(index) == i) {
                    //   currAffirmation = count;
                    // }
                    // goals.add(i);
                    // Hive.box("goals").put(count, [i["a"], i["b"]]);

                    if (File('$appDocPath/${i["b"]}.jpg').existsSync()) {
                      print("File exists");
                      await File('$appDocPath/${i["b"]}.jpg').delete();
                    }
                    final StorageReference storageReference = FirebaseStorage()
                        .ref()
                        .child("images")
                        .child(FirebaseAuth.instance.currentUser.uid)
                        .child('${i["b"]}.jpg');

                    print('This is i[\"b\"] ${i["b"]}');

                    File imageFile = File('$appDocPath/${i["b"]}.jpg');
                    await imageFile.create();

                    String url = await storageReference.getDownloadURL();
                    // http.Response downloadData = await http.get(url);
                    StorageFileDownloadTask task =
                        storageReference.writeToFile(imageFile);
                    await task.future;

                    visionBoardMap[count] = {};
                    visionBoardMap[count][0] = i["a"];
                    visionBoardMap[count][1] = '$appDocPath/${i["b"]}.jpg';
                    print(goalsMap[count]);
                    count++;
                  }
                }
                print(visionBoardMap);
              }
            });
            setState(() {
              isLoading = true;
            });

            // TODO: Remove this


            // Put all the data to Hive Boxes (Maintain the sequence!!)
            await Hive.box("visionBoard").clear();
            await Hive.box("visionBoard").putAll(visionBoardMap);
            
            
            await Hive.box("progress").clear();
            await Hive.box("progress").putAll({0: days, 1: date});
            // Hive.box("progress").put(1, date);
            // Hive.box("progress").put(0, days);
            
            
            await Hive.box("affirmations").clear();
            await Hive.box("affirmations").putAll(affirmationsMap);


            await Hive.box("goals").clear();
            await Hive.box("goals").putAll(goalsMap);
          }

          DateTime dayTime = DateTime.parse("2020-04-04 06:30:00.000");
          FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              );
          var time = Time(6, 30, 00);
          var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'repeatDailyAtTime channel id',
            'repeatDailyAtTime channel name',
            'repeatDailyAtTime description',
            importance: Importance.Max,
            priority: Priority.High,
          );
          var iOSPlatformChannelSpecifics = IOSNotificationDetails();
          var platformChannelSpecifics = NotificationDetails(
              androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
          flutterLocalNotificationsPlugin
              .showDailyAtTime(
                  14,
                  'Daily Practice Reminder',
                  'Take out some time for what\'s most important to you in life',
                  time,
                  platformChannelSpecifics)
              .then((value) => print("Done"));
          Hive.box("morningTime").put(0, dayTime);
          Hive.box("isIntroComplete").put(0, true);
          // Navigator.pushNamed(context, "/");
          Hive.box("isIntroComplete").put(0, true);
          DateTime nightTime = DateTime.parse("2020-04-04 10:30:00.000");
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              );

          flutterLocalNotificationsPlugin
              .showDailyAtTime(
                  14,
                  'Daily Practice Reminder',
                  'Take out some time for what\'s most important to you in life',
                  Time(10, 30, 00),
                  platformChannelSpecifics)
              .then((value) => print("Done"));
          Hive.box("nightTime").put(0, nightTime);
          // setState(() {
          //   isLoading = false;
          // });
          setState(() {
            isSignedIn = true;
            isEmailVerified = user.emailVerified;
            userEmail = user.email;
          });
          print("Navigator Called");
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

          // if (!user.emailVerified) {}
          print('User is signed in!');
        } catch (e) {
          setState(() {
            isLoading = false;
          });
        }
        setState(() {
          isLoading = false;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  signInWithEmailAndPassword(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    // TODO: Remove this
    // await Hive.box("goals").clear();
    // await Hive.box("progress").clear();
    // await Hive.box("affirmations").clear();
    // await Hive.box("visionBoard").clear();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // User user = FirebaseAuth.instance.currentUser;
      // setState(() {
      //   isLoading = false;
      // });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      await Hive.box("visionBoard").putAll(visionBoardMap);
      Hive.box("progress").put(1, date);
      Hive.box("progress").put(0, days);
      await Hive.box("affirmations").putAll(affirmationsMap);
      await Hive.box("goals").putAll(goalsMap);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.light(),
              child: AlertDialog(
                title: Text(
                  "Alert!",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                content: Text(e.message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "Okay!",
                      style: TextStyle(
                        color: accent,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primaryColor: secondary,
        splashColor: accent,
        accentColor: accent,
        buttonColor: secondary,
      ),
      child: WillPopScope(
        onWillPop: () async => !isLoading,
        child: Scaffold(
            appBar: AppBar(
              // title: Text("Backup Data"),
              backgroundColor: secondary,
              // centerTitle: true,
              elevation: 0,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 15, left: 15),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 5,
                              child: Image.asset(
                                "assets/images/icon_manifest.png",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          isSignedIn
                              ? Container()
                              : Text(
                                  "Get your data back",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          isSignedIn
                              ? Text(
                                  "Your data is being backed up. You're signed as $userEmail",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, color: greenColor),
                                )
                              : Text(
                                  "If you have any data on this app currently, it will be lost.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: Align(
                          //     alignment: Alignment.topLeft,
                          //     child: Text(
                          //       "*Your Goal",
                          //       style: TextStyle(fontSize: 20, color: secondary),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 40,
                          ),
                          isSignedIn
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                    controller: emailController,
                                    scrollPhysics: BouncingScrollPhysics(),
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: secondary,
                                    decoration: InputDecoration(
                                        // border: InputBorder.none,
                                        hintText: 'Email'),
                                  ),
                                ),
                          isSignedIn
                              ? Container()
                              : SizedBox(
                                  height: 20,
                                ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: Align(
                          //     alignment: Alignment.topLeft,
                          //     child: Text(
                          //       "*Plan to achieve it",
                          //       style: TextStyle(fontSize: 20, color: secondary),
                          //     ),
                          //   ),
                          // ),
                          isSignedIn
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextField(
                                    scrollPhysics: BouncingScrollPhysics(),

                                    controller: passwordController,
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    obscureText: true,
                                    // keyboardType: TextInputType.visiblePassword,
                                    cursorColor: secondary,
                                    decoration: InputDecoration(
                                        // border: InputBorder.none,
                                        hintText: 'Password'),
                                  ),
                                ),

                          // Text("Vector art by Freepik"),
                          isSignedIn
                              ? Container()
                              : SizedBox(
                                  height: 20,
                                ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: RaisedButton(
                              // elevation: 10,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              // splashColor: accent,
                              // color:
                              //     boxDarkMode.get(0) ? textDark : iconCardDark,
                              onPressed: isLoading
                                  ? null
                                  : isSignedIn
                                      ? () async {
                                          await FirebaseAuth.instance.signOut();
                                        }
                                      : () {
                                          // Navigator.of(context).pushNamed('/practice');
                                          signInWithEmailAndPassword(
                                              email, password);
                                        },
                              disabledColor: secondary,
                              child: !isLoading
                                  ? Text(
                                      isSignedIn ? "SIGN OUT" : "SIGN IN",
                                      style: TextStyle(
                                          color: boxDarkMode.get(0)
                                              ? textDark
                                              : textLight),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                            ),
                          ),
                          isSignedIn
                              ? Container()
                              : InkWell(
                                  onTap: () async {
                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await FirebaseAuth.instance
                                          .sendPasswordResetEmail(email: email)
                                          .then((value) => _toast.showToast(
                                              context,
                                              Icons.done,
                                              "Password reset Email sent",
                                              greenColor));
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Theme(
                                              data: ThemeData.light(),
                                              child: AlertDialog(
                                                title: Text(
                                                  "Alert!",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                content: Text(e.message),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text(
                                                      "Okay!",
                                                      style: TextStyle(
                                                        color: accent,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Forgot Password?"),
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal:
                          //           MediaQuery.of(context).size.width / 8.5),
                          //   child: SizedBox(
                          //     width: double.infinity,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(12),
                          //       child:
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )))),
      ),
    );
  }
}
