import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:redkettle/model/address.dart';
import 'package:redkettle/model/cart.dart';
import 'package:redkettle/model/country.dart';
import 'package:redkettle/model/appstatemanager.dart';
import 'package:redkettle/model/category.dart';
import 'package:redkettle/model/network_reponse.dart';
import 'package:redkettle/model/order.dart';
import 'package:redkettle/model/paymentmethod.dart';
import 'package:redkettle/model/product.dart';
import 'package:redkettle/model/shippingmethod.dart';
import 'package:redkettle/model/userdata.dart';
import 'package:redkettle/model/userpref.dart';
import 'package:redkettle/network/network_client.dart';
import 'package:redkettle/utils/request_type.dart';
import 'package:redkettle/model/result.dart';
import 'package:http/http.dart';
import 'network_client.dart';

class RemoteDataSource {
  //Creating Singleton
  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _apiResponse =
      RemoteDataSource._privateConstructor();
  factory RemoteDataSource() => _apiResponse;

  NetworkClient client = NetworkClient(Client());


  StreamController<Result> _updateCartItemStream;
  Stream<Result> hasCartItemUpdated() => _updateCartItemStream.stream;

  void init() => _updateCartItemStream = StreamController();


  Future<Result> fetchFeaturedProducts({int limit, int page}) async {
    final String path =
        NetworkEndpoints.featuredProducts + '&limit=$limit&page=$page';
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: path, headerWithAuth: false);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final products = ProductData.fromMap(apiresponse.data);
        return Result.success(products);
      }
      else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");
      }
      else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error(error);
    }
  }

  Future<Result> loginUser({dynamic param}) async {
    try {
      final response = await client.request(
          requestType: RequestType.POST,
          path: NetworkEndpoints.login,
          headerWithAuth: false,
          parameter: param);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final userModel = UserData.fromMap(apiresponse.data);
        UserPref.persistUserData(response.body);
        AppStateManager.shared.loginUserData = userModel;
        return Result.success(userModel);
      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error(error);
    }
  }

  Future<Result> registerUser({dynamic param}) async {
    try {
      final response = await client.request(
          requestType: RequestType.POST,
          path: NetworkEndpoints.register,
          headerWithAuth: false,
          parameter: param);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        return Result.success(apiresponse.message);
      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> logoutUser() async {
    try {
      final response = await client.request(
          requestType: RequestType.GET,
          path: NetworkEndpoints.logout,
          headerWithAuth: true);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        return Result.success(apiresponse.success);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");
      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> fetchCategories({@required int parentID}) async {
    try {
      final String path = NetworkEndpoints.categories +
          'parent_id=$parentID&pagination=0&sort=id&order=asc';
      final response =
          await client.request(requestType: RequestType.GET, path: path);
      if (response.statusCode == 200) {
        final apiresponse = NetworkResponse.fromRawJson(response.body);
        final List<Category> categories = List();
        final data = apiresponse.data as List;
        for (int i = 0; i < data.length; i++) {
          categories.add(Category.fromMap(data[i]));
        }
        print(categories);
        return Result.success(categories);
      } else {
        return Result.error("Couldn't fetch categories");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> fetchProducts({@required int categoryID}) async {
    try {
      final String path = NetworkEndpoints.products +
          'category_id=$categoryID&limit=100&page=1';
      final response = await client.request(
          requestType: RequestType.GET, path: path, headerWithAuth: false);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final productData = ProductData.fromMap(apiresponse.data);
        print(productData);
        return Result.success(productData);
      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

//  void addItemToCart({@required dynamic param}) async {
//    _addToCartStream.sink.add(Result<String>.loading("Loading"));
//    try {
//      final response = await client.request(
//          requestType: RequestType.POST,
//          path: NetworkEndpoints.addToCart,
//          parameter: param,
//          headerWithAuth: true);
//      if (response.statusCode == 200) {
//        print(response.statusCode);
////        final statusCode = response.statusCode;
////        _addToCartStream.sink.add(Result<NetworkResponse>.success(
////            NetworkResponse.fromRawJson(response.body)));
//      } else {
//        _addToCartStream.sink
//            .add(Result.error("Item couldnt be added ti cart"));
//      }
//    } catch (error) {
//      _addToCartStream.sink.add(Result.error("Something went wrong!"));
//    }
//  }

  Future<Result> addItemToCart({@required dynamic param}) async {
    try {
      final path = NetworkEndpoints.addToCart + '/${param['product_id']}';
      final response = await client.request(
          requestType: RequestType.POST,
          path: path,
          parameter: param,
          headerWithAuth: true);
      if (response.statusCode == 200) {
        print(response.statusCode);
        final apiresponse = NetworkResponse.fromRawJson(response.body);
        return Result.success(apiresponse.success);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");
      } else {
        return Result.error("Something went wrong!");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> emptyEntireCart() async {
    try {
      final response = await client.request(
          requestType: RequestType.GET,
          path: NetworkEndpoints.emptyCart,
          headerWithAuth: true);
      if (response.statusCode == 200) {
        final apiresponse = NetworkResponse.fromRawJson(response.body);
        return Result.success(apiresponse.success);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");
      } else {
        return Result.error("Something went wrong!");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

//  Future<Result> updateItemInCart(dynamic param) async {
//    try {
//      final response = await client.request(
//          requestType: RequestType.POST,
//          path: NetworkEndpoints.updateItemInCart,
//          headerWithAuth: true,
//          parameter: param);
//      final apiresponse = NetworkResponse.fromRawJson(response.body);
//      if (response.statusCode == 200) {
//        final cart = Cart.fromMap(apiresponse.data);
//        print(cart);
//        return Result.success(cart);
//      } else {
//        return Result.error(apiresponse.message);
//      }
//    } catch (error) {
//      return Result.error("Something went wrong!");
//    }
//  }

  void updateItemInCart(dynamic param) async {
    _updateCartItemStream.sink.add(Result<String>.loading("Loading"));
    try {
      final response = await client.request(
          requestType: RequestType.POST,
          path: NetworkEndpoints.updateItemInCart,
          headerWithAuth: true,
          parameter: param);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        _updateCartItemStream.sink.add(Result.success(Cart.fromMap(apiresponse.data)));

      } else if (response.statusCode == 401) {
        _updateCartItemStream.sink.add(Result.error("INVALID EXPIRED TOKEN"));

      } else {
        _updateCartItemStream.sink.add(Result.error(apiresponse.message));
      }
    } catch (error) {
      _updateCartItemStream.sink.add(Result.error("Something went wrong!"));
    }
  }


  Future<Result> removeItemInCart(int itemID) async {
    try {
      final String path = NetworkEndpoints.removeItemInCart + '/$itemID';
      final response = await client.request(
          requestType: RequestType.GET,
          path: path,
          headerWithAuth: true);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        if (apiresponse.data[0] == null) {
          return Result.success(Cart());
        }
        else {
          final cart = Cart.fromMap(apiresponse.data[0]);
          print(cart);
          return Result.success(cart);
        }
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> getCartDetails() async {
    try {
      final response = await client.request(
          requestType: RequestType.GET,
          path: NetworkEndpoints.cartDetails,
          headerWithAuth: true);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {

        if(apiresponse.data == null) {
          return Result.success('No item in cart');
        }
        final cart = Cart.fromMap(apiresponse.data);
        print(cart);
        return Result.success(cart);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      print(error);
      return Result.error(error);
    }
  }

  Future<Result> getCountries() async {
    try {
      final response = await client.request(
          requestType: RequestType.GET,
          path: NetworkEndpoints.countries,
          headerWithAuth: true);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final List<Country> countries = List();
        final data = apiresponse.data as List;
        for (int i = 0; i < data.length; i++) {
          countries.add(Country.fromMap(data[i]));
        }
        return Result.success(countries);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      print(error);
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> addAddress(dynamic param) async {
    try {
      final response = await client.request(
          requestType: RequestType.POST,
          path: NetworkEndpoints.addAddress,
          headerWithAuth: true,
          parameter: param);
      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final address = Address.fromMap(apiresponse.data);
        return Result.success(address);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> getAddress() async {
    try {
      final response = await client.request(
          requestType: RequestType.GET,
          path: NetworkEndpoints.getAddress,
          headerWithAuth: true);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final List<Address> addresses = List();
        final data = apiresponse.data as List;
        for (int i = 0; i < data.length; i++) {
          addresses.add(Address.fromMap(data[i]));
        }
        return Result.success(addresses);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      print(error);
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> updateAddress(int addressID, dynamic param) async {
    try {
      final path = NetworkEndpoints.updateAddress + '$addressID';
      final response = await client.request(
          requestType: RequestType.POST,
          path: path,
          headerWithAuth: true,
          parameter: param);
      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        return Result.success(apiresponse.message);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> saveAddressInCart(dynamic param) async {
    try {
      final response = await client.request(
          requestType: RequestType.POST,
          path: NetworkEndpoints.saveAddressInCart,
          headerWithAuth: true,
          parameter: param);
      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final shippingMethod = ShippingMethod.fromMap(apiresponse.data);
        print(shippingMethod);

        return Result.success(shippingMethod);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> saveShipping(dynamic param) async {
    try {
      final response = await client.request(
          requestType: RequestType.POST,
          path: NetworkEndpoints.saveShipping,
          headerWithAuth: true,
          parameter: param);
      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final paymentMethodData = PaymentMethod.fromMap(apiresponse.data);
        print(paymentMethodData);
        return Result.success(paymentMethodData);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> savePayment(dynamic param) async {
    try {
      final response = await client.request(
          requestType: RequestType.POST,
          path: NetworkEndpoints.savePayment,
          headerWithAuth: true,
          parameter: param);
      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        return Result.success(response.statusCode);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      }  else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> saveOrder() async {
    Map<String, dynamic> param = {};
    try {
      final response = await client.request(
          requestType: RequestType.POST,
          path: NetworkEndpoints.saveOrder,
          headerWithAuth: true,
          parameter: param);
      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        return Result.success(apiresponse.data);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> getOrders() async {
    try {
      final response = await client.request(
          requestType: RequestType.GET,
          path: NetworkEndpoints.getOrders,
          headerWithAuth: true);

      final apiresponse = NetworkResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        final List<Order> orders = List();
        final data = apiresponse.data as List;
        for (int i = 0; i < data.length; i++) {
          orders.add(Order.fromMap(data[i]));
        }
        return Result.success(orders);
      } else if (response.statusCode == 401) {
        return Result.error("INVALID EXPIRED TOKEN");

      } else {
        return Result.error(apiresponse.message);
      }
    } catch (error) {
      print(error);
      return Result.error("Something went wrong!");
    }
  }


  void dispose() => _updateCartItemStream.close();
}
