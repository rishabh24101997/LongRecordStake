import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:Manifest/Widgets/settings_action_card.dart';
import 'package:Manifest/Widgets/settings_content_card.dart';
import 'package:hive/hive.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var boxDarkMode = Hive.box('darkMode');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              SettingsContentCard(
                title: "Thank You!",
                content:
                    "Our journey has been unbelievable, in just few months we have reached 200,000+ people and have received numerous amazing reviews and emails around the world. Thank you so much for using Manifest app. Happy Manifesting",
              ),
              SettingsContentCard(
                title: "Contact Us",
                content:
                    "Help us make this app even better, tell us what do you like/dislike about this app.",
              ),
              SettingsContentCard(
                title: "Looking to edit something",
                content:
                    "To edit/delete a goal, affirmation or vision card long press on it for about 1 second. To navigate through other goals simply tap on goal card.",
              ),
              SettingsActionCard(
                title: "Dark Mode",
                hasSwitch: true,
              ),
              SettingsActionCard(
                title: "Vibration",
                hasSwitch: true,
              ),
              SettingsActionCard(
                title: "Change Morning Time",
                hasSwitch: false,
                icon: Icon(
                  Icons.access_time,
                  color: boxDarkMode.get(0) ? iconCardDark : iconCardLight,
                ),
              ),
              SettingsActionCard(
                title: "Change Night Time",
                hasSwitch: false,
                icon: Icon(
                  Icons.access_time,
                  color: boxDarkMode.get(0) ? iconCardDark : iconCardLight,
                ),
              ),
              SettingsActionCard(
                title: "Add Goal",
                hasSwitch: false,
                icon: Icon(
                  Icons.add,
                  color: boxDarkMode.get(0) ? iconCardDark : iconCardLight,
                ),
              ),
              SettingsActionCard(
                title: "Share App",
                hasSwitch: false,
                icon: Icon(
                  Icons.share,
                  color: boxDarkMode.get(0) ? iconCardDark : iconCardLight,
                ),
              ),
              // SettingsActionCard(
              //   title: "Change Start Date",
              //   hasSwitch: false,
              //   icon: Icon(
              //     Icons.calendar_today,
              //     color: boxDarkMode.get(0) ? iconCardDark : iconCardLight,
              //   ),
              // ),
              SettingsActionCard(
                title: "Reset Progress to Day 1",
                isWarning: true,
                hasSwitch: false,
                icon: Icon(
                  Icons.warning,
                  color: warningColor,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        )));
  }
}
