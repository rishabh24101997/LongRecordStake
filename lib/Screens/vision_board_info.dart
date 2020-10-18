import 'package:Manifest/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VisionBoardInfo extends StatelessWidget {
  const VisionBoardInfo({Key key}) : super(key: key);
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
      String title, String content, String videoCode, BuildContext context) {
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
                          initialVideoId: videoCode,
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
                  "Harness power of visualization to influence your subconscious mind even faster.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 40,
                ),
                generateCard("Vision board",
                    "Having a vision board makes visualization a lot more effective, easy, and fun. Our subconscious mind only thinks in terms of images. It is recommended that you find at least 4-7 pictures of whatever it is that you want. It is a great way of visualizing your goals."),
                SizedBox(
                  height: 20,
                ),
                generateCardwithButton(
                    "A famous example",
                    "Some of you might be amazed to know that the famous Hollywood actor 'Jim Carrey' used to do visualization. Not only that, but he also wrote himself a cheque of \$10 Million for acting. \n\nYou can watch the interview here -",
                    "nPU5bjzLZX0",
                    context),
                SizedBox(
                  height: 20,
                ),
                generateCardwithButton(
                    "Power of visualization!",
                    "Your subconscious mind can't make a difference between what you imagine or what is real, this is what makes visualization very powerful tool. You are requested to watch the video given below where Tony Robbins describes the power of visualization through a practical exercise that you can do right now! \n\n(GO AND WATCH THE VIDEO NOW AND PERFORM THE ACTIVITY HE SHOWS, YOU'LL BE AMAZED)",
                    "AAP3fOW8b8g",
                    context),
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
