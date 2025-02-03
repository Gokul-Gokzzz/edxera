import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/My_cources/lesson_play.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../repositories/api/api_constants.dart';

class DynamicFileViewer extends StatelessWidget {
  final String fileUrl;

  const DynamicFileViewer({
    Key? key,
    required this.fileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (fileUrl.isEmpty) return const SizedBox();

    print("====>${jsonDecode(fileUrl)}");

    final fileExtension = path.extension(jsonDecode(fileUrl).trim()).toLowerCase();
    final fullUrl = Uri.parse('${ApiConstants.publicBaseUrl}/${jsonDecode(fileUrl)}').toString();

    if (fileExtension.contains('jpg') || fileExtension.contains('jpeg') || fileExtension.contains('png')) {
      return _buildImageViewer(fullUrl);
    } else if (fileExtension.contains('pdf')) {
      return _buildPdfViewer(context, fullUrl);
    } else if (fileExtension.contains('mp4') || fileExtension.contains('mov') || fileExtension.contains('avi')) {
      return _buildVideoViewer(context, fullUrl);
    }

    return const Center(child: Text('Unsupported file type'));
  }

  Widget _buildImageViewer(String imageUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            SizedBox(height: 25, width: 25, child: Center(child: CircularProgressIndicator(value: downloadProgress.progress))),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget _buildPdfViewer(BuildContext context, String pdfUrl) {
    return Container(
      height: 80,
      width: double.infinity,
      child: ListTile(
        leading: Icon(Icons.picture_as_pdf, color: Colors.red),
        title: Text(path.basename(jsonDecode(fileUrl))),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFViewerScreen(pdfUrl: pdfUrl),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoViewer(BuildContext context, String videoUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      child: VideoPlayerWidget(videoUrl: videoUrl),
    );
  }
}

// Separate screen for PDF viewing
class PDFViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer')),
      body: SfPdfViewer.network(
        pdfUrl,
      ),
    );
  }
}

// Video Player Widget
class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VidioPlay(lessonplay: videoUrl);
  }
}
