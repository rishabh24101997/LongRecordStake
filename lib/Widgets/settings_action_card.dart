import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class SettingsActionCard extends StatefulWidget {
  const SettingsActionCard(
      {Key key, this.hasSwitch, this.icon, this.title, this.isWarning})
      : super(key: key);

  final bool hasSwitch;
  final bool isWarning;
  final Icon icon;
  final String title;

  @override
  _SettingsActionCardState createState() => _SettingsActionCardState();
}

class _SettingsActionCardState extends State<SettingsActionCard> {
  bool isSwitchOn = false;
  var boxDarkMode = Hive.box('darkMode');
  @override
  void initState() {
    super.initState();
  }

  changeSwitchValue(bool value) {
    var box;
    switch (widget.title.trim()) {
      case "Dark Mode":
        box = Hive.box('darkMode');
        break;

      case "Vibration":
        box = Hive.box('vibration');
        break;
      default:
    }
    box.put(0, value);
    // setState(() {
    //   isSwitchOn = value;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.title == "Dark Mode"
            ? Hive.box('darkMode').listenable()
            : Hive.box('vibration').listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: InkWell(
                  onTap: () {
                    switch (widget.title.trim()) {
                      case "Dark Mode":
                        break;
                      case "Vibration":
                        break;
                      case "Change Morning Time":
                        var box = Hive.box('morningTime');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  floatingActionButton: FloatingActionButton(
                                      child: Icon(Icons.done),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                  appBar: AppBar(
                                    title: Text("Change Morning Time"),
                                  ),
                                  body: CupertinoDatePicker(
                                    // minimumDate: today,
                                    initialDateTime:
                                        box.get(0) ?? DateTime.now(),
                                    minuteInterval: 1,
                                    backgroundColor: primaryLight,
                                    mode: CupertinoDatePickerMode.time,
                                    onDateTimeChanged: (DateTime dateTime) {
                                      FlutterLocalNotificationsPlugin
                                          flutterLocalNotificationsPlugin =
                                          FlutterLocalNotificationsPlugin();
                                      flutterLocalNotificationsPlugin
                                          .resolvePlatformSpecificImplementation<
                                              IOSFlutterLocalNotificationsPlugin>()
                                          ?.requestPermissions(
                                            alert: true,
                                            badge: true,
                                            sound: true,
                                          );
                                      var time = Time(
                                          dateTime.hour, dateTime.minute, 00);
                                      var androidPlatformChannelSpecifics =
                                          AndroidNotificationDetails(
                                        'repeatDailyAtTime channel id',
                                        'repeatDailyAtTime channel name',
                                        'repeatDailyAtTime description',
                                        importance: Importance.Max,
                                        priority: Priority.High,
                                      );
                                      var iOSPlatformChannelSpecifics =
                                          IOSNotificationDetails();
                                      var platformChannelSpecifics =
                                          NotificationDetails(
                                              androidPlatformChannelSpecifics,
                                              iOSPlatformChannelSpecifics);
                                      flutterLocalNotificationsPlugin
                                          .showDailyAtTime(
                                              14,
                                              'Daily Practice Reminder',
                                              'Take out some time for what\'s most important to you in life',
                                              time,
                                              platformChannelSpecifics)
                                          .then((value) => print("Done"));
                                      box.put(0, dateTime);
                                    },
                                  ),
                                )));

                        break;
                      case "Change Night Time":
                        var box = Hive.box('nightTime');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  floatingActionButton: FloatingActionButton(
                                      child: Icon(Icons.done),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                  appBar: AppBar(
                                    title: Text("Change Night Time"),
                                  ),
                                  body: CupertinoDatePicker(
                                    // minimumDate: today,
                                    initialDateTime:
                                        box.get(0) ?? DateTime.now(),
                                    minuteInterval: 1,
                                    backgroundColor: primaryLight,
                                    mode: CupertinoDatePickerMode.time,
                                    onDateTimeChanged: (DateTime dateTime) {
                                      FlutterLocalNotificationsPlugin
                                          flutterLocalNotificationsPlugin =
                                          FlutterLocalNotificationsPlugin();
                                      flutterLocalNotificationsPlugin
                                          .resolvePlatformSpecificImplementation<
                                              IOSFlutterLocalNotificationsPlugin>()
                                          ?.requestPermissions(
                                            alert: true,
                                            badge: true,
                                            sound: true,
                                          );
                                      var time = Time(
                                          dateTime.hour, dateTime.minute, 00);
                                      var androidPlatformChannelSpecifics =
                                          AndroidNotificationDetails(
                                        'repeatDailyAtTime channel id',
                                        'repeatDailyAtTime channel name',
                                        'repeatDailyAtTime description',
                                        importance: Importance.Max,
                                        priority: Priority.High,
                                      );
                                      var iOSPlatformChannelSpecifics =
                                          IOSNotificationDetails();
                                      var platformChannelSpecifics =
                                          NotificationDetails(
                                              androidPlatformChannelSpecifics,
                                              iOSPlatformChannelSpecifics);
                                      flutterLocalNotificationsPlugin
                                          .showDailyAtTime(
                                              15,
                                              'Daily Practice Reminder',
                                              'Take out some time for what\'s most important to you in life',
                                              time,
                                              platformChannelSpecifics)
                                          .then((value) => print("Done"));
                                      box.put(0, dateTime);
                                    },
                                  ),
                                )));
                        break;
                      case "Add Goal":
                        Navigator.of(context).pushNamed('/addGoal');
                        break;
                      case "Share App":
                        break;
                      // case "Change Start Date":
                      //   var box = Hive.box('startDate');
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => Scaffold(
                      //             appBar: AppBar(
                      //               title: Text("Change Start Date"),
                      //             ),
                      //             body: CupertinoDatePicker(
                      //               // minimumDate: today,
                      //               maximumDate: DateTime.now(),
                      //               initialDateTime: box.get(0) ??
                      //                   DateTime.now()
                      //                       .subtract(Duration(days: 1)),
                      //               // initialDateTime: DateTime.now()
                      //               //     .subtract(Duration(days: 1)),
                      //               minuteInterval: 1,
                      //               backgroundColor: primaryLight,
                      //               mode: CupertinoDatePickerMode.date,
                      //               onDateTimeChanged: (DateTime dateTime) {
                      //                 box.put(0, dateTime);
                      //                 print(dateTime);
                      //               },
                      //             ),
                      //           )));
                      //   break;
                      case "Reset Progress to Day 1":
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Are you sure?",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                content: Text(
                                    "This will set your progress again to day 1 and this change is irreversible."),
                                actions: <Widget>[
                                  FlatButton(
                                    // splashColor: accentDark,
                                    child: Text(
                                      "Close",
                                      style: TextStyle(
                                        color: accent,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    // splashColor: accentDark,
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                        color: warningColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      var box = Hive.box('progress');
                                      box.put(0, 0);
                                      box.put(1, DateTime.now());
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });

                        break;
                      default:
                    }
                  },
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: widget.isWarning ?? false
                                          ? warningColor
                                          : accent,
                                    ),
                                  ),
                                ),
                                widget.hasSwitch
                                    ? CupertinoSwitch(
                                        value: box.get(0),
                                        onChanged: (value) {
                                          changeSwitchValue(value);
                                        },
                                        activeColor: accent)
                                    : widget.icon
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
