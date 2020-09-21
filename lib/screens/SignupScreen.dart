import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/HomeScreen.dart';
import 'package:redkettle/screens/LoginScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  showProgressDialog(String loadingString) => showDialog(
      context: context, barrierDismissible: false,  builder: (BuildContext context) => ProgressDialog(textString: loadingString,));

  RemoteDataSource _apiResponse = RemoteDataSource();

  final _formKey = GlobalKey<FormState>();
  var shouldObscurePasswordText = true;
  var shouldObscureConfirmPasswordText = true;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final focus = FocusNode();



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _buildUI(context, screenWidth),
    );
  }

  Widget _buildUI(BuildContext ctx, double screenWidth) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildUpperSection(screenWidth),
          _buildFormSection(),
          _registerButtonSection(ctx),
          _bottomNavButton(),
        ],
      ),
    );
  }

  Widget _buildUpperSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Image(
            height: 210,
            width: screenWidth,
            image: AssetImage(
              '${Constants.imagesPath}login-cover-bg.png',
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25, top: 50),
          child: Text(
            'Please sign up',
            style: TextStyle(
                color: Colors.black,
                //fontFamily: 'Oswald',
                fontSize: 22,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 25, top: 25, right: 25),
          child: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            controller: _firstNameController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: disableRedColor),
                //  when the TextFormField in unfocused
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeRedColor),
                //  when the TextFormField in focused
              ),
              border: UnderlineInputBorder(),
              hintText: 'First Name',
              suffixIcon: Image(
                height: 16,
                width: 16,
                image:
                AssetImage('${Constants.iconsPath}Icon awesome-user-alt.png'),
              ),
            ),
            validator: (firstName) {
              if (firstName.isEmpty || firstName.length < 3) {
                return "First name should be longer";
              }
              return null;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25, top: 15, right: 25),
          child: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            controller: _lastNameController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: disableRedColor),
                //  when the TextFormField in unfocused
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeRedColor),
                //  when the TextFormField in focused
              ),
              border: UnderlineInputBorder(),
              hintText: 'Last Name',
              suffixIcon: Image(
                height: 16,
                width: 16,
                image:
                AssetImage('${Constants.iconsPath}Icon awesome-user-alt.png'),
              ),
            ),
            validator: (lastName) {
              if (lastName.isEmpty || lastName.length < 3) {
                return "Last name name should be longer";
              }
              return null;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25, top: 15, right: 25),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: disableRedColor),
                //  when the TextFormField in unfocused
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeRedColor),
                //  when the TextFormField in focused
              ),
              border: UnderlineInputBorder(),
              hintText: 'Email',
              suffixIcon: Image(
                height: 16,
                width: 16,
                image:
                AssetImage('${Constants.iconsPath}Icon material-email-1.png'),
              ),
            ),
            validator:  (email)=> EmailValidator.validate(email) ? null : "Invalid email address",
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25, top: 15, right: 25),
          child: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focus),
            controller: _passwordController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: disableRedColor),
                //  when the TextFormField in unfocused
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeRedColor),
                //  when the TextFormField in focused
              ),
              border: UnderlineInputBorder(),
              hintText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  shouldObscurePasswordText == true ? Icons.visibility : Icons.visibility_off,
                  color: themeRedColor,
                ),
                onPressed: (){
                  setState(() {
                    shouldObscurePasswordText == false ? shouldObscurePasswordText = true : shouldObscurePasswordText = false;
                  });
                },
              ),
            ),
            obscureText: shouldObscurePasswordText,
            validator: (password) {
              if (password.isEmpty || password.length < 3) {
                return "Password should contains more then 5 character";
              }
              return null;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25, top: 15, right: 25),
          child: TextFormField(
            keyboardType: TextInputType.text,
            focusNode: focus,
            textInputAction: TextInputAction.done,
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: disableRedColor),
                //  when the TextFormField in unfocused
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeRedColor),
                //  when the TextFormField in focused
              ),
              border: UnderlineInputBorder(),
              hintText: 'Confirm Password',
              suffixIcon:IconButton(
                icon: Icon(
                  shouldObscureConfirmPasswordText == false ? Icons.visibility : Icons.visibility_off,
                  color: themeRedColor,
                ),
                onPressed: (){
                  setState(() {
                    shouldObscureConfirmPasswordText == false ? shouldObscureConfirmPasswordText = true : shouldObscureConfirmPasswordText = false;
                  });
                },
              ),
            ),
            obscureText: shouldObscureConfirmPasswordText,
            validator: (confirm) {
              if(confirm != _passwordController.text){
                return 'Passwords donot match';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _registerButtonSection(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.only(left: 22, right: 22, top: 38),
      child: FlatButton(
        child: Text(
          'REGISTER',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Oswald',
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        onPressed: () {
          print('REGISTER WAS PRESSED');
          if(_formKey.currentState.validate()) {
            //Util.showToast('API WOULD HAVE BEEN HIT');
            hitRegisterAPI();
          }
          else {
            Util.showToast('Invalid credentials');
          }
        },
      ),
      color: themeRedColor,
      height: 65,
    );
  }

  Widget _bottomNavButton() {
    return Container(
        margin: EdgeInsets.only(left: 9, right: 6, top: 14),
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              child: FlatButton(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Align(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Ubuntu',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                ),
                onPressed: (){
                  Util.navigateViewWithPop(context, LoginScreen());
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Container(
              width: 155,
              child: FlatButton(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: themeRedColor,
                      ),
                    ),
                  )),
            ),
          ],
        ));
  }

  void hitRegisterAPI(){

    final String firstName = _firstNameController.text ;
    final String lastName = _lastNameController.text ;
    final String email = _emailController.text ;
    final String password = _passwordController.text ;
    final String confirmPassword = _confirmPasswordController.text;

    
    showProgressDialog('Signing Up');
    
    Map<String, dynamic> param = {
      'first_name': firstName,
      'last_name':lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    _apiResponse.registerUser(param: param).then((result) => {
      if (result is SuccessState){
        print(result.value),
        print('REGISTERED USER SUCESS'),
        Navigator.pop(context),
        Navigator.pop(context),
        Util.showToast("User registered successfully"),
      }
      else if(result is ErrorState) {
        print(result.msg),
        Navigator.pop(context),
        Util.showToast(result.msg),
      }

    }).catchError((error) => {
      print(error)
    });
  }


}


