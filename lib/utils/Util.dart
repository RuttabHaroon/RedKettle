import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redkettle/screens/LoginScreen.dart';


class Util {
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          width: 50,
          height: 50,
          child: new Center(
            child: (Platform.isIOS) ? new CupertinoActivityIndicator(animating: true, radius: 35.0,) : new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFFEC00)),
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 5), () {});
  }

  static void showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Warning'),
          content: Text('Going back will cancel the payment. Are you sure you want to go back?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("YES"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text("NO"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    new Future.delayed(new Duration(seconds: 5), () {});
  }

  static void hideLoader(BuildContext context){
    Navigator.pop(context);
  }

  static Widget showLoader1() {
        return Container(
          color: Colors.white,
          width: 50,
          height: 50,
          child: new Center(
            child: new CircularProgressIndicator(),
          ),
        );
  }

  static void navigateView(BuildContext context, Widget newScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => newScreen,
      ),
    );
  }

  static void navigateViewWithPop(BuildContext context, Widget newScreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => newScreen,
      ),
    );
  }

  static void pushAndRemoveUntil(BuildContext context, Widget newScreen) {
    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => newScreen,
      ),
      // this function should return true when we're done removing routes
      // but because we want to remove all other screens, we make it
      // always return false
          (Route route) => false,
    );
  }


  static void popAndRemoveUntil(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);

  }

  static String getDayWithIncrement(String date, int incrementDays){

    DateTime dateTime = new DateTime.now().add(Duration(days: incrementDays));
    var x =  DateTime.parse(date);
    x = x.add(Duration(days: incrementDays));

    DateFormat dateFormat = new DateFormat("yyyy-MM-dd");

    return dateFormat.format(x);
  }

  static String getCurrentDate(){
    DateTime dateTime = new DateTime.now();

    DateFormat dateFormat = new DateFormat("yyyy-MM-dd");
    return dateFormat.format(dateTime);
  }

  static String formatDate(String date){
    var dateParse = new DateFormat("dd-MMM-yyyy KK:mm a");
    var dateDisplay = new DateFormat("KK:mm a");

    return dateDisplay.format(dateParse.parse(date));
  }

  static String formatDate2(String date){
    var dateParse = new DateFormat("dd-MMM-yyyy KK:mm a");
    var dateDisplay = new DateFormat("MMM dd, yyyy");

    return dateDisplay.format(dateParse.parse(date));
  }

  static String formatDate3(String date){
    var dateParse = new DateFormat("dd-MMM-yyyy KK:mm a");
    var dateDisplay = new DateFormat("dd-MM-yyyy");

    return dateDisplay.format(dateParse.parse(date));
  }

  static String formatDate4(String date){
    var dateParse = new DateFormat("yyyy-MM-ddThh:mm:ss");
    var dateDisplay = new DateFormat("yyyy-MM-dd");
    return dateDisplay.format(dateParse.parse(date));
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.BOTTOM);
  }

  static bool isValidEmailAddress(String emailAddress) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailAddress);
  }

  static String getTimesDifference(String time1, String time2){
    var timeParse = new DateFormat("dd-MMM-yyyy KK:mm a");
    var timeDisplay = new DateFormat("KK:mm a");

    var TIME_DIFFERENCE;

    var TIME1 = timeParse.parse(time1);
    var TIME2 = timeParse.parse(time2);

    print("${TIME1}  ${TIME2}");

    if(TIME2.isAfter(TIME1)){
      TIME_DIFFERENCE = TIME2.difference(TIME1).inMinutes;

      return TIME_DIFFERENCE.toString();
    }

    return "null";
  }

  static String getStringIn2DecimalPlaces(String str) {
    var doubleValue = double.parse(str);
    return doubleValue.toStringAsFixed(2);
  }


  static void handleInvalidExpiredTokenRequest(ctx) {
    Util.pushAndRemoveUntil(ctx, LoginScreen());
  }

}
