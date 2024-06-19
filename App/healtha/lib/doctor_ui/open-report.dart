import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:healtha/generated/l10n.dart';

class OpenReport extends StatefulWidget {
  final Function(bool) onConfirm;

  const OpenReport({Key? key, required this.onConfirm}) : super(key: key);

  @override
  _OpenReportState createState() => _OpenReportState();
}

class _OpenReportState extends State<OpenReport> {
  String _translatedReport = '';
  bool _isTranslating = false;
  final TextEditingController _textEditingController = TextEditingController();
  bool _isEditing = false;
  static const String _apiKey = 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9';
  static const String _backendUrl =
      'http://your_backend_url/healtha/reports'; // Change to your actual backend URL
  int reportId = 1; // Example report ID, replace with actual ID

  Future<void> _translateReport() async {
    setState(() {
      _isTranslating = true;
    });

    String promptWithLanguage =
        'Write a user-friendly lab analysis report about this lab test in this formats '
        'in points and each point list of items, in this report write'
        "start with Dear (patient name from the report), We hope this report finds you in good health. "
        "We have conducted a comprehensive analysis to assess your health. "
        "1. Test name and definition 2. Interpretations about each important value result"
        "3. Medical advices and tips for managing these values to take care of their health"
        "write all under 250 words"
        'after the final warm regards write (Healtha team)'
        'write the whole report';

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
            'content': promptWithLanguage,
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _translatedReport = json.decode(response.body)['content'];
        _isTranslating = false;
        _textEditingController.text = _translatedReport;
      });
    } else {
      throw Exception('Failed to translate report');
    }
  }

  Future<void> _updateReport() async {
    try {
      final response = await http.put(
        Uri.parse('$_backendUrl/$reportId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'reportContent': _textEditingController.text}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _translatedReport = _textEditingController.text;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).Report_updated_successfully)),
        );
      } else {
        throw Exception('Failed to update report');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).Error_updating_report(error))),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _translateReport();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFE0E7EA),
                    const Color(0xff7c77d1).withOpacity(0.2),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -screenSize.width * 0.3,
              right: -screenSize.width * 0.1,
              child: Container(
                width: screenSize.width * 0.6,
                height: screenSize.width * 0.6,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C77D1),
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
                  color: const Color(0xFF7C77D1),
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
                  color: const Color(0xFF7C77D1),
                  borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                  width: double.infinity,
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: screenSize.height * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white70.withOpacity(0.6),
                          blurRadius: 1,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: _isTranslating
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    S.of(context).Healtha_Report,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff7c77d1),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  constraints: BoxConstraints(
                                    maxHeight: screenSize.height * 0.5,
                                  ),
                                  child: _isEditing
                                      ? SizedBox(
                                          height: screenSize.height * 0.5,
                                          child: TextField(
                                            controller: _textEditingController,
                                            decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: S
                                                  .of(context)
                                                  .Enter_report_text,
                                            ),
                                            maxLines: null,
                                            expands: true,
                                          ),
                                        )
                                      : Text(
                                          _translatedReport ?? '',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_isEditing) {
                              await _updateReport(); // Save changes to the database
                            }
                            _toggleEdit();
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
                                fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_isTranslating) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(S
                                      .of(context)
                                      .Report_confirmed_successfully),
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
                                fontSize: 20),
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
      if (_isEditing) {
        _translatedReport = _textEditingController.text;
      }
      _isEditing = !_isEditing;
    });
  }
}
