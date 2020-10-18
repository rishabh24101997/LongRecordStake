import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class CongratulateOnDay extends StatefulWidget {
  @override
  _CongratulateOnDayState createState() => _CongratulateOnDayState();
}

class _CongratulateOnDayState extends State<CongratulateOnDay> {
  var boxDarkMode = Hive.box('darkMode');
  var progressBox = Hive.box('progress');

  int progress;

  String heading;
  String desc;
  String greenText;

  @override
  void initState() {
    progress = progressBox.length == 0 ? 0 : progressBox.get(0);

    switch (progress) {
      case 1:
        progressBox.put(2, false);
        heading = "Congratulations on finishing\n your very first day!";
        desc = "Below is one of the most valuable teaching" +
            " of napoleon hill.  " +
            "There is a difference between WISHING" +
            " for a thing and being READY to receive it." +
            " No one is ready for a thing, until he " +
            "believes he can acquire it. Your state" +
            " of mind must be BELIEF, not mere hope " +
            "or wish. Open-mindedness is essential for" +
            " belief.";
        greenText =
            "“One sound idea is all that one needs to achieve success” " +
                "– Napoleon Hill";
        break;
      case 4:
        // case 0:
        progressBox.put(3, false);
        heading = "Get the best out of your ";
        desc = "We urge you do all the " +
            " activities with utmost Faith. And most " +
            "importantly FEEL that you've already  " +
            "achieved your goal. This is very " +
            "important. Because if you repeat " +
            "sentences without involving feelings you " +
            "will be able to influence your " +
            "Sub-Conscious mind..";
        greenText =
            "A man can only rise, conquer, and achieve by lifting up his thoughts. - James Allen";
        break;
      case 10:
        progressBox.put(4, false);
        heading = "Next 11 day's are crucial...";
        desc = "So, you've done it. You did the hardest " +
            "part, it is said that first 10 days are " +
            "the hardest, next 11 days are crucial. " +
            "You've gained momentum now it's " +
            "important you don't miss any day and " +
            "focus on QUALITY PRACTICE.";
        greenText = "Whatever your mind can conceive" +
            " and believe, it can achieve." +
            " - Napoleon Hill";
        break;
      case 90:
        progressBox.put(5, false);
        heading = "Congratulations on finishing\n" + "your 90th day!";
        desc = "Wooho! 90 days. yes that's how long," +
            "we've come. Truly you're a person of " +
            "consistency. You've formed an invaluable" +
            "habit of training your mind. Many people" +
            "either don't use this gifts given to us by " +
            "nature or uses it occasionally." +
            "Congratulations! Keep dreaming and" +
            "Keep manifesting.";
        greenText =
            "“Every day, stand guard at the door of your mind” " + "– Jim Rohn";
        break;
      default:
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                  padding: EdgeInsets.all(16),
                  // color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 15),
                              child: SizedBox(
                                height: 180,
                                width: double.infinity,
                                child: SvgPicture.asset(
                                  "assets/images/winner.svg",
                                  fit: BoxFit.fitHeight,
                                ),
                              )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 20, 0, 2),
                          child: Text(
                            heading,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 23,
                                color:
                                    boxDarkMode.get(0) ? textDark : textLight,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 20, 0, 2),
                          child: Text(
                            desc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: boxDarkMode.get(0)
                                  ? textSubtitleDark
                                  : textSubtitleLight,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 20, 0, 20),
                          child: Text(
                            greenText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: boxDarkMode.get(0)
                                    ? greenColor
                                    : greenColor,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      RaisedButton(
                        // elevation: 5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        splashColor: accent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "AWESOME",
                          style: TextStyle(color: textDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
