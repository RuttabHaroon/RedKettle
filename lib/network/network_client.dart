import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/utils/nothing.dart';
import 'package:redkettle/utils/request_type.dart';


class ServerSettings{

  static final String _redkettlebaseUrl = "https://redkettle.thesupportonline.net/api/";


  static var headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "X-Requested-With": "XMLHttpRequest",
  };

  static var headerWithAuth = {
    "Content-Type": "application/x-www-form-urlencoded",
    "X-Requested-With": "XMLHttpRequest",
    'Authorization': 'Bearer ${Constants.bearerTOKEN}',
  };

}



class NetworkEndpoints {
  static String featuredProducts = 'products?featured=1';
  static String login = 'customer/login?token=true';
  static String register = 'customer/register';
  static String logout = 'customer/logout';
  static String categories = 'categories?';
  static String products = 'products?';
  static String addToCart = 'checkout/cart/add';
  static String emptyCart = 'checkout/cart/empty';
  static String updateItemInCart = 'checkout/cart/update';
  static String removeItemInCart = 'checkout/cart/remove-item';
  static String cartDetails = 'checkout/cart';
  static String countries = 'countries?sort=name&order=asc';
  static String addAddress = 'addresses/create';
  static String getAddress = 'addresses';
  static String updateAddress = 'addresses/';
  static String saveAddressInCart = 'checkout/save-address';
  static String saveShipping = 'checkout/save-shipping';
  static String savePayment = 'checkout/save-payment';
  static String saveOrder = 'checkout/save-order';
  static String getOrders = 'orders';
}



class NetworkClient {

  final Client _client;
  NetworkClient(this._client);
  Future<Response> request({@required RequestType requestType,
    @required String path,
    @required bool headerWithAuth,
    dynamic parameter = Nothing}) async {

    switch(requestType){
      case RequestType.GET:
        return _client.get('${ServerSettings._redkettlebaseUrl}$path',
        headers: headerWithAuth == true ? (ServerSettings.headerWithAuth) : (ServerSettings.headers));
      case RequestType.POST:
        return _client.post('${ServerSettings._redkettlebaseUrl}$path',
            headers: headerWithAuth == true ? ServerSettings.headerWithAuth : ServerSettings.headers,
            body: parameter);
        
    }
  }
}

