import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';

class AffirmationsCard extends StatefulWidget {
  const AffirmationsCard({
    Key key,
    this.removeCard,
    this.index,
    this.fromIndex,
    this.affirmationsDoneCallback,
    this.isAffirmationsOnlyPractice,
  }) : super(key: key);

  final AffirmationsDoneCallback affirmationsDoneCallback;
  final int fromIndex;
  final int index;
  final RemoveCardCallback removeCard;
  final bool isAffirmationsOnlyPractice;

  @override
  _AffirmationsCardState createState() => _AffirmationsCardState();
}

class _AffirmationsCardState extends State<AffirmationsCard> {
  List affirmations = [];
  var box = Hive.box('affirmations');
  var boxVibration = Hive.box('vibration');
  var boxDarkMode = Hive.box('darkMode');
  int completedTimeOfAffirmation = 0;
  int currAffirmation = 0;
  int fromIndex;
  int progress;
  var repeatCountBox = Hive.box('affirmationRepeatCount');
  // String text;
  int totalAffirmations;
  // int totalAffirmations;
  int totalTimeOfAffirmation = 5;

  AdmobBannerSize bannerSize;

  bool isAffirmationsOnlyPractice;

  @override
  void initState() {
    // TODO: Concert to dynamic
    // totalAffirmations = 5;

    isAffirmationsOnlyPractice = widget.isAffirmationsOnlyPractice ?? false;

    fromIndex = widget.fromIndex;

    if (repeatCountBox.length != 0) {
      totalTimeOfAffirmation = repeatCountBox.get(0);
    }

    // affirmations = [
    //   "My life is filled with joy and abundance ❤",
    //   "I allow only positive and empowering thoughts.",
    //   "I now believe in my self more than ever.",
    //   "Everything happens for greater good.",
    //   "Everything happens for greater good.",
    //   "I now believe in my self more than ever.",
    // ];

    // currAffirmation = widget.fromIndex;
    int count = 0;
    for (var i in box.values.toList()) {
      // print(i);
      if (i != null) {
        if (box.get(widget.fromIndex) == i) {
          currAffirmation = count;
        }
        affirmations.add(i);
        count++;
      }
    }
    totalAffirmations = affirmations.length;

    // affirmations = box.values.toList().sublist(fromIndex);
    // for(var)

    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.BANNER;

    super.initState();
  }

  @override
  void dispose() {
    // interstitialAd.dispose();
    super.dispose();
  }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        // showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        // showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        // showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        // showSnackBar('Admob $adType failed to load.');
        break;
      default:
    }
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
              Container(
                color: boxDarkMode.get(0)
                    ? practiceBackgroundDark
                    : practiceBackgroundLight,
                child: totalAffirmations == 0
                    ? Container(
                        color: secondary,
                        child: SizedBox(
                          height: 200,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: InkWell(
                                  onTap: () {
                                    // print("object");
                                  },
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Container(
                                    width: double.infinity,
                                    color: boxDarkMode.get(0)
                                        ? primaryDark
                                        : primaryLight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 28),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: secondary,
                                                borderRadius:
                                                    BorderRadius.circular(300)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: Text(
                                                  (totalTimeOfAffirmation -
                                                          completedTimeOfAffirmation)
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              affirmations[0],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: boxDarkMode.get(0)
                                                    ? textDark
                                                    : textLight,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30, bottom: 8),
                                            child: Container(
                                              child: LinearProgressIndicator(
                                                value: (currAffirmation) /
                                                    totalAffirmations,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: Text(
                                                (currAffirmation).toString() +
                                                    "/" +
                                                    totalAffirmations
                                                        .toString(),
                                                style: TextStyle(
                                                    color: boxDarkMode.get(0)
                                                        ? boxDarkMode.get(0)
                                                            ? textSubtitleDark
                                                            : textSubtitleLight
                                                        : textSubtitleLight),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            child: widget.index != null
                                                ? RaisedButton(
                                                    elevation: 10,
                                                    splashColor: accent,
                                                    onPressed: () {
                                                      // Navigator.of(context).pushNamed('/practice');
                                                      // widget.removeCard(widget.index);
                                                      print(
                                                          "completedTimeOfAffirmation $completedTimeOfAffirmation");
                                                      print(
                                                          "totalTimeOfAffirmation $totalTimeOfAffirmation");
                                                      // print("completedTimeOfAffirmation $completedTimeOfAffirmation");
                                                      if (affirmations.length ==
                                                              1 &&
                                                          (completedTimeOfAffirmation ==
                                                              totalTimeOfAffirmation -
                                                                  1)) {
                                                        Vibration.vibrate(
                                                            duration:
                                                                boxVibration
                                                                        .get(0)
                                                                    ? 300
                                                                    : 0);
                                                        widget.removeCard(
                                                            widget.index);
                                                      } else if (affirmations
                                                                  .length >
                                                              1 ||
                                                          (completedTimeOfAffirmation <
                                                              totalTimeOfAffirmation -
                                                                  1)) {
                                                        setState(() {
                                                          if (completedTimeOfAffirmation <
                                                              totalTimeOfAffirmation -
                                                                  1) {
                                                            completedTimeOfAffirmation++;
                                                            // currAffirmation++;
                                                          } else {
                                                            completedTimeOfAffirmation =
                                                                0;
                                                            currAffirmation++;
                                                            affirmations
                                                                .removeAt(0);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Text("Affirm",
                                                        style: TextStyle(
                                                            color: textDark)),
                                                  )
                                                : RaisedButton(
                                                    elevation: 10,
                                                    splashColor: accent,
                                                    onPressed: () {
                                                      if (affirmations.length ==
                                                              1 &&
                                                          (completedTimeOfAffirmation ==
                                                              totalTimeOfAffirmation -
                                                                  1)) {
                                                        Vibration.vibrate(
                                                            duration:
                                                                boxVibration
                                                                        .get(0)
                                                                    ? 300
                                                                    : 0);
                                                        Navigator.of(context)
                                                            .pop();
                                                        widget
                                                            .affirmationsDoneCallback();
                                                      } else if (affirmations
                                                                  .length >
                                                              1 ||
                                                          (completedTimeOfAffirmation <
                                                              totalTimeOfAffirmation -
                                                                  1)) {
                                                        setState(() {
                                                          if (completedTimeOfAffirmation <
                                                              totalTimeOfAffirmation -
                                                                  1) {
                                                            completedTimeOfAffirmation++;
                                                            // currAffirmation++;
                                                          } else {
                                                            completedTimeOfAffirmation =
                                                                0;
                                                            currAffirmation++;
                                                            affirmations
                                                                .removeAt(0);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Text("Affirm",
                                                        style: TextStyle(
                                                            color: textDark)),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Repeat count"),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton<int>(
                                value: totalTimeOfAffirmation,
                                // icon: Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                // style: TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: secondary,
                                ),
                                onChanged: (int newValue) {
                                  setState(() {
                                    repeatCountBox.put(0, newValue);
                                    totalTimeOfAffirmation = newValue;
                                  });
                                },
                                items: <int>[1, 3, 5, 7]
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                              ),
                            ],
                          )
                        ],
                      ),
              ),
              !isAffirmationsOnlyPractice
                  ? Container()
                  : Container(
                      height: 70,
                      // color: Colors.red,
                      child: AdmobBanner(
                        adUnitId: getBannerAdUnitId(),
                        adSize: bannerSize,
                        listener:
                            (AdmobAdEvent event, Map<String, dynamic> args) {
                          handleEvent(event, args, 'Banner');
                        },
                        onBannerCreated: (AdmobBannerController controller) {
                          // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                          // Normally you don't need to worry about disposing this yourself, it's handled.
                          // If you need direct access to dispose, this is your guy!
                          // controller.dispose();
                        },
                      ),
                      // color: Colors.red,
                    )
            ],
          ),
        ),
      ),
    );

    // return
  }
}

typedef RemoveCardCallback = Future<void> Function(int index);
typedef AffirmationsDoneCallback = void Function();
