import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/profile/Controllers/profile_controller/profile_conreoller.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserProfileController controller = Get.put(UserProfileController());
  File? _selectedImage;
  File? _selectedResume;
  final ImagePicker _picker = ImagePicker();

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
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedResume = File(result.files.single.path!);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.dobNameController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.04;
    final double radius = size.width * 0.05;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.userProfile.value?.data != null) {
          final userData = controller.userProfile.value!.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.15,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : userData.profileImage != null
                                ? CachedNetworkImageProvider(
                                        "${ApiConstants.publicBaseUrl}/${userData.profileImage}")
                                    as ImageProvider
                                : const AssetImage('assets/placeholder.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: size.width * 0.05,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.white),
                            onPressed: _updateProfileImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: padding),
                _buildEditableDataItem("First Name", userData.firstName,
                    controller.firstNameController, radius),
                _buildEditableDataItem("Last Name", userData.lastName,
                    controller.lastNameController, radius),
                _buildEditableDataItem("Email", userData.email,
                    controller.emailController, radius),
                _buildEditableDataItem("Address", userData.address,
                    controller.addressController, radius),
                _buildEditableDataItem("Qualification", userData.qualification,
                    controller.qualificationController, radius),
                _buildDateEditableDataItem(
                  "Date of Birth",
                  userData.dateOfBirth != null
                      ? DateFormat('yyyy-MM-dd').format(userData.dateOfBirth!)
                      : null,
                  controller.dobNameController,
                  context,
                ),
                GestureDetector(
                  onTap: _pickResume,
                  child: Container(
                    padding: EdgeInsets.all(padding * 0.6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius),
                          bottomRight: Radius.circular(radius)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: size.width * 0.5,
                          child: Text(
                            _selectedResume != null
                                ? _selectedResume!.path.split('/').last
                                : userData.resume ?? "Upload Resume (PDF)",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.upload_file, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: padding),
                ElevatedButton(
                  onPressed: () {
                    controller.updateProfile(
                      firstName: controller.firstNameController.text,
                      lastName: controller.lastNameController.text,
                      email: controller.emailController.text,
                      address: controller.addressController.text,
                      qualification: controller.qualificationController.text,
                      dateOfBirth: controller.dobNameController.text,
                      profileImageFile: _selectedImage,
                      resumeFile: _selectedResume,
                    );
                  },
                  child: const Text("Save Changes"),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("No data available."));
        }
      }),
    );
  }

  Widget _buildEditableDataItem(String label, String? value,
      TextEditingController? controller, double radius) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateEditableDataItem(String label, String? value,
      TextEditingController? controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(border: InputBorder.none),
              onTap: () => _selectDate(context), // Show date picker on tap
              readOnly: true, // Prevent manual text input
            ),
          ),
        ],
      ),
    );
  }
}
