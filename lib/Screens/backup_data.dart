import 'dart:async';

import 'package:Manifest/Theme/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:Manifest/Widgets/toast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BackupData extends StatefulWidget {
  const BackupData({Key key}) : super(key: key);

  @override
  _BackupDataState createState() => _BackupDataState();
}

class _BackupDataState extends State<BackupData> {
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

  bool isEmailVerifiedLoading = false;

  CustomToast _toast = CustomToast();

  StreamSubscription subscription;

  @override
  void initState() {
    // print("TAG_DATE " +
    //     DateFormat("d/M/y", "en_US")
    //         .parse("6/10/2020")
    //         .year
    //         .toString());
    // print("TAG_DATE " + Hive.box("progress").get(1).day.toString());
    // Hive.box("progress").put(0, 0);

    print("TAG_DATE " + Hive.box("progress").get(0).toString());

    emailController = TextEditingController();
    passwordController = TextEditingController();
    email = "";
    password = "";
    emailController.value = TextEditingValue(text: email);
    passwordController.value = TextEditingValue(text: password);

    subscription =
        FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isSignedIn = false;
        });
      } else {
        User user = FirebaseAuth.instance.currentUser;
        setState(() {
          isEmailVerifiedLoading = true;
        });
        await user.reload();
        setState(() {
          isEmailVerifiedLoading = false;
        });
        if (user.emailVerified) {
          Hive.box("darkMode").put(3, "null");
        }

        setState(() {
          isSignedIn = true;
          isEmailVerified = user.emailVerified;
          userEmail = user.email;
        });
        print('User is signed in!');
        print(user.emailVerified);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  signUpWithEmailAndPassword(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = FirebaseAuth.instance.currentUser;

      await user.reload();

      if (!user.emailVerified) {
        await user.sendEmailVerification();
        _toast.showToast(context, Icons.done,
            "Signed Up! Now verify your email :)", greenColor,
            duration: 4);
      } else {}
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
    return isEmailVerifiedLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Theme(
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
                  // backgroundColor: primaryLight,
                  // floatingActionButton: FloatingActionButton(
                  //   child: Icon(Icons.done),
                  //   onPressed: () {
                  //     if (email.length < 10 || password.length < 10) {
                  //       showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //               title: Text(
                  //                 "Alert!",
                  //                 style: TextStyle(fontWeight: FontWeight.w700),
                  //               ),
                  //               content: Text(
                  //                   "Length of Goals and Plans must be greater than 10!"),
                  //               actions: <Widget>[
                  //                 FlatButton(
                  //                   child: Text(
                  //                     "Okay!",
                  //                     style: TextStyle(
                  //                       color: accent,
                  //                     ),
                  //                   ),
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                 )
                  //               ],
                  //             );
                  //           });
                  //       return;
                  //     }

                  //     // box.put(
                  //     //     widget.isEdit ? widget.index : box.length, [email, password]);
                  //     _toast.showToast(context, Icons.done, "Goal added", greenColor);
                  //     Navigator.of(context).pop();
                  //     // box.put(3, ["goal", "plan"]);
                  //     // print(box.get(3));
                  //   },
                  // ),
                  appBar: AppBar(
                    title: Text("Backup Data"),
                    backgroundColor: secondary,
                    centerTitle: true,
                    elevation: 0,
                  ),
                  body: SafeArea(
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, right: 15, left: 15),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: "affirmation",
                                  child: Center(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      child: SvgPicture.asset(
                                        "assets/images/sync.svg",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                isSignedIn
                                    ? Container()
                                    : Text(
                                        "Backup your data",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                isSignedIn
                                    ? isEmailVerified
                                        ? Text(
                                            "Your data is being backed up. You're signed as $userEmail",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: greenColor),
                                          )
                                        : Text(
                                            "To backup your data, you need to verify your email.\nIf you've done it already, then data will be automatically backed up.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          )
                                    : Text(
                                        "Your data is not being backed up. You may lose all your data! Back up now.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: warningColor),
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              email = value;
                                            });
                                          },
                                          controller: emailController,
                                          scrollPhysics:
                                              BouncingScrollPhysics(),
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        child: TextField(
                                          scrollPhysics:
                                              BouncingScrollPhysics(),

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
                                isSignedIn
                                    ? Container()
                                    : SizedBox(
                                        height: 20,
                                      ),
                                isSignedIn
                                    ? Container()
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Note: Verification link will be sent on your email",
                                          textAlign: TextAlign.start,
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
                                                await FirebaseAuth.instance
                                                    .signOut();
                                              }
                                            : () {
                                                // Navigator.of(context).pushNamed('/practice');
                                                signUpWithEmailAndPassword(
                                                    email, password);
                                              },
                                    disabledColor: secondary,
                                    child: !isLoading
                                        ? Text(
                                            isSignedIn ? "SIGN OUT" : "SIGN UP",
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
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .pushNamed('/login');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "Want to recover your data?"),
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
