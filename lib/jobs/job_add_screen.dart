import 'dart:io';
import 'package:edxera/jobs/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddJobScreen extends StatefulWidget {
  final int userId;

  AddJobScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _AddJobScreenState createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final JobController jobController = Get.find<JobController>();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      jobController.setCompanyLogo(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Job")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(jobController.titleController, "Job Title"),
                _buildTextField(
                    jobController.companyNameController, "Company Name"),
                _buildTextField(
                    jobController.smallDescController, "Small Description",
                    maxLines: 2),
                _buildTextField(
                    jobController.descriptionController, "Description",
                    maxLines: 4),
                _buildDropdown("Work Type", jobController.workTypes,
                    jobController.selectedWorkType),
                _buildDropdown("Job Type", jobController.jobTypes,
                    jobController.selectedJobType),
                _buildDropdown("Experience", jobController.experienceLevels,
                    jobController.selectedExperience),
                _buildDatePicker(
                    context, "Deadline", jobController.deadlineController),
                _buildTextField(
                    jobController.jobSalaryController, "Min Salary"),
                _buildTextField(
                    jobController.maxSalaryController, "Max Salary"),
                _buildTextField(
                    jobController.jobBenefitsController, "Job Benefits"),
                _buildTextField(
                    jobController.jobLocationController, "Location"),
                _buildTextField(jobController.emailController, "Contact Email",
                    keyboardType: TextInputType.emailAddress),
                _buildTextField(
                    jobController.contactLinkController, "Contact Link"),
                _buildTextField(
                    jobController.whatsappController, "WhatsApp Number",
                    keyboardType: TextInputType.phone),
                _buildTextField(jobController.responsibilitiesController,
                    "Responsibilities",
                    maxLines: 3),
                _buildTextField(
                    jobController.requirementsController, "Requirements",
                    maxLines: 3),
                _buildTextField(jobController.skillsController, "Skills",
                    maxLines: 3),
                _buildTextField(jobController.preferredQualificationController,
                    "Preferred Qualification",
                    maxLines: 3),
                _buildTextField(
                    jobController.companyWebsiteController, "Company Website"),

                // Image Picker Field
                Text("Company Logo", style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _selectedImage == null
                        ? Icon(Icons.image, size: 50, color: Colors.grey)
                        : Image.file(_selectedImage!, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 10),

                Obx(() => Row(
                      children: [
                        Text("Allow Apply: ", style: TextStyle(fontSize: 16)),
                        Switch(
                          value: jobController.applyStatus.value == 1,
                          onChanged: (value) {
                            jobController.applyStatus.value = value ? 1 : 0;
                          },
                        ),
                      ],
                    )),
                SizedBox(height: 20),

                Obx(() => jobController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () => jobController.submitJob(widget.userId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Center(child: Text("Submit Job")),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label, List<String> items, RxString selectedValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Obx(() => DropdownButtonFormField<String>(
            value: selectedValue.value,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
            items: items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (newValue) {
              selectedValue.value = newValue!;
            },
          )),
    );
  }

  Widget _buildDatePicker(
      BuildContext context, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            controller.text = pickedDate.toLocal().toString().split(' ')[0];
          }
        },
      ),
    );
  }
}
