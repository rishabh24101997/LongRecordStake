import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProgressBar extends StatefulWidget {
  // final int progress;

  final int total;

  final String text;

  final bool isPractice;

  final bool toIncrement;

  const ProgressBar({
    Key key,
    // this.progress,
    this.total,
    this.text,
    this.isPractice,
    this.toIncrement,
  }) : super(key: key);
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  // int progress;
  int total;
  String text;
  var boxDarkMode = Hive.box('darkMode');
  @override
  void initState() {
    super.initState();
    // progress = widget.progress;
    total = widget.total;
    text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('progress').listenable(),
        builder: (context, box, _) {
          int progress = box.length == 0 ? 0 : box.get(0);
          progress = widget.isPractice ?? false
              ? progress + (widget.toIncrement ?? false ? 1 : 0)
              : progress;
          return Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                // height: 3,
                child: Container(
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          text,
                          style: TextStyle(
                              color: boxDarkMode.get(0)
                                  ? boxDarkMode.get(0)
                                      ? textSubtitleDark
                                      : textSubtitleLight
                                  : textSubtitleLight,
                              fontSize: 13),
                        ),
                      ),
                      Text(
                        '$progress/$total',
                        style: TextStyle(
                          color: accent,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 4,
                      child: Container(
                        child: LinearProgressIndicator(
                          backgroundColor: boxDarkMode.get(0)
                              ? progressIndicatorBackgroundDark
                              : progressIndicatorBackgroundLight,
                          value: progress / total,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
