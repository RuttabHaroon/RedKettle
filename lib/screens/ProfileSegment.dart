import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redkettle/TabbarNotification.dart';
import 'package:redkettle/UpdateAddressNotification.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/cart.dart';
import 'package:redkettle/model/checkout_address_param.dart';
import 'package:redkettle/model/address.dart';
import 'package:redkettle/model/country.dart';
import 'package:redkettle/model/category.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/model/shippingmethod.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/PaymentScreen.dart';
import 'package:redkettle/screens/SucessScreen.dart';
import 'package:redkettle/screens/UpdateAddressScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'ProfileScreen.dart';
import 'OrdersScreen.dart';



class ProfileSegment extends StatefulWidget {
  @override
  _ProfileSegmentState createState() => _ProfileSegmentState();
}

class _ProfileSegmentState extends State<ProfileSegment> {

  @override
  Widget build(BuildContext context) {

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
        "Profile",
        style: TextStyle(color: Colors.white,
          fontSize: 20,
          fontFamily: 'Oswald',
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: ProfileSegmentControl(),
    );
  }
}

class ProfileSegmentControl extends StatefulWidget {
  @override
  _ProfileSegmentControlState createState() => _ProfileSegmentControlState();
}

class _ProfileSegmentControlState extends State<ProfileSegmentControl> {
  bool isLeftButtonClicked = true;


  List<Widget> pages = [];


  changeStyle(bool isLeft) {
    setState(() {
      isLeftButtonClicked = isLeft;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pages = [
      ProfileScreen(),
      OrdersScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          child: _buildSegmentSection(),
          preferredSize: Size(double.infinity, 0),
        ),
        leading: Container(),
      ),
      body: pages[isLeftButtonClicked ? 0 : 1],
      // bottomNavigationBar: isLeftButtonClicked ? _buildNewAddressBottomNavButton() : _buildSavedAddressBottomNavButton()
    );
    throw UnimplementedError();
  }


  Widget _buildSegmentSection() {
    if (!isLeftButtonClicked) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSegmentButton(
              'Profile', Colors.white, Colors.grey, Colors.grey[700], true,
              1),
          _buildSegmentButton(
              'Orders', themeRedColor, Colors.transparent, Colors.white,
              false, 0),
        ],
      );
    }
    else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSegmentButton(
              'Profile', themeRedColor, Colors.transparent, Colors.white,
              true, 0),
          _buildSegmentButton(
              'Orders', Colors.white, Colors.grey, Colors.grey[700],
              false, 1),
        ],
      );
    }
  }


  Widget _buildSegmentButton(String title,
      Color backgroundColor,
      Color borderColor,
      Color textColor,
      bool isLeftButton,
      int btnIndex) {
    return Expanded(
      child: Container(
        child: Padding(
          child: FlatButton(
            child: Text(title,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Oswald',
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),),
            onPressed: () => changeStyle(isLeftButton ? true : false),
          ),
          padding: EdgeInsets.all(0),
        ),
        margin: (isLeftButton) ? EdgeInsets.only(left: 30) : EdgeInsets.only(
            right: 30),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: (isLeftButton) ? BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6)
          ) :
          BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6)
          ),
          color: backgroundColor,
        ),
        height: 45,
      ),
    );
  }

}
