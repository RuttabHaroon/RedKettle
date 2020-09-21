import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/screens/HomeScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';

class SucessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final appBar = AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: themeRedColor,
      leading: Container(
        margin: EdgeInsets.only(left: 30),
        child: IconButton(onPressed: () {
            Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios
            , size: 14,
          ),
        ),
      ),
      title: Text(
        "CHECKOUT",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Oswald',
          fontWeight: FontWeight.w500,
        ),
      )
    );


    return MaterialApp(
      home: Scaffold(
        appBar: appBar,
        body: _buidUI(),
        bottomNavigationBar: _buildBottomNavButton(context)
      ),
    );
  }

  Widget _buidUI() {
    return Column(
      children: <Widget>[
        _buildTextSection(55, 'THANK YOU', themeRedColor, 44, 'Oswald', FontWeight.w800),
        _buildTextSection(0, 'FOR YOUR ORDER', lighterDarkColor, 22, 'Oswald', FontWeight.w500),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextSection(10, 'Order Number: ', lighterDarkColor, 17, 'Ubuntu', FontWeight.w400),
            _buildTextSection(10, '# ${Constants.currentOrderID}', lighterDarkColor, 18, 'Ubuntu', FontWeight.w500),
          ],
        ),
        _buildImageSection(32, 600, 300),
        _buildTextSection(35, 'ESTIMATED DELIVERY', Colors.black, 27, 'Ubuntu', FontWeight.w500),
        _buildTextSection(5, 'Monday June 30, 2019', redColor, 22, 'Oswald', FontWeight.w400),
      ],
    );
  }


  Widget _buildTextSection(double topInset, String text, Color textColor, double fontSize, String fontFamily, FontWeight fontWeight) {
    return Container(
      margin: EdgeInsets.only(top: topInset),
      child: Text(
        text,
        style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontWeight: fontWeight
        ),
      ),
    );
  }


  Widget _buildImageSection(double topInset, double width, double height) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child:
      Container(
        margin: EdgeInsets.only(top: topInset),
        child: Image.asset('${Constants.iconsPath}Layer 3@3x.png',
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _buildBottomNavButton(BuildContext ctx) {
    return SafeArea(
      child: BottomAppBar(
        elevation: 0,
        child: GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              alignment: Alignment.center,
              height: 70,
              color: themeRedColor,
              child: Text('CONTINUE SHOPPING', style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w500
              ),
              ),
            ),
            onTap: (){
              Util.pushAndRemoveUntil(ctx, HomeScreen());
            }
        ),
      ),
    );
  }

}

//Util.pushAndRemoveUntil(ctx, SucessScreen());