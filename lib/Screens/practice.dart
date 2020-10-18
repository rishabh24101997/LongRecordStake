import 'dart:io';

import 'package:Manifest/Models/Goals.dart';
import 'package:Manifest/Screens/affirmations_info.dart';
import 'package:Manifest/Screens/goal_info.dart';
import 'package:Manifest/Screens/progress.dart';
import 'package:Manifest/Screens/vision_board_info.dart';
import 'package:Manifest/Widgets/affirmations_card.dart';
import 'package:Manifest/Widgets/practice_instructions_card.dart';
import 'package:Manifest/Widgets/review_goal_card.dart';
import 'package:Manifest/Widgets/activity_done_card.dart';
import 'package:Manifest/Widgets/vision_board_card.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Practice extends StatefulWidget {
  @override
  _PracticeState createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  List affirmations;
  AdmobBannerSize bannerSize;
  var box = Hive.box('goals');
  var boxDarkMode = Hive.box('darkMode');
  int currPageIndex;
  List goals = [];
  AdmobInterstitial interstitialAd;
  double practiceCardOpacity = 1;
  double reviewGoalOpacity = 0;
  // AdmobReward rewardAd;
  List visualizations;

  SwiperController _controller;

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  void initState() {
    _controller = new SwiperController();
    goals.add("goalActivityDone");
    // goals.add(Goals(
    //   title: "This is my First Goal",
    //   desc: "This is my First desc",
    // ));
    // goals.add(Goals(
    //   title: "This is my second Goal",
    //   desc: "This is my second desc",
    // ));
    // goals.add(Goals(
    //   title: "This is my Third Goal",
    //   desc: "This is my Third desc",
    // ));
    for (var i in box.values.toList().reversed) {
      if (i != null) {
        goals.add(Goals(title: i[0], desc: i[1]));
      }
    }

    Goals tempGoal = goals.last;
    goals.removeLast();
    goals.add(
        Goals(title: tempGoal.title, desc: tempGoal.desc, isPrimary: true));

    goals.add("PracticeCard");

    affirmations = [
      "affirmationsDone",
    ];
    var affirmtionBox = Hive.box('affirmations');
    for (var i in affirmtionBox.values.toList()) {
      // print(i);
      if (i != null) {
        affirmations.add("affirmations");
        break;
      }
    }

    affirmations.add("PracticeCard");

    visualizations = [
      "visualizationsDone",
      "visualizations",
      "PracticeCard",
    ];

    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );

    interstitialAd.load();

    super.initState();
  }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  // void showSnackBar(String content) {
  //   scaffoldState.currentState.showSnackBar(
  //     SnackBar(
  //       content: Text(content),
  //       duration: Duration(milliseconds: 1500),
  //     ),
  //   );
  // }

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

  Future<void> removeGoalCard(int index) async {
    setState(() {
      goals.removeAt(index);
    });
  }

  Future<void> removeAffirmationsCard(int index) async {
    setState(() {
      affirmations.removeAt(index);
    });
  }

  Future<void> removeVisualizationsCard(int index) async {
    setState(() {
      visualizations.removeAt(index);
    });
  }

  void changePage() {
    _controller.next(animation: true);
  }

  void setCurrPageIndex(int index) {
    setState(() {
      currPageIndex = index;
    });
  }

  Future<void> loadInterstitialAd() async {
    if (await interstitialAd.isLoaded) {
      interstitialAd.show();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          title: Text("Practice"),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: boxDarkMode.get(0)
            ? practiceBackgroundDark
            : practiceBackgroundLight,
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                // margin: EdgeInsets.only(bottom: 70),
                child: new Swiper(
                  loop: false,
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Stack(
                                  children: [
                                    for (var i in goals)
                                      if (i is Goals)
                                        ReviewGoalCard(
                                          changeOpacity: removeGoalCard,
                                          index: goals.indexOf(i),
                                          goal: i,
                                        )
                                      else if (i == "PracticeCard")
                                        Container(
                                          color: boxDarkMode.get(0)
                                              ? practiceBackgroundDark
                                              : practiceBackgroundLight,
                                          // height: 1000,
                                          // height: double.infinity,
                                          child: new PracticeInstructionsCard(
                                            activityNo: "One",
                                            title: "Review your goal",
                                            firstLine:
                                                "1. Read your goals out loud thrice.",
                                            secondLine:
                                                "2. As you finish reading, close your eyes and see yourself already having achieved the goal.",
                                            thirdLine:
                                                "3. It is very important to feel the emotions,Try imagining how would you feel if you would've already achieved your goal.",
                                            descLine:
                                                "It might seem difficult to imagine, if you've never practiced this before, but with each day you'll be able to direct your imagination easily.",
                                            removeCard: removeGoalCard,
                                            index: goals.indexOf(i),
                                          ),
                                        )
                                      else if (i == "goalActivityDone")
                                        new ActivityDoneCard(
                                          title: "Goal Activity done!",
                                          desc:
                                              "By doing this activity daily, You're transforming your mere wish into a deep burning desire which is the first step towards achieving any practical goal.",
                                          changePage: changePage,
                                          index: goals.indexOf(i),
                                        ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Why this?"),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GoalInfo(),
                                        ));
                                  },
                                ),
                              ),
                            )
                          ],
                        );
                        break;
                      case 1:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Stack(
                                  children: [
                                    for (var i in affirmations)
                                      if (i == "affirmations")
                                        new AffirmationsCard(
                                          removeCard: removeAffirmationsCard,
                                          index: affirmations.indexOf(i),
                                          fromIndex: 0,
                                        )
                                      else if (i == "PracticeCard")
                                        Container(
                                          color: boxDarkMode.get(0)
                                              ? practiceBackgroundDark
                                              : practiceBackgroundLight,
                                          child: new PracticeInstructionsCard(
                                            activityNo: "Two",
                                            title: "Time for Affirmations",
                                            firstLine:
                                                "1. Repeat each affirmations at least 3-5 times out loud. ",
                                            secondLine:
                                                "2. Do not just utter these sentences to yourself, Repeat each affirmation with firm conviction and faith.",
                                            thirdLine:
                                                "3. Just pretend as if you're saying these speaking to your best friend. ",
                                            descLine:
                                                "**Put a big smile on your face while you are affirming, this will immediately raise your vibrations.",
                                            removeCard: removeAffirmationsCard,
                                            index: affirmations.indexOf(i),
                                          ),
                                        )
                                      else if (i == "affirmationsDone")
                                        new ActivityDoneCard(
                                          title: "Affirmations done!",
                                          desc:
                                              "Affirmations are the best way to reprogram the subconscious mind.\n Affirmations make us believe certain things about ourselves or about the world.\n *Our actions largely depends on what we believe about ourselves or what we believe can achieve.",
                                          changePage: changePage,
                                          index: affirmations.indexOf(i),
                                        ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Why this?"),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AffirmationsInfo(),
                                        ));
                                  },
                                ),
                              ),
                            )
                          ],
                        );
                        break;
                      case 2:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Stack(
                                  children: [
                                    for (var i in visualizations)
                                      if (i == "visualizations")
                                        new VisionBoardCard(
                                          removeCard: removeVisualizationsCard,
                                          index: visualizations.indexOf(i),
                                        )
                                      else if (i == "PracticeCard")
                                        Container(
                                          color: boxDarkMode.get(0)
                                              ? practiceBackgroundDark
                                              : practiceBackgroundLight,
                                          child: new PracticeInstructionsCard(
                                            activityNo: "Three",
                                            title: "Time for Visualization",
                                            firstLine:
                                                "1. Look at all the pictures and repeat the affirmations written with it.",
                                            secondLine:
                                                "2. Images will help you imagine better and clearer.",
                                            thirdLine:
                                                "3. Make sure you visualize everything to be happening in present.",
                                            descLine:
                                                "**Vision cards make visualization more easier, faster and effective.",
                                            removeCard:
                                                removeVisualizationsCard,
                                            index: visualizations.indexOf(i),
                                          ),
                                        )
                                      else if (i == "visualizationsDone")
                                        new ActivityDoneCard(
                                          title: "Visualizations done!",
                                          desc:
                                              "Having a vision board makes visualization a lot more effective easy and fun.\nOur subconscious mind only thinks in terms of images.\nIt is recommended that you find at least 4-7 pictures of whatever it is that you want. It is a great way of visualizing your goals.",
                                          changePage: changePage,
                                          index: visualizations.indexOf(i),
                                        ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Why this?"),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VisionBoardInfo(),
                                        ));
                                  },
                                ),
                              ),
                            )
                          ],
                        );
                        break;
                      case 3:
                        return Progress(
                          loadInterstitialAdCallback: loadInterstitialAd,
                        );
                        break;
                      default:
                        return Container();
                        break;
                    }
                  },
                  itemCount: 4,
                  // pagination: new SwiperPagination(),
                  // control: new SwiperControl(),
                ),
              ),
            ),
            Container(
              height: 70,
              child: AdmobBanner(
                adUnitId: getBannerAdUnitId(),
                adSize: bannerSize,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
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
        )));
  }
}
