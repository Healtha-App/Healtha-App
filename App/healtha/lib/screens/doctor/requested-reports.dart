import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Import this package for date formatting
import 'report_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/screens/doctor/doc-profile.dart';
import 'package:healtha/localization/generated/l10n.dart';

class RequestedReports extends StatefulWidget {
  const RequestedReports({super.key});

  @override
  _RequestedReportsState createState() => _RequestedReportsState();
}

class _RequestedReportsState extends State<RequestedReports> {
  List<dynamic> _reports = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    try {
      final response = await http.get(Uri.parse(
          'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/reports?confirmed=false'));
      if (response.statusCode == 200) {
        List<dynamic> fetchedReports = json.decode(response.body);

        // Sort reports by uploadTime in descending order
        fetchedReports.sort((a, b) {
          // Assuming uploadTime is a string in ISO 8601 format
          DateTime timeA = DateTime.parse(a['uploadTime']);
          DateTime timeB = DateTime.parse(b['uploadTime']);
          return timeB.compareTo(timeA); // Sort in descending order
        });

        setState(() {
          _reports = fetchedReports;
        });
      } else {
        throw Exception('Failed to fetch reports');
      }
    } catch (error) {
      print('Error fetching reports: $error');
    }
  }

  String formatUploadTime(String uploadTime) {
    // Parse the uploadTime string into DateTime object
    DateTime uploadDateTime = DateTime.parse(uploadTime);

    // Calculate time difference
    Duration difference = DateTime.now().difference(uploadDateTime);

    if (difference.inDays > 0) {
      return 'Requested ${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return 'Requested ${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return 'Requested ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
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
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2), // Light blue
                    const Color(0xff7c77d1).withOpacity(0.2), // Light grey
                  ],
                ),
              ),
            ),
            // Abstract Shapes
            Positioned(
              top: -screenSize.width * 0.25,
              right: -screenSize.width * 0.25,
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
              padding: EdgeInsets.all(screenSize.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => drProfile(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: screenSize.width * 0.1,
                          backgroundImage: const AssetImage("images/dr.PNG"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02), // Adjust as needed
                  Text(
                    S.of(context).Requested_Reports, // Your healthcare app name
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _reports.length,
                      itemBuilder: (context, index) {
                        final report = _reports[index];
                        final testName = report['testName'] ?? 'Unknown Test'; // Get the test name from the report data
                        final uploadTime = report['uploadTime'] ?? ''; // Assuming uploadTime is in ISO 8601 format
                        final formattedTime = formatUploadTime(uploadTime);
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.01),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenSize.width * 0.05),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withOpacity(0.7)
                                      .withOpacity(0.8),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.02),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Text(
                                  testName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7C77D1),
                                  ),
                                ),
                                subtitle: Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                trailing: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReportDetails(
                                          reportId: report['reportid'].toString(),
                                          onConfirm: (bool confirmed) {
                                            /* Handle confirmation logic here */
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  elevation: 2.0,
                                  fillColor: const Color(0xFF7C77D1),
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0), // Adjust the radius as needed
                                  ),
                                  child: Text(
                                    'View',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
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