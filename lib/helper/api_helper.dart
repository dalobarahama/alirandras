import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/models/register_data.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class CallApi {
  final String SERVER_URL = 'http://alirandras.inotive.id';
  final String LOGIN_URL = '/api/auth/login';
  final String REGISTER_URL = '/api/register';

  Future<String> login(String email, String password) async {
    Uri fullUrl = Uri.parse(SERVER_URL + LOGIN_URL);
    LoginData _loginData = LoginData();
    try {
      var post =
          http.post(fullUrl, body: {'email': email, 'password': password});
      var res = await post;
      var a = jsonDecode(res.body)['status_code'];
      print(a);
      (_loginData.status_code);

      if (a == 200) {
        _loginData = loginDataFromJson(res.body);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', _loginData.token!);
        sharedPreferences.setString('user_data', userToJson(_loginData.user!));
        return 'success';
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');
        var msg = jsonDecode(res.body)['message'];
        return msg;
      } else {
        return 'failed';
      }
    } catch (e) {
      // print(e);
      return 'failed';
    }
  }

  Future<String> register(String nama, String email, String password) async {
    Uri fullUrl = Uri.parse(SERVER_URL + REGISTER_URL);
    RegisterData _registerData = RegisterData();
    try {
      var post = http.post(fullUrl,
          body: {'name': nama, 'email': email, 'password': password});
      var res = await post;
      var b = int.parse(jsonDecode(res.body)['status_code']);
      print(res.body);
      print(res.statusCode);
      print('aaaa');
      print(b);
      print('bbbb');

      if (b == 200) {
        //_registerData = registerDataFromJson(res.body);

        return 'success';
      } else if (b >= 400 && b <= 500) {
        // print('zzzzzz');
        var msg = jsonDecode(res.body)['message'];
        return msg;
      } else {
        return 'failed';
      }
    } catch (e) {
      // print(e);
      return 'failed';
    }
  }
}
