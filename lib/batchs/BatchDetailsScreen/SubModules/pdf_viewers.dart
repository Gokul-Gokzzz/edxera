// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViwersScreen extends StatefulWidget {
  String name, path;
  PdfViwersScreen({super.key, required this.name, required this.path});

  @override
  State<PdfViwersScreen> createState() => _PdfViwersScreenState();
}

class _PdfViwersScreenState extends State<PdfViwersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color(0XFF503494),
        leading: const BackButton(
          color: Colors.white, // <-- SEE HERE
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SfPdfViewer.network(
        initialZoomLevel: 1,
        widget.path,
      ),
    );
  }
}
