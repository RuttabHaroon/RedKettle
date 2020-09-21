import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/appstatemanager.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/model/userpref.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/LoginScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';
import 'package:redkettle/widget/Widgets.dart';
import 'dart:math' as math;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}


final rowImages = ['','Male User.png','Envelope copy 4.png','Group 1773.png','Lock  copy 5.png','', ''];

var rowItems = new List(7);

class _ProfileScreenState extends State<ProfileScreen> {

  showProgressDialog(String loadingString) => showDialog(
      context: context, barrierDismissible: false,  builder: (BuildContext context) => ProgressDialog(textString: loadingString,));

  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  Widget build(BuildContext context) {

    changeStatusBarColor(color: Colors.black, isWhiteForground: true);


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
        "PROFILE",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Oswald',
          fontWeight: FontWeight.w500,
        ),
      ),
    );


    return Scaffold(
      body: _buildRowSection(),
    );

    // TODO: implement build
    throw UnimplementedError();
  }

  Widget _buildRowSection() {
    return ListView.separated(itemBuilder: (context, index) {
      return _buildingRow(index, rowItems[index], rowImages[index]);
    }, separatorBuilder: (context, index) {
      return Divider(
        height: 1.0,
        color: Colors.black38,
      );
    }, itemCount: rowItems.length);
  }

  Widget _buildingRow(int index, String text, String imageName) {
    if(index == 0) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('${Constants.imagesPath}11m.png'),
              radius: 68,
            ),
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(68), bottomRight:  Radius.circular(68)),
              child: Container(
                height: 30,
                width: 110,
                //margin: EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(120), bottomRight:  Radius.circular(120)),
                  color: Colors.transparent,
                  image: DecorationImage(image: AssetImage('${Constants.iconsPath}editHalfCirle@3x.png'),),
                ),
              ),
            )
          ],
        ),
      );
    }
    else if(index == 5) {
      return Divider(
        height: 1.0,
        color: Colors.black38,
      );
    }
    else if(index == 6) {
      return Container(
        height: 60,
        child: FlatButton(
          color: themeRedColor,
          child: Text('LOGOUT',
            style: TextStyle(color: Colors.white),),
          onPressed: (){
            hitTheLogoutAPI();
          },
        ),
      );
    }
    else {
      return Container(
        margin: EdgeInsets.only(top: 10,bottom: 10, left: 10),
        child:  ListTile(
          title: textToDisplay(index),
          leading: Image.asset('${Constants.iconsPath}$imageName',
            width: 32,
            height: 32,),
        ),
      );
    }
  }


  Widget textToDisplay(int index) {
    if (index == 1){
      return Text(AppStateManager.shared.loginUserData.user.name,
        style: TextStyle(fontFamily: 'BebasNeue',
            fontSize: 20,
            color: Colors.black),);
    }
    else if (index == 2){
      return Text(AppStateManager.shared.loginUserData.user.email,
        style: TextStyle(fontFamily: 'BebasNeue',
            fontSize: 20,
            color: Colors.black),);
    }
    else if (index == 3){
      return Text(AppStateManager.shared.loginUserData.user.phone ?? 'N/A',
          style: TextStyle(fontFamily: 'BebasNeue',
              fontSize: 20,
              color: Colors.black));
    }
    else if (index == 4){
      return Text('Change Password');
    }
  }

  void hitTheLogoutAPI() {
    showProgressDialog('Logging out');
    _apiResponse
        .logoutUser()
        .then((result) => {
      if (result is SuccessState)
        {
          print('LOGGEDOUT SUCESS'),
          print(result.value),

          UserPref.removeUserData(), //remove data from shared preference,
          Constants.bearerTOKEN = '',
          AppStateManager.shared.loginUserData = null,

          Navigator.pop(context),
          Util.pushAndRemoveUntil(context, LoginScreen()),

        }
      else if (result is ErrorState)
        {
          if(result.msg == "INVALID EXPIRED TOKEN") {
            print(result.msg),
            Navigator.pop(context),
            Util.handleInvalidExpiredTokenRequest(context),
          }
          else {
            print(result.msg),
            Navigator.pop(context),
            Util.showToast(result.msg)
          }
        }
    })
        .catchError((error) => {print(error)});
  }
}
