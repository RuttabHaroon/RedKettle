import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/category.dart';
import 'package:redkettle/model/product.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/CartScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';

import 'ProductScreen.dart';


class ShopScreen extends StatefulWidget {

  int currentCategoryID = 0;
  int currentParentID = 0;
  ShopScreen(
      {Key key,
        @required this.currentCategoryID,
        @required this.currentParentID,})
      : super(key: key);


  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  RemoteDataSource _apiResponse = RemoteDataSource();
  var categories = [];
  var products = [];

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
        child: IconButton(onPressed: () {
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios
            , size: 14,
          ),
        ),
      ),
      title: Text(
        "SHOP",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Oswald',
          fontWeight: FontWeight.w500,
        ),
      )
    );


    return Scaffold(
        appBar: appBar,
        body: _buildUI(context)
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
        child: Column(
          children: <Widget>[
            _buildCategoriesScroll(),
            Expanded(
              child: _buildProductScroll(context),
            )
          ],
        )
    );
  }

  Widget _buildCategoriesScroll() {
    return Container(
        color: Colors.black12.withAlpha(12),
        padding: EdgeInsets.only(top: 30, left: 8),
        height: 85,
        child: FutureBuilder(
          future: _apiResponse.fetchCategories(parentID: widget.currentParentID),
          builder: (context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              final fetchedCategories = ((snapshot.data as SuccessState).value as List<Category>);
              categories = fetchedCategories;
              return ListView.builder(itemBuilder: (context, index){
                return _categoryListing(index);
              },
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,);
            }
            else if(snapshot.data is ErrorState) {
              if ((snapshot.data as ErrorState) != null){
                return Center(
                  child: Text('Unable to get categories'
                  ),
                );
              }

              final errorMessage = ((snapshot.data as ErrorState).msg);
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
        ),
    );
  }

  Widget _categoryListing(int index) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(categories[index].name,
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600
                )),
          ),
          Padding(padding: EdgeInsets.only(top: 10,left: 15),
            child: Container(
              height: 3.0,
              width: 60.0,
              color: widget.currentCategoryID == categories[index].id ? themeRedColor: themeRedColor.withAlpha(70),
            ),
          )
        ],
      ),
      onTap: (){
        setState(() {
          widget.currentCategoryID = categories[index].id;
          print('The current selected category id is ${widget.currentCategoryID} and the category name is ${categories[index].name}');
        });
      },
    );
  }


  Widget _buildProductScroll(BuildContext context) {
    return FutureBuilder(
      future: _apiResponse.fetchProducts(categoryID: widget.currentCategoryID),
      builder: (context, snapshot) {
        if (snapshot.data is SuccessState) {
          final fetchedProducts = ((snapshot.data as SuccessState).value as ProductData).products;
          products = fetchedProducts;

          if(products.length == 0) {
            return Center(
              child: Text('No products found'),
            );
          }

          return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (MediaQuery.of(context).size.width * 0.50 / 200),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(products.length, (index) {
                return Center(
                  child: _productListing(index),
                );
              })
          );
        }
        else if(snapshot.data is ErrorState) {
          if ((snapshot.data as ErrorState) != null){
            return Center(
              child: Text('Unable to get products'
              ),
            );
          }

          final errorMessage = ((snapshot.data as ErrorState).msg);
          return Center(
            child: Text(errorMessage
            ),
          );
        }
        else  {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(themeRedColor),
            ),
          );
        }
      },
    );
  }

  Widget _productListing(int index) {
    return GestureDetector(
      child:  Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: themeRedColor,
                width: 1, //                   <--- border width here
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Text(
                        products[index].name,
                        style: TextStyle(fontFamily: 'BebasNeue'),
                      )
                  ),
                  Expanded(
                      child: Text(
                        Util.getStringIn2DecimalPlaces(products[index].price),
                        style: TextStyle(fontFamily: 'Oswald', color: themeRedColor),
                      )
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 80),
            color: Colors.white,
            width: 80,
            height: 100,
            child: Center(child: Image.asset(''
                '${Constants.imagesPath}coffeeBag.png'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.50,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(left: 0, bottom: 10, right: 12),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeRedColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onTap: (){
                          print('THIS ITEM WAS PRESSED');
                          Util.navigateView(context, CartScreen());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: (){
        print('SHOW PRODUCT DETAILSSSS');
        Util.navigateView(context,
            ProductScreen(product: products[index],
              categoriesList: this.categories,
              selectedCategoryIndex: widget.currentCategoryID,
            ));
      },
    );
  }
}


