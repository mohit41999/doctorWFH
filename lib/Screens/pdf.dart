import 'dart:io';

import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OpenPdf extends StatefulWidget {
  final String url;
  final bool isnetwork;
  const OpenPdf({Key? key, required this.url, this.isnetwork = false})
      : super(key: key);

  @override
  _OpenPdfState createState() => _OpenPdfState();
}

class _OpenPdfState extends State<OpenPdf> {
  @override
  Widget build(BuildContext context) {
    print(widget.url + 'ppp');
    return Scaffold(
      appBar: AppBar(
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
        title: commonAppBarTitle(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: (widget.isnetwork)
          ? SfPdfViewer.network(widget.url)
          : SfPdfViewer.file(File(widget.url)),
    );
  }
}
