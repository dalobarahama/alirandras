import 'package:shared_preferences/shared_preferences.dart';

class CallStorage {
  Future<bool> checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var owner = localStorage.getString('token');
    if (owner != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    return true;
  }
}
