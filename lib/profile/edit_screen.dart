import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/profile/service/edit_service.dart';
import 'package:edxera/profile/Controllers/profile_controller/profile_conreoller.dart';
import 'package:edxera/repositories/api/api_constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserProfileService service = UserProfileService();
  final UserProfileController profileController =
      Get.put(UserProfileController());
  File? _selectedImage;
  File? _selectedResume;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    profileController.loadUserProfile("498"); // Replace with actual user ID
  }

  Future<void> _updateProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        _selectedResume = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (profileController.userProfile.value == null) {
          return Center(child: Text("Failed to load profile"));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : CachedNetworkImageProvider(
                                "${ApiConstants.publicBaseUrl}/${profileController.userProfile.value!.data!.profileImage}",
                              ) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.white),
                            onPressed: _updateProfileImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: profileController.firstNameController,
                    decoration: InputDecoration(labelText: "First Name"),
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: profileController.lastNameController,
                    decoration: InputDecoration(labelText: "Last Name"),
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: profileController.emailController,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: profileController.addressController,
                    decoration: InputDecoration(labelText: "Address"),
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: profileController.dobNameController,
                    decoration: InputDecoration(labelText: "Date of Birth"),
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: profileController.qualificationController,
                    decoration: InputDecoration(labelText: "Qualification"),
                  ),
                  SizedBox(height: 20),

                  // Resume Upload Box
                  GestureDetector(
                    onTap: _pickResume,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedResume != null
                                ? "${_selectedResume!.path.split('/').last}"
                                : "Upload Resume (PDF)",
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.upload_file, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      bool isUpdated = await service.updateUserProfile(
                        userId: "498",
                        firstName: profileController.firstNameController.text,
                        lastName: profileController.lastNameController.text,
                        email: profileController.emailController.text,
                        address: profileController.addressController.text,
                        qualification:
                            profileController.qualificationController.text,
                        dateOfBirth: profileController.dobNameController.text,
                        gender: "Male",
                      );

                      if (isUpdated) {
                        Get.snackbar("Success", "Profile updated successfully",
                            snackPosition: SnackPosition.BOTTOM);
                        Future.delayed(Duration(seconds: 1), () {
                          Get.back(); // Pop back to the previous screen
                        });
                      } else {
                        Get.snackbar("Error", "Failed to update profile",
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: Text("Save Changes"),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
