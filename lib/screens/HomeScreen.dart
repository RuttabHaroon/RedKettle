import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/category.dart';
import 'package:redkettle/model/product.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/CartScreen.dart';
import 'package:redkettle/screens/ProfileScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'ProductScreen.dart';
import 'ShopScreen.dart';
import 'ProfileSegment.dart';



double currentIndexPage = 0;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();



}

class _HomeScreenState extends State<HomeScreen> {

  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  Widget build(BuildContext context) {


    final appBar = AppBar(
      elevation: 0,
      brightness: Brightness.dark,
      backgroundColor: themeRedColor,
      leading: IconButton(onPressed: () {
        Util.navigateView(context, ProfileSegment());
      }, icon: Icon(Icons.perm_identity)),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Util.navigateView(context, CartScreen());
          },
          icon: Icon(Icons.shopping_cart),
        ),
      ],
      title: Center(
        child: Text(
          "HOME",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    );

    final body = SafeArea(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
//        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 56,
              color: Colors.black12.withAlpha(12),
              child:  Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 10),
                    child: Text('NEW RELEASES',
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600
                        ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 7,left: 15),
                    child: Container(
                      height: 3.0,
                      width: 60.0,
                      color: themeRedColor,
                    ),
                  )
                ],
              ),
            ),

           Container(
             height: 206,
             child: FutureBuilder(
               future: _apiResponse.fetchFeaturedProducts(limit: 100, page: 1),
               builder: (context, AsyncSnapshot<Result> snapshot){
                 if (snapshot.data is SuccessState) {
                   final products = ((snapshot.data as SuccessState).value as ProductData).products;
                   return ListView.builder(
                       scrollDirection: Axis.horizontal,
                       itemCount: products.length,
                       itemBuilder: (context, index) {
                         return productListing(index, products, context);
                       });
                 }
                 else if (snapshot.data is ErrorState) {
                   
                   if ((snapshot.data as ErrorState) != null){
                     return Center(
                       child: Text('Featured Products couldnot be retrieved'
                       ),
                     );
                   }

                   final errorMessage = ((snapshot.data as ErrorState).msg);

                   if(errorMessage == "INVALID EXPIRED TOKEN") {
                     Util.handleInvalidExpiredTokenRequest(context);
                   }

                   return Center(
                     child: Text(errorMessage
                     ),
                   );
                 } else {
                   return Center(
                     child: CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation<Color>(themeRedColor),
                     ),
                   );
                 }
               },
             ),
           ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: GestureDetector(child: Image.asset("${Constants.imagesPath}HomeOption1.png"),
              onTap: ()
                  {
                    Util.navigateView(context, new ShopScreen(currentCategoryID: 12, currentParentID: 11,));
                  },
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: GestureDetector(child: Image.asset("${Constants.imagesPath}HomeOption2.png"),
              onTap: (){
                 Util.navigateView(context, new ShopScreen(currentCategoryID: 4, currentParentID: 3,));
              }),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: GestureDetector(child: Image.asset("${Constants.imagesPath}HomeOption3.png"),
              onTap: (){
                  //Util.navigateView(context, ShopScreen());
              }),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: GestureDetector(child: Image.asset("${Constants.imagesPath}HomeOption4.png"),
              onTap: (){
                Util.navigateView(context, new ShopScreen(currentCategoryID: 8, currentParentID: 2,));
              }),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
        appBar: appBar,
        body: body,
    );
  }

}

Widget productListing(int index, List<Product> productList, BuildContext context) {
  return GestureDetector(
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.50,
          height: 203,
          child: Container(
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
                  Text(
                    productList[index].name,
                    style: TextStyle(fontFamily: 'BebasNeue'),
                  ),
                  Text(
                      Util.getStringIn2DecimalPlaces(productList[index].price),
                    style: TextStyle(fontFamily: 'Oswald', color: themeRedColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 80),
          color: Colors.white,
          width: 80,
          height: 100,
          child:
          Center(child: Image.asset(''
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
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    onTap: (){
        Util.navigateView(context, ProductScreen(product: productList[index],
        categoriesList: [Category(id: -1, name: 'Featured Products')], //featured product dont have category so i am creating dummy one
        selectedCategoryIndex: -1,));
    },
  );
}
