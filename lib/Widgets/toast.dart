import 'package:Manifest/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  FToast fToast;

  void showToast(
      BuildContext context, IconData icon, String content, Color color,
      {int duration = 2}) {
    fToast = FToast(context);
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: textDark,
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              content,
              style: TextStyle(fontWeight: FontWeight.w700, color: textDark),
            ),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
    );
  }
}
