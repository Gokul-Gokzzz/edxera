import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:edxera/jobs/job_list_model.dart';

class JobDetailScreen extends StatelessWidget {
  final Datum job;

  const JobDetailScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          job.title ?? "Job Details",
          maxLines: 3,
          style: TextStyle(color: Color(0XFF503494)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///title
              Text(
                job.title ?? "No Title",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800]),
              ),
              SizedBox(height: 10),

              Center(
                child: SizedBox(
                  height: 150,
                  child: CachedNetworkImage(
                    imageUrl:
                        "${ApiConstants.publicBaseUrl}/${job.companyLogo ?? ""}",
                    errorWidget: (context, url, error) => Center(
                      child: SizedBox(
                        height: 100,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///Description
              ///
              Text(job.description ?? "",
                  style: TextStyle(fontSize: 18, color: Colors.black87)),
              SizedBox(height: 16),

              ///  🏢 Job Title (Text Input)
              _infoRow2("🏚", "Company Name", job.companyName),
              _infoRow2("🌍", "Job Location", job.jobLocation),
              _infoRow2("🏠", "Work Type", job.workType),
              _infoRow2("💼", "Job Type", job.jobType),
              _infoRow2("💰", "Salary Range",
                  "${job.jobSalaryMin} - ${job.jobSalaryMax}"),
              _infoRow2("🎓", "Experience Required", job.experience),

              ///2️⃣ Job Description
              _infoRow(Icons.location_on_outlined, "Responsibilities",
                  job.responsibilities),
              _infoRow(
                  Icons.work_history_outlined, "Requirements", job.workType),
              _infoRow(
                  Icons.work_history_outlined, "Skills Required", job.jobType),
              _infoRow(Icons.attach_money, "Salary Range",
                  "${job.jobSalaryMin} - ${job.jobSalaryMax}"),
              _infoRow(Icons.workspace_premium, "Preferred Qualifications",
                  job.experience),

              /// 3️⃣ Application Process
              _infoRow2("📅", "Application Deadline", job.applicationDeadline),
              _infoRow2("✉️", "How to Apply?", job.contactLink, isLink: true),
              _infoRow2("🔗", "Application Link/Email", job.contactEmail),

              /// 4️⃣ Additional Details
              _infoRow2("🎁", "Job Benefits", job.jobBenefits),
              _infoRow2("📂", "Company Logo", job.companyLogo),
              _infoRow2("🌐", "Company Website", job.companyWebsite,
                  isLink: true),
              _infoRow2(
                "📱",
                "WhatsApp",
                job.contactWhatsappNumber,
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: job.applyAalowedStatus == 0
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => _showApplyOptions(context),
                child: Text(
                  "Apply Now",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF503494),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          : null,
    );
  }

  /// **Info Row Widget**
  Widget _infoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey[700]),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "$label: ${value ?? "N/A"}",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow2(String icon, String label, String? value,
      {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            icon,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
                if (isLink) {
                  launchUrl(Uri.parse(value!));
                }
              },
              child: Text(
                "$label: ${value ?? "N/A"}",
                style: TextStyle(
                    fontSize: 16, color: isLink ? Colors.blue : Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _infoRow3(String icon, String label, String? value,
  //     {bool isLink = false}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 10),
  //     child: Row(
  //       children: [
  //         Text(
  //           icon,
  //           style: TextStyle(fontSize: 16, color: Colors.black87),
  //         ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: InkWell(
  //             onTap: () {
  //               if (isLink) {
  //                 launchUrl(Uri.parse(value!));
  //               }
  //             },
  //             child: Text(
  //               "$label: ${value ?? "N/A"}",
  //               style: TextStyle(
  //                   fontSize: 16, color: isLink ? Colors.blue : Colors.black87),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// **Bottom Sheet for Apply Options**
  void _showApplyOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Apply via",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800]),
              ),
              SizedBox(height: 16),
              _optionTile(context, Icons.chat, "WhatsApp", Colors.green, () {
                _showWhatsAppNumber(context);
              }),
              _optionTile(context, Icons.email, "Email", Colors.red,
                  () => _sendEmail(context)),
            ],
          ),
        );
      },
    );
  }

  Widget _optionTile(BuildContext context, IconData icon, String text,
      Color color, Function() onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(fontSize: 16)),
      onTap: () {
        onTap();
        // Navigator.pop(context);
      },
    );
  }

  /// **Open WhatsApp**
  void _showWhatsAppNumber(BuildContext context) {
    final phone = job.contactWhatsappNumber;
    if (phone != null && phone.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("WhatsApp Contact"),
            content: Text("📱 8129935578"),
            // Text("📱 $phone"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          );
        },
      );
    }
  }

  /// **Send Email**
  void _sendEmail(BuildContext context) {
    final email = job.contactEmail;
    if (email != null && email.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Send Email"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Send your job application using the following format:"),
                SizedBox(height: 8),
                Text("📌 Subject: Job Application for ${job.title}"),
                Text(
                    "📌 Body:\n- Name: \n- Contact: \n- Experience: \n- Cover Letter:"),
                SizedBox(height: 10),
                // Text("📧 Send to: $email"),
                Text("📧 Send to: info@edxera.com"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  final subject =
                      Uri.encodeComponent("Job Application for ${job.title}");
                  final body = Uri.encodeComponent(
                      "Dear Hiring Manager,\n\nI am interested in the ${job.title} position. Here are my details:\n\n- Name:\n- Contact:\n- Experience:\n- Cover Letter:\n\nBest regards,");
                  final url = "mailto:$email?subject=$subject&body=$body";
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: Text("Send Email"),
              ),
            ],
          );
        },
      );
    }
  }

  /// **Open Application Link**
  // void _openApplicationLink() async {
  //   // final link = job.applicationLink;
  //   if (link != null && link.isNotEmpty) {
  //     if (await canLaunch(link)) {
  //       await launch(link);
  //     }
  //   }
  // }
}
