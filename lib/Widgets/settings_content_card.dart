import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';

class SettingsContentCard extends StatelessWidget {
  final String title;

  final String content;

  const SettingsContentCard({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDarkMode = Hive.box('darkMode');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: InkWell(
            onTap: () {
              print("object");
            },
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  color: boxDarkMode.get(0) ? primaryDark : primaryLight,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 2),
                          child: Text(
                            title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    boxDarkMode.get(0) ? textDark : textLight,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 2),
                          child: Text(
                            content,
                            style: TextStyle(
                              color: boxDarkMode.get(0)
                                  ? boxDarkMode.get(0)
                                      ? textSubtitleDark
                                      : textSubtitleLight
                                  : textSubtitleLight,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
