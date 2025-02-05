import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File? _selectedMedia;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia({bool isVideo = false}) async {
    final XFile? pickedFile;

    if (isVideo) {
      pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    } else {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      setState(() {
        _selectedMedia = File(pickedFile!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Create Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              onPressed: () {},
              child: Text("POST", style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => _pickMedia(isVideo: true),
                  child: Row(
                    children: [
                      Icon(Icons.video_call, color: Colors.purple),
                      SizedBox(width: 5),
                      Text("Video"),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _pickMedia(isVideo: false),
                  child: Row(
                    children: [
                      Icon(Icons.photo, color: Colors.purple),
                      SizedBox(width: 5),
                      Text("Gallery"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write something..",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _selectedMedia != null
                ? isVideo(_selectedMedia!)
                    ? Text("Video selected: ${_selectedMedia!.path}")
                    : Image.file(
                        _selectedMedia!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                : Container(),
          ],
        ),
      ),
    );
  }

  bool isVideo(File file) {
    return file.path.toLowerCase().endsWith('.mp4') ||
        file.path.toLowerCase().endsWith('.mov') ||
        file.path.toLowerCase().endsWith('.avi');
  }
}
