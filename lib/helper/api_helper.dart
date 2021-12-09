import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_3/models/get_kelurahan.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/models/register_data.dart';
import 'package:flutter_application_3/models/get_kecamatan.dart';
import 'package:flutter_application_3/models/submit_formulir.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class CallApi {
  final String SERVER_URL = 'http://alirandras.inotive.id';
  final String LOGIN_URL = '/api/auth/login';
  final String REGISTER_URL = '/api/register';
  final String CEK_EMAIL = '/api/reset-password/cek-email';
  final String VERIFIKASI_OTP = '/api/reset-password/verifikasi-kode-otp';
  final String RESET_PASSWORD = '/api/reset-password';
  final String GET_KECAMATAN = '/api/location/villages?id=363';
  final String GET_KELURAHAN = '/api/location/villages?id=';
  final String SUBMIT_FORMULIR = '/api/formulir';
  final String SUBMIT_GAMBAR = '/api/tambah-file-formulir';

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
      return e.toString();
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
      return e.toString();
    }
  }

  Future<String> cek_email(String email) async {
    Uri fullUrl = Uri.parse(SERVER_URL + CEK_EMAIL);

    try {
      var post = http.post(fullUrl, body: {'email': email});
      var res = await post;
      var a = int.parse(jsonDecode(res.body)['status_code']);
      print(a);
      if (a == 200) {
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
      return e.toString();
    }
  }

  Future<String> verifikasi_otp(String code) async {
    Uri fullUrl = Uri.parse(SERVER_URL + VERIFIKASI_OTP);

    try {
      var post = http.post(fullUrl, body: {'code': code});
      var res = await post;
      var a = int.parse(jsonDecode(res.body)['status_code']);
      print(a);
      if (a == 200) {
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
      return e.toString();
    }
  }

  Future<String> reset_password(String code, String password) async {
    Uri fullUrl = Uri.parse(SERVER_URL + RESET_PASSWORD);

    try {
      var post = http.post(fullUrl, body: {'code': code, 'password': password});
      var res = await post;
      var a = int.parse(jsonDecode(res.body)['status_code']);
      print(a);
      if (a == 200) {
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
      return e.toString();
    }
  }

  Future<List<GetKecamatan>> getKecamatan() async {
    List<GetKecamatan> _dataKecamatan = <GetKecamatan>[];
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + GET_KECAMATAN);

    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;
      //print(res.body);
      //print(res.statusCode);
      // print(res.body);
      if (res.statusCode == 200) {
        _dataKecamatan = getKecamatanFromJson(res.body);

        //print(_data[1].image);

        return _dataKecamatan;
      } else if (res.statusCode == 401) {
        //tanya return kalau fail apa?
        //token salah belum di handle
        GetKecamatan temporary = GetKecamatan();
        temporary.name = '401';
        _dataKecamatan.add(temporary);
        return _dataKecamatan;
      } else {
        _dataKecamatan.clear();
        return _dataKecamatan;
      }
    } catch (e) {
      print(e);
      _dataKecamatan.clear();
      return _dataKecamatan;
    }
  }

  Future<List<GetKelurahan>> getKelurahan(String id) async {
    List<GetKelurahan> _dataKelurahan = <GetKelurahan>[];
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + GET_KELURAHAN + id);
    print(fullUrl);
    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;

      if (res.statusCode == 200) {
        _dataKelurahan = getKelurahanFromJson(res.body);

        //print(_data[1].image);

        return _dataKelurahan;
      } else if (res.statusCode == 401) {
        //tanya return kalau fail apa?
        //token salah belum di handle
        GetKelurahan temporary = GetKelurahan();
        temporary.name = '401';
        _dataKelurahan.add(temporary);
        return _dataKelurahan;
      } else {
        _dataKelurahan.clear();
        return _dataKelurahan;
      }
    } catch (e) {
      print(e);
      _dataKelurahan.clear();
      return _dataKelurahan;
    }
  }

  Future<SubmitFormulir> submit_formulir(
      String type,
      String district,
      String? subdistrict,
      String building_area,
      String land_area,
      String building_location,
      String complete_address,
      String lat,
      String lng) async {
    SubmitFormulir _dataFormulir = SubmitFormulir();
    Uri fullUrl = Uri.parse(SERVER_URL + SUBMIT_FORMULIR);

    try {
      var post = http.post(fullUrl, body: {
        'type': type,
        'district': district,
        'subdistrict': subdistrict,
        'building_area': building_area,
        'land_area': land_area,
        'building_location': building_location,
        'complete_address': complete_address,
        'lat': lat,
        'lng': lng
      });
      var res = await post;
      var a = int.parse(jsonDecode(res.body)['status_code']);
      print(a);
      if (a == 200) {
        _dataFormulir = submitFormulirFromJson(res.body);
        return _dataFormulir;
      } else if (a >= 400 && a <= 500) {
        _dataFormulir = submitFormulirFromJson(res.body);
        var msg = jsonDecode(res.body)['message'];
        return _dataFormulir;
      } else {
        _dataFormulir.clear();
        return _dataFormulir;
      }
    } catch (e) {
      _dataFormulir.clear();
      return _dataFormulir;
    }
  }

  Future<String> submit_gambar(var id, XFile? image) async {
    Uri fullUrl = Uri.parse(SERVER_URL + SUBMIT_GAMBAR);

    try {
      var post =
          http.post(fullUrl, body: {'registration_form_id': id, 'file': image});
      var res = await post;
      var a = int.parse(jsonDecode(res.body)['status_code']);
      print(a);
      if (a == 200) {
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
      return e.toString();
    }
  }
}
