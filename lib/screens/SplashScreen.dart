import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/userpref.dart';
import 'package:redkettle/screens/HomeScreen.dart';
import 'package:redkettle/screens/SignupScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/widget/Widgets.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatelessWidget {

  final GlobalKey _globalKey = new GlobalKey();


  @override
  Widget build(BuildContext context) {
//    changeStatusBarColor(color: gradientStartColor, isWhiteForground: true);
    final size = MediaQuery.of(context).size;
    Future.delayed(const Duration(seconds: 3), () {
     // Util.pushAndRemoveUntil(_globalKey.currentContext , new LoginScreen());
      navigateUser();
    });

    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("${Constants.imagesPath}splash-bg.png",
                scale: 1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Image.asset(
                "${Constants.imagesPath}splashLogo.png",
                scale: 2.5,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 80, left: 60, right: 60, bottom: 30),
              child: Container(
                padding: const EdgeInsets.all(0.1),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xff317ab),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LinearPercentIndicator(
                    lineHeight: 15.0,
                    //percent: progress,
                    percent: 1.0,
                    animation: true,
                    animationDuration: 2000,
                    padding: EdgeInsets.zero,
                    linearStrokeCap: LinearStrokeCap.butt,
                    backgroundColor: Colors.transparent,
                    progressColor: themeRedColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  void navigateUser() async{
    UserPref.retrieveUserDate().then((value) => {
      Util.pushAndRemoveUntil(_globalKey.currentContext, HomeScreen())
    }).catchError((err) {
      print(err);
      Util.pushAndRemoveUntil(_globalKey.currentContext , new LoginScreen());
    });
  }
}
