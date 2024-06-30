import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/variables.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:healtha/screens/doctor/report_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/screens/doctor/doc-profile.dart';

import '../lab_analysis/report.dart';

String _formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  List<dynamic> _reports = [];
  final List<dynamic> _todayReports = [];
  final List<dynamic> _thisWeekReports = [];
  final List<dynamic> _laterReports = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
    //  _setupFirebaseMessaging();
  }

  Future<void> _fetchReports() async {
    try {
      final response = await http.get(Uri.parse(
          'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/reports?confirmed=true'));
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
              color: Theme.of(context).colorScheme.surface,

            ),

            // Content
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: screenSize.height * 0.051), // Adjust as needed
                    Text(
                      S.of(context).Notification_Center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,

                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    if (_todayReports.isNotEmpty) ...[
                      Text(
                        S.of(context).Today,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      _buildReportList(_todayReports),
                      SizedBox(
                        height: screenSize.width * 0.03,
                      ),
                    ],
                    if (_thisWeekReports.isNotEmpty) ...[
                      Text(
                        S.of(context).This_Week,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      _buildReportList(_thisWeekReports),
                    ],
                    if (_laterReports.isNotEmpty) ...[
                      SizedBox(
                        height: screenSize.width * 0.03,
                      ),
                      Text(
                        S.of(context).Later_Reports,
                        style:  TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
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
      physics: const NeverScrollableScrollPhysics(),
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
            child: const Padding(
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
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.all(Radius.circular(
                    screenSize.width * 0.02)), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: AppConfig.myPurple.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    screenSize.width * 0.0081), // Reduced internal padding
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8), // Reduced padding
                  title: Text(
                    S.of(context).Your_CBC_Test_Report_is_ready,
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,

                    ),
                  ),
                  subtitle: Text(
                    S.of(context).Uploaded_on(_formatDate(report['uploadTime'],
                    ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  trailing: Padding(
                    padding:
                    const EdgeInsets.only(right: 12.0), // Added padding
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Report(reportContent: '',),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                        const Color(0xFF7C77D1), // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18.0), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0), // Button padding
                      ),
                      child: Text(
                        S.of(context).view,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
