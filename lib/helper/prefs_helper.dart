import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/models/login_data.dart';

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

  Future<User1> getUserData() async {
    User1 _data = User1();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? data = localStorage.getString('user_data');
    _data = user1FromJson(data!);
    return _data;
  }
}
