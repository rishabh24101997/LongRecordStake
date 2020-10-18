import 'package:Manifest/Screens/add_affirmation.dart';
import 'package:Manifest/Screens/affirmations_info.dart';
import 'package:Manifest/Widgets/activity_done_card.dart';
import 'package:Manifest/Widgets/affirmations_card.dart';
import 'package:Manifest/Widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';

class SelectAffirmations extends StatefulWidget {
  const SelectAffirmations({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SelectAffirmationsState createState() => _SelectAffirmationsState();
}

class _SelectAffirmationsState extends State<SelectAffirmations> {
  var box = Hive.box('affirmations');
  var boxDarkMode = Hive.box('darkMode');
  CustomToast _toast = CustomToast();

  List moneyAffirmationsList = [
    "Money comes to me easily and effortlessly",
    "I am a money magnet",
    "I am ready to receive the abundance",
    "I love money",
    "I deserve to be rich",
    "I am financially independent",
    "I am a millionaire",
    "I receive money everyday",
    "I just love being rich",
    "I am surrounded by abundance"
  ];

  List lifeAffirmationsList = [
    "I just love my life ♥",
    "Every day in every way I am getting better and better",
    "I always ask how can I, rather than why I can't",
    "My life is really amazing",
    "Everything is happening for good reason",
    "I am enjoying my life more than ever",
    "I am happier than ever",
    "Today is going to be the best day of my life",
    "I am always grateful for everything that life has to offer",
    "I love myself and others around me",
    "People enjoy my company a lot",
  ];

  List healthAffirmationsList = [
    "I enjoy exercising",
    "I always find time for myself",
    "I am so determined to be healthy",
    "Each workout makes me feel happier and healthier",
    "I am energized all the time",
    "I am getting faster, better and healthier",
    "I love building healthy habits",
    "I love eating healthy food",
    "I keep on going on",
    "I am living a healthy lifestyle",
  ];

  List confidenceAffirmationsList = [
    "I am confident",
    "Confidence flows through me",
    "I radiate confidence",
    "I love the person I am becoming",
    "I always find a solution",
    "I deserve all that I want",
    "I am letting go of people's judgment",
    "I focus on the solution",
    "I love overcoming obstacles",
    "I love my self",
    "I let go of the need to impress others",
  ];

  List affirmationsList = [];

  bool isAffirmationsDone = false;

  void affirmationsDoneCallback() {
    setState(() {
      isAffirmationsDone = true;
    });
  }

  void affirmationsResetCallback() {
    setState(() {
      isAffirmationsDone = false;
    });
  }

  @override
  void initState() {
    switch (widget.title) {
      case "Money Affirmations":
        affirmationsList = moneyAffirmationsList;
        break;
      case "Life Affirmations":
        affirmationsList = lifeAffirmationsList;
        break;
      case "Health Affirmations":
        affirmationsList = healthAffirmationsList;
        break;
      case "Confidence Affirmations":
        affirmationsList = confidenceAffirmationsList;
        break;
      default:
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add " + widget.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        var list = box.values.toList();
                        for (var i in list) {
                          if (i == affirmationsList[index]) {
                            _toast.showToast(context, Icons.close,
                                "Same affirmation already added.", accent);
                            return;
                          }
                        }
                        box
                            .put(box.length, affirmationsList[index])
                            .then((value) {
                          _toast.showToast(context, Icons.done,
                              "Affirmation added.", greenColor);
                          _toast.showToast(context, Icons.remove_circle,
                              "Long click to remove", warningColor);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: SizedBox(
                          child: Text(
                            affirmationsList[index],
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }, childCount: affirmationsList.length),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 2,
                child: Container(
                  color: boxDarkMode.get(0) ? dividerDark : dividerLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
