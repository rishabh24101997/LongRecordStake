import 'package:Manifest/Screens/congratulate_on_day.dart';
import 'package:Manifest/Widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class Progress extends StatefulWidget {
  const Progress({Key key, this.loadInterstitialAdCallback}) : super(key: key);

  final LoadInterstitialAdCallback loadInterstitialAdCallback;

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  var box = Hive.box('progress');
  var boxDarkMode = Hive.box('darkMode');
  bool enjoying = true;
  String feedbackTitle = "Enjoying the Manifest app?";
  DateTime lastDay;
  String leftFeedbackButtonText = "NOT REALLY";
  DateTime oneDayBefore;
  DateTime present;
  String rightFeedbackButtonText = "YES!";
  bool shouldDisplayFeedback = true;
  String sliderEmoji = "🤩"; // Default value is 5 so happy.
  double sliderValue = 5;
  bool toIncrement;

  @override
  void initState() {
    super.initState();
    present = DateTime.now();
    lastDay = box.get(1);
    oneDayBefore = present.subtract(Duration(days: 1));
    // toIncrement = ;
    toIncrement = box.get(0) == 0 ? true : lastDay.isBefore(oneDayBefore);
    // print("present: $present");
    // print("oneDayBefore: $oneDayBefore");
    // print("lastDay: $lastDay");
    // print("ToIncrement: $toIncrement");
  }

  Widget cogratulationsCard() {
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
              print("object");
            },
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
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: SvgPicture.asset(
                                  "assets/images/goal_save.svg",
                                ),
                              )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                          child: Text(
                            "Congratulations!\nYou're one day closer to your goal.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    boxDarkMode.get(0) ? textDark : textLight,
                                fontWeight: FontWeight.w800),
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
      ),
    );
  }

  Widget wordsOfWisdomCard() {
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
              print("object");
            },
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                          child: Text(
                            "Words of wisdom",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: secondary,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 2),
                          child: Text(
                            "Problems are not stop signs, they are guidelines",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 2),
                          child: Text(
                            "Robert H. Schuller",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: boxDarkMode.get(0)
                                    ? boxDarkMode.get(0)
                                        ? textSubtitleDark
                                        : textSubtitleLight
                                    : textSubtitleLight,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
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
      ),
    );
  }

  Widget yourProgressCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: InkWell(
            onTap: () {
              print("object");
            },
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              color: boxDarkMode.get(0) ? primaryDark : primaryLight,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                      child: Text(
                        "Your Progress",
                        style: TextStyle(
                            fontSize: 20,
                            color: secondary,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                    child: Container(
                      color: boxDarkMode.get(0) ? dividerDark : dividerLight,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                            child: Container(
                                // color: boxDarkMode.get(0) ? textDark : textLight,
                                child: Column(
                              children: <Widget>[
                                Text(
                                  box.length == 0
                                      ? "1"
                                      : (box.get(0) + (toIncrement ? 1 : 0))
                                          .toString(),
                                  style:
                                      TextStyle(color: secondary, fontSize: 25),
                                ),
                                SizedBox(height: 7),
                                Text("Days")
                              ],
                            ))),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ProgressBar(
                                      toIncrement: toIncrement,
                                      isPractice: true,
                                      total: 21,
                                      text: "Building a habit"),
                                  ProgressBar(
                                      toIncrement: toIncrement,
                                      isPractice: true,
                                      total: 91,
                                      text: "Make it part of your lifestyle"),
                                  ProgressBar(
                                      toIncrement: toIncrement,
                                      isPractice: true,
                                      total: 365,
                                      text: "Keeping it real for a year"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget feedbackCard() {
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
              print("object");
            },
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                          child: Text(
                            feedbackTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                // color: boxDarkMode.get(0) ? boxDarkMode.get(0) ? textSubtitleDark : textSubtitleLight : textSubtitleLight,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text(leftFeedbackButtonText,
                                    style: TextStyle(color: textDark)),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    if (rightFeedbackButtonText == "YES!") {
                                      leftFeedbackButtonText = "NOT NOW";
                                      rightFeedbackButtonText = "SURE THING!";
                                      feedbackTitle =
                                          "Uh oh! Would you like to send feedback?";
                                    } else {
                                      shouldDisplayFeedback = false;
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                            ),
                            Expanded(
                              child: RaisedButton(
                                child: Text(rightFeedbackButtonText,
                                    style: TextStyle(color: textDark)),
                                color: rightFeedbackButtonText == "YES!"
                                    ? Colors.blue
                                    : greenColor,
                                onPressed: () {
                                  setState(() {
                                    if (rightFeedbackButtonText == "YES!") {
                                      leftFeedbackButtonText = "NOT NOW";
                                      rightFeedbackButtonText = "SURE THING!";
                                      feedbackTitle =
                                          "Awesome! We'd love an App Store review from you";
                                    } else if (enjoying) {
                                      // TODO: Open App Store link.
                                    } else if (!enjoying) {
                                      // TODO: Open
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
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
  }

  Widget saveProgressCard() {
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
            // onTap: () {
            //   print("object");
            // },
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                          child: Text(
                            "It is very important to feel good in this moment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: boxDarkMode.get(0)
                                    ? boxDarkMode.get(0)
                                        ? textSubtitleDark
                                        : textSubtitleLight
                                    : textSubtitleLight,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Negative",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: warningColor,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Amazing",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: greenColor,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 2),
                            child: Slider(
                              activeColor: accent,
                              // inactiveColor: buttonColor,
                              min: 1,
                              max: 5,
                              divisions: 4,
                              label: sliderEmoji,
                              value: sliderValue,
                              onChanged: (value) {
                                setState(() {
                                  sliderValue = value;
                                  switch (sliderValue.toInt()) {
                                    case 1:
                                      sliderEmoji = "☹";
                                      break;
                                    case 2:
                                      sliderEmoji = "😐";
                                      break;
                                    case 3:
                                      sliderEmoji = "😀";
                                      break;
                                    case 4:
                                      sliderEmoji = "😃";
                                      break;
                                    case 5:
                                      sliderEmoji = "🤩";
                                      break;
                                    default:
                                  }
                                });
                              },
                            )),
                      ),
                      RaisedButton(
                        child: Text("SAVE PROGRESS",
                            style: TextStyle(color: textDark)),
                        onPressed: () {
                          int value = box.length == 0
                              ? 1
                              : int.parse(box.get(0).toString()) + 1;

                          if (toIncrement) {
                            box.put(0, value);
                            box.put(1, DateTime.now());
                          }
                          Navigator.of(context).pop();
                          int progress = box.get(0);
                          // box.get(2): Here 2 = 1st day
                          // box.get(3): Here 3 = 4th day
                          // box.get(4): Here 4 = 10th day
                          // box.get(5): Here 5 = 90th day
                          print("Box 2: ${box.get(2)}");
                          if ((progress == 1 && (box.get(2) ?? true)) ||
                              (progress == 4 && (box.get(3) ?? true)) ||
                              (progress == 10 && (box.get(4) ?? true)) ||
                              (progress == 90 && (box.get(5) ?? true))) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CongratulateOnDay()));
                          }
                            widget.loadInterstitialAdCallback();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          cogratulationsCard(),
          wordsOfWisdomCard(),
          yourProgressCard(),
          shouldDisplayFeedback ? feedbackCard() : Container(),
          saveProgressCard(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    )));
  }
}

typedef LoadInterstitialAdCallback = Function();
