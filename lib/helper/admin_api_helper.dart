import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_3/models/admin_home_model.dart';
import 'package:flutter_application_3/models/admin_pemohon_model.dart';
import 'package:flutter_application_3/models/list_pengajuan_admin_model.dart';
import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/models/manajemen_pengguna_model.dart';
import 'package:flutter_application_3/models/notif_model.dart';
import 'package:flutter_application_3/models/setting_pengajuan.dart';
import 'package:flutter_application_3/models/setting_pengajuan_user_model.dart';
import 'package:flutter_application_3/models/setting_update_post_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallAdminApi {
  final String SERVER_URL = 'http://alirandras.inotive.id';
  final String GET_SETTING_PENGAJUAN = '/api/setting-pengajuan';
  final String GET_LIST_PENGGUNA = '/api/list-pengguna';
  final String GET_ADMIN_HOME_DATA = '/api/formulir';
  final String GET_ADMIN_LIST_PEMOHON_DATA = '/api/surat-permohonan';
  final String EDIT_MANAJEMEN_PENGGUNA = '/api/edit-pengguna/';
  final String DELETE_PENGGUNA = '/api/hapus-pengguna/';
  final String APPROVE_PERMOHONAN = '/api/verifikasi-surat-permohonan/';
  final String GET_SETTING_USER_LIST = '/api/setting-pengajuan/list-user';
  final String UPDATE_SETTING = '/api/setting-pengajuan';
  final String UPDATE_FCM = '/api/update-fcm-token';
  final String GET_NOTIFICATON = '/api/notif';

  Future<SettingPengajuanModel> getSettingPengajuan() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + GET_SETTING_PENGAJUAN);
    SettingPengajuanModel _data = SettingPengajuanModel();

    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;
      //print(res.body);
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        _data = settingPengajuanModelFromJson(res.body);
        return _data;
      } else {
        print('error');
        throw 'error';
      }
    } catch (e) {
      print(e);
      throw 'error';
    }
  }

  Future<ManajemenPenggunaModel> getListPengguna() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + GET_LIST_PENGGUNA);
    ManajemenPenggunaModel _data = ManajemenPenggunaModel();

    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;
      //print(res.body);
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        _data = manajemenPenggunaModelFromJson(res.body);
        return _data;
      } else {
        print('error');
        throw 'error';
      }
    } catch (e) {
      print(e);
      throw 'error';
    }
  }

  Future<AdminHomeModel> getAdminHomeData(String year, String status) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(
        SERVER_URL + GET_ADMIN_HOME_DATA + '?year=$year&status=$status');
    AdminHomeModel _data = AdminHomeModel();
    print(SERVER_URL + GET_ADMIN_HOME_DATA + '?year=$year&status=$status');
    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      });

      var res = await get;
      //print(res.body);
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        _data = adminHomeModelFromJson(res.body);
        return _data;
      } else {
        print('error');
        throw 'error';
      }
    } catch (e) {
      print(e);
      throw 'error';
    }
  }

  Future<GetListPemohon> getListPemohonData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + GET_ADMIN_LIST_PEMOHON_DATA);
    GetListPemohon _data = GetListPemohon();

    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;
      //print(res.body);
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        _data = getListPemohonFromJson(res.body);
        return _data;
      } else {
        print('error');
        throw 'error';
      }
    } catch (e) {
      print(e);
      throw 'error';
    }
  }

  Future<String> editManajemenPengguna(String name, String email,
      String password, XFile avatar, XFile signature, String id) async {
    Uri fullUrl = Uri.parse(SERVER_URL + EDIT_MANAJEMEN_PENGGUNA);

    print(fullUrl);
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      print(avatar.name);
      // String token =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9hbGlyYW5kcmFzLmlub3RpdmUuaWRcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MzkzMDEwMzEsIm5iZiI6MTYzOTMwMTAzMSwianRpIjoiM2V4VlV5YjNQUmZNZU1HRyIsInN1YiI6NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.zsqcqCdOPuIQa5FawcY_8KzBSpYUVCDK6JI0OWFpZFE';
      File? image1 = File(avatar.path);
      File? image2 = File(signature.path);

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest("POST", fullUrl)
        ..headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      if (avatar != null) {
        http.MultipartFile _file1 = http.MultipartFile(
            'avatar', avatar.readAsBytes().asStream(), image1.lengthSync(),
            filename: 'avatar_$name _${avatar.path.split(".").last}');
        request.files.add(_file1);
      }
      if (signature != null) {
        http.MultipartFile _file2 = http.MultipartFile('signature',
            signature.readAsBytes().asStream(), image2.lengthSync(),
            filename: 'signature_$name _${signature.path.split(".").last}');
        request.files.add(_file2);
      }

      print('asdasd');
      print(request.fields);
      print(request.files);
      print(request);
      http.StreamedResponse response = await request.send();
      var data = await http.Response.fromStream(response);
      print(data.body);
      int a = int.parse(jsonDecode(data.body)['status_code']);
      print(a);
      if (a == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.setString(
            'user_data', user1ToJson(jsonDecode(data.body)['user']));
        return 'success';
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> deleteManajemenPengguna(String id) async {
    Uri fullUrl = Uri.parse(SERVER_URL + DELETE_PENGGUNA + id.toString());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var post = http.post(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      });
      print(fullUrl);
      var res = await post;
      int a = res.statusCode;
      print(res.body);
      print('del penga');
      print(a);
      if (a == 200) {
        return 'success';
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');

        return 'failed';
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> approvePermohonan(String id) async {
    Uri fullUrl = Uri.parse(SERVER_URL + APPROVE_PERMOHONAN + id.toString());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var post = http.post(fullUrl, body: {
        'category': 'diterima'
      }, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      });
      print(fullUrl);
      var res = await post;
      int a = res.statusCode;
      print(res.body);
      print('del penga');
      print(a);
      if (a == 200) {
        return 'success';
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');

        return 'failed';
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> rejectPermohonan(String id, String reason) async {
    Uri fullUrl = Uri.parse(SERVER_URL + APPROVE_PERMOHONAN + id.toString());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var post = http.post(fullUrl, body: {
        'category': 'ditolak',
        'reason_rejection': reason
      }, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      });
      print(fullUrl);
      var res = await post;
      int a = res.statusCode;
      print(res.body);
      print('del penga');
      print(a);
      if (a == 200) {
        return 'success';
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');

        return 'failed';
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<SettingPengajuanListUser> getListUserSetting() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + GET_SETTING_USER_LIST);
    SettingPengajuanListUser _data = SettingPengajuanListUser();

    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;
      //print(res.body);
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        _data = settingPengajuanListUserFromJson(res.body);
        return _data;
      } else {
        print('error');
        throw 'error';
      }
    } catch (e) {
      print(e);
      throw 'error';
    }
  }

  Future<String> updateSetting(SettingUserPost _data) async {
    Uri fullUrl = Uri.parse(SERVER_URL + UPDATE_SETTING);
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var post =
          http.post(fullUrl, body: settingUserPostToJson(_data), headers: {
        'Authorization': 'Bearer $token',
        'Accept': '*/*',
        'Content-Type': 'application/json'
      });
      print(json.encode(settingUserPostToJson(_data)));
      print(fullUrl);
      var res = await post;
      int a = res.statusCode;
      print(res.body);
      print(a);
      if (a == 200) {
        return 'success';
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');

        return 'failed';
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> updateFCM(String fcm) async {
    Uri fullUrl = Uri.parse(SERVER_URL + UPDATE_FCM);
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var post = http.post(fullUrl, body: {
        'fcm_token': fcm
      }, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      });
      print(fullUrl);
      var res = await post;
      int a = res.statusCode;
      print(res.body);
      if (a == 200) {
        return 'success';
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');

        return 'failed';
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<NotifModel> getNotificationList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + GET_NOTIFICATON);
    NotifModel _data = NotifModel();

    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;
      //print(res.body);
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        _data = notifModelFromJson(res.body);
        return _data;
      } else {
        print('error');
        throw 'error';
      }
    } catch (e) {
      print(e);
      throw 'error';
    }
  }
}
