import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';

class PracticeInstructionsCard extends StatefulWidget {
  const PracticeInstructionsCard({
    Key key,
    this.removeCard,
    this.index,
    this.firstLine,
    this.secondLine,
    this.thirdLine,
    this.descLine,
    this.activityNo,
    this.title,
  }) : super(key: key);

  final RemoveCardCallback removeCard;
  final int index;
  final String title;
  final String activityNo;
  final String firstLine;
  final String secondLine;
  final String thirdLine;
  final String descLine;

  @override
  _PracticeInstructionsCardState createState() =>
      _PracticeInstructionsCardState();
}

class _PracticeInstructionsCardState extends State<PracticeInstructionsCard> {
  int progress;
  String text;
  int total;
  var boxDarkMode = Hive.box('darkMode');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "startPractice",
      child: Center(
        child: Container(
          color: boxDarkMode.get(0)
              ? practiceBackgroundDark
              : practiceBackgroundLight,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                        "#Activity ${widget.activityNo}",
                        style: TextStyle(fontSize: 16, color: textDark),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    elevation: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          // print("object");
                        },
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          width: double.infinity,
                          color:
                              boxDarkMode.get(0) ? primaryDark : primaryLight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 28),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: secondary,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.firstLine,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: boxDarkMode.get(0)
                                            ? boxDarkMode.get(0)
                                                ? textSubtitleDark
                                                : textSubtitleLight
                                            : textSubtitleLight,
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.secondLine,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: boxDarkMode.get(0)
                                            ? boxDarkMode.get(0)
                                                ? textSubtitleDark
                                                : textSubtitleLight
                                            : textSubtitleLight,
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.thirdLine,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: boxDarkMode.get(0)
                                            ? boxDarkMode.get(0)
                                                ? textSubtitleDark
                                                : textSubtitleLight
                                            : textSubtitleLight,
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.descLine,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: boxDarkMode.get(0)
                                            ? boxDarkMode.get(0)
                                                ? textSubtitleDark
                                                : textSubtitleLight
                                            : textSubtitleLight,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  child: RaisedButton(
                                    elevation: 10,
                                    splashColor: accent,
                                    onPressed: () {
                                      // Navigator.of(context).pushNamed('/practice');
                                      widget.removeCard(widget.index);
                                    },
                                    child: Text("START NOW",
                                        style: TextStyle(color: textDark)),
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(bottom: 16),
                                //   color: boxDarkMode.get(0) ? primaryDark:primaryLight,
                                //   child: Container(
                                //     child: Column(
                                //       children: <Widget>[],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // return
  }
}

typedef RemoveCardCallback = Future<void> Function(int index);
