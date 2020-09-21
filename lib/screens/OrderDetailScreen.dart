import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/order.dart' as AOrder;
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';

class OrderDetailScreen extends StatefulWidget {

  var orderItems = [];

  OrderDetailScreen(
  {Key key,
  @required this.orderItems,})
      : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

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
          "Order Detail Screen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Oswald',
              fontWeight: FontWeight.w500,
            ),
        ),
    );


    return Scaffold(
      appBar: appBar,
      body: _buildUI(),
    );
  }


  Widget orderItem(AOrder.Item item) {
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
                            item.formatedPrice,
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
                      padding: const EdgeInsets.only(left: 60, top: 40, right: 20),
                      child: Container(
                        child: Container(
                          height: 40,
                          width: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              item.qtyOrdered.toString(),
                              style: TextStyle(color: themeRedColor, fontSize: 17),
                            ),
                          ),
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
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            itemCount: widget.orderItems.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: new ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return orderItem(widget.orderItems[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 15,
              );
            },
          ),
        ),
      ],
    );
  }
}
