import 'package:flutter/material.dart';
import 'package:redkettle/TabbarNotification.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/order.dart' as AnOrder;
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/PaymentWebviewScreen.dart';
import 'package:redkettle/screens/SucessScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';


class ConfirmationScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return ConfirmationState();
  }
}

class ConfirmationState extends State<ConfirmationScreen> {

  showProgressDialog(String loadingString) => showDialog(
      context: context, barrierDismissible: false,  builder: (BuildContext context) => ProgressDialog(textString: loadingString,));

  RemoteDataSource _apiResponse = RemoteDataSource();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // title: Text("Confirmation"),
      //),
      bottomNavigationBar: GestureDetector(
        child: SafeArea(
          child: Container(
            height: 60,
            color: themeRedColor,
            child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  "ORDER NOW",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w500),
                )
            ),
          ),
        ),
        onTap: (){
          hitTheSaveOrderAPI();
        },
      ),
      body: ListView(
        children: <Widget>[
          _buildList(),
          Divider(
            height: 1.0,
          ),
          _buildOrdersView(),
          _buildPaymentSummaryView()
        ],
      ),
      backgroundColor: Colors.white,
    );
  }


  Widget _buildList() => SizedBox(
    child: Card(
      elevation: 0,
      child: Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 0),
          child: ListTile(
            title: Text(
              "SHIPPING TO",
              style: TextStyle(
                color: HexColor.fromHex('#333333'),
                fontFamily: 'BebasNeue',
                fontSize: 19,
                fontWeight: FontWeight.w300,
              ),
            ),
            subtitle: Text(
              Constants.cartData.customerFirstName + ' ' + Constants.cartData.customerLastName + '\n${Constants.cartData.billingAddress.address1}',
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                  color: Colors.grey[700]),
            ),
            trailing: GestureDetector(
              child: Container(
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              onTap: () {
                TabbarNotification(currentTabIndex: 0).dispatch(context);
              },
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildOrdersView() {
    return Container(
      margin: EdgeInsets.only(top: 22),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "YOUR ORDER",
                    style: TextStyle(
                      color: HexColor.fromHex('#333333'),
                      fontFamily: 'BebasNeue',
                      fontSize: 19,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      "Edit",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  onTap: () {
                    print("ORDER EDIT TAPPED");
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
          Container(
            height: Constants.cartData.items.length.toDouble() * 130,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: Constants.cartData.items.length,
              itemBuilder: (BuildContext context, int index) {
                return productListing(productName:Constants.cartData.items[index].name,
                  productPrice: Constants.cartData.items[index].formatedPrice,
                  productQuantity: Constants.cartData.items[index].quantity,
                ); //Text("play");
              },
            ),
          )
        ],
      ),
    );
  }

  Widget productListing({String productName, String productPrice, int productQuantity}) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 88,
                width: 88,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1, //                   <--- border width here
                  ),
                ),
                child: Image.asset("${Constants.imagesPath}coffeeBag.png"),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          productName,
                          style: TextStyle(
                            fontFamily: 'BebasNeue',
                            fontSize: 22,
//                        fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          productPrice,
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            color: themeRedColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                ),
              ),
              Container(height: 57,
                  width: 60,
                  child: Text(' Qty: ' + productQuantity.toString(),
                  ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPaymentSummaryView() => SizedBox(
    child: Container(
      color: HexColor.fromHex('#FFF2F2'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            child: ListTile(
              title: Text(
                "Payment Summary",
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            height: 35,
            padding: EdgeInsets.only(bottom: 5),
            child: ListTile(
              title: Text(
                "Order Total",
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Text(
                Constants.cartData.formatedGrandTotal,
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              "Delivery Charge",
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: Text(
              "Free",
              style: TextStyle(
                  fontFamily: 'Oswald',
                  color: themeRedColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              "Total Amount",
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              Constants.cartData.formatedGrandTotal,
              style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: themeRedColor),
            ),
          )
        ],
      ),
    ),
  );


  void hitTheSaveOrderAPI() {
    showProgressDialog('Saving Order Method');
    _apiResponse
        .saveOrder()
        .then((result)  {
      if (result is SuccessState)
      {
        print(result.value);
        print('SUCESSS SAVE ORDER');


        final response = result.value["redirect_url"];
        print(response);

        final o = (AnOrder.Order.fromMap(result.value["order"]));
        Constants.currentOrderID = o.id;


        Navigator.pop(context);

        if(response == '') {
          Util.navigateView(context, SucessScreen());
        }
        else {
          Util.navigateView(context, PaymentWebviewScreen(selectedUrl: response,));
        }

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
