import 'package:Manifest/Theme/theme.dart';
import 'package:Manifest/Widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class InitSetup extends StatefulWidget {
  @override
  _InitSetupState createState() => _InitSetupState();
}

class _InitSetupState extends State<InitSetup> {
  var box = Hive.box('goals');
  var boxDarkMode = Hive.box('darkMode');
  String goal;
  TextEditingController goalController;
  String morningTime;
  String nightTime;
  String plan;
  TextEditingController planController;

  CustomToast _toast = CustomToast();

  @override
  void initState() {
    goalController = TextEditingController();
    planController = TextEditingController();
    goal = "";
    plan = "";
    morningTime = "";
    nightTime = "";
    goalController.value = TextEditingValue(text: goal);
    planController.value = TextEditingValue(text: plan);

    super.initState();
  }

  Widget getStarted() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Card(
        color: boxDarkMode.get(0) ? primaryDark : primaryLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: greenColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              "Get Started",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Set a Definite Goal and the exact date you want to achieve it.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget greatExample() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Card(
        color: boxDarkMode.get(0) ? primaryDark : primaryLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Here's a great example!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 2,
                      child: Container(
                        color: boxDarkMode.get(0)
                            ? practiceBackgroundDark
                            : practiceBackgroundLight,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "By May 10th 2021, I will have in my possession \$100K. To achieve my goal, I will be doing my best as a content creator and provide value to the people. \n\nOr \n\nBy 5th July 2021, I will be losing 25Ibs weight. To achieve my goal I will give my best in the gym and I will follow a strict diet.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addGoalCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            padding: EdgeInsets.all(16),
            color: boxDarkMode.get(0) ? primaryDark : primaryLight,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: "affirmation",
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: SvgPicture.asset(
                        "assets/images/mind.svg",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Add a new goal!🚀",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Your Goal",
                      style: TextStyle(fontSize: 20, color: secondary),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        goal = value;
                      });
                    },
                    controller: goalController,
                    scrollPhysics: BouncingScrollPhysics(),
                    minLines: 2,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    cursorColor: secondary,
                    decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText:
                            '(example) By Dec 31st I will have in my possession \$100k)'),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Plan to achieve it",
                      style: TextStyle(fontSize: 20, color: secondary),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: TextField(
                    scrollPhysics: BouncingScrollPhysics(),
                    minLines: 2,
                    maxLines: 4,
                    controller: planController,
                    onChanged: (value) {
                      setState(() {
                        plan = value;
                      });
                    },
                    keyboardType: TextInputType.multiline,
                    cursorColor: secondary,
                    decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText:
                            '(example) To achieve my goal, I\'ll be doing my best as a digital marketer and will give mu absolute best'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Note - You can add more goals later",
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget setTimeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 15),
                            child: Icon(
                              Icons.access_time,
                              size: 100,
                              color: Colors.tealAccent,
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Text(
                          "Reminder for daily practice",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.tealAccent,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    morningTime == ""
                        ? Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                "Wake-Up time",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: boxDarkMode.get(0)
                                        ? textDark
                                        : textLight,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                morningTime,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: boxDarkMode.get(0)
                                        ? textDark
                                        : textLight,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: RaisedButton(
                              child: Text(
                                "Change",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    // color: Colors.tealAccent,
                                    fontWeight: FontWeight.w800),
                              ),
                              onPressed: () {
                                var box = Hive.box('morningTime');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          floatingActionButton:
                                              FloatingActionButton(
                                                  child: Icon(Icons.done),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                          appBar: AppBar(
                                            title: Text("Change Wake-Up Time"),
                                          ),
                                          body: CupertinoDatePicker(
                                            // minimumDate: today,
                                            initialDateTime:
                                                box.get(0) ?? DateTime.now(),
                                            minuteInterval: 1,
                                            backgroundColor: primaryLight,
                                            mode: CupertinoDatePickerMode.time,
                                            onDateTimeChanged:
                                                (DateTime dateTime) {
                                              setState(() {
                                                morningTime = dateTime.hour
                                                        .toString() +
                                                    ":" +
                                                    dateTime.minute.toString() +
                                                    " @morning";
                                              });
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
                                              var time = Time(dateTime.hour,
                                                  dateTime.minute, 00);
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
                                                  .then(
                                                      (value) => print("Done"));
                                              box.put(0, dateTime);
                                            },
                                          ),
                                        )));
                              })),
                    ),
                    nightTime == ""
                        ? Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Text(
                                "Sleep time",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: boxDarkMode.get(0)
                                        ? textDark
                                        : textLight,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                nightTime,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: boxDarkMode.get(0)
                                        ? textDark
                                        : textLight,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: RaisedButton(
                              child: Text(
                                "Change",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    // color: Colors.tealAccent,
                                    fontWeight: FontWeight.w800),
                              ),
                              onPressed: () {
                                var box = Hive.box('nightTime');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          floatingActionButton:
                                              FloatingActionButton(
                                                  child: Icon(Icons.done),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                          appBar: AppBar(
                                            title: Text("Change Sleep Time"),
                                          ),
                                          body: CupertinoDatePicker(
                                            // minimumDate: today,
                                            initialDateTime:
                                                box.get(0) ?? DateTime.now(),
                                            minuteInterval: 1,
                                            backgroundColor: primaryLight,
                                            mode: CupertinoDatePickerMode.time,
                                            onDateTimeChanged:
                                                (DateTime dateTime) {
                                              setState(() {
                                                nightTime = dateTime.hour
                                                        .toString() +
                                                    ":" +
                                                    dateTime.minute.toString() +
                                                    " @night";
                                              });
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
                                              var time = Time(dateTime.hour,
                                                  dateTime.minute, 00);
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
                                                  .then(
                                                      (value) => print("Done"));
                                              box.put(0, dateTime);
                                            },
                                          ),
                                        )));
                              })),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // RaisedButton(
                    //     child: Text(
                    //       "Get Started",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           fontSize: 17,
                    //           // color: Colors.tealAccent,
                    //           fontWeight: FontWeight.w800),
                    //     ),
                    //     onPressed: () {}),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        // padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Important Note : It is recommended to do the practice given here first thing in the morning after you wake up and last thing before you sleep. Set the remainder accordingly!",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          onPressed: () {
            if (goal.length < 10 || plan.length < 10) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Alert!",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      content: Text(
                          "Length of Goals and Plans must be greater than 10!"),
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
                    );
                  });
              return;
            }

            if (morningTime == "") {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Alert!",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      content: Text("Please select Wake-Up time"),
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
                    );
                  });
              return;
            }

            if (nightTime == "") {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Alert!",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      content: Text("Please select Sleep time"),
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
                    );
                  });
              return;
            }

            box.put(0, [goal, plan]);
            Hive.box("isIntroComplete").put(0, true);
            Hive.box("progress").put(1, DateTime.now());
            Hive.box("affirmations").put(Hive.box("affirmations").length,
                "My thoughts and feelings are nourishing");
            Hive.box("affirmations").put(Hive.box("affirmations").length,
                "I allow only positive and empowering thoughts");
            Hive.box("affirmations").put(Hive.box("affirmations").length,
                "I find opportunities to be kind and caring everywhere I look");
            Hive.box("affirmations").put(Hive.box("affirmations").length,
                "Life is full of love and I find it everywhere I go");
            _toast.showToast(
                context, Icons.done, "Setup Complete🎉", greenColor);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                getStarted(),
                greatExample(),
                addGoalCard(),
                setTimeCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
