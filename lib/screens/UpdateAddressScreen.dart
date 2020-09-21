import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redkettle/UpdateAddressNotification.dart';
import 'package:redkettle/model/country.dart';
import 'package:redkettle/model/result.dart';
import 'package:redkettle/network/remote_data_source.dart';
import 'package:redkettle/utils/MyColors.dart';
import 'package:redkettle/utils/Util.dart';
import 'package:redkettle/utils/common_widget/progress_dialog.dart';


class UpdateAddressScreen extends StatefulWidget {

  int addressID;
  String fname = '';
  String lName = '';
  String address = '';
  String phoneNo = '';
  String city = '';
  String state = '';
  String zipcode = '';


  UpdateAddressScreen(
      {Key key,
        @required this.addressID,
        @required this.fname,
        @required this.lName,
        @required this.address,
        @required this.phoneNo,
        @required this.city,
        @required this.state,
        @required this.zipcode,})
      : super(key: key);


  @override
  _UpdateAddressScreenState createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {

  RemoteDataSource _apiResponse = RemoteDataSource();

  List<Country> countries = [];
  var currentCountryIndex = 0;

  final _formKey = GlobalKey<FormState>();


  TextEditingController _firstNameTEC = TextEditingController();
  TextEditingController _lastNameTEC = TextEditingController();
  TextEditingController _addressTEC = TextEditingController();
  TextEditingController _phoneTEC = TextEditingController();
  TextEditingController _cityTEC = TextEditingController();
  TextEditingController _stateTEC = TextEditingController();
  TextEditingController _zipcodeTEC = TextEditingController();


  showProgressDialog(String loadingString) => showDialog(
      context: context, barrierDismissible: false,  builder: (BuildContext context) => ProgressDialog(textString: loadingString,));


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firstNameTEC.text = widget.fname;
    _lastNameTEC.text = widget.lName;
    _addressTEC.text = widget.address;
    _phoneTEC.text = widget.phoneNo;
    _cityTEC.text = widget.city;
    _stateTEC.text = widget.state;
    _zipcodeTEC.text = widget.zipcode;


    hitTheCountriesAPI();

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
          "Edit Address",
          style: TextStyle(color: Colors.white,
            fontSize: 20,
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w500,
          ),
        )
    );


    return Scaffold(
      appBar: appBar,
      body: _buildUI(),
      bottomNavigationBar: _buildBottomNavButton()
    );
  }

  Widget _buildUI() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildTwoTextFieldsSection(firstLabel: 'First name', secondLabel: 'Last name', firstTEC: _firstNameTEC, secondTEC: _lastNameTEC),
          _buildSingleTextFieldSection(formLabel: 'Address', left: 20, top: 45, right: 20, controller: _addressTEC),
          _buildSingleTextFieldSection(formLabel: 'Phone number', left: 20, top: 45, right: 20, controller: _phoneTEC),
          _buildTwoTextFieldsSection(firstLabel: 'City', secondLabel: 'State', firstTEC: _cityTEC , secondTEC: _stateTEC),
          _buildTextfieldDropDownSection(dropdownLabel: 'Country', textfieldLabel: 'Zip Code', controller: _zipcodeTEC),
          SizedBox(height: 55,),
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
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                  //color: Colors.yellow,
                  margin: EdgeInsets.only(left: left, right: right),
                  child: DropdownButtonFormField(
                    value: currentCountryIndex,
                    items: List.generate(countries.length, (index) {
                      return DropdownMenuItem(
                        child: Center(
                          child: Text(countries[index].name, style: TextStyle(
                            //color: themeRedColor,
                            fontFamily: 'Oswald',
                            fontSize: 19,
                            fontWeight: FontWeight.w500,),
                          ),
                        ),
                        value: index,
                      );
                    }),
                    hint: Text('Helloo'),
                    onChanged: (value) {
                      setState(() {
                        currentCountryIndex = value;
                      });
                    },
                  )
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBottomNavButton() {
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
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();

                hitTheUpdateAddressAPI();

                //testing
                //Constants.payment_api_param =  {'shipping_method': 'flatrate_flatrate'};
                //TabbarNotification(currentTabIndex: 1).dispatch(context);

              }
              else {
                Util.showToast('Invalid address details');
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
        print(result.msg);
      }
    });
  }

  void hitTheUpdateAddressAPI() {

    showProgressDialog('Updating Address');

    Map<String, dynamic> param = {
      "address1": _addressTEC.text,
      "city": _cityTEC.text,
      "country": countries[currentCountryIndex].code,
      "country_name": countries[currentCountryIndex].name,
      "phone": _phoneTEC.text,
      "postcode": _zipcodeTEC.text,
      "state": _stateTEC.text,
      "first_name": _firstNameTEC.text,
      "last_name": _lastNameTEC.text,
    };

    _apiResponse.updateAddress(widget.addressID, param).then((result)  {
      if (result is SuccessState){
        final sucessMsg = result.value;
        print(sucessMsg);
        Navigator.pop(context);
        Navigator.pop(context);
        Util.showToast(sucessMsg);
      }
      else if(result is ErrorState)
      {
        if(result.msg == "INVALID EXPIRED TOKEN") {
          print(result.msg);
          Navigator.pop(context);
          Navigator.pop(context);
          Util.handleInvalidExpiredTokenRequest(context);
        }
        else {
          print(result.msg);
          Navigator.pop(context);
          Navigator.pop(context);
          Util.showToast(result.msg);
        }
      }
    });
  }

}
