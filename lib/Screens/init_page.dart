import 'package:Manifest/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDarkMode = Hive.box('darkMode');

    return Container(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 15, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    height: 50,
                  ),
                  Text(
                    "Thank you for downloading the Manifest app. We would like to thank each and everyone who has ever left a review, have emailed us their stories, or have given us valuable feedback.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: boxDarkMode.get(0) ? textDark : textLight),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "We love to hear your stories, so if you're using this app for the first time we would love to get your feedback. We wish you all the very best for the journey ahead. Happy Manifesting!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: boxDarkMode.get(0) ? textDark : textLight),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 8.5),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        // elevation: 10,
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        splashColor: accent,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/intro');
                        },
                        child: Text(
                          "GET STARTED",
                          style: TextStyle(color: textDark),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "OR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: boxDarkMode.get(0) ? textDark : textLight),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 8.5),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        // elevation: 10,
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        splashColor: accent,
                        color: boxDarkMode.get(0) ? textDark : iconCardDark,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                        child: Text(
                          "RESTORE YOUR DATA",
                          style: TextStyle(
                              color:
                                  !boxDarkMode.get(0) ? textDark : textLight),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
