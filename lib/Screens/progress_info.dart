import 'package:flutter/material.dart';

class ProgressInfo extends StatelessWidget {
  Widget generateCard(String title, String content) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              "🔥",
              style: TextStyle(fontSize: 70),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                content,
                // style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Streak Info"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                generateCard("Day 0 - 21",
                    "It is said that anything you do for 21 days becomes a habit. It is very essential that you do all mental exercises here for 21 days, if you miss any day you'll be back to 0."),
                SizedBox(
                  height: 50,
                ),
                generateCard("Day 22 - 91",
                    "As you repeat anything for more than 90 days it becomes part of your LIFESTYLE. So if you can reach there then definitely you'll be living your life with a totally new and positive mindset. If you miss more than 2 days your streak will be reset to 21."),
                SizedBox(
                  height: 50,
                ),
                generateCard("Day 92 - 365",
                    "And there you're living a new lifestyle, try and keep this new habit for a year. If you miss more than 1 day your streak will be reset to 91."),
                SizedBox(
                  height: 50,
                ),
                generateCard("Day 366 and onwards",
                    "Congratulations! you just finished a whole year. You're are on a new level just keep ongoing."),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
