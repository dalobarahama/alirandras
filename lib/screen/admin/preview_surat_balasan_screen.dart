import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewSuratBalasanScreen extends StatefulWidget {
  String id, type;
  PreviewSuratBalasanScreen(this.id, this.type);

  @override
  _PreviewSuratBalasanScreenState createState() =>
      _PreviewSuratBalasanScreenState(this.id, this.type);
}

class _PreviewSuratBalasanScreenState extends State<PreviewSuratBalasanScreen> {
  String id, type, execURL = '';
  _PreviewSuratBalasanScreenState(this.id, this.type);
  final String SERVER_URL = 'https://alirandras.inotive.id/api/preview-pdf/';
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String? token;

  @override
  initState() {
    execURL = SERVER_URL + id;

    print(execURL);
    initData();
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  initData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      token = localStorage.getString('token');
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.red),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: Builder(builder: (BuildContext context) {
                return WebView(
                  initialUrl: execURL,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    webViewController.loadUrl('execURL', headers: {
                      'Authorization': 'Bearer $token',
                    });
                    _controller.complete(webViewController);
                  },
                  onWebResourceError: (a) {
                    Fluttertoast.showToast(
                        msg: 'error load : ${a.description}');
                  },
                  onProgress: (int progress) {
                    print('WebView is loading (progress : $progress%)');
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                  },
                  gestureNavigationEnabled: true,
                  backgroundColor: const Color(0x00000000),
                );
              }),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 20),
              child: Center(
                child: Text(
                  'Lanjut Verifikasi',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
            )
          ],
        ));
  }
}
