import 'package:edxera/jobs/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddJobScreen extends StatelessWidget {
  final int userId;
  final JobController jobController =
      Get.find<JobController>(); // Get existing instance

  AddJobScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Job")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(jobController.titleController, "Job Title"),
              _buildTextField(
                  jobController.smallDescController, "Small Description",
                  maxLines: 2),
              _buildTextField(
                  jobController.descriptionController, "Description",
                  maxLines: 4),
              _buildTextField(jobController.emailController, "Contact Email",
                  keyboardType: TextInputType.emailAddress),
              _buildTextField(
                  jobController.contactLinkController, "Contact Link"),
              _buildTextField(
                  jobController.whatsappController, "WhatsApp Number",
                  keyboardType: TextInputType.phone),
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
                      onPressed: () => jobController.submitJob(userId),
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
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
}
