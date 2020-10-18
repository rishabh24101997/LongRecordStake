import 'dart:io';
import 'package:Manifest/Models/vision_board_item.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:vibration/vibration.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class VisionBoardCard extends StatefulWidget {
  const VisionBoardCard({
    Key key,
    this.removeCard,
    this.index,
  }) : super(key: key);

  final RemoveCardCallback removeCard;
  final int index;

  @override
  _VisionBoardCardState createState() => _VisionBoardCardState();
}

class _VisionBoardCardState extends State<VisionBoardCard> {
  var box = Hive.box('visionBoard');
  var boxDarkMode = Hive.box('darkMode');
  var boxVibration = Hive.box('vibration');

  int progress;
  // String text;
  int totalAffirmations;

  // int totalAffirmations;
  int currIndex = 0;
  int length;

  List visionBoardList = [];

  @override
  void initState() {
    // TODO: Concert to dynamic
    // totalAffirmations = 5;

    for (var i in box.values.toList()) {
      // print(i);
      if (i != null) {
        visionBoardList.add(VisionBoardItem(image: i[1], title: i[0]));
      }
    }

    // visionBoardList = [
    //   VisionBoardItem(
    //       title: "My life is filled with joy and abundance 🧡",
    //       image: "https://i.ytimg.com/vi/uojqV6hUEDc/maxresdefault.jpg"),
    //   VisionBoardItem(
    //       title: "I allow only positive and empowering thoughts",
    //       image:
    //           "https://flutterawesome.com/content/images/2019/09/flutter-icons.jpg"),
    //   VisionBoardItem(
    //       title: "I know I believe in myself more than ever",
    //       image:
    //           "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRfcr_0hBqMkgS-YtS28Hsm0qi7f7fuFR6O_Q&usqp=CAU"),
    //   VisionBoardItem(
    //       title: "Everything happens for greater good",
    //       image: "https://i.ytimg.com/vi/uojqV6hUEDc/maxresdefault.jpg"),
    //   VisionBoardItem(
    //       title: "Everything is happening for good reason",
    //       image: "https://i.ytimg.com/vi/uojqV6hUEDc/maxresdefault.jpg"),
    // ];
    length = visionBoardList.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return length == 0
        ? Container(
            color: secondary,
            child: SizedBox(
              height: 800,
            ),
          )
        : Container(
            height: double.infinity - 100,
            color: boxDarkMode.get(0)
                ? practiceBackgroundDark
                : practiceBackgroundLight,
            child: Center(
              child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

                child: Column(
                  children: [
                    Container(
                      color: boxDarkMode.get(0)
                          ? practiceBackgroundDark
                          : practiceBackgroundLight,
                      child: ValueListenableBuilder(
                        valueListenable: box.listenable(),
                        builder: (BuildContext context, value, Widget child) {
                          return Container(
                            color: boxDarkMode.get(0)
                                ? practiceBackgroundDark
                                : practiceBackgroundLight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                    elevation: 8,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: InkWell(
                                        onTap: () {
                                          print("object");
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              color: boxDarkMode.get(0)
                                                  ? primaryDark
                                                  : primaryLight,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                          child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                            // minHeight: 5.0,
                                                            // minWidth: 5.0,
                                                            maxHeight: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                1.8,
                                                            maxWidth: 30.0,
                                                          ),
                                                          child: Image.file(
                                                            File(visionBoardList[
                                                                    currIndex]
                                                                .image),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              color: boxDarkMode.get(0)
                                                  ? primaryDark
                                                  : primaryLight,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          visionBoardList[
                                                                  currIndex]
                                                              .title,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: boxDarkMode
                                                                      .get(0)
                                                                  ? textDark
                                                                  : textLight,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
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
                                Row(
                                  mainAxisAlignment: currIndex != 0
                                      ? MainAxisAlignment.spaceAround
                                      : MainAxisAlignment.center,
                                  children: <Widget>[
                                    currIndex != 0
                                        ? RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (currIndex != 0) {
                                                  currIndex--;
                                                }
                                              });
                                            },
                                            // splashColor: accentDark,
                                            child: Text("Previous",
                                                style:
                                                    TextStyle(color: textDark)),
                                          )
                                        : Container(),
                                    RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (currIndex < length - 1) {
                                            currIndex++;
                                          } else if (currIndex == length - 1) {
                                            Vibration.vibrate(
                                                duration: boxVibration.get(0)
                                                    ? 600
                                                    : 0);
                                            widget.removeCard(widget.index);
                                          }
                                        });
                                      },
                                      // splashColor: accentDark,
                                      child: currIndex == length - 1
                                          ? Text("Done",
                                              style: TextStyle(color: textDark))
                                          : Text("Next",
                                              style:
                                                  TextStyle(color: textDark)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

    // return
  }
}

typedef RemoveCardCallback = Future<void> Function(int index);
