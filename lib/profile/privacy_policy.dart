import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Privacy Policy"),
              _buildParagraph(
                  "This privacy policy applies to the edxera app (hereby referred to as 'Application') for mobile devices that was created by Sharan P (hereby referred to as 'Service Provider') as a Free service. This service is intended for use 'AS IS'."),
              _buildSectionTitle("Information Collection and Use"),
              _buildParagraph(
                  "The Application collects information when you download and use it. This may include:"),
              _buildBulletPoint(
                  "Your device's Internet Protocol address (IP address)."),
              _buildBulletPoint("The pages of the Application that you visit."),
              _buildBulletPoint(
                  "The time and date of your visit and time spent on pages."),
              _buildBulletPoint("The operating system of your mobile device."),
              _buildParagraph(
                  "The Application does not gather precise location information."),
              _buildSectionTitle("Third Party Access"),
              _buildParagraph(
                  "Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service."),
              _buildParagraph(
                  "The Application utilizes third-party services that have their own Privacy Policies. Below are the links to the Privacy Policies of these services:"),
              _buildBulletPoint("Google Play Services"),
              _buildSectionTitle("Opt-Out Rights"),
              _buildParagraph(
                  "You can stop all data collection by uninstalling the application."),
              _buildSectionTitle("Data Retention Policy"),
              _buildParagraph(
                  "The Service Provider will retain user-provided data for as long as you use the Application. If you wish to delete your data, please contact info@edxera.com."),
              _buildSectionTitle("Children's Privacy"),
              _buildParagraph(
                  "The Service Provider does not knowingly collect data from children under 13. If a child has provided information, it will be deleted immediately."),
              _buildSectionTitle("Security"),
              _buildParagraph(
                  "The Service Provider provides physical, electronic, and procedural safeguards to protect your data."),
              _buildSectionTitle("Changes to Privacy Policy"),
              _buildParagraph(
                  "This Privacy Policy may be updated from time to time. You are advised to check this page for updates."),
              _buildSectionTitle("Contact Us"),
              _buildParagraph(
                  "For any privacy concerns, contact info@edxera.com."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
