import 'package:flutter_application_3/models/manajemen_pengguna_model.dart';
import 'package:flutter_application_3/models/setting_pengajuan.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallAdminApi {
  final String SERVER_URL = 'http://alirandras.inotive.id';
  final String GET_SETTING_PENGAJUAN = '/api/setting-pengajuan';
  final String GET_LIST_PENGGUNA = '/api/list-pengguna';

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
}
