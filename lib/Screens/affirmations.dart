import 'package:Manifest/Screens/add_affirmation.dart';
import 'package:Manifest/Screens/affirmations_info.dart';
import 'package:Manifest/Widgets/activity_done_card.dart';
import 'package:Manifest/Widgets/affirmations_card.dart';
// import 'package:Manifest/Widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
// import 'package:flutter_svg/svg.dart';

class Affirmations extends StatefulWidget {
  @override
  _AffirmationsState createState() => _AffirmationsState();
}

class _AffirmationsState extends State<Affirmations> {
  var box = Hive.box('affirmations');
  var boxDarkMode = Hive.box('darkMode');
  // CustomToast _toast = CustomToast();

  // List affirmationsList = [
  //   "My life is filled with joy and abundance ❤",
  //   "I allow only positive and empowering thoughts.",
  //   "I now believe in my self more than ever.",
  //   "Everything happens for greater good.",
  //   "Everything happens for greater good.",
  //   "I now believe in my self more than ever.",
  // ];

  bool isAffirmationsDone = false;

  void affirmationsDoneCallback() {
    setState(() {
      isAffirmationsDone = true;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (Scaffold(
              body: SafeArea(
            child: ActivityDoneCard(
              affirmationsResetCallback: affirmationsResetCallback,
              title: "Affirmations done!",
              desc:
                  "Affirmations are the best way to reprogram the subconscious mind.\n Affirmations make us believe certain things about ourselves or about the world.\n *Our actions largely depends on what we believe about ourselves or what we believe can achieve.",
            ),
          ))),
        ));
  }

  void affirmationsResetCallback() {
    setState(() {
      isAffirmationsDone = false;
    });
  }

  @override
  void initState() {
    // box.clear();
    super.initState();
    // box.deleteFromDisk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAffirmation(),
              ));
        },
        child: Icon(Icons.add),
        heroTag: "affirmation",
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('affirmations').listenable(),
        builder: (BuildContext context, value, Widget child) {
          int count = 0;
          for (var i in value.values.toList()) {
            // print(i);
            if (i != null) {
              // if (box.get(widget.fromIndex) == i) {
              //   currAffirmation = count;
              // }
              // affirmations.add(i);
              count++;
            }
          }

          // int count = 0;
          // for (var i in box.values.toList()) {
          //   // print(i);
          //   if (i != null) {
          //     // if (box.get(index) == i) {
          //     //   currAffirmation = count;
          //     // }
          //     // affirmations.add(i);
          //     count++;
          //   }
          // }
          // print("Count" + count.toString());
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tap on any affirmation to begin",
                        style: TextStyle(
                            color: boxDarkMode.get(0)
                                ? boxDarkMode.get(0)
                                    ? textSubtitleDark
                                    : textSubtitleLight
                                : textSubtitleLight),
                      ),
                      IconButton(
                        // enableFeedback: true,
                        // padding: EdgeInsets.all(8),
                        // splashColor: accentDark,
                        // hoverColor: accentDark,
                        color:
                            boxDarkMode.get(0) ? iconCardDark : iconCardLight,
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AffirmationsInfo(),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      child: count == 0
                          ? Padding(
                              padding: const EdgeInsets.all(45),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Image.asset(
                                        "assets/images/noitemsaffirmations.png"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "No items in Affirmations \nTap the button to add some😄",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: boxDarkMode.get(0)
                                                ? textDark
                                                : textLight,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                            )
                          : Container()),
                ),
              ),
              // count == 0
              //     ? Container(
              //         child: Expanded(
              //           child: SvgPicture.asset(
              //             "assets/images/noData.svg",
              //           ),
              //         ),
              //       )
              //     :
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return value.get(index) != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: index != 0
                                  ? SizedBox(
                                      height: 2,
                                      child: Container(
                                        color: boxDarkMode.get(0)
                                            ? dividerDark
                                            : dividerLight,
                                      ),
                                    )
                                  : Container(),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: InkWell(
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Do you want to delete your affirmation?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                            maxLines: 2,
                                          ),
                                          content: Text(value.get(index) ?? ""),
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
                                                "Delete",
                                                style: TextStyle(
                                                  color: warningColor,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                value.put(index, null);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                  // print("sjnc");
                                },
                                borderRadius: BorderRadius.circular(5),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => (Scaffold(
                                            body: SafeArea(
                                          child: true
                                              // !isAffirmationsDone
                                              ? AffirmationsCard(
                                                  affirmationsDoneCallback:
                                                      affirmationsDoneCallback,
                                                      isAffirmationsOnlyPractice: true,
                                                  // fromIndex: index,
                                                  fromIndex: 0,
                                                )
                                              : ActivityDoneCard(
                                                  affirmationsResetCallback:
                                                      affirmationsResetCallback,
                                                  title: "Affirmations done!",
                                                  desc:
                                                      "Affirmations are the best way to reprogram the subconscious mind.\n Affirmations make us believe certain things about ourselves or about the world.\n *Our actions largely depends on what we believe about ourselves or what we believe can achieve.",
                                                ),
                                        ))),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: SizedBox(
                                    child: Text(
                                      value.get(index) ?? "",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container();
                }, childCount: value.length),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 2,
                    child: Container(
                      color: count == 0
                          ? Colors.transparent
                          : boxDarkMode.get(0) ? dividerDark : dividerLight,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
