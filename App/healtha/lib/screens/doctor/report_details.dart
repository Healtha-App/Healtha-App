import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:healtha/localization/generated/l10n.dart';

class ReportDetails extends StatefulWidget {
  final String reportId;
  final Function(bool) onConfirm;

  const ReportDetails({Key? key, required this.reportId, required this.onConfirm})
      : super(key: key);

  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  String _reportContent = '';
  String _prompt = '';
  bool _isLoading = true;
  final TextEditingController _textEditingController = TextEditingController();
  bool _isEditing = false;
  static const String _apiKey = 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9';

  @override
  void initState() {
    super.initState();
    _fetchReportContent();
    _fetchPromptAndTestValues();
  }

  Future<void> _fetchPromptAndTestValues() async {
    try {
      final response = await http.post(
        Uri.parse('https://api.chatpdf.com/v1/chats/message'),
        headers: {
          'x-api-key': _apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'sourceId': 'src_zGaagrXZbLcNV3hDaVUyR',
          'messages': [
            {
              'role': 'user',
              'content': 'extract and write only the extracted test values from the pdf',
            }
          ],
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _prompt = jsonData['content']; // Adjusted according to the expected key in response
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch prompt');
      }
    } catch (error) {
      print('Error fetching prompt: $error');
    }
  }

  Future<void> _fetchReportContent() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/reports?id=${widget.reportId}'),
      );
      if (response.statusCode == 200) {
        setState(() {
          _reportContent = json.decode(response.body)['reportContent'];
          _isLoading = false;
          _textEditingController.text = _reportContent;
        });
      } else {
        throw Exception('Failed to fetch report content');
      }
    } catch (error) {
      print('Error fetching report content: $error');
    }
  }

  Future<void> _updateReport() async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/reports/${widget.reportId}'),
        body: {'reportContent': _textEditingController.text},
      );
      if (response.statusCode == 200) {
        setState(() {
          _reportContent = _textEditingController.text;
          _isEditing = false; // Exit editing mode after saving
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).Report_updated_successfully),
          ),
        );
      } else {
        throw Exception('Failed to update report');
      }
    } catch (error) {
      print('Error updating report: $error');
    }
  }

  Future<void> _confirmReport() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/reports/${widget.reportId}/confirm'),
      );
      if (response.statusCode == 200) {
        // Update UI or take necessary actions upon successful confirmation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).Report_confirmed_and_notification_sent),
          ),
        );
        widget.onConfirm(true);
      } else {
        throw Exception(S.of(context).Failed_to_confirm_report);
      }
    } catch (error) {
      print('Error confirming report: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).Failed_to_confirm_report),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            // Main Content
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface.withOpacity(0.7),

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: _isLoading
                          ? Center(
                        child: CircularProgressIndicator(),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Healtha Report',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff7c77d1),
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dear Doctor,\n'
                                            '\n'
                                            'This is the extracted test values from a patient\'s'
                                            ' report, along with the generated report for your review.'
                                            '',
                                        style: TextStyle(fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                      ),
                                      Divider(),
                                      Text('-- Test values',style: TextStyle(fontSize: 14,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                      ),
                                      if (_prompt != null && _prompt.isNotEmpty)
                                        Text(_prompt,style: const TextStyle(fontSize: 14),),
                                      Divider(),
                                      _isEditing
                                          ? TextField(
                                        controller: _textEditingController,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: S.of(context).Enter_report_text,
                                        ),
                                      )
                                          : Text(
                                        '-- Generated Reports\n'
                                            '$_reportContent',
                                        style: TextStyle(fontSize: 14,
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isEditing) {
                              _updateReport();
                            } else {
                              _toggleEdit();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C77D1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            _isEditing ? 'Save' : 'Edit',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_isEditing) {
                              _confirmReport();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(S.of(context).Report_confirmed_successfully),
                                ),
                              );
                              widget.onConfirm(true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C77D1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            S.of(context).Confirm,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing; // Toggle editing mode
    });
  }
}
