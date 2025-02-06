import 'dart:io';
import 'package:edxera/jobs/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddJobScreen extends StatefulWidget {
  AddJobScreen({Key? key}) : super(key: key);

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final JobController jobController = Get.find<JobController>();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Job")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(jobController.titleController, "Job Title",
                    isRequired: true),
                _buildTextField(
                    jobController.companyNameController, "Company Name"),
                _buildTextField(
                    jobController.smallDescController, "Small Description",
                    maxLines: 2),
                _buildTextField(
                    jobController.descriptionController, "Description",
                    maxLines: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DropdownButtonFormField(
                    items: jobController.jobCategoryList.map(
                      (element) {
                        return DropdownMenuItem(
                            value: element.id,
                            child: Text(element.title ?? ""));
                      },
                    ).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        jobController.selectedJobCategoryId.value = value;
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return "This field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Job category")),
                  ),
                ),
                _buildDropdown("Work Type", jobController.workTypes,
                    jobController.selectedWorkType),
                _buildDropdown("Job Type", jobController.jobTypes,
                    jobController.selectedJobType),
                _buildDropdown("Experience", jobController.experienceLevels,
                    jobController.selectedExperience),
                _buildDatePicker(
                  context,
                  "Deadline",
                  jobController.deadlineController,
                ),
                _buildTextField(jobController.jobSalaryController, "Min Salary",
                    isRequired: true, keyboardType: TextInputType.number),
                _buildTextField(jobController.maxSalaryController, "Max Salary",
                    isRequired: true, keyboardType: TextInputType.number),
                _buildTextField(
                    jobController.jobBenefitsController, "Job Benefits"),
                _buildTextField(jobController.jobLocationController, "Location",
                    isRequired: true),
                _buildTextField(jobController.emailController, "Contact Email",
                    keyboardType: TextInputType.emailAddress, isRequired: true),
                _buildTextField(
                    jobController.contactLinkController, "Contact Link",
                    isRequired: true),
                _buildTextField(
                    jobController.whatsappController, "WhatsApp Number",
                    keyboardType: TextInputType.phone, isRequired: true),
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
                TextFormField(
                  controller: jobController.companyLogoController,
                  readOnly: true,
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();

                    XFile? pickedImages =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedImages != null) {
                      jobController.selectedLogo = pickedImages!;
                      jobController.companyLogoController.text =
                          pickedImages!.name;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Company Logo",
                    border: OutlineInputBorder(),
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
                Obx(
                  () => jobController.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              jobController.submitJob();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: Center(child: Text("Submit Job")),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: isRequired
            ? (value) {
                if ((value ?? "").isEmpty) {
                  return "This field is required";
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    RxString selectedValue, {
    bool isRequired = false,
  }) {
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
            validator: isRequired
                ? (value) {
                    if ((value ?? "").isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  }
                : null,
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
