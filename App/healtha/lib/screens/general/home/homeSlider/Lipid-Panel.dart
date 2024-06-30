import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:http/http.dart' as http;

class LabTest {
  final String name;
  final List<Section> sections;

  LabTest({required this.name, required this.sections});
}

class Section {
  final String title;
  final String content;

  Section({required this.title, required this.content});
}

class LipidPanel extends StatelessWidget {
  const LipidPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchLabTest(),
        builder: (context, AsyncSnapshot<LabTest> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(S.of(context).Error(snapshot.error!)));
          } else {
            LabTest? labTest = snapshot.data;
            if (labTest == null) {
              return Center(child: Text(S.of(context).No_lab_test_found));
            }
            return LabTestDetailsPage(labTest: labTest);
          }
        },
      ),
    );
  }

  Future<LabTest> fetchLabTest() async {
    final response = await http.get(Uri.parse(
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/lab-tests'));
    if (response.statusCode == 200) {
      List<dynamic> labTests = jsonDecode(response.body);
      if (labTests.isNotEmpty && labTests.length >= 3) {
        // Check if there are at least 3 lab tests
        Map<String, dynamic> fifthLabTest =
        labTests[2]; // Accessing the third lab test using index 2
        String name = fifthLabTest['name'];
        List<dynamic> sections = fifthLabTest['sections'];
        List<Section> parsedSections = sections.map((section) {
          return Section(
            title: section['title'],
            content: section['content'],
          );
        }).toList();
        return LabTest(name: name, sections: parsedSections);
      } else {
        throw Exception('Not enough lab tests found');
      }
    } else {
      throw Exception('Failed to load lab tests');
    }
  }
}

class LabTestDetailsPage extends StatelessWidget {
  final LabTest labTest;

  const LabTestDetailsPage({super.key, required this.labTest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff7c77d1).withOpacity(0.5),
                      const Color(0xff7c77d1).withOpacity(0.7),
                      const Color(0xff7c77d1).withOpacity(0.9),
                      const Color(0xff7c77d1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff7c77d1),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      labTest.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7c77d1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).Lab_Test_Details,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7c77d1),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).Name(labTest.name),
                      style: TextStyle(fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    // Display sections
                    if (labTest.sections.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        S.of(context).Sections,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7c77d1),
                        ),
                      ),
                      for (Section section in labTest.sections)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              section.title,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              section.content,
                              style:  TextStyle(fontSize: 14,
                                color: Theme.of(context).colorScheme.onPrimary,

                              ),
                            ),
                          ],
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
