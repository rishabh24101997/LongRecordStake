import 'package:Manifest/Screens/add_goal.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Manifest/Widgets/toast.dart';
import 'package:Manifest/Screens/goal_info.dart';

class GoalCard extends StatefulWidget {
  const GoalCard({
    Key key,
  }) : super(key: key);

  @override
  _GoalCardState createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  var box = Hive.box('goals');
  var boxDarkMode = Hive.box('darkMode');
  // List goals;

  int currIndex = 0;
  CustomToast _toast = CustomToast();

  @override
  void initState() {
    // var list = box.values;
    // print("Length");
    // print(
    //     list.contains(["This is my primary goal", "This is my primary plan"]));
    // var newList = list.toList(growable: true);
    // print(newList[0][0]);
    // list.toSet()
    // for (var i in list) {
    //   print(i.runtimeType);
    // }
    // print(list[0]);
    // box.put(0, ["This is my primary goal", "This is my primary plan"])
    // box.put(1, ["This is my first goal", "This is my first plan"]);
    // box.put(2, ["This is my second goal", "This is my second plan"]);
    // box.deleteFromDisk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('goals').listenable(),
      builder: (context, box, widget) {
        box.length == 0
            ? box.put(0, ["This is my primary goal", "This is my primary plan"])
            : null;
        // int count = 0;
        List goals = [];
        for (var i in box.values.toList()) {
          // print(i);
          if (i != null) {
            // if (box.get(index) == i) {
            //   currAffirmation = count;
            // }
            goals.add(i);
            // count++;
          }
        }
        // print("Contains: " + box.)
        currIndex = currIndex >= goals.length ? currIndex - 1 : currIndex;
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
                onLongPress: () {
                  // currIndex == 0
                  //     ? _toast.showToast(context, Icons.close,
                  //         "You can't edit your primary goal", accent)
                  //     :
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            currIndex == 0
                                ? "Do you want to edit your goal?"
                                : "Alert!",
                            style: TextStyle(fontWeight: FontWeight.w700),
                            maxLines: 2,
                          ),
                          content: Text(
                              "Do not keep changing your goal, it is recommended that you stick to one. Doesn't matter whether you believe, you can achieve it or not, right now"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: accent,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: accent,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddGoal(
                                        isEdit: true,
                                        index: currIndex,
                                      ),
                                    ));
                              },
                            )
                          ],
                        );
                      });
                  // print("sjnc");
                },
                onTap: () {
                  setState(() {
                    if (currIndex < goals.length - 1) {
                      currIndex++;
                    } else {
                      currIndex = 0;
                    }
                  });
                  // print(box.get(currIndex)[0]);
                },
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
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 2),
                                  child: Text(
                                    currIndex == 0 ? "Primary Goal" : "My Goal",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: boxDarkMode.get(0)
                                          ? textDark
                                          : textLight,
                                    ),
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
                                        builder: (context) => GoalInfo(),
                                      ));
                                },
                              )
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
                        color: boxDarkMode.get(0) ? dividerDark : dividerLight,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  goals[currIndex][0],
                                  style: TextStyle(
                                      color: secondary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
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
                        color: boxDarkMode.get(0) ? dividerDark : dividerLight,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  goals[currIndex][1],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: boxDarkMode.get(0)
                                          ? textSubtitleDark
                                          : textSubtitleLight,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
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
        );
      },
    );
  }
}
