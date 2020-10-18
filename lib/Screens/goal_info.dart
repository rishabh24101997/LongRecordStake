import 'package:Manifest/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class GoalInfo extends StatelessWidget {
  const GoalInfo({Key key}) : super(key: key);
  static var boxDarkMode = Hive.box('darkMode');

  Widget generateCard(String title, String content) {
    return Card(
      // decoration: BoxDecoration(
      //   color: practiceBackground,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black,
      //       blurRadius: 10, // soften the shadow
      //       spreadRadius: 0,
      //       offset: Offset(
      //         1,
      //         1,
      //       ),
      //     )
      //   ],
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            // Expanded(
            //   flex: 3,
            //   child: Center(
            //     child: Text(
            //       "🔥",
            //       style: TextStyle(fontSize: 70),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 2,
                    child: Container(
                      color: boxDarkMode.get(0)
                          ? practiceBackgroundDark
                          : practiceBackgroundLight,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Goal Info"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: SvgPicture.asset(
                      "assets/images/mind.svg",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Power of definite goal💯",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                generateCard("Setting goals",
                    "Think for a second over the following... What would you do or want if you were guaranteed to achieve/have it. It is not necessary that you believe it right now? But just think about it and write it down somewhere... \n\nWhat is it that you truly want?"),
                SizedBox(
                  height: 20,
                ),
                generateCard("Defining your goal",
                    "Once you have a DEFINITE GOAL, now decide on what time span you want to achieve it, make sure you have the exact date. And finally, what are you willing to do in order to achieve your goal. (This is very important!)"),
                SizedBox(
                  height: 20,
                ),
                generateCard("Here's a great example!",
                    "By May 10th, 2021, I will have in my possession \$100K. To achieve my goal, I will be doing my best as a content creator and provide value to the people.\n\nOr \n\nBy 5th July 2021, I will be losing 25Ibs weight. To achieve my goal I will give my best in gym and I will follow a strict diet."),
                SizedBox(
                  height: 20,
                ),
                generateCard("Pay attention closely!",
                    "As you will be following daily practice given here, you will be making your Subconscious mind more receptive to the thoughts related to your goal. And you'll be having by some mysterious way a plan or inspiration for achieving your goal. DO NOT DENY THAT! Make sure as soon as you have it NOTE IT DOWN IMMEDIATELY. AND PUT THAT PLAN INTO ACTION, EVEN IF YOU THINK YOU CAN'T RIGHT NOW."),
                SizedBox(
                  height: 20,
                ),
                Text("Vector art by Freepik")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
