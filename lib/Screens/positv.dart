import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:Manifest/Models/positv_item.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class POSITV extends StatefulWidget {
  @override
  _POSITVState createState() => _POSITVState();
}

class _POSITVState extends State<POSITV> {
  static List booksummariesList = [
    // // POSITVItem(
    // //     isNew: true, title: "One HABIT That Will Change Your World", url: ""),
    // // POSITVItem(
    // //     isNew: false, title: "How to visualize your dreams into reality"),
    // // POSITVItem(isNew: false, title: "Imagination Is Everything (MUST WATCH)"),
    // POSITVItem(
    //     // isNew: false,
    //     title: "Attract Success by doing THIS... (NO B.S. GUIDE)"),
    // POSITVItem(
    //     isNew: false, title: "The Winning Attitude (Your Life Depends On It)"),
    // POSITVItem(
    //     isNew: true, title: "The Fight Starts Within | Motivational Video"),
    // POSITVItem(isNew: true, title: "The Secret To Making Money"),
    // POSITVItem(isNew: true, title: "Improve Your Life In 24 Hours!"),
    // POSITVItem(
    //     isNew: true,
    //     title:
    //         "I Manifested \$1M I Jake Ducey (NEW) HOW TINY CHANGES CREATE REMARKABLE RESULTS"),
    // POSITVItem(
    //     isNew: true, title: "HOW TINY CHANGES CREATE REMARKABLE RESULTS."),
    // POSITVItem(isNew: true, title: "You Become What You Think"),
    // POSITVItem(isNew: true, title: "THE MINDSET OF HIGH ACHIEVERS"),
    // POSITVItem(isNew: true, title: "Grant Cardone - The Money Game"),
    // POSITVItem(
    //     isNew: true, title: "Napoleon Hill - The Key To Becoming Filthy Rich"),
    // POSITVItem(isNew: true, title: "Grant Cardone - Obsessed"),
    // POSITVItem(
    //     isNew: false, title: "How To Think And Attract Wealth - MUST WATCH"),
    // POSITVItem(isNew: false, title: "We Are All Looking For Hope"),
    // POSITVItem(
    //     isNew: false, title: "You are not your condition - Sean Stephenson"),
    // POSITVItem(isNew: false, title: "The Law Of Vibration by BOB"),
    // POSITVItem(isNew: false, title: "The Millionaire Mindset"),
    // POSITVItem(isNew: false, title: "The Magic Of Visualization"),
    // POSITVItem(isNew: false, title: "The Law of Attraction Explained"),
    // POSITVItem(
    //     isNew: false, title: "All You Need is Six Minutes Each Day To Success"),
    // POSITVItem(
    //     isNew: false,
    //     title: "How To Think & Grow Rich (This Will Change Your Life!)"),
    // POSITVItem(
    //     isNew: false,
    //     title: "Visualization Technique Arnold Schwarzenegger Uses"),
    // POSITVItem(isNew: false, title: "Develop Your Imagination"),
    // POSITVItem(isNew: false, title: "You Will Never Be Lazy Again"),
    // POSITVItem(
    //     isNew: false,
    //     title: "How To Control Your Mind (USE THIS to Brainwash Yourself)"),
    // POSITVItem(
    //     isNew: false,
    //     title: "THEY WANT YOU TO BE POOR - An Eye Opening Interview"),
  ];

  static List lawOfAttractionList = [
    // POSITVItem(
    //     isNew: true, title: "One HABIT That Will Change Your World", url: ""),
    // POSITVItem(
    //     isNew: false, title: "How to visualize your dreams into reality"),
    // POSITVItem(isNew: false, title: "Imagination Is Everything (MUST WATCH)"),
    // POSITVItem(
    //     isNew: false,
    //     title: "Attract Success by doing THIS... (NO B.S. GUIDE)"),
    // POSITVItem(
    //     isNew: false, title: "The Winning Attitude (Your Life Depends On It)"),
    // POSITVItem(
    //     isNew: true, title: "The Fight Starts Within | Motivational Video"),
    // POSITVItem(isNew: true, title: "The Secret To Making Money"),
    // POSITVItem(isNew: true, title: "Improve Your Life In 24 Hours!"),
    // POSITVItem(
    //     isNew: true,
    //     title:
    //         "I Manifested \$1M I Jake Ducey (NEW) HOW TINY CHANGES CREATE REMARKABLE RESULTS"),
    // POSITVItem(
    //     isNew: true, title: "HOW TINY CHANGES CREATE REMARKABLE RESULTS."),
    // POSITVItem(isNew: true, title: "You Become What You Think"),
    // POSITVItem(isNew: true, title: "THE MINDSET OF HIGH ACHIEVERS"),
    // POSITVItem(isNew: true, title: "Grant Cardone - The Money Game"),
    // POSITVItem(
    //     isNew: true, title: "Napoleon Hill - The Key To Becoming Filthy Rich"),
    // POSITVItem(isNew: true, title: "Grant Cardone - Obsessed"),
    // POSITVItem(
    //     isNew: false, title: "How To Think And Attract Wealth - MUST WATCH"),
    // POSITVItem(isNew: false, title: "We Are All Looking For Hope"),
    // POSITVItem(
    //     isNew: false, title: "You are not your condition - Sean Stephenson"),
    // POSITVItem(isNew: false, title: "The Law Of Vibration by BOB"),
    // POSITVItem(isNew: false, title: "The Millionaire Mindset"),
    // POSITVItem(isNew: false, title: "The Magic Of Visualization"),
    // POSITVItem(isNew: false, title: "The Law of Attraction Explained"),
    // POSITVItem(
    //     isNew: false, title: "All You Need is Six Minutes Each Day To Success"),
    // POSITVItem(
    //     isNew: false,
    //     title: "How To Think & Grow Rich (This Will Change Your Life!)"),
    // POSITVItem(
    //     isNew: false,
    //     title: "Visualization Technique Arnold Schwarzenegger Uses"),
    // POSITVItem(isNew: false, title: "Develop Your Imagination"),
    // POSITVItem(isNew: false, title: "You Will Never Be Lazy Again"),
    // POSITVItem(
    //     isNew: false,
    //     title: "How To Control Your Mind (USE THIS to Brainwash Yourself)"),
    // POSITVItem(
    //     isNew: false,
    //     title: "THEY WANT YOU TO BE POOR - An Eye Opening Interview"),
  ];

  static List visualizationList = [
    // POSITVItem(
    //     isNew: true, title: "One HABIT That Will Change Your World", url: ""),
    // POSITVItem(
    //     isNew: false, title: "How to visualize your dreams into reality"),
    // POSITVItem(isNew: false, title: "Imagination Is Everything (MUST WATCH)"),
    // POSITVItem(
    //     isNew: false,
    //     title: "Attract Success by doing THIS... (NO B.S. GUIDE)"),
    // POSITVItem(
    //     isNew: false, title: "The Winning Attitude (Your Life Depends On It)"),
    // POSITVItem(
    //     isNew: true, title: "The Fight Starts Within | Motivational Video"),
    // POSITVItem(isNew: true, title: "The Secret To Making Money"),
    // POSITVItem(isNew: true, title: "Improve Your Life In 24 Hours!"),
    // POSITVItem(
    //     isNew: true,
    //     title:
    //         "I Manifested \$1M I Jake Ducey (NEW) HOW TINY CHANGES CREATE REMARKABLE RESULTS"),
    // POSITVItem(
    //     isNew: true, title: "HOW TINY CHANGES CREATE REMARKABLE RESULTS."),
    // POSITVItem(isNew: true, title: "You Become What You Think"),
    // POSITVItem(isNew: true, title: "THE MINDSET OF HIGH ACHIEVERS"),
    // POSITVItem(isNew: true, title: "Grant Cardone - The Money Game"),
    // POSITVItem(
    //     isNew: true, title: "Napoleon Hill - The Key To Becoming Filthy Rich"),
    // POSITVItem(isNew: true, title: "Grant Cardone - Obsessed"),
    // POSITVItem(
    //     isNew: false, title: "How To Think And Attract Wealth - MUST WATCH"),
    // POSITVItem(isNew: false, title: "We Are All Looking For Hope"),
    // POSITVItem(
    //     isNew: false, title: "You are not your condition - Sean Stephenson"),
    // POSITVItem(isNew: false, title: "The Law Of Vibration by BOB"),
    // POSITVItem(isNew: false, title: "The Millionaire Mindset"),
    // POSITVItem(isNew: false, title: "The Magic Of Visualization"),
    // POSITVItem(isNew: false, title: "The Law of Attraction Explained"),
    // POSITVItem(
    //     isNew: false, title: "All You Need is Six Minutes Each Day To Success"),
    // POSITVItem(
    //     isNew: false,
    //     title: "How To Think & Grow Rich (This Will Change Your Life!)"),
    // POSITVItem(
    //     isNew: false,
    //     title: "Visualization Technique Arnold Schwarzenegger Uses"),
    // POSITVItem(isNew: false, title: "Develop Your Imagination"),
    // POSITVItem(isNew: false, title: "You Will Never Be Lazy Again"),
    // POSITVItem(
    //     isNew: false,
    //     title: "How To Control Your Mind (USE THIS to Brainwash Yourself)"),
    // POSITVItem(
    //     isNew: false,
    //     title: "THEY WANT YOU TO BE POOR - An Eye Opening Interview"),
  ];

  List categoryList = [
    "Law of attraction",
    "Visualization/Meditation",
    "Book Summaries",
  ];

  List currentList = lawOfAttractionList;
  String currListItem = 'Law of attraction';

  @override
  void initState() {
    // TODO: implement initState

    lawOfAttractionList.add(POSITVItem(
        "(NEW) One HABIT That Will Change Your World ", "nQKu-xAJqYs"));

    lawOfAttractionList.add(
        POSITVItem("How To Visualize Your Dreams Into Reality", "FZFMTpEAPsU"));

    lawOfAttractionList.add(
        POSITVItem("Imagination Is Everything (MUST WATCH)", "CA0UIqgwH-A"));

    lawOfAttractionList.add(POSITVItem(
        "Attract Success by doing THIS... (NO B.S. GUIDE)", "ky1bYJ6ljH0"));

    lawOfAttractionList.add(POSITVItem(
        "The Winning Attitude (Your Life Depends On It)", "YiZ05G6LgUM"));

    lawOfAttractionList.add(POSITVItem(
        "(NEW) The Fight Starts Within | Motivational Video", "AABQyCy304A"));

    lawOfAttractionList
        .add(POSITVItem("(NEW) The Secret To Making Money", "XU1hLA6hfms"));

    lawOfAttractionList
        .add(POSITVItem("(NEW) Improve Your Life In 24 Hours!", "A5Vgds4B-v4"));

    lawOfAttractionList
        .add(POSITVItem("(NEW) I Manifested \$1M | Jake Ducey", "XU1hLA6hfms"));

    lawOfAttractionList.add(POSITVItem(
        "(NEW) HOW TINY CHANGES CREATE REMARKABLE RESULTS", "Q8ApZXWgJq4"));

    lawOfAttractionList
        .add(POSITVItem("(NEW) You Become What You Think", "_BDv4QaSKI4"));

    lawOfAttractionList
        .add(POSITVItem("(NEW) THE MINDSET OF HIGH ACHIEVERS ", "0mm57rH1sTE"));

    lawOfAttractionList
        .add(POSITVItem("(NEW) Grant Cardone - The Money Game", "elhiy0DpyPU"));

    lawOfAttractionList.add(POSITVItem(
        "(NEW) Napoleon Hill - The Key To Becoming Filthy Rich",
        "dEMRqz0gE7A"));

    lawOfAttractionList
        .add(POSITVItem("(NEW) Grant Cardone - Obsessed", "tjFhjq5EfBY"));

    lawOfAttractionList.add(POSITVItem(
        "How To Think And Attract Wealth ~ MUST WATCH", "Y4viCnaXu9k"));

    lawOfAttractionList
        .add(POSITVItem("We Are All Looking For Hope ", "eYHPHFfnhbo"));

    lawOfAttractionList.add(POSITVItem(
        "You are not your condition - Sean Stephenson", "U3h-lylC9q8"));

    lawOfAttractionList
        .add(POSITVItem("The Law Of Vibration by BOB ", "zJ7tJApsKCo"));
    lawOfAttractionList
        .add(POSITVItem("The Millionaire Mindset", "LiTmN7K4xTM"));
    lawOfAttractionList
        .add(POSITVItem("The Magic Of Visualization", "O72kDJAhBq8"));
    lawOfAttractionList
        .add(POSITVItem("The Law of Attraction Explained", "5zvnFM2BXqY"));
    lawOfAttractionList.add(POSITVItem(
        "All You Need is Six Minutes Each Day To Success", "DRLvxbuJtW8"));

    lawOfAttractionList.add(POSITVItem(
        "How To Think & Grow Rich (This Will Change Your Life!)",
        "QHy6GdmWzBk"));

    lawOfAttractionList.add(POSITVItem(
        "Visualization Technique Arnold Schwarzenegger Uses", "DNWvNTWBSFM"));

    lawOfAttractionList
        .add(POSITVItem("Develop Your Imagination", "CkL9eRJlnic"));

    lawOfAttractionList
        .add(POSITVItem("You Will Never Be Lazy Again", "REeROakzwfU"));

    lawOfAttractionList.add(POSITVItem(
        "How To Control Your Mind (USE THIS to Brainwash Yourself)",
        "WYfYmYbp7C4"));

    lawOfAttractionList.add(POSITVItem(
        "THEY WANT YOU TO BE POOR - An Eye Opening Interview", "m6pWEzkbnDE"));

    visualizationList.add(
        POSITVItem("(NEW) Guided Meditation For Gratitude", "S5BR75ySQOo"));

    visualizationList
        .add(POSITVItem("(NEW) 15 Minute Guided Meditation ", "W8a3T8pI9Ns"));

    visualizationList.add(POSITVItem(
        "(NEW) 10 Minutes To Start Every Day Perfectly ", "FGO8IWiusJo"));

    visualizationList.add(POSITVItem(
        "(NEW) Guided Meditation For Manifesting Dreams", "98L-kB8L2lw"));

    visualizationList.add(POSITVItem(
        "(NEW) Guided Meditation For Self-Acceptance", "g-BjFvbsYqs"));

    visualizationList.add(POSITVItem(
        "(NEW) Meditation for Clarity, Stability, and Presence",
        "OccjH_2ddQc"));

    visualizationList.add(POSITVItem(
        "(NEW) Morning Affirmations for POSITIVE DAY", "ZssjZnsN4Gg"));

    visualizationList.add(POSITVItem(
        "(new)Success Affirmations & Visuals (WATCH EVERY DAY!)",
        "hIYcpHb-LVs"));

    visualizationList
        .add(POSITVItem("GUIDED VISUALIZATION EXERCISE", "r-zXv7aYYqY"));

    visualizationList
        .add(POSITVItem("528 hz \"I AM\" Affirmations", "lNS70QJh4Go"));
    visualizationList.add(POSITVItem(
        "Rich Money Success Mind Programming Subliminal (Audio + Visual)",
        "TD826QgET1c"));

    visualizationList.add(POSITVItem(
        "(NEW)  I AM Affirmations For Wealth, Success, Health & Prosperity",
        "r4PIFMcOTdw"));

    visualizationList
        .add(POSITVItem("Paul Mckenna Official | Confidence", "TUxFvnC3Yr0"));

    visualizationList.add(POSITVItem(
        "LIFE IS GOOD - Subliminal Wealth Attraction", "tP_NzElnl58"));

    visualizationList
        .add(POSITVItem("Guided Visualization Exercise", "YpmW-qIlRqU"));

    booksummariesList
        .add(POSITVItem("Napoleon Hill's THINK and GROW RICH", "7UbxJCIUQRE"));

    booksummariesList
        .add(POSITVItem("JAMES CLEAR - ATOMIC HABITS", "Q8ApZXWgJq4"));

    booksummariesList.add(POSITVItem("The Compound Effect", "oZIvEr-Kkx8"));

    booksummariesList.add(POSITVItem(
        "THE 7 HABITS OF HIGHLY EFFECTIVE PEOPLE BY STEPHEN COVEY",
        "ktlTxC4QG8g"));

    booksummariesList
        .add(POSITVItem("THE POWER OF HABIT BY CHARLES DUHIGG", "Zq2LVa36ukk"));

    booksummariesList.add(
        POSITVItem("Accomplish Everything With Mini Habits", "aHDvEfiSipo"));

    booksummariesList.add(POSITVItem("RICH DAD POOR DAD", "wuSgn85I1fQ"));
    booksummariesList
        .add(POSITVItem("THE 4-HOUR WORKWEEK BY TIM FERRISS", "j3TeLsaKzAM"));

    booksummariesList
        .add(POSITVItem("The Alchemist by Paulo Coelho", "b41MXNaFJj0"));

    booksummariesList.add(
        POSITVItem("\"The POWER of NOW,\" by Eckhart Tolle ", "UmLe9I74whs"));

    booksummariesList
        .add(POSITVItem("The Miracle Morning by Hal Elrod", "FLrP0qaMUAM"));

    booksummariesList
        .add(POSITVItem("The Monk Who Sold His Ferrari", "e-d1sRrnXKY"));

    booksummariesList
        .add(POSITVItem("ZERO TO ONE by Peter Thiel", "Hd9pHZC7Sak"));

    booksummariesList.add(POSITVItem(
        "THE SCIENCE OF GETTING RICH SUMMARY (BY WALLACE WATTLES)",
        "_2woW2oNh7w"));

    booksummariesList
        .add(POSITVItem("How to Talk to Anyone: Leil Lowndes", "Uixa3xBJzzs"));

    booksummariesList
        .add(POSITVItem("How to Talk to Anyone: Leil Lowndes", "FyjLOg8o6_w"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new DropdownButton<String>(
                  value: currListItem,
                  underline: Container(
                    height: 2,
                    color: secondary,
                  ),
                  items: categoryList
                      .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      currListItem = value;
                      switch (currListItem) {
                        case "Law of attraction":
                          currentList = lawOfAttractionList;
                          break;
                        case "Visualization/Meditation":
                          currentList = visualizationList;
                          break;
                        case "Book Summaries":
                          currentList = booksummariesList;
                          break;
                        default:
                          currentList = lawOfAttractionList;
                          break;
                      }
                    });
                  },
                  // value: currListItem,
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                  YoutubePlayerController _controller = YoutubePlayerController(
                    initialVideoId: currentList[index].url,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WillPopScope(
                                onWillPop: () async {
                                  // Navigator.of(context).pop();
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.portraitUp,
                                    DeviceOrientation.portraitDown,
                                  ]);
                                  return true;
                                },
                                child: (Container(
                                  child: YoutubePlayer(
                                    controller: _controller,
                                    showVideoProgressIndicator: true,
                                  ),
                                )),
                              )));
                },
                child: Container(
                  color: secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            child: Icon(
                              Icons.play_circle_outline,
                              color: textDark,
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            child: Text(
                              currentList[index].title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textDark),
                              // overflow: TextOverflow.,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }, childCount: currentList.length),
        ),
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 4.0),
        //     child: SizedBox(
        //       height: 2,
        //       child: Container(
        //         color: boxDarkMode.get(0) ? dividerDark : dividerLight,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
