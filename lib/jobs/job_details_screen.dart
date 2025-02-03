import 'package:edxera/jobs/job_list_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailScreen extends StatelessWidget {
  final Datum job;

  const JobDetailScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          job.title ?? "Job Details",
          style: TextStyle(color: Colors.white38),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title ?? "No Title",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800]),
              ),
              SizedBox(height: 10),
              Text(
                job.description ?? "",
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 16),
              _infoRow(Icons.email, "Contact Email", job.contactEmail),
              _infoRow(Icons.phone, "WhatsApp", job.contactWhatsappNumber),
              _infoRow(Icons.work, "Status", job.status),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: job.applyAalowedStatus == 1
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => _showApplyOptions(context),
                child: Text("Apply Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
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
              _optionTile(
                  context, Icons.chat, "WhatsApp", Colors.green, _openWhatsApp),
              _optionTile(
                  context, Icons.email, "Email", Colors.red, _sendEmail),
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
        Navigator.pop(context);
      },
    );
  }

  void _openWhatsApp() async {
    final phone = job.contactWhatsappNumber;
    if (phone != null && phone.isNotEmpty) {
      final url = "https://wa.me/$phone";
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }

  void _sendEmail() async {
    final email = job.contactEmail;
    if (email != null && email.isNotEmpty) {
      final url = "mailto:$email";
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }
}
