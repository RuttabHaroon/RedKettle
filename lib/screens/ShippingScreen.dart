
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redkettle/TabbarNotification.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/address.dart';
import 'package:redkettle/model/country.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/model/shippingmethod.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/screens/SucessScreen.dart';
import 'package:redkettle/screens/UpdateAddressScreen.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';
import 'dart:convert';



class ShippingScreen extends StatefulWidget {

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: AddressSegmentedControl(),
    );
  }
}


class AddressSegmentedControl extends StatefulWidget {
  @override
  _AddressSegmentControlState createState() => _AddressSegmentControlState();
}

class _AddressSegmentControlState extends State {

  RemoteDataSource _apiResponse = RemoteDataSource();
  bool isLeftButtonClicked = true;


  List<Widget> pages = [];



  changeStyle(bool isLeft) {
    setState(() {
      isLeftButtonClicked = isLeft;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   pages = [
      NewAddressScreen(),
      SavedAddress(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          child: _buildSegmentSection(),
          preferredSize: Size(double.infinity, 8),
        ),
        leading: Container(),
      ),
      body: pages[isLeftButtonClicked ? 0 : 1],
      // bottomNavigationBar: isLeftButtonClicked ? _buildNewAddressBottomNavButton() : _buildSavedAddressBottomNavButton()
    );
    throw UnimplementedError();
  }



  Widget _buildSegmentSection() {
    if (!isLeftButtonClicked) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSegmentButton('New Address', Colors.white, Colors.grey, Colors.grey[700], true, 1),
          _buildSegmentButton('Saved Address', themeRedColor, Colors.transparent, Colors.white, false, 0),
        ],
      );
    }
    else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSegmentButton('New Address', themeRedColor, Colors.transparent, Colors.white, true, 0),
          _buildSegmentButton('Saved Address', Colors.white, Colors.grey, Colors.grey[700], false, 1),
        ],
      );
    }
  }



  Widget _buildSegmentButton(String title,
      Color backgroundColor,
      Color borderColor,
      Color textColor,
      bool isLeftButton,
      int btnIndex) {
    return Expanded(
      child: Container(
        child: Padding(
          child: FlatButton(
            child: Text(title,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Oswald',
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),),
            onPressed: () => changeStyle( isLeftButton ? true: false),
          ),
          padding: EdgeInsets.all(0),
        ),
        margin: (isLeftButton) ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: (isLeftButton) ? BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6)
          ) :
          BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6)
          ),
          color: backgroundColor,
        ),
        height: 45,
      ),
    );
  }




//MARK:- Saved Address
  Widget _buildSavedAddressBottomNavButton() {
    return SafeArea(
      child: BottomAppBar(
        elevation: 0,
        child: GestureDetector(
          child: Container(
            //padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            alignment: Alignment.center,
            height: 60,
            color: themeRedColor,
            child: Text('SAVE', style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: 'Oswald',
                fontWeight: FontWeight.w500
                ),
              ),
            ),
          onTap: (){
            Util.navigateView(context, SucessScreen());
          },
          ),
        ),
      );
  }

}


class NewAddressScreen extends StatefulWidget {


  @override
  _NewAddressScreenState createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {

  showProgressDialog(String loadingString) => showDialog(
      barrierDismissible: false, context: context, builder: (BuildContext context) => ProgressDialog(textString: loadingString,));


  RemoteDataSource _apiResponse = RemoteDataSource();

  final _formKey = GlobalKey<FormState>();

  List<Country> countries = [];
  var currentCountryIndex = 0;

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zipcode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    hitTheCountriesAPI();

  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildTwoTextFieldsSection(firstLabel: 'First name', secondLabel: 'Last name', firstTEC: _firstName, secondTEC: _lastName),
          _buildSingleTextFieldSection(formLabel: 'Address', left: 20, top: 45, right: 20, controller: _address),
          _buildSingleTextFieldSection(formLabel: 'Phone number', left: 20, top: 45, right: 20, controller: _phone),
          _buildTwoTextFieldsSection(firstLabel: 'City', secondLabel: 'State', firstTEC: _city , secondTEC: _state),
          _buildTextfieldDropDownSection(dropdownLabel: 'Country', textfieldLabel: 'Zip Code', controller: _zipcode),
          SizedBox(height: 55,),
          _buildNewAddressBottomNavButton()
        ],
      ),
    );
  }

  Widget _buildTwoTextFieldsSection({String firstLabel, String secondLabel, TextEditingController firstTEC, TextEditingController secondTEC}) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
              child: _buildSingleTextFieldSection(formLabel: firstLabel, left: 20, top: 45, right: 8, controller: firstTEC),
            )
        ),
        Expanded(
          child: Container(
            child: _buildSingleTextFieldSection(formLabel: secondLabel, left: 8, top: 45, right: 20, controller: secondTEC),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleTextFieldSection({String formLabel, double left, double top, double right, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 26,),
        Container(
          margin: EdgeInsets.only(left: left),
          child: Text(formLabel,
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'Ubuntu',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
          margin: EdgeInsets.only(left: left, right: right),
          child: TextFormField(
            keyboardType: getKeyboardType(formLabel),
            controller: controller,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Oswald',
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                //  when the TextFormField in unfocused
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeRedColor),
                //  when the TextFormField in focused
              ),
              border: UnderlineInputBorder(),
            ),
            validator: (value) => validateTextFormField(formLabel, value),
          ),
        ),
      ],
    );
  }

  Widget _buildTextfieldDropDownSection({String dropdownLabel, String textfieldLabel, TextEditingController controller}) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
                child: _buildDropdownSection(formLabel: dropdownLabel, left: 20, right: 14)
            )
        ),
        Expanded(
          child: Container(
            child: _buildSingleTextFieldSection(formLabel: textfieldLabel, left: 14, top: 45, right: 20, controller: controller),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownSection({String formLabel, double left, double right}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 21,),
        Container(
          margin: EdgeInsets.only(left: left),
          child: Text(formLabel,
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'Ubuntu',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
          margin: EdgeInsets.only(left: left, right: right),
          child: DropdownButtonFormField(
              value: currentCountryIndex,
              items: List.generate(countries.length, (index) {
                return DropdownMenuItem(
                  child: Center(
                    child: Text(countries[index].name, style: TextStyle(
                      //color: themeRedColor,
                      fontFamily: 'Oswald',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,),
                    ),
                  ),
                  value: index,
                );
              }),
              hint: Text('Country'),
              onChanged: (value) {
                setState(() {
                  currentCountryIndex = value;
                });
              },
            ),
        )
      ],
    );
  }

//  Widget _buildDropdownSection({String formLabel, double left, double right}) {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        SizedBox(height: 26,),
//        Container(
//          margin: EdgeInsets.only(left: left),
//          child: Text(formLabel,
//            style: TextStyle(
//              color: Colors.grey[600],
//              fontFamily: 'Ubuntu',
//              fontSize: 14,
//              fontWeight: FontWeight.w500,
//            ),
//          ),
//        ),
////        Row(
////          children: <Widget>[
////            Container(
////                transform: Matrix4.translationValues(0.0, -8.0, 0.0),
////              //color: Colors.yellow,
////                margin: EdgeInsets.only(left: left, right: right),
////                child: DropdownButtonFormField(
////                  value: currentCountryIndex,
//                  items: List.generate(countries.length, (index) {
//                    return DropdownMenuItem(
//                      child: Center(
//                        child: Text(countries[index].name, style: TextStyle(
//                          //color: themeRedColor,
//                          fontFamily: 'Oswald',
//                          fontSize: 19,
//                          fontWeight: FontWeight.w500,),
//                        ),
//                      ),
//                      value: index,
//                    );
//                  }),
//                  hint: Text('Country'),
//                  onChanged: (value) {
//                    setState(() {
//                      currentCountryIndex = value;
//                    });
//                  },
////                )
////            ),
////          ],
////        )
//      ],
//    );
//  }

  //MARK:- New Address
  Widget _buildNewAddressBottomNavButton() {
    return SafeArea(
      child: BottomAppBar(
          elevation: 0,
          child: GestureDetector(
            child: Container(
              //padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              alignment: Alignment.center,
              height: 60,
              color: themeRedColor,
              child: Text('CONTINUE TO PAYMENT', style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w500
              ),
              ),
            ),
            onTap: (){

              if(_formKey.currentState.validate()){
                _formKey.currentState.save();

                hitTheAddAddressAPI ();

                //testing
                //Constants.payment_api_param =  {'shipping_method': 'flatrate_flatrate'};
                //TabbarNotification(currentTabIndex: 1).dispatch(context);

              }
              else {
                Util.showToast('Invalid shipping details');
              }
            },
          )
      ),
    );
  }



  TextInputType getKeyboardType(String formLabel) {
    if (formLabel == 'Phone number' || formLabel == 'Zip Code' ) {
      return TextInputType.phone;
    }
    return TextInputType.text;
  }

  String validateTextFormField(String formLabel, String value) {
    if (formLabel == 'First name') {
      if (value.isEmpty || value.length < 3) {
        return "$formLabel should be longer";
      }
      return null;
    }
    else if (formLabel == 'Last name') {
      if (value.isEmpty || value.length < 3) {
        return "$formLabel should be longer";
      }
      return null;
    }
    else if (formLabel == 'City') {
      if (value.isEmpty || value.length < 3) {
        return "$formLabel should be longer";
      }
      return null;
    }
    else if (formLabel == 'State') {
      if (value.isEmpty || value.length < 3) {
        return "$formLabel should be longer";
      }
      return null;
    }
    else if (formLabel == 'Address') {
      if (value.isEmpty || value.length > 100) {
        return "Invalid address";
      }
      return null;
    }
    else if (formLabel == 'Phone number') {
      if (value.isEmpty) {
        return "Invalid phone number";
      }
      return null;
    }
    else if (formLabel == 'Zip Code') {
      if (value.isEmpty || value.length > 7) {
        return "Invalid zip code";
      }
      return null;
    }
  }


  //MARK:= API
  void hitTheCountriesAPI() {

    _apiResponse.getCountries().then((result)  {
      if (result is SuccessState){
        final countryList = result.value as List<Country>;
        setState(() {
          this.countries = countryList;
          print('the length of the array is => ${countries.length}');
        });
      }
      else if(result is ErrorState)
      {
        if(result.msg == "INVALID EXPIRED TOKEN") {
          print(result.msg);
          Navigator.pop(context);
          Util.handleInvalidExpiredTokenRequest(context);
        }
        else {
          print(result.msg);
          Util.showToast(result.msg);
        }
      }
    });
  }

  void hitTheAddAddressAPI() {

    showProgressDialog('Saving Shipping Address');

    Map<String, dynamic> param = {
      "address1": _address.text,
      "city": _city.text,
      "country": countries[currentCountryIndex].code,
      "country_name": countries[currentCountryIndex].name,
      "phone": _phone.text,
      "postcode": _zipcode.text,
      "state": _state.text,
      "first_name": _firstName.text,
      "last_name": _lastName.text,
    };

    _apiResponse.addAddress(param).then((result) {
      if (result is SuccessState) {
        print('SUCESS ADD ADDRESS');

        final address = result.value as Address;
        hitTheSaveAddressInCartAPI(addressID: address.id);

      }
      else if (result is ErrorState)
        {
          if(result.msg == "INVALID EXPIRED TOKEN") {
            print(result.msg);
            Navigator.pop(context);
            Util.handleInvalidExpiredTokenRequest(context);
          }
          else {
            print(result.msg);
            Util.showToast(result.msg);
          }
        }
    });
  }

  void hitTheSaveAddressInCartAPI({int addressID}){

//    final checkoutaddress = CheckoutAddressParam(billing: Billing(addressId: addressID, useForShipping: true),
//        shipping: Shipping(addressId: addressID));
//
//    var body = json.encode(checkoutaddress);
//    print(body);

    final Map<String, dynamic> param = {'billing': { "use_for_shipping" : true, "address_id" : addressID}, "shipping" : {"address_id" : addressID}};
    var body = json.encode(param);
    print(body);

    _apiResponse.saveAddressInCart(body).then((result) {
      if (result is SuccessState) {

        print('move to payment');
        print('SUCESSS SAVE ADDRESS IN CART API');
        print(result.value);


        final shippingmethodData = result.value as ShippingMethod;
        final shippingMethod = shippingmethodData.rates[0].rates[0].method;
        Constants.shipping_api_param = {'shipping_method' : shippingMethod};

        Navigator.pop(context);

        TabbarNotification(currentTabIndex: 1).dispatch(context);

      }
      else if (result is ErrorState) {
        print('FAILEDD');
        print(result.msg);
        Navigator.pop(context);
        Navigator.pop(context);
        Util.showToast(result.msg);
      }
    }).catchError((onerr){
      print(onerr);
    });
  }
}


class SavedAddress extends StatefulWidget {
  @override
  _SavedAddressState createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {

  showProgressDialog(String loadingString) => showDialog(
      context: context, builder: (BuildContext context) => ProgressDialog(textString: loadingString,));


  RemoteDataSource _apiResponse = RemoteDataSource();

  List<Address> addresses;
  int currentSelectedAddress;

  @override
  Widget build(BuildContext context) {
    return _buildSaveAddressUI();
  }

  Widget _buildSaveAddressUI() {
    return FutureBuilder(
      future: _apiResponse.getAddress(),
      builder: (context, AsyncSnapshot<Result> snapshot) {
        if (snapshot.data is SuccessState) {
          final addressList = ((snapshot.data as SuccessState).value as List<Address>);
          this.addresses = addressList;

          if(this.addresses.length == 0) {
            return Center(
              child: Text('No Saved Address'),
            );
          }

          return ListView.builder(itemBuilder: (context, index){
            if (index == addressList.length - 1) {
              return _buildSavedAddressBottomNavButton();
            }
            return GestureDetector(
              child: Container(
                color: currentSelectedAddress == index ? HexColor.fromHex('#fff2f2') : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(addresses[index].firstName + ' ' + addresses[index].lastName,
                              style: TextStyle(
                                color: HexColor.fromHex('#333333'),
                                fontFamily: 'Oswald',
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            //padding: EdgeInsets.only(right: 2),
                              height: 35,
                              child: FlatButton(
                                child: Text('Edit',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                                onPressed: (){
                                  Util.navigateView(context, UpdateAddressScreen(
                                    addressID: addresses[index].id,
                                    fname: addresses[index].firstName,
                                    lName: addresses[index].lastName,
                                    address: addresses[index].address1,
                                    phoneNo: addresses[index].phone,
                                    city: addresses[index].city,
                                    state: addresses[index].state,
                                    zipcode: addresses[index].postcode,
                                  ),
                                  );
                                },
                              )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(addresses[index].address1 + '\n${addresses[index].city} ${addresses[index].state} ${addresses[index].companyName}' ,
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            color: Colors.grey[700]
                        ),
                      ),
                    ),
                    SizedBox(height: 22,),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  currentSelectedAddress = index;
                });
              },
            );
          },
            scrollDirection: Axis.vertical,
            itemCount: addressList.length,);
        }
        else if(snapshot.data is ErrorState) {
          final errorMessage = ((snapshot.data as ErrorState).msg);
          return Center(
            child: Text('No saved addresses found'
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

  Widget _buildSavedAddressBottomNavButton() {
    return SafeArea(
      child: BottomAppBar(
          elevation: 0,
          child: GestureDetector(
            child: Container(
              //padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              alignment: Alignment.center,
              height: 60,
              color: themeRedColor,
              child: Text('SAVE', style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w500
              ),
              ),
            ),
            onTap: (){
              if(currentSelectedAddress == null) {
                Util.showToast('No address has been selected');
              }
              else {
                print(addresses[currentSelectedAddress].id);
                hitTheSaveAddressInCartAPI(
                    addressID: addresses[currentSelectedAddress].id);
              }
            },
          )
      ),
    );
  }


  //MARK:- API
  void hitTheGetAddressAPI() {
    showProgressDialog('Saving Shipping Address');
    _apiResponse.getAddress()
        .then((result) {
      if (result is SuccessState) {
        print('SUCESS GET ADDRESS');
        final List<Address> addressList = result.value as List<Address>;
        this.addresses = addressList;
      }
      else if (result is ErrorState) {

        if(result.msg == "INVALID EXPIRED TOKEN") {
          print(result.msg);
          Navigator.pop(context);
          Util.showToast(result.msg);
          Util.handleInvalidExpiredTokenRequest(context);
        }
        else {
          print(result.msg);
          Navigator.pop(context);
          Util.showToast(result.msg);
        }
      }
    });
  }

  void hitTheSaveAddressInCartAPI({int addressID}){

    showProgressDialog('SAVING SELECTED ADDRESS');

    //final checkoutaddress = CheckoutAddressParam(billing: Billing(addressId: addressID, useForShipping: true),shipping: Shipping(addressId: addressID));
    //var body = json.encode(checkoutaddress);

    final Map<String, dynamic> param = {'billing': { "use_for_shipping" : true, "address_id" : addressID}, "shipping" : {"address_id" : addressID}};
    var body = json.encode(param);
    print(body);


    _apiResponse.saveAddressInCart(body).then((result) {
      if (result is SuccessState) {

        print('move to payment');
        print('SUCESSS SAVE ADDRESS IN CART API');
        print(result.value);

        final shippingmethodData = result.value as ShippingMethod;
        final shippingMethod = shippingmethodData.rates[0].rates[0].method;
        Constants.shipping_api_param = {'shipping_method' : shippingMethod};

        Navigator.pop(context);

        TabbarNotification(currentTabIndex: 1).dispatch(context);

      }
      else if (result is ErrorState) {
        if(result.msg == "INVALID EXPIRED TOKEN") {
          print(result.msg);
          Navigator.pop(context);
          Navigator.pop(context);
          Util.showToast(result.msg);
          Util.handleInvalidExpiredTokenRequest(context);
        }
        else {
          print('FAILEDD');
          print(result.msg);
          Navigator.pop(context);
          Navigator.pop(context);
          Util.showToast(result.msg);
        }

      }
    }).catchError((onerr){
      print(onerr);
    });
  }
}



