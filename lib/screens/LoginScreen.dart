import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/appstatemanager.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/HomeScreen.dart';
import 'package:redkettle/screens/SignupScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';
import 'package:redkettle/widget/Widgets.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  showProgressDialog(String loadingString) => showDialog(
    barrierDismissible: false, context: context, builder: (BuildContext context) => ProgressDialog(textString: loadingString,));

  RemoteDataSource _apiResponse = RemoteDataSource();

  var shouldObscureText = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  bool isEmailValid = true;
  bool isPasswordValid = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _emailController.addListener(_checkEmailValid);
    //_passwordController.addListener(_checkPasswordValid);
  }


  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(color: Colors.black, isWhiteForground: true);

    var body = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                child: Image(
                  image: AssetImage('${Constants.imagesPath}login-cover-bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  width: 200,
                  child: Text(
                    'Welcome Back',
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -37.0, 0.0),
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                print('skip press');
                if(isEmailValid && isPasswordValid && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                  hitTheLoginAPI();
                }
                else {
                  isEmailValid = false;
                  isPasswordValid = false;
                  Util.showToast('Invalid username or password');
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeRedColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      Text(
                        'Skip',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 4, left: 25),
            child: Text(
              'Please sign in',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.only(left: 25, bottom: 15, right: 25),
            child: TextField(
              maxLines: 1,
              cursorColor: themeRedColor,
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (_) {
                _checkEmailValid();
                FocusScope.of(context).nextFocus();
              },
              textInputAction: TextInputAction.next,
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
                  errorText: isEmailValid == true ? '' : 'Invalid email'
              ),
            )
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: TextField(
                  maxLines: 1,
                  cursorColor: themeRedColor,
                  onSubmitted: (_) {
                    _checkPasswordValid();
                    FocusScope.of(context).unfocus();
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
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
                    errorText: isPasswordValid == true ? '' : 'Invalid password',
//                  suffixIcon: IconButton(
//                    icon: Icon(
//                      shouldObscureText == false ? Icons.visibility : Icons.visibility_off,
//                      color: themeRedColor,
//                    ),
//                    onPressed: (){
//                      setState(() {
//                        shouldObscureText = !shouldObscureText;
//                      });
//                    },
//                  )
                  ),
                  obscureText: shouldObscureText,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: IconButton(
                  color: Colors.yellow,
                  icon: Icon(
                    shouldObscureText == false ? Icons.visibility : Icons.visibility_off,
                    color: themeRedColor,
                  ),
                  onPressed: (){
                    setState(() {
                      print('it was tapped');
                      shouldObscureText = !shouldObscureText;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                FlatButton(
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black54),
                  ),
                  onPressed: (){
                    Util.navigateViewWithPop(context, SignupScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: body,
    );

  }

  void hitTheLoginAPI() {

    showProgressDialog('Logging in');

    String email = _emailController.text;
    String password = _passwordController.text;

//    email = 'ruttab@eplanetcom.com';
//    password = 'testtest';

    Map<String, dynamic> param = {'email': email, 'password': password};
    _apiResponse.loginUser(param: param)
        .then((result) => {
      if (result is SuccessState)
        {
          print(result.value),
          print('LOGGEDIN SUCESS'),
          Constants.bearerTOKEN = AppStateManager.shared.loginUserData.token,
          print(AppStateManager.shared.loginUserData.user.name),
          Util.pushAndRemoveUntil(context, HomeScreen()),
          Util
        }
      else if (result is ErrorState)
        {
          print(result.msg),
          Navigator.pop(context),
          Util.showToast(result.msg),
        }

    })
        .catchError((error) => {print(error)});
  }


  void _checkEmailValid(){
    setState(() {
      isEmailValid = EmailValidator.validate(_emailController.text) ? true : false;
    });
  }

  void _checkPasswordValid(){
    setState(() {
      if (_passwordController.text.isEmpty || _passwordController.text.length < 6) {
        isPasswordValid = false;
      }
      else {
        isPasswordValid = true;
      }
    });
  }

}

//Align(
//alignment: Alignment.bottomRight,
//child: InkWell(
//onTap: () {
//print('skip press');
//
//if(isEmailValid && isPasswordValid && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
//hitTheLoginAPI();
//}
//else {
//isEmailValid = false;
//isPasswordValid = false;
//Util.showToast('Invalid username or password');
//}
//},
//child: Container(
//margin: EdgeInsets.only(right: 20),
//width: 80,
//height: 80,
//decoration: BoxDecoration(
//shape: BoxShape.circle,
//color: themeRedColor,
//),
//child: Center(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Icon(
//Icons.arrow_forward,
//color: Colors.white,
//),
//Text(
//'Skip',
//style: TextStyle(color: Colors.white, fontSize: 17),
//),
//],
//),
//),
//),
//),
//),