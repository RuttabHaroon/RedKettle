import 'package:redkettle/model/userdata.dart';
import 'package:redkettle/model/userpref.dart';

class AppStateManager {
  static final AppStateManager shared = AppStateManager._internal();

  UserData loginUserData;

  factory AppStateManager() {
    return shared;
  }

  AppStateManager._internal() {
    getUserData();
  }

  getUserData() async {
    await UserPref.retrieveUserDate().then((value) {
      if (value != null) {
        this.loginUserData = value;
      }
    });
  }
}