import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/notificiations/InvalidTokenNotification.dart';
import 'package:redkettle/screens/LoginScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/model/paymentmethod.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';

import '../TabbarNotification.dart';


class PaymentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaymentScreenState();
  }
}


class PaymentScreenState extends State<PaymentScreen> {

  showProgressDialog(String loadingString) => showDialog(
      context: context, barrierDismissible: false, builder: (BuildContext context) => ProgressDialog(textString: loadingString,));


  RemoteDataSource _apiResponse = RemoteDataSource();
  var selectedPaymentMethodTitle = '';
  var selectedPaymentMethod = '';
  final unselectedButtonPath = 'assets/icons/unselectedButton.png';
  final selectedButtonPath = 'assets/icons/selctedButton.png';


  final selectedStyle =  TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Oswald',
    fontWeight: FontWeight.w500,
  );

  final unselectedTextStyle = TextStyle(
    color: HexColor.fromHex('333333'),
    fontSize: 20,
    fontFamily: 'Oswald',
    fontWeight: FontWeight.w300,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GestureDetector(
          child: SafeArea(
            child:  Container(
              height: 70,
              color: themeRedColor,
              child: Container(margin: const EdgeInsets.only(top: 20),child: Text("CONTINUE TO CONFIRMATION", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Oswald',fontWeight: FontWeight.w400),)),
            ),

          ),
          onTap:() {

            if(selectedPaymentMethod == null || selectedPaymentMethod == '') {
              Util.showToast('No payment method selected');
            }
            else {

              Map<String, dynamic> p = {
                'payment': {'method': selectedPaymentMethod}
              };
              var body = json.encode(p);
              print(body);

              hitTheSavePaymentAPI(body);

              //testing
              //TabbarNotification(currentTabIndex: 2).dispatch(context);

            }
          },
        ),
        body: FutureBuilder(
          future: _apiResponse.saveShipping(Constants.shipping_api_param),
          builder: (context, AsyncSnapshot<Result> snapshot){
            if (!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeRedColor),
                ),
              );
            }
            if (snapshot.data is SuccessState) {
              final paymentData = ((snapshot.data as SuccessState).value as PaymentMethod);
              Constants.cartData = paymentData.cart;
              Constants.currentOrderID = paymentData.cart.id;
              final methods = paymentData.methods;
              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == methods.length) {
                      return _buildAmountView(grandTotal: paymentData.cart.formatedGrandTotal);
                    }
                    return _buildList(
                        leadingIconPath: 'assets/icons/unselectedButton.png' ,
                        title: methods[index].methodTitle,
                        method: methods[index].method,
                        trailingIconPath: 'assets/icons/unselectedCOD.png');
                  },
                  separatorBuilder: (context, int index) {
                    return Divider(height: 0,);
                  },
                  itemCount: methods.length + 1);
            }
            else if(snapshot.data is ErrorState) {
              final errorMessage = ((snapshot.data as ErrorState).msg);


              final error = errorMessage == "INVALID EXPIRED TOKEN" ? "No payment methods found" : errorMessage;

              return Center(
                child: Text(error
                ),
              );
            }
            else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeRedColor),
                ),
              );
            }
          },
        ),
    );
  }



  Widget _buildList({String leadingIconPath, String title, String method, String trailingIconPath,}) => SizedBox(
    height: 70,
    child: Card(
      elevation: 0,
      margin: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
                title,
                style: selectedPaymentMethodTitle == title ? selectedStyle : unselectedTextStyle
              ),
              trailing: GestureDetector(
                child: Image(
                  height: 20,
                  width: 20,
                  image: selectedPaymentMethodTitle == title ? AssetImage(selectedButtonPath) : AssetImage(unselectedButtonPath),
                ),
                onTap: (){
                  setState(() {
                    selectedPaymentMethodTitle = title;
                    selectedPaymentMethod = method;
                  });
                },
              ),
              leading: Image(
                height: 30,
                width: 30,
                image: AssetImage(trailingIconPath),
              ),
            selected: selectedPaymentMethodTitle == title ? true : false,
          ),
        ],
      ),
    ),
  );

  Widget _buildPaymentView() => SizedBox(
    height: 200,
    child: Card(
      elevation: 0,
      margin: const EdgeInsets.only(left: 0, right: 0),
      color: HexColor.fromHex('fff2f2'),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: themeRedColor)),
                        labelText: "Enter Name",
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  )),
              Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: themeRedColor)
                        ),
                        labelText: "Enter surname",
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: themeRedColor)
                  ),
                  labelText: "Card Number"
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: themeRedColor)
                        ),
                        labelText: "Date",
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  )),
              Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: themeRedColor)
                        ),
                        labelText: "CVV",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ))
            ],
          )
        ],
      ),
    ),
  );

  Widget _buildAmountView({String grandTotal}) => SizedBox (
    height: 120,
    child: Card(
      elevation: 0,
      margin: const EdgeInsets.only(left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(margin: const EdgeInsets.only(left: 19),
                child: Text("Total Amount",
                  style: TextStyle(color: HexColor.fromHex('333333'),
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(margin: const EdgeInsets.only(left: 30),
                child: Text(grandTotal,
                  style: TextStyle(color: themeRedColor,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
            ),
          )
        ],
      ),
    ),
  );



  void hitTheSavePaymentAPI(dynamic param) {
    showProgressDialog('Saving Payment Method');
    _apiResponse
        .savePayment(param)
        .then((result)  {
      if (result is SuccessState)
      {
        print(result.value);
        print('SUCESS SAVE PAYMENT');

        Navigator.pop(context);

        TabbarNotification(currentTabIndex: 2).dispatch(context);

      }
      else if(result is ErrorState)
      {

        if(result.msg == "INVALID EXPIRED TOKEN") {
          print(result.msg);

          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Util.handleInvalidExpiredTokenRequest(context);
        }
        else {
          print(result.msg);

          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Util.showToast(result.msg);
        }


      }
    });
  }
}

