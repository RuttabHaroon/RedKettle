import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redkettle/TabbarNotification.dart';
import 'package:redkettle/screens/ShippingScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/widget/DecoratedTabBar.dart';
import 'PaymentScreen.dart';
import 'ConfirmationScreen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: TabBarApp(),
    );
  }
}


class TabBarApp extends StatefulWidget {
  createState() => _TabBarAppState();
}

class _TabBarAppState extends State<TabBarApp>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<TabData> _tabData;
  List<Tab> _tabs = [];
  List<Widget> _tabViews = [];
  Color _activeColor;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabData = [
      TabData(title: 'Shipping', color: Colors.white,),
      TabData(title: 'Payment', color: Colors.white,),
      TabData(title: 'Confirmation', color: Colors.white,),
    ];
    _activeColor =  _tabData.first.color;
    _tabData.forEach((data) {
      final tab = Tab(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: tabbarSkinColor,//data.color,
          child: Center(
            child: Text(data.title),
          ),
        ),
      );
      _tabs.add(tab);
    });

    final s = ShippingScreen();
    final payment = PaymentScreen();
    final confirm = ConfirmationScreen();
    _tabViews.add(s);
    _tabViews.add(payment);
    _tabViews.add(confirm);

    _controller = TabController(vsync: this, length: _tabData.length)
      ..addListener(() {
        setState(() {
          _activeColor = _tabData[_controller.index].color;
          _controller.index = currentTabIndex;
        });
      });



  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: _activeColor),
      child: Scaffold(
        backgroundColor: _activeColor,
        appBar: AppBar(
          elevation: 0,
            brightness: Brightness.dark,
          centerTitle: true,
          backgroundColor: themeRedColor,
          leading: Container(
            margin: EdgeInsets.only(left: 30),
            child: IconButton(onPressed: () {
              Navigator.pop(context);
            },
              icon: Icon(Icons.arrow_back_ios
                , size: 14,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            "CHECKOUT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Oswald',
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: DecoratedTabBar(
            tabBar: TabBar(
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.zero,
              controller: _controller,
              unselectedLabelColor: Colors.grey[700],
              labelStyle: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.w400,
                fontSize: 19,
            ),
              tabs: _tabs,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: tabbarSkinColor,
                  width: 2.0
                )
              )
            ),
          )
        ),
        body: NotificationListener<TabbarNotification>(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: _tabViews,
          ),
          onNotification: (notification){
            _controller.animateTo(notification.currentTabIndex);
            currentTabIndex = notification.currentTabIndex;
            return true;
          }),
      ),
    );
  }
}

class TabData {
  TabData({this.title, this.color});

  final String title;
  final Color color;
}

