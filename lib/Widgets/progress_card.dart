import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:Manifest/Widgets/progress_bar.dart';
import 'package:Manifest/Screens/progress_info.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ProgressCard extends StatefulWidget {
  const ProgressCard({
    Key key,
  }) : super(key: key);

  @override
  _ProgressCardState createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  int progress;
  String text;
  int total;
  var box = Hive.box("progress");
  var boxDarkMode = Hive.box('darkMode');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('progress').listenable(),
        builder: (context, box, _) {
          progress = box.length == 0 ? 0 : int.parse(box.get(0).toString());
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
                  // onTap: () {
                  //   print("object");
                  // },
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                    "My Progress",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: boxDarkMode.get(0)
                                          ? textDark
                                          : textLight,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  // enableFeedback: true,
                                  padding: EdgeInsets.all(8),
                                  // splashColor: accentDark,
                                  // hoverColor: accentDark,
                                  color: boxDarkMode.get(0)
                                      ? iconCardDark
                                      : iconCardLight,
                                  icon: Icon(Icons.info_outline),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProgressInfo(),
                                        ));
                                  },
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  // "Since 10/6/2020",
                                  "Since ${Hive.box("progress").get(1).day}/${Hive.box("progress").get(1).month}/${Hive.box("progress").get(1).year}",
                                  style: TextStyle(
                                    color: boxDarkMode.get(0)
                                        ? boxDarkMode.get(0)
                                            ? textSubtitleDark
                                            : textSubtitleLight
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
                          color:
                              boxDarkMode.get(0) ? dividerDark : dividerLight,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                                child: Container(
                                    // color: boxDarkMode.get(0) ? textDark : textLight,
                                    child: Column(
                                  children: <Widget>[
                                    Text(
                                      progress.toString(),
                                      style: TextStyle(
                                          color: secondary, fontSize: 25),
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
                                          total: 21, text: "Building a habit"),
                                      ProgressBar(
                                          total: 91,
                                          text:
                                              "Make it part of your lifestyle"),
                                      ProgressBar(
                                          total: 365,
                                          text: "Keeping it real for a year"),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: RaisedButton(
                                              // elevation: 10,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 9),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              splashColor: accent,
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamed('/practice');
                                              },
                                              child: Text(
                                                "START PRACTICE",
                                                style:
                                                    TextStyle(color: textDark),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
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
          );
        });
  }
}
