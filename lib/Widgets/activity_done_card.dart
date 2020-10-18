import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class ActivityDoneCard extends StatefulWidget {
  const ActivityDoneCard({
    Key key,
    this.changePage,
    this.index,
    this.title,
    this.desc,
    this.affirmationsResetCallback,
  }) : super(key: key);

  final ChangePageCallback changePage;
  final AffirmationsResetCallback affirmationsResetCallback;
  final int index;
  final String title;
  final String desc;

  @override
  _ActivityDoneCardState createState() => _ActivityDoneCardState();
}

class _ActivityDoneCardState extends State<ActivityDoneCard> {
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
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: boxDarkMode.get(0)
              ? practiceBackgroundDark
              : practiceBackgroundLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        color: goalActivityDoneCardColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 28),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height: 150,
                                  child: Lottie.asset(
                                      'assets/lottie/success2.json',
                                      repeat: true)),
                              Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: goalActivityDoneTitleCardColor,
                                    fontWeight: FontWeight.w700),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  widget.desc,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: goalActivityDoneTextCardColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              Container(
                                // color: Colors.red,
                                child: widget.index != null
                                    ? RaisedButton(
                                        elevation: 10,
                                        splashColor:
                                            goalActivityDoneTextCardColor,
                                        color: goalActivityDoneTitleCardColor,
                                        onPressed: () {
                                          // Navigator.of(context).pushNamed('/practice');
                                          widget.changePage();
                                        },
                                        child: Text(
                                            widget.title == 'Visualizations done!'
                                                ? "FINISH"
                                                : "Next Activity",
                                            style: TextStyle(color: textDark)),
                                      )
                                    : RaisedButton(
                                        elevation: 10,
                                        splashColor:
                                            goalActivityDoneTextCardColor,
                                        color: goalActivityDoneTitleCardColor,
                                        onPressed: () {
                                          // Navigator.of(context).pushNamed('/practice');
                                          // widget.changePage();

                                          Navigator.pop(context);
                                          widget.affirmationsResetCallback();
                                        },
                                        child: Text("Done!",
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
    );

    // return
  }
}

typedef ChangePageCallback = Function();
typedef AffirmationsResetCallback = Function();
