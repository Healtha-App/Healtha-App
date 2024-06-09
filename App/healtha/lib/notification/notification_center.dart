import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../doctor_ui/report_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/doctor_ui/doc-profile.dart';

String _formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

class NotificationCenter extends StatefulWidget {
  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  List<dynamic> _reports = [];
  List<dynamic> _todayReports = [];
  List<dynamic> _thisWeekReports = [];
  List<dynamic> _laterReports = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
  //  _setupFirebaseMessaging();
  }

  Future<void> _fetchReports() async {
    try {
      final response = await http.get(Uri.parse(
          'http://ec2-18-221-98-187.us-east-2.compute.amazonaws.com:4000/api/healtha/reports?confirmed=false'));
      if (response.statusCode == 200) {
        List<dynamic> reports = json.decode(response.body);
        setState(() {
          _reports = reports;
          _categorizeReports();
        });
      } else {
        throw Exception('Failed to fetch reports');
      }
    } catch (error) {
      print('Error fetching reports: $error');
    }
  }

  void _categorizeReports() {
    DateTime now = DateTime.now();
    _todayReports.clear();
    _thisWeekReports.clear();
    _laterReports.clear();

    for (var report in _reports) {
      DateTime reportDate = DateTime.parse(report['uploadTime']);
      if (DateFormat('yyyy-MM-dd').format(reportDate) ==
          DateFormat('yyyy-MM-dd').format(now)) {
        _todayReports.add(report);
      } else if (reportDate
          .isAfter(now.subtract(Duration(days: now.weekday))) &&
          reportDate.isBefore(now.add(Duration(days: 7 - now.weekday)))) {
        _thisWeekReports.add(report);
      } else {
        _laterReports.add(report);
      }
    }

    _todayReports.sort((a, b) => DateTime.parse(a['uploadTime'])
        .compareTo(DateTime.parse(b['uploadTime'])));
    _thisWeekReports.sort((a, b) => DateTime.parse(a['uploadTime'])
        .compareTo(DateTime.parse(b['uploadTime'])));
    _laterReports.sort((a, b) => DateTime.parse(a['uploadTime'])
        .compareTo(DateTime.parse(b['uploadTime'])));
  }
  //
  // void _setupFirebaseMessaging() {
  //   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');
  //
  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //
  //     // Handle your logic here, for example:
  //     _fetchReports();
  //   });
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('Message clicked!');
  //   });
  // }

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
                    Color(0xFFE0E7EA), // Light blue
                    Color(0xff7c77d1).withOpacity(0.2), // Light grey
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
                  color: Color(0xFF7C77D1), // Purple
                  borderRadius: BorderRadius.circular(screenSize.width * 0.3),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * 0.3,
              left: -screenSize.width * 0.07,
              child: Container(
                width: screenSize.width * 0.4,
                height: screenSize.width * 0.4,
                decoration: BoxDecoration(
                  color: Color(0xFF7C77D1), // Purple
                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                ),
              ),
            ),
            // Small circle at the bottom right
            Positioned(
              bottom: screenSize.height * 0.15,
              right: screenSize.width * 0.15,
              child: Container(
                width: screenSize.width * 0.2,
                height: screenSize.width * 0.2,
                decoration: BoxDecoration(
                  color: Color(0xFF7C77D1), // Purple
                  borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                ),
              ),
            ),
            // Content
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: screenSize.height * 0.1), // Adjust as needed
                    Text(
                      'Notification Center',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    if (_todayReports.isNotEmpty) ...[
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      _buildReportList(_todayReports),
                      SizedBox(
                        height: screenSize.width * 0.03,
                      ),
                    ],
                    if (_thisWeekReports.isNotEmpty) ...[
                      Text(
                        'This Week',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      _buildReportList(_thisWeekReports),
                    ],
                    if (_laterReports.isNotEmpty) ...[
                      SizedBox(
                        height: screenSize.width * 0.03,
                      ),
                      Text(
                        'Later Reports',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      _buildReportList(_laterReports),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportList(List<dynamic> reports) {
    final Size screenSize = MediaQuery.of(context).size;

    // Static time indicators
    final List<String> timeIndicatorsToday = ["23m", "1h", "2h", "5h"];
    final List<String> timeIndicatorsThisWeek = ["1d", "2d", "5d", "6d", "7d"];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];

        // Calculating time difference
        DateTime now = DateTime.now();
        DateTime reportDate = DateTime.parse(report['uploadTime']);
        Duration difference = now.difference(reportDate);

        // Conditionally determining time indicator
        String timeIndicator = '';
        if (difference.inDays == 0 &&
            difference.inHours == 0 &&
            difference.inMinutes <= 59) {
          timeIndicator = '${difference.inMinutes}m';
        } else if (difference.inDays == 0 && difference.inHours <= 24) {
          timeIndicator = '${difference.inHours}h';
        } else if (difference.inDays <= 7) {
          timeIndicator = '${difference.inDays}d';
        }

        return Dismissible(
          key: Key(report['reportid'].toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: Icon(
                Icons.delete,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              reports.removeAt(index);
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenSize.width * 0.01, horizontal: 0),
            // Reduced padding
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(
                    screenSize.width * 0.02)), // Reduced border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.white70.withOpacity(1),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    screenSize.width * 0.0081), // Reduced padding
                child: ListTile(
                  contentPadding: EdgeInsets.all(8), // Reduced padding
                  title: Text(
                    "Your CBC Test Report is ready",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C77D1),
                    ),
                  ),
                  subtitle: Text(
                    "Uploaded on ${_formatDate(report['uploadTime'])}",
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 12.0), // Added padding
                    child: Text(
                      timeIndicator,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReportDetails(reportId: report['reportid'].toString(), onConfirm: (bool confirmed) { /* Handle confirmation logic here */ },)),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
