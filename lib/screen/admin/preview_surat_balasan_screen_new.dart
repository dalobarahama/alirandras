import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/helper/admin_api_helper.dart';
import 'package:flutter_application_3/screen/admin/approval_screen.dart';
import 'package:flutter_application_3/utils/transition_animation.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewSuratBalasanScreenNew extends StatefulWidget {
  String id, type, modelId;
  PreviewSuratBalasanScreenNew(this.id, this.type, this.modelId);

  @override
  _PreviewSuratBalasanScreenNewState createState() =>
      _PreviewSuratBalasanScreenNewState(this.id, this.type, this.modelId);
}

class _PreviewSuratBalasanScreenNewState
    extends State<PreviewSuratBalasanScreenNew> {
  String id, type, execURL = '', modelId;
  _PreviewSuratBalasanScreenNewState(this.id, this.type, this.modelId);
  final String SERVER_URL = 'https://alirandras.inotive.id/api/preview-pdf/';
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String? token, localPath;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

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
    CallAdminApi().getListPreviewSuratBalasan(execURL).then((value) {
      setState(() {
        localPath = value;
        // Fluttertoast.showToast(msg: 'File downloaded');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Stack(
          children: [
            localPath != null
                ? PDF(
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: false,
                    pageFling: false,
                    onPageChanged: (int? current, int? total) =>
                        _pageCountController.add('${current! + 1} - $total'),
                    onViewCreated: (PDFViewController pdfViewController) async {
                      _pdfViewController.complete(pdfViewController);
                      final int currentPage =
                          await pdfViewController.getCurrentPage() ?? 0;
                      final int? pageCount =
                          await pdfViewController.getPageCount();
                      _pageCountController
                          .add('${currentPage + 1} - $pageCount');
                    },
                  ).fromAsset(
                    localPath!,
                    errorWidget: (dynamic error) =>
                        Center(child: Text(error.toString())),
                  )
                : Container(),
            type == 'view'
                ? Container()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            SlideToLeftRoute(
                                page: ApprovalScreen('pengajuan', modelId)));
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 50, top: 20),
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ))
          ],
        ));
  }
}
