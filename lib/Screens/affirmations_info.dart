import 'package:Manifest/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AffirmationsInfo extends StatelessWidget {
  const AffirmationsInfo({Key key}) : super(key: key);

  static var boxDarkMode = Hive.box('darkMode');
  Widget generateCard(String title, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
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

  Widget generateCardwithButton(
      String title, String content, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
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
                  Center(
                    child: RaisedButton(
                      child:
                          Text("WATCH NOW!", style: TextStyle(color: textDark)),
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight,
                        ]);
                        YoutubePlayerController _controller =
                            YoutubePlayerController(
                          initialVideoId: 'xCoNh78UC4E',
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
                    ),
                  )
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
        title: Text("Affirmations Info"),
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
                  "Powerful way to form new beliefs,try forming a habit of affirming positive thoughts everyday...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 40,
                ),
                generateCard("What are affirmations?",
                    "Affirmations are short and well defined positive statements written in present tense."),
                SizedBox(
                  height: 20,
                ),
                generateCard("Few words from the famous 'THINK AND GROW RICH'",
                    "Following are the statements of the classic 'THINK AND GROW RICH' by Napoleon Hill - \n\n'It is a well known fact that one comes, finally to believe whatever one repeats to one's self, whether the statements be true of false. If a man repeats a lie over and over, he will eventually accept the lie as truth. \nMoreover, he will believe it to be the truth. \n\nYou are suggested to read the above paragraph at least twice and make sure you absorb the POWERFUL INFORMATION laid out here."),
                SizedBox(
                  height: 20,
                ),
                generateCardwithButton(
                    "Why use affirmations?",
                    "You'll be repeating affirmations daily. They are a great way to form new beliefs. Don't get tricked by the simplicity of the idea. Affirmations when mixed with a feeling of faith are extremely powerful, you can actually rewire your brain through the daily practices given here. Whatever your beliefs are right now understand that it has been instilled from your parents and society. \n\n(This video covers everything you need to understand about the affirmations)",
                    context),
                SizedBox(
                  height: 20,
                ),
                generateCard("Writing affirmations",
                    "The following are the points you should consider while writing your affirmations: \n\n1. Your affirmations must be short but well defined.\n\n 2.1t must be positive. (Example - say you want to be financially independent, then you can write affirmation like 'I am wealthy' rather than 'I've cleared all my debts now' your subconscious can't differentiate what you want or don't want) \n\n3.1t must be in PRESENT STATE(this is important). \n\n4. You must mix positive emotions and visualization with it, plain unemotional words don't influence your mind.\n\n 5. Focus on 5-8 affirmations and then add a new one slowly. \n\n6. And most importantly be consistent! You can only rewire your brain by constant repetition. (repeat your affirmations at least twice a day)"),
                SizedBox(
                  height: 20,
                ),
                generateCard("A powerful exercise!",
                    "EXERCISE - Today just pick one area of life where you struggle and try to think about all the beliefs that might be holding you from doing the best in that area. Write them down and burn or flush that piece of paper. And Write the new beliefs that you want to acquire! \n\n(TAKE ACTION IMMEDIATELY, DO THE EXERCISE NOW WHETHER YOU FEEL LIKE IT OR NOT)"),
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
