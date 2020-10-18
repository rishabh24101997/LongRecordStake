import 'package:Manifest/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hive/hive.dart';

class Intro extends StatefulWidget {
  Intro({Key key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  SwiperController _controller;
  var boxDarkMode = Hive.box('darkMode');
  int i = 0;

  @override
  void initState() {
    super.initState();
    _controller = new SwiperController();
  }

  Widget firstPage() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            color: greenColor,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment:
                //     CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Image.asset(
                        "assets/images/icon_manifest.png",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Manifest App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: textLight,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "It will help you achieve any goal/ desire, by helping you apply The Secret/Law of attraction.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bulletPoints(String id, String content) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: textDark,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Center(
              child: Container(
                child: Text(
                  id,
                  style: TextStyle(color: textLight, fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18, color: textLight, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ]);
  }

  Widget secondPage() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color: greenColor,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Napoleon Hill had taught in his book Think and Grow Rich: 'one can achieve any goal by following these four principles:'",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: textDark,
                              fontWeight: FontWeight.w700),
                        ),
                        bulletPoints("1", "Have a definite goal."),
                        bulletPoints("2",
                            "Have a BURNING DESIRE to achieve it, be obsessed with that goal."),
                        bulletPoints("3",
                            "HAVE FAITH, you've to believe that you can achieve it in order to achieve it."),
                        bulletPoints("4",
                            "Make a plan and put it into action towards achieving your goal."),
                        // bulletPoints("4",
                        //     "Make a plan and put it into action towards achieving your goal."),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget thirdPage() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            color: greenColor,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment:
                //     CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: SvgPicture.asset(
                        "assets/images/mind.svg",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Give your best!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: textLight,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Give your best and do the practices given here daily with FAITH. You're all set to achieve your biggest goal",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      color: textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(i == 2 ? Icons.done : Icons.arrow_forward),
          onPressed: () {
            i == 2
                ? Navigator.of(context).pushNamed('/initSetup')
                : _controller.next(animation: true);
          }),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Swiper(
                    loop: false,
                    physics: BouncingScrollPhysics(),
                    controller: _controller,
                    onIndexChanged: (value) {
                      setState(() {
                        i = value;
                      });
                    },
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      switch (index) {
                        case 0:
                          return firstPage();
                          break;
                        case 1:
                          return secondPage();
                          break;
                        case 2:
                          return thirdPage();
                          break;
                        default:
                          return Container();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
