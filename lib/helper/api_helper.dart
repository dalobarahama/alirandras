import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter_application_3/models/admin_permission_model.dart';
import 'package:flutter_application_3/models/update_profile_return.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_3/models/login_data.dart';
import 'package:flutter_application_3/models/register_data.dart';
import 'package:flutter_application_3/models/get_kecamatan.dart';
import 'package:flutter_application_3/models/submit_formulir.dart';
import 'package:flutter_application_3/models/get_kelurahan.dart';
import 'package:flutter_application_3/models/get_list_pengajuan.dart';
import 'package:flutter_application_3/models/profile_data.dart';
import 'package:flutter_application_3/helper/prefs_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class CallApi {
  final String SERVER_URL = 'https://alirandras.inotive.id';
  final String LOGIN_URL = '/api/auth/login';
  final String REGISTER_URL = '/api/register';
  final String CEK_EMAIL = '/api/reset-password/cek-email';
  final String VERIFIKASI_OTP = '/api/reset-password/verifikasi-kode-otp';
  final String RESET_PASSWORD = '/api/reset-password';
  final String GET_KECAMATAN = '/api/location/districts?id=363';
  final String GET_KELURAHAN = '/api/location/villages?id=';
  final String SUBMIT_FORMULIR = '/api/formulir';
  final String SUBMIT_GAMBAR = '/api/tambah-file-formulir';
  final String SUBMIT_DOKUMEN = '/api/tambah-file-pendukung-formulir';
  final String GET_LIST_PENGAJUAN = '/api/surat-permohonan';
  final String UPDATE_FORMULIR = '/api/edit-formulir/';
  final String DELETE_FORMULIR = '/api/hapus-formulir/';
  final String DELETE_IMAGE = '/api/hapus-file-formulir/';
  final String DELETE_DOCUMENT = '/api/hapus-file-pendukung-formulir/';
  final String UPDATE_PROFILE = '/api/auth/edit-profile';

  Future<String> login(String email, String password) async {
    Uri fullUrl = Uri.parse(SERVER_URL + LOGIN_URL);
    LoginData loginData = LoginData();
    AdminPermission dataPermission = AdminPermission();
    try {
      var post =
          http.post(fullUrl, body: {'email': email, 'password': password});
      var res = await post;
      var a = jsonDecode(res.body)['status_code'];
      print(a);
      (loginData.statusCode);

      if (a == 200) {
        loginData = loginDataFromJson(res.body);
        dataPermission = adminPermissionFromJson(res.body);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', loginData.token!);
        sharedPreferences.setString('user_data', user1ToJson(loginData.user!));
        sharedPreferences.setString(
            'admin_permission', adminPermissionToJson(dataPermission));
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
    RegisterData registerData = RegisterData();
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
    List<GetKecamatan> dataKecamatan = <GetKecamatan>[];
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
        dataKecamatan = getKecamatanFromJson(res.body);

        //print(_data[1].image);

        return dataKecamatan;
      } else if (res.statusCode == 401) {
        //tanya return kalau fail apa?
        //token salah belum di handle
        GetKecamatan temporary = GetKecamatan();
        temporary.name = '401';
        dataKecamatan.add(temporary);
        return dataKecamatan;
      } else {
        dataKecamatan.clear();
        return dataKecamatan;
      }
    } catch (e) {
      print(e);
      dataKecamatan.clear();
      return dataKecamatan;
    }
  }

  Future<List<GetKelurahan>> getKelurahan(String id) async {
    List<GetKelurahan> dataKelurahan = <GetKelurahan>[];
    //id = '5130';
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + GET_KELURAHAN + id);

    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;

      if (res.statusCode == 200) {
        dataKelurahan = getKelurahanFromJson(res.body);

        //print(_data[1].image);

        return dataKelurahan;
      } else if (res.statusCode == 401) {
        //tanya return kalau fail apa?
        //token salah belum di handle
        GetKelurahan temporary = GetKelurahan();
        temporary.name = '401';
        dataKelurahan.add(temporary);
        return dataKelurahan;
      } else {
        dataKelurahan.clear();
        return dataKelurahan;
      }
    } catch (e) {
      print(e);
      dataKelurahan.clear();
      return dataKelurahan;
    }
  }

  Future<SubmitFormulir> submit_formulir(
      String type,
      String? district,
      String? subdistrict,
      String buildingArea,
      String landArea,
      String buildingLocation,
      String peruntukanBangunan,
      String lat,
      String lng,
      // List<XFile> imageFileList,
      List<File> dokumenFileList) async {
    SubmitFormulir dataFormulir = SubmitFormulir();
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var token = localStorage.getString('token');
    Uri fullUrl = Uri.parse(SERVER_URL + SUBMIT_FORMULIR);

    print(fullUrl);
    try {
      var post = http.post(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      }, body: {
        'type': type,
        'district': district,
        'subdistrict': subdistrict,
        'building_area': buildingArea,
        'land_area': landArea,
        'building_location': buildingLocation,
        'building_designation': peruntukanBangunan,
        'lat': lat,
        'lng': lng
      });
      print("post $post");
      var res = await post;

      int a = jsonDecode(res.body)['status_code'];
      print(a);
      if (a == 200) {
        print('masul200');
        print("api_helper res.body: ${res.body}");
        dataFormulir = submitFormulirFromJson(res.body);
        // if (imageFileList.isNotEmpty) {
        //   for (var i = 0; i < imageFileList.length; i++) {
        //     await CallApi().submit_gambar(
        //         dataFormulir.registrationForm!.id.toString(), imageFileList[i]);
        //   }
        // }
        if (dokumenFileList.isNotEmpty) {
          for (var i = 0; i < dokumenFileList.length; i++) {
            await CallApi().submitDokumen(
                dataFormulir.registrationForm!.id, dokumenFileList[i], i);
          }
        }
        print("api_helper res.body: ${res.body}");
        print("api_helper dataFormulir: $dataFormulir");
        return dataFormulir;
      } else if (a >= 400 && a <= 500) {
        print('masul400');
        dataFormulir = submitFormulirFromJson(res.body);
        var msg = jsonDecode(res.body)['message'];
        return dataFormulir;
      } else {
        print('masulexep');
        dataFormulir.clear();
        return dataFormulir;
      }
    } catch (e) {
      print(e);
      // dataFormulir.clear();
      return dataFormulir;
    }
  }

  Future<bool> submit_gambar(String id, XFile? image) async {
    Uri fullUrl = Uri.parse(SERVER_URL + SUBMIT_GAMBAR);
    print('ini submit gambar');
    print(fullUrl);
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      // String token =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9hbGlyYW5kcmFzLmlub3RpdmUuaWRcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MzkzMDEwMzEsIm5iZiI6MTYzOTMwMTAzMSwianRpIjoiM2V4VlV5YjNQUmZNZU1HRyIsInN1YiI6NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.zsqcqCdOPuIQa5FawcY_8KzBSpYUVCDK6JI0OWFpZFE';
      File? image1 = File(image!.path);
      http.MultipartFile file = http.MultipartFile(
          'file', image.readAsBytes().asStream(), image1.lengthSync(),
          filename: 'Gambar_bangunan_$id _${image.path.split(".").last}');

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest("POST", fullUrl)
        ..headers.addAll(headers);
      request.fields['registration_form_id'] = id.toString();
      request.files.add(file);

      print('asdasd');
      print(request.fields);
      print(request.files);
      // var response = await request.send();
      //var data = await http.Response.fromStream(response);
      http.StreamedResponse response = await request.send();
      var data = await http.Response.fromStream(response);
      print(data.body);
      int a = jsonDecode(data.body)['status_code'];
      print(a);
      if (a == 200) {
        print('selesai submit imeage');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> submitDokumen(var id, File? dokumen, int index) async {
    Uri fullUrl = Uri.parse(SERVER_URL + SUBMIT_DOKUMEN);
    print('ini submit dokumen');
    print(fullUrl);
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      // String token =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9hbGlyYW5kcmFzLmlub3RpdmUuaWRcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MzkzMDEwMzEsIm5iZiI6MTYzOTMwMTAzMSwianRpIjoiM2V4VlV5YjNQUmZNZU1HRyIsInN1YiI6NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.zsqcqCdOPuIQa5FawcY_8KzBSpYUVCDK6JI0OWFpZFE';
      File? dokumen1 = File(dokumen!.path);
      http.MultipartFile file = http.MultipartFile(
          'document', dokumen.readAsBytes().asStream(), dokumen1.lengthSync(),
          filename:
              'Dokumen_bangunan_${id}_$index.${dokumen.path.split(".").last}');
      print(
          "filename: Dokumen_bangunan_${id}_$index.${dokumen.path.split(".").last}");

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest("POST", fullUrl)
        ..headers.addAll(headers);
      request.fields['registration_form_id'] = id.toString();
      request.files.add(file);

      print('asdasd');
      print(request.fields);
      print(request.files);
      // var response = await request.send();
      //var data = await http.Response.fromStream(response);
      http.StreamedResponse response = await request.send();
      var data = await http.Response.fromStream(response);
      print(data.body);
      int a = jsonDecode(data.body)['status_code'];
      print(a);
      if (a == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ApplicationLetter1>?> getListPengajuan() async {
    bool isNull = false;
    ListPengajuan listPengajuan = ListPengajuan();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    //var token =
    //    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9hbGlyYW5kcmFzLmlub3RpdmUuaWRcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MzkyNDQ1ODgsIm5iZiI6MTYzOTI0NDU4OCwianRpIjoiVmdzTlhqMUtqRXBPazl6aCIsInN1YiI6NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.ojNMq1sf3oAKkgQ_-wsSc0nHu8xUC_vVEoogJ4CVp_g';
    Uri fullUrl = Uri.parse(SERVER_URL + GET_LIST_PENGAJUAN);
    print(fullUrl);
    try {
      var get = http.get(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var res = await get;
      //print(res.body);
      int a = jsonDecode(res.body)['status_code'];
      print(res.body);
      if (a == 200) {
        listPengajuan = listPengajuanFromJson(res.body);
        print(listPengajuan.applicationLetters1![0].id);
        return listPengajuan.applicationLetters1;
      } else if (a == 401) {
        List<ApplicationLetter1> temporary = <ApplicationLetter1>[];
        temporary[0].status = '401';
        listPengajuan.applicationLetters1![0].add(temporary);
        return listPengajuan.applicationLetters1;
      } else {
        listPengajuan.applicationLetters1!.clear();
        return listPengajuan.applicationLetters1;
      }
    } catch (e) {
      print(e);
      listPengajuan.applicationLetters1!.clear();
      return listPengajuan.applicationLetters1;
    }
  }

  Future<SubmitFormulir> update_formulir(
      String type,
      String? district,
      String? subdistrict,
      String buildingArea,
      String landArea,
      String buildingLocation,
      String buildingDesignation,
      String lat,
      String lng,
      List<XFile>? imageFileList,
      int? id,
      List<File>? dokumenFileList) async {
    SubmitFormulir dataFormulir = SubmitFormulir();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    //var token =
    //    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9hbGlyYW5kcmFzLmlub3RpdmUuaWRcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MzkzMDEwMzEsIm5iZiI6MTYzOTMwMTAzMSwianRpIjoiM2V4VlV5YjNQUmZNZU1HRyIsInN1YiI6NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.zsqcqCdOPuIQa5FawcY_8KzBSpYUVCDK6JI0OWFpZFE';
    Uri fullUrl = Uri.parse(SERVER_URL + UPDATE_FORMULIR + id.toString());
    print(fullUrl);
    try {
      var post = http.post(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      }, body: {
        'type': type,
        'district': district,
        'subdistrict': subdistrict,
        'building_area': buildingArea,
        'land_area': landArea,
        'building_location': buildingLocation,
        'building_designation': buildingDesignation,
        'lat': lat,
        'lng': lng
      });
      print(post);
      var res = await post;
      print(res.body);
      //print(res.statusCode);
      int a = jsonDecode(res.body)['status_code'];
      print(a);
      if (a == 200) {
        print('masul200');
        dataFormulir = submitFormulirFromJson(res.body);
        print('abnis masul200');
        if (imageFileList!.length > 0) {
          print(';bieh dari0');
          for (var i = 0; i < imageFileList.length; i++) {
            print('looping $i');
            await CallApi().submit_gambar(
                dataFormulir.registrationForm!.id.toString(), imageFileList[i]);
          }
        }
        if (dokumenFileList!.isNotEmpty) {
          for (var i = 0; i < dokumenFileList.length; i++) {
            await CallApi().submitDokumen(
                dataFormulir.registrationForm!.id, dokumenFileList[i], i);
          }
        }
        return dataFormulir;
      } else if (a >= 400 && a <= 500) {
        print('masul400');
        // _dataFormulir.clear();
        dataFormulir = submitFormulirFromJson(res.body);
        var msg = jsonDecode(res.body)['message'];
        print(msg);
        return dataFormulir;
      } else {
        print('masulexep');
        dataFormulir.clear();
        return dataFormulir;
      }
    } catch (e) {
      print(e);
      dataFormulir.clear();
      return dataFormulir;
    }
  }

  Future<String> deletePengajuan(int? id) async {
    Uri fullUrl = Uri.parse(SERVER_URL + DELETE_FORMULIR + id.toString());
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
        CallApi().deleteImage(id);
        CallApi().deleteDocument(id);
        return 'success';
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');

        return 'failed';
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  Future<bool> deleteImage(int? id) async {
    Uri fullUrl = Uri.parse(SERVER_URL + DELETE_IMAGE + id.toString());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var post = http.post(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      });
      print(fullUrl);
      var res = await post;
      print(res.body);
      print('del dok');

      var a = jsonDecode(res.body)['status_code'];
      print(res.body);
      print(a);
      if (a == 200) {
        return true;
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteDocument(int? id) async {
    Uri fullUrl = Uri.parse(SERVER_URL + DELETE_DOCUMENT + id.toString());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var post = http.post(fullUrl, headers: {
        'Authorization': 'Bearer $token',
        // 'Accept': 'application/json'
      });
      print(fullUrl);
      var res = await post;
      print(res.body);
      print('del dok');

      var a = int.parse(jsonDecode(res.body)['status_code']);
      print(res.body);
      print(a);
      if (a == 200) {
        return true;
      } else if (a >= 400 && a <= 500) {
        // print('zzzzzz');
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> updateProfile(String name, String email, String password,
      XFile? imageavatar, XFile? signature) async {
    Uri fullUrl = Uri.parse(SERVER_URL + UPDATE_PROFILE);
    UpdateProfileReturn dataProfile = UpdateProfileReturn();
    print(fullUrl);
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      // String token =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9hbGlyYW5kcmFzLmlub3RpdmUuaWRcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MzkzMDEwMzEsIm5iZiI6MTYzOTMwMTAzMSwianRpIjoiM2V4VlV5YjNQUmZNZU1HRyIsInN1YiI6NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.zsqcqCdOPuIQa5FawcY_8KzBSpYUVCDK6JI0OWFpZFE';
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest("POST", fullUrl)
        ..headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['email'] = email;
      if (password != null) {
        request.fields['password'] = password;
      }

      if (imageavatar != null) {
        File? image1 = File(imageavatar.path);
        http.MultipartFile file1 = http.MultipartFile(
            'avatar', imageavatar.readAsBytes().asStream(), image1.lengthSync(),
            filename: 'avatar_$name _${imageavatar.path.split(".").last}');
        request.files.add(file1);
      }
      if (signature != null) {
        File? image2 = File(signature.path);
        http.MultipartFile file2 = http.MultipartFile('signature',
            signature.readAsBytes().asStream(), image2.lengthSync(),
            filename: 'signature_$name _${signature.path.split(".").last}');
        request.files.add(file2);
      }

      http.StreamedResponse response = await request.send();
      var data = await http.Response.fromStream(response);
      int a = int.parse(jsonDecode(data.body)['status_code']);

      if (a == 200) {
        dataProfile = updateProfileReturnFromJson(data.body);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        localStorage.setString(
            'user_data', updateUserToJson(dataProfile.user!));
        print("api_helper user_data: ${localStorage.getString('user_data')}");
        print("response: ${data.body}");
        return 'success';
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
