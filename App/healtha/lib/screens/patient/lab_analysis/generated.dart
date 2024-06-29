import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../localization/generated/l10n.dart';
import '../../../models/report.dart';
import '../../doctor/doc-profile.dart';
import 'report.dart';
import 'dart:convert';

class GeneratedReports extends StatelessWidget {
  const GeneratedReports({super.key});

  Future<List<ReportModel>> fetchReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    final response = await http.get(Uri.parse('http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/reports?userId=$userId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      final result = jsonResponse.map((data) => ReportModel.fromJson(data)).toList();

      return result;
    } else {
      throw Exception('Failed to load reports');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFE0E7EA), // Light blue
                    const Color(0xff7c77d1).withOpacity(0.2), // Light grey
                  ],
                ),
              ),
            ),
            // Abstract Shapes
            Positioned(
              top: -screenSize.width * 0.3,
              right: -screenSize.width * 0.1,
              child: Container(
                width: screenSize.width * 0.6,
                height: screenSize.width * 0.6,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C77D1), // Purple
                  borderRadius: BorderRadius.circular(screenSize.width * 0.3),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * 0.3,
              left: -screenSize.width * 0.2,
              child: Container(
                width: screenSize.width * 0.4,
                height: screenSize.width * 0.4,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C77D1), // Purple
                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                ),
              ),
            ),
            // Small circle at the bottom right
            Positioned(
              bottom: screenSize.height * 0.01,
              right: screenSize.width * 0.01,
              child: Container(
                width: screenSize.width * 0.2,
                height: screenSize.width * 0.2,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C77D1), // Purple
                  borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkResponse(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => drProfile()),
                      );
                    },
                    child: CircleAvatar(
                      radius: screenSize.width * 0.1,
                      backgroundImage: const AssetImage("images/dr.PNG"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.13),
                  Text(
                    S.of(context).Generated_Reports,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Expanded(
                    child: FutureBuilder<List<ReportModel>>(
                      future: fetchReports(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No reports found.'));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              ReportModel report = snapshot.data![index];
                              return Padding(
                                padding: EdgeInsets.all(screenSize.width * 0.01),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(screenSize.width * 0.05),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white70.withOpacity(0.8),
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(screenSize.width * 0.02),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(16),
                                      subtitle: Text(
                                        report.reportContent,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      trailing: RawMaterialButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Report(reportContent: report.reportContent,)),
                                          );
                                        },
                                        elevation: 2.0,
                                        fillColor: const Color(0xFF7C77D1),
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width * 0.04),
                                        shape: const CircleBorder(),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: MediaQuery.of(context).size.width * 0.065,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
