// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViwersScreen extends StatefulWidget {
  String name, path;
  PdfViwersScreen({super.key, required this.name, required this.path});

  @override
  State<PdfViwersScreen> createState() => _PdfViwersScreenState();
}

class _PdfViwersScreenState extends State<PdfViwersScreen> {
  Uint8List? data;

  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await getData();
      },
    );
    super.initState();
  }

  FutureOr<Uint8List> getData() async {
    setState(() {
      isLoading = true;
    });
    data = await downloadFile();
    setState(() {
      isLoading = false;
    });
    return data!;
  }

  Future<Uint8List?> downloadFile() async {
    final dio = Dio();
    print(widget.path);
    try {
      Response response = await dio.get(
        widget.path,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );

      return response.data;
    } catch (e) {
      print('error $e');
    }
    return null;
  }

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : data != null
              ? PdfPreview(
                  canChangeOrientation: false,
                  allowPrinting: true,
                  canDebug: false,
                  canChangePageFormat: true,
                  actionBarTheme: const PdfActionBarTheme(),
                  allowSharing: true,
                  useActions: true,
                  build: (format) => data!,
                )
              : Center(
                  child: Text("Failed to load pdf"),
                ),
    );
  }
}
