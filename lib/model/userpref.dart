import 'package:redkettle/config/Constants.dart';
import 'package:redkettle/model/network_reponse.dart';
import 'package:redkettle/model/userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appstatemanager.dart';

class UserPref {

  static void persistUserData(String str) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', str);
  }

  static Future<UserData> retrieveUserDate() async {
    final prefs = await SharedPreferences.getInstance();
    final userJsonString = prefs.getString('user') ?? '';

    final apiresponse = NetworkResponse.fromRawJson(userJsonString);
    final userModel = UserData.fromMap(apiresponse.data);

    AppStateManager.shared.loginUserData = userModel;
    Constants.bearerTOKEN = userModel.token;

    return userModel;
  }

  static void removeUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');
  }


  static void clearPersistance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}