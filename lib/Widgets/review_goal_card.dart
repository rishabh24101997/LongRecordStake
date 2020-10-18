import 'package:Manifest/Models/Goals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';

class ReviewGoalCard extends StatefulWidget {
  const ReviewGoalCard({
    Key key,
    this.goal,
    this.changeOpacity,
    this.index,
  }) : super(key: key);

  final Goals goal;
  final ChangeOpcaityCallback changeOpacity;
  final int index;

  @override
  _ReviewGoalCardState createState() => _ReviewGoalCardState();
}

class _ReviewGoalCardState extends State<ReviewGoalCard> {
  int count;
  // double opacity;
  var boxDarkMode = Hive.box('darkMode');
  var boxVibration = Hive.box('vibration');

  @override
  void initState() {
    count = 3;
    super.initState();
    // opacity = widget.opcaity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity - 100,
      color:
          boxDarkMode.get(0) ? practiceBackgroundDark : practiceBackgroundLight,
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // SizedBox(
              //   height: 1000,
              //   child: Container(
              //     color: Colors.red,
              //     height: 1000,
              //   ),
              // ),
              Container(
                // height: 1000,
                color: boxDarkMode.get(0)
                    ? practiceBackgroundDark
                    : practiceBackgroundLight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(35)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 13),
                          child: Text(
                            "Review your goal",
                            style: TextStyle(fontSize: 16, color: textDark),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        elevation: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              color: boxDarkMode.get(0)
                                  ? primaryDark
                                  : primaryLight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    // color: reviewGoalCardColor,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8.0, 0, 0, 2),
                                                child: Text(
                                                  widget.goal.isPrimary
                                                      ? "Primary Goal"
                                                      : "My Goal",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: boxDarkMode.get(0)
                                                        ? textDark
                                                        : textLight,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Icon(
                                            //   Icons.info_outline,
                                            //   color: boxDarkMode.get(0) ? iconCardDark : iconCardLight,
                                            // )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            // Icon(
                                            //   Icons.watch_later,
                                            //   color: Colors.grey[100],
                                            // ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "(I am so happy and grateful now that)",
                                              style: TextStyle(
                                                color: boxDarkMode.get(0)
                                                    ? textSubtitleDark
                                                    : textSubtitleLight,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                    child: Container(
                                      color: boxDarkMode.get(0)
                                          ? dividerDark
                                          : dividerLight,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    color: boxDarkMode.get(0)
                                        ? primaryDark
                                        : primaryLight,
                                    // color: boxDarkMode.get(0) ? primaryDark:primaryLight,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Text(
                                                widget.goal.title,
                                                style: TextStyle(
                                                    color: secondary,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                    child: Container(
                                      color: boxDarkMode.get(0)
                                          ? dividerDark
                                          : dividerLight,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    // color: boxDarkMode.get(0) ? primaryDark:primaryLight,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Text(
                                                widget.goal.desc,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: boxDarkMode.get(0)
                                                        ? textSubtitleDark
                                                        : textSubtitleLight,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: InkWell(
                          splashColor: accent,
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            if (count > 1) {
                              setState(() {
                                count--;
                              });
                              Vibration.vibrate(
                                  duration: boxVibration.get(0) ? 300 : 0);
                            } else if (count == 1) {
                              Vibration.vibrate(
                                  duration: boxVibration.get(0) ? 600 : 0);
                              widget.changeOpacity(widget.index);
                            }
                          },
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Center(
                                  child: Text(
                                count.toString(),
                                style: TextStyle(fontSize: 24, color: textDark),
                              ))),
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
}

typedef ChangeOpcaityCallback = Future<void> Function(int index);
