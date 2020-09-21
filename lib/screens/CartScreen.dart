import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/cart.dart' as ACart;
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/notificiations/InvalidTokenNotification.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';

import 'CheckoutScreen.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  RemoteDataSource _apiResponse = RemoteDataSource();

  var cartItems = [];
  var totalPriceOfItems = '';


  showProgressDialog(String loadingString) => showDialog(
      barrierDismissible: false, context: context, builder: (BuildContext context) => ProgressDialog(textString: loadingString,));

  showLoader() => Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(themeRedColor),
      ));


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiResponse.init();
    hitTheUpdateItemInCartAPI();
  }


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
        "CART",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Oswald',
          fontWeight: FontWeight.w500,
        ),
      )
    );


    Widget _buildBottomBar() {
      return Container(
        child: SafeArea(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: GestureDetector(
                  child: Container(
                    height: 50,
                    color: themeRedColor,
                    child: Center(
                      child: Text(
                        'PLACE THIS ORDER',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  onTap: (){
                    Util.navigateView(context, CheckoutScreen());
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      totalPriceOfItems,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget cartItem(ACart.Item item) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 80,
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.name,
                              style: TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 19,
//                        fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              Util.getStringIn2DecimalPlaces(item.price),
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                color: themeRedColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(0.0),
                                    width: 30.0, // you can adjust the width as you need
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                onPressed: (){
                                  print('ADD');
                                  final qty = item.quantity + 1;
                                  Map<String, dynamic> param = {'qty': qty.toString(), 'item_id': item.id.toString()};
                                  _apiResponse.updateItemInCart(param);
                                },
                              ),
                              Container(
                                height: 40,
                                width: 40,
//                        color: Colors.lightBlue,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    item.quantity.toString(),
                                    style:
                                    TextStyle(color: themeRedColor, fontSize: 17),
                                  ),
                                ),
                              ),
                              FlatButton(
                                child: Container(
                                  padding: const EdgeInsets.all(0.0),
                                  width: 30.0, // you can adjust the width as you need
                                  child: Icon(
                                    Icons.minimize,
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: (){
                                  print('SUBTRACT');
                                  final qty = (item.quantity - 1) > 1 ? (item.quantity - 1) : 1;
                                  if(qty <= 1) {

                                  }
                                  else {
                                    Map<String, dynamic> param = {'qty': qty.toString(), 'item_id': item.id.toString()};
                                    _apiResponse.updateItemInCart(param);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
              Divider(
                height: 0.5,
                thickness: 0.5,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildUI() {
      return FutureBuilder(
        future: _apiResponse.getCartDetails(),
        builder: (context, AsyncSnapshot<Result> snapshot) {
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeRedColor),
              ),
            );
          }
          if (snapshot.data is SuccessState) {
            if ((snapshot.data as SuccessState).value == 'No item in cart') {
              return Center(
                child: Text((snapshot.data as SuccessState).value
                ),
              );
            }

            final cart = ((snapshot.data as SuccessState).value as ACart.Cart);
            cartItems = cart.items;
            totalPriceOfItems = cart.formatedBaseGrandTotal;
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    itemCount: cartItems.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: new ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return new  Dismissible(
                          key: new Key(index.toString()),
                          child: cartItem(cartItems[index]),
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.red,
                          child: Icon(Icons.delete,
                            color: Colors.white,
                            size: 55,),
                        ),
                        onDismissed: (direction){
                            hitTheRemoveItemFromCartAPI(itemID: cartItems[index].id, itemName: cartItems[index].product.name);
                        },
                        direction: DismissDirection.endToStart,
                      );
                      return cartItem(cartItems[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                  ),
                ),
                _buildBottomBar(),
              ],
            );
          }
          else if(snapshot.data is ErrorState) {

            final errorMessage = ((snapshot.data as ErrorState).msg);

            if ((snapshot.data as ErrorState) != null){
              return Center(
                child: Text('No item in cart'
                ),
              );
            }
           return Center(
              child: Text(errorMessage
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
      );
    }

    return Scaffold(
      appBar: appBar,
      body: _buildUI(),
    );
  }


//  void hitTheUpdateItemInCartAPI({dynamic param}) {
//    _apiResponse
//        .updateItemInCart(param)
//        .then((result) {
//      if(result is SuccessState)
//        {
//          final cart = (result.value as ACart.Cart);
//          setState(() {
//            cartItems = cart.items;
//          });
//          print(result.value);
//        }
//      else if (result is LoadingState)
//        {
//        }
//      else if (result is ErrorState)
//          {
//            print(result.msg);
//          }
//    });
//  }

  void hitTheUpdateItemInCartAPI() {
    _apiResponse.hasCartItemUpdated().listen((Result result) {
      if (result is LoadingState) {
        showProgressDialog('UPDATING CART');
      } else if (result is SuccessState) {
        print(result.value as ACart.Cart);
        final cart = result.value as ACart.Cart;
        setState(() {
          cartItems = cart.items;
        });

        Future.delayed(const Duration(milliseconds: 1300), () {
          Navigator.pop(context);
        });
        
      } else if (result is ErrorState) {
        if(result.msg == "INVALID EXPIRED TOKEN") {
          print(result.msg);
          Navigator.pop(context);
          Util.handleInvalidExpiredTokenRequest(context);
        }
        else {
          print(result.msg);
          Navigator.pop(context);
          Util.showToast('Unable to update item');
        }
      }
    });
  }

  void hitTheRemoveItemFromCartAPI({int itemID, String itemName}){
    showProgressDialog('Removing from cart');
    _apiResponse
        .removeItemInCart(itemID)
        .then((result) {
          if (result is SuccessState){
              var cart = (result.value as ACart.Cart);
              Navigator.pop(context);
              Util.showToast('$itemName removed from cart');
              setState(() {
                if (cart.items == null) {
                  cartItems.clear();
                }
                if (cart.formatedBaseGrandTotal == null) {
                  totalPriceOfItems = '\$0';
                }
              });
          }
          else if (result is ErrorState){
            if(result.msg == "INVALID EXPIRED TOKEN") {
              print(result.msg);
              Navigator.pop(context);
              Util.handleInvalidExpiredTokenRequest(context);
            }
            else {
              print(result.msg);
              Navigator.pop(context);
              Util.showToast(result.msg);
            }
          }
    // ignore: empty_statements
    }).catchError((error) => {print(error)});
  }

}



