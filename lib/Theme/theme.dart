import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

// abstract class Styles {
//   static const TextStyle productRowItemName = TextStyle(
//     color: Color.fromRGBO(0, 0, 0, 0.8),
//     fontSize: 18,
//     fontStyle: FontStyle.normal,
//     fontWeight: FontWeight.normal,
//   );

//   static const TextStyle productRowTotal = TextStyle(
//     color: Color.fromRGBO(0, 0, 0, 0.8),
//     fontSize: 18,
//     fontStyle: FontStyle.normal,
//     fontWeight: FontWeight.bold,
//   );
// }

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Color secondary = hexToColor("#7223E1");
Color accent = hexToColor("#ff0074");

// Light Theme
Color primaryLight = hexToColor("#ECECEC");
Color backgroundLight = hexToColor("#FDFDFD");
Color dividerLight = hexToColor("#CBCBCB");
Color textLight = hexToColor("#262626");
Color iconCardLight = hexToColor("#5F5F5F");
Color textSubtitleLight = hexToColor("#777777");
Color progressIndicatorBackgroundLight = hexToColor("#cccccc");
Color textLightColor = hexToColor("#ffffff");
Color practiceBackgroundLight = hexToColor("#FAFAFA");


// Dark Theme
Color primaryDark = hexToColor("#181818");
Color backgroundDark = hexToColor("#292929");
Color dividerDark = hexToColor("#434343");
Color textDark = hexToColor("#f1f1f1");
Color textSubtitleDark = hexToColor("#999999");
Color iconCardDark = hexToColor("#858585");
Color progressIndicatorBackgroundDark = hexToColor("#f1f1f1");
Color practiceBackgroundDark = hexToColor("#303030");

// Color iconDark = hexToColor("#f2f2f2");
// Color secondaryDark = hexToColor("#7E50FF");
// Color secondaryDark = hexToColor("#6639F8");
// Color settingsCardBackgroundDark = hexToColor("#1d1d1d");

Color iconHighlight = hexToColor("#ff8800");
Color warningColor = hexToColor("#f12500");
Color greenColor = hexToColor("#00c239");

// Color primaryDark = hexToColor("#181818");

Color reviewGoalCardColorLight = hexToColor("#d9e9ff");
Color reviewGoalTextHighlightColorLight = hexToColor("#0070d6");
Color reviewGoalTextColorLight = hexToColor("#303030");
Color reviewGoalDividerColorLight = hexToColor("#a3d4ff");

Color goalActivityDoneCardColor = hexToColor("#BAFFF1");
Color goalActivityDoneTitleCardColor = hexToColor("#0F7568");
Color goalActivityDoneTextCardColor = hexToColor("#343938");
