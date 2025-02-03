import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String path;

  const ImageViewerScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF503494),
        leading: const BackButton(
          color: Colors.white, // <-- SEE HERE
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.network(path)],
        ),
      ),
    );
  }
}
