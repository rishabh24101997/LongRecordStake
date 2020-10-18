import 'dart:io';

import 'package:Manifest/Screens/add_goal.dart';
import 'package:Manifest/Screens/backup_data.dart';
import 'package:Manifest/Screens/init_page.dart';
import 'package:Manifest/Screens/init_setup.dart';
import 'package:Manifest/Screens/intro.dart';
import 'package:Manifest/Screens/login.dart';
import 'package:Manifest/Screens/practice.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:Manifest/Screens/profile.dart';
import 'package:Manifest/Screens/affirmations.dart';
import 'package:Manifest/Screens/vision_board.dart';
import 'package:Manifest/Screens/positv.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Screens/settings.dart';
import 'Models/tab_bar_choices.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/subjects.dart';

import 'package:firebase_core/firebase_core.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final String body;
  final int id;
  final String payload;
  final String title;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Admob.initialize();
  await Admob.requestTrackingAuthorization();

  
  await Hive.initFlutter();
  await Hive.openBox("goals");
  await Hive.openBox("affirmations");
  await Hive.openBox("affirmationRepeatCount");
  await Hive.openBox("visionBoard");
  // await Hive.openBox("startDate");
  await Hive.openBox("morningTime");
  await Hive.openBox("nightTime");
  await Hive.openBox("darkMode");
  await Hive.openBox("vibration");
  await Hive.openBox("progress");
  await Hive.openBox("isIntroComplete");
  await Hive.openBox("isEmailVerified");

  // await Hive.openBox("");
  // await Hive.openBox("");
  // await Hive.openBox("");

  if (Hive.box("affirmationRepeatCount").length == 0) {
    Hive.box("affirmationRepeatCount").put(0, 5);
  }

  if (Hive.box("darkMode").length == 0) {
    Hive.box("darkMode").put(0, true);
  }

  if (Hive.box("vibration").length == 0) {
    Hive.box("vibration").put(0, true);
  }

  if (Hive.box("isIntroComplete").length == 0) {
    Hive.box("isIntroComplete").put(0, false);
  }

  if (Hive.box("progress").length == 0) {
    Hive.box("progress").put(0, 0);
  }

  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         IOSFlutterLocalNotificationsPlugin>()
  //     ?.requestPermissions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'your channel id', 'your channel name', 'your channel description',
  //     importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  // var platformChannelSpecifics = NotificationDetails(
  //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  // await flutterLocalNotificationsPlugin.show(
  //     0, 'plain title', 'plain body', platformChannelSpecifics,
  //     payload: 'item x');

  // Showing a daily notification at a specific time
  // var time = Time(23, 26, 00);
  // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'repeatDailyAtTime channel id',
  //     'repeatDailyAtTime channel name',
  //     'repeatDailyAtTime description');
  // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  // var platformChannelSpecifics = NotificationDetails(
  //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  // await flutterLocalNotificationsPlugin
  //     .showDailyAtTime(
  //         10,
  //         'show daily title',
  //         'Daily notification shown at approximately ',
  //         time,
  //         platformChannelSpecifics)
  //     .then((value) => print("Done"));

  // scheduleNotification(
  //     flutterLocalNotificationsPlugin, '4', "custom", DateTime.now());

  runApp(MyApp());
}

Future<void> scheduleNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String id,
    String body,
    DateTime scheduledNotificationDateTime) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    id,
    'Reminder notifications',
    'Remember about it',
    icon: 'app_icon',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.schedule(0, 'Reminder', body,
      scheduledNotificationDateTime, platformChannelSpecifics);
}

Future<void> scheduleNotificationPeriodically(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String id,
    String body,
    RepeatInterval interval) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    id,
    'Reminder notifications',
    'Remember about it',
    icon: 'smile_icon',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(
      0, 'Reminder', body, interval, platformChannelSpecifics);
}

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  // Animation<double> animation;
  // AnimationController controller;

  bool _error = false;
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;

  bool emailVerified = false;

  @override
  void initState() {
    initializeFlutterFire();

    super.initState();
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();

      // FirebaseAuth.instance.authStateChanges().listen((User user) async {
      //   if (user == null) {
      //     print('User is currently signed out!');
      //   } else {
      //     User user = FirebaseAuth.instance.currentUser;

      //     await user.reload();

      //     setState(() {
      //       emailVerified = user.emailVerified;
      //     });
      //     print('User is signed in!');
      //     print("" + user.emailVerified.toString());
      //   }
      // });

      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_initialized
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ValueListenableBuilder(
            valueListenable: Hive.box('darkMode').listenable(),
            builder: (context, box, _) {
              FirebaseAuth.instance.currentUser != null
                  ? emailVerified =
                      FirebaseAuth.instance.currentUser.emailVerified
                  : null;
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                routes: <String, WidgetBuilder>{
                  '/intro': (BuildContext context) => new Intro(),
                  '/initSetup': (BuildContext context) => new InitSetup(),
                  '/addGoal': (BuildContext context) => new AddGoal(
                        isEdit: false,
                        index: null,
                      ),
                  '/backupData': (BuildContext context) => new BackupData(),
                  '/login': (BuildContext context) => new Login(),
                  // '/sync': (BuildContext context) => new Settings(),
                  '/settings': (BuildContext context) => new Settings(),
                  '/practice': (BuildContext context) => new Practice(),
                  // '/screen3': (BuildContext context) => new Screen3(),
                  // '/screen4': (BuildContext context) => new Screen4()
                },
                home: ValueListenableBuilder(
                  valueListenable: Hive.box('goals').listenable(),
                  builder: (context, goalsBox, _) {
                    User user = FirebaseAuth.instance.currentUser;
                    if (user == null) {
                      print('User is currently signed out!');
                    } else {
                      // user.reload();
                      if (emailVerified) {
                        // Goals Sync
                        Map<String, dynamic> goalsMap = new Map();
                        int count = 0;
                        for (var i in goalsBox.values.toList()) {
                          // print(i);
                          if (i != null) {
                            // if (box.get(index) == i) {
                            //   currAffirmation = count;
                            // }
                            // goals.add(i);
                            goalsMap[count.toString()] = {};
                            goalsMap[count.toString()]["a"] = i[0];
                            goalsMap[count.toString()]["b"] = i[1];
                            count++;
                          }
                        }
                        FirebaseDatabase.instance
                            .reference()
                            .child("backUpData")
                            .child(user.uid)
                            .child("profile")
                            .child("a")
                            .set(goalsMap);
                      }
                    }
                    return ValueListenableBuilder(
                      valueListenable: Hive.box('affirmations').listenable(),
                      builder: (context, affirmationsBox, _) {
                        User user = FirebaseAuth.instance.currentUser;
                        if (user == null) {
                          print('User is currently signed out!');
                        } else {
                          if (emailVerified) {
                            // Affirmations Sync

                            List affirmations = [];
                            for (var i in affirmationsBox.values.toList()) {
                              // print(i);
                              if (i != null) {
                                // if (box.get(index) == i) {
                                //   currAffirmation = count;
                                // }
                                affirmations.add(i);
                                // count++;
                              }
                            }
                            FirebaseDatabase.instance
                                .reference()
                                .child("backUpData")
                                .child(user.uid)
                                .child("affirmations")
                                .set(affirmations);
                          }
                        }

                        return ValueListenableBuilder(
                          valueListenable: Hive.box('progress').listenable(),
                          builder: (context, progressBox, _) {
                            // Progress sync
                            User user = FirebaseAuth.instance.currentUser;
                            if (user == null) {
                              print('User is currently signed out!');
                            } else {
                              if (emailVerified) {
                                FirebaseDatabase.instance
                                    .reference()
                                    .child("backUpData")
                                    .child(user.uid)
                                    .child("profile")
                                    .child("b")
                                    .set(progressBox.get(0));

                                // print("TAG_DATE " +
                                //     Hive.box("progress").get(1).day.toString());

                                FirebaseDatabase.instance
                                    .reference()
                                    .child("backUpData")
                                    .child(user.uid)
                                    .child("profile")
                                    .child("c")
                                    .set(
                                        "${progressBox.get(1).day}/${progressBox.get(1).month}/${progressBox.get(1).year}");
                              }
                            }

                            // DateTime time = DateFormat("d/M/y", 'en_US').parse('23/10/2012');
                            return ValueListenableBuilder(
                              valueListenable:
                                  Hive.box('visionBoard').listenable(),
                              builder: (context, visionBoardBox, _) {
                                User user = FirebaseAuth.instance.currentUser;
                                if (user == null) {
                                  print('User is currently signed out!');
                                } else {
                                  if (emailVerified) {
                                    // Vision Board
                                    Map<String, dynamic> visionBoardMap =
                                        new Map();
                                    int countVision = 0;
                                    for (var i
                                        in visionBoardBox.values.toList()) {
                                      // print(i);
                                      if (i != null) {
                                        // if (box.get(index) == i) {
                                        //   currAffirmation = count;
                                        // }
                                        // goals.add(i);
                                        final StorageReference
                                            storageReference = FirebaseStorage()
                                                .ref()
                                                .child("images")
                                                .child(FirebaseAuth
                                                    .instance.currentUser.uid)
                                                .child(countVision.toString() +
                                                    ".jpg");

                                        final StorageUploadTask uploadTask =
                                            storageReference.putFile(
                                                File(i[1]), StorageMetadata());
                                        visionBoardMap[countVision.toString()] =
                                            {};
                                        visionBoardMap[countVision.toString()]
                                            ["a"] = i[0].toString();
                                        visionBoardMap[countVision.toString()]
                                            ["b"] = countVision.toString();
                                        countVision++;
                                      }
                                    }
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child("backUpData")
                                        .child(user.uid)
                                        .child("visionBoard")
                                        .set(visionBoardMap);
                                  }

                                  // FirebaseDatabase.instance
                                  //     .reference()
                                  //     .child("backUpData")
                                  //     .child(FirebaseAuth
                                  //         .instance.currentUser.uid)
                                  //     .child("visionBoard")
                                  //     .once()
                                  //     .then((DataSnapshot dataSnapshot) {
                                  //   print(dataSnapshot.value ??
                                  //       {}.length ??
                                  //       0);
                                  // });

                                  print('User is signed in!');
                                }
                                // FirebaseAuth.instance
                                //     .authStateChanges()
                                //     .listen((User user) {

                                // });

                                return !(Hive.box("isIntroComplete").get(0) ??
                                        false)
                                    ? InitPage()
                                    : Builder(
                                        builder: (context) =>
                                            DefaultTabController(
                                          length: choices.length,
                                          child: Scaffold(
                                            appBar: AppBar(
                                              actions: <Widget>[
                                                IconButton(
                                                  tooltip: "New Goal",
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: iconHighlight,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed('/addGoal');
                                                  },
                                                ),
                                                IconButton(
                                                  tooltip: "Sync",
                                                  icon: Icon(Icons.sync),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/backupData');
                                                  },
                                                ),
                                                IconButton(
                                                  tooltip: "Settings",
                                                  icon: Icon(Icons.settings),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/settings');
                                                  },
                                                )
                                              ],
                                              title: const Text('Manifest'),
                                              centerTitle: true,
                                              elevation: 0,
                                              bottom: TabBar(
                                                isScrollable: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                tabs: choices
                                                    .map((Choice choice) {
                                                  return Tab(
                                                    text: choice.title,
                                                    // icon: Icon(choice.icon),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            body: TabBarView(
                                              physics: BouncingScrollPhysics(),
                                              children:
                                                  choices.map((Choice choice) {
                                                switch (choice.title) {
                                                  case "Profile":
                                                    return Profile();
                                                    break;
                                                  case "Affirmations":
                                                    return Affirmations();
                                                    break;
                                                  case "Vision Board":
                                                    return VisionBoard();
                                                    break;
                                                  case "POSITV":
                                                    return POSITV();
                                                    break;
                                                  default:
                                                    return Center(
                                                        child: new Text("404"));
                                                }
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                theme: ThemeData(
                  brightness: box.get(0) ? Brightness.dark : Brightness.light,
                  primaryColor: box.get(0) ? primaryDark : secondary,
                  // iconTheme: IconThemeData(color: iconDark),
                  // primaryIconTheme: IconThemeData(color: iconDark),
                  // accentIconTheme: IconThemeData(color: iconDark),
                  accentColor: accent,
                  buttonColor: secondary,
                  scaffoldBackgroundColor:
                      box.get(0) ? backgroundDark : backgroundLight,
                  backgroundColor:
                      box.get(0) ? backgroundDark : backgroundLight,
                  splashColor: accent,
                  // fontFamily: 'Georgia',
                  textTheme: TextTheme(
                      // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                      // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                      // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                      ),
                ),
              );
            });
  }
}
