import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/category.dart';
import 'package:redkettle/model/product.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/PaymentScreen.dart';
import 'package:redkettle/screens/ShippingScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';

import 'CartScreen.dart';
import 'CheckoutScreen.dart';
import 'ConfirmationScreen.dart';



var selectedItemIndex = 0;

class ProductScreen extends StatefulWidget {

  Product product;
  List<Category> categoriesList;
  int selectedCategoryIndex;

  ProductScreen(
      {Key key,
        @required this.product,
        @required this.categoriesList,
        @required this.selectedCategoryIndex,})
      : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  int productQuantity = 1;
  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: themeRedColor,
        leading: Container(
          margin: EdgeInsets.only(left: 30),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 14,
            ),
          ),
        ),
        title: Text(
          "PRODUCT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w500,
          ),
        ));

    return Scaffold(
      appBar: appBar,
      body: Center(
          child: _buildUI()
      ),
      bottomNavigationBar: _buildButtonSection(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildProducSection(),
          _buildCategoriesSection(),
        ],
      ),
    );
  }

  Widget _buildProducSection() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          child: Image.asset(
            ('${Constants.imagesPath}coffeeBag.png'),
            fit: BoxFit.contain,
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 34),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontSize: 29,
                        fontWeight: FontWeight.w500,
                        height: 0),
                  )),
              Container(
                child: Text(
                  Util.getStringIn2DecimalPlaces(widget.product.price),
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: themeRedColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
  
  Widget _buildCategoriesSection() {
    return Container(
      color: HexColor.fromHex('FdF3F1'),
      height: widget.categoriesList.length * 60.0,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 30, top: 17, bottom: 5),
                    child: GestureDetector(
                      child: (widget.selectedCategoryIndex == widget.categoriesList[index].id)
                          ? Image.asset(
                        '${Constants.iconsPath}Group 1772@3x.png',
                        width: 32,
                        height: 32,
                      )
                          : Image.asset(
                        '${Constants.iconsPath}unSelectRadioButton@3x.png',
                        width: 27,
                        height: 27,
                      ),
                      onTap: () {
                      },
                    )),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 17, bottom: 5),
                  child: Text(
                    widget.categoriesList[index].name,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 0.0,
              color: Colors.transparent,
            );
          },
          itemCount: widget.categoriesList.length),
    );
  }

  Widget _buildButtonSection() {
    return SafeArea(
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 62,
                color: Colors.black,
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: themeRedColor),
                  child: DropdownButtonFormField(
                    icon: Image.asset('${Constants.iconsPath}Forma -4@3x.png',
                    alignment: Alignment.bottomLeft,
                    height: 17,
                    width: 17,),
                    decoration: decoration('Qty: '),
                    value: productQuantity,
                    items: [
                      DropdownMenuItem(
                        child: Center(
                          child: Text("1", style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Oswald',
                              fontSize: 19,
                              fontWeight: FontWeight.w500,),
                          ),
                        ),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Center(
                          child: Text("2", style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Oswald',
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                          ),
                        ),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Center(
                          child: Text("3", style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Oswald',
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                          ),
                        ),
                        value: 3,
                      ),
                      DropdownMenuItem(
                          child: Center(
                            child: Text("4", style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Oswald',
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                          ),
                        value: 4,
                      ),
                      DropdownMenuItem(
                        child: Center(
                          child: Text("5", style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Oswald',
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                          ),
                        ),
                        value: 5,
                      ),
                    ],
                    onChanged: (value) {
                        setState(() {
                          productQuantity = value;
                        });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                child: Container(
                  color: themeRedColor,
                  padding: EdgeInsets.all(17),
                  child: Text(
                    'ADD TO CART',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Oswald',
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                  ),
                ),
                  onTap: () {
                    hitTheAddToCartAPI();
                  }),
              ),
          ],
        ),
      ),
    );
  }

  showProgressDialog() => showDialog(context: context, barrierDismissible: false,  builder: (BuildContext context) => ProgressDialog(textString: 'Adding Item to cart',));
  void hitTheAddToCartAPI() {
    final Map<String, dynamic> param = {
      'product_id': widget.product.id.toString(),
      'quantity': productQuantity.toString(),
      'is_configurable': 'false'
    };

    showProgressDialog();
    _apiResponse.addItemToCart(param: param).then((result) => {
      if (result is SuccessState) {
        print(result.value),
        Navigator.pop(context),
        Util.navigateView(context, CartScreen())
      }
      else if(result is ErrorState) {
        if(result.msg == "INVALID EXPIRED TOKEN") {
          print(result.msg),
          Navigator.pop(context),
          Util.handleInvalidExpiredTokenRequest(context),
        }
        else {
          print(result.msg),
          Navigator.pop(context),
        }
      }
    });
  }


  InputDecoration decoration(String prefixText) {
    return InputDecoration(
      hintText: 'Select a quantity',
      hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: 'Poppins-Regular',
          color: const Color(0xff94A5A6)), 
        prefixText: prefixText, 
        prefixStyle: TextStyle(
            color: Colors.white, 
            fontFamily: 'Oswald', 
            fontSize: 19, 
            fontWeight: FontWeight.w500),
        border: InputBorder.none, 
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20)
    );
  }

}
