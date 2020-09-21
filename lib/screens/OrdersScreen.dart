import 'package:flutter/material.dart';
import 'package:redkettle/model/order.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/OrderDetailScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  Widget build(BuildContext context) {
    return _buildUI(); //_buildOrdersList();
  }


  Widget _buildUI() {
    return FutureBuilder(
      future: _apiResponse.getOrders(),
      builder: (context,  AsyncSnapshot<Result> snapshot){
        if (!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(themeRedColor),
            ),
          );
        }
        if (snapshot.data is SuccessState) {
          if ((snapshot.data as SuccessState).value == 'No orders found') {
            return Center(
              child: Text((snapshot.data as SuccessState).value
              ),
            );
          }

          final orders = ((snapshot.data as SuccessState).value as List<Order>);
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: ListView.separated(
              itemCount: orders.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Util.navigateView(context, OrderDetailScreen(orderItems: orders[index].items,));
                  },
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 22,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Order ID# ${orders[index].id}', style: TextStyle(
                                  color: HexColor.fromHex('#333333'),
                                  fontFamily: 'Oswald',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(orders[index].formatedBaseGrandTotal, style: TextStyle(
                                  color: HexColor.fromHex('#333333'),
                                  fontFamily: 'Oswald',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                ),),
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Text(Util.formatDate4(orders[index].createdAt.toIso8601String()),),
                          margin: EdgeInsets.only(left: 10, top: 5),
                        ),
                        Container(
                          child: Text(orders[index].status.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w500,),
                          ),
                          color: HexColor.fromHex('FCBF2F'),
                          margin: EdgeInsets.only(left: 10, top: 8),
                          padding: EdgeInsets.all(4),
                        ),
                        SizedBox(height: 22,),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                );
              },
            ),
          );
        }
        else if(snapshot.data is ErrorState) {
          if ((snapshot.data as ErrorState) != null){
            return Center(
              child: Text('No orders found'
              ),
            );
          }
          final errorMessage = ((snapshot.data as ErrorState).msg);


          if(errorMessage == "INVALID EXPIRED TOKEN") {
            print(errorMessage);
            Navigator.pop(context);
            Util.handleInvalidExpiredTokenRequest(context);
          }
          else {
            print(errorMessage);
            Util.showToast(errorMessage);
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
}
