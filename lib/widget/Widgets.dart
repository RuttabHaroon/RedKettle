import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:redkettle/utils/MyColors.dart';

changeStatusBarColor({Color color, bool isWhiteForground}) async {
  await FlutterStatusbarcolor.setStatusBarColor(color);
  if (useWhiteForeground(color)) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(isWhiteForground);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(!isWhiteForground);
  }
}

Widget buildButton({BuildContext context, String title}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 15.0),
    decoration: BoxDecoration(
      color: statusBarColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    ),
  );
}
