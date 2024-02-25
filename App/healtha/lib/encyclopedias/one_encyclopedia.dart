import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LabTest {
  final String id;
  final String name;
  final List<Section> sections;

  LabTest({required this.id, required this.name, required this.sections});

  factory LabTest.fromJson(Map<String, dynamic> json) {
    return LabTest(
      id: json['_id'],
      name: json['name'],
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class Section {
  final String title;
  final String content;

  Section({required this.title, required this.content});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'],
      content: json['content'],
    );
  }
}

class EncyclopediaPage extends StatefulWidget {
  final String category;
  final String image;

  EncyclopediaPage(this.category, this.image);

  @override
  _EncyclopediaPageState createState() => _EncyclopediaPageState();
}

class _EncyclopediaPageState extends State<EncyclopediaPage> {
  List<LabTest> labTests = [];

  @override
  void initState() {
    super.initState();
    fetchLabTests();
  }

  Future<void> fetchLabTests() async {
    try {
      String healthaIP='http://ec2-18-220-246-59.us-east-2.compute.amazonaws.com:4000/api/healtha/lab-tests';
      final response =
      await http.get(Uri.parse(healthaIP));
      print('Lab Tests Response status: ${response.statusCode}');
      print('Lab Tests Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          labTests = jsonList.map((labTest) => LabTest.fromJson(labTest)).toList();
        });
      } else {
        throw Exception('Failed to load lab tests');
      }
    } catch (e) {
      print('Error fetching lab tests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7c77d1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xff7c77d1),
                  borderRadius: BorderRadius.only(
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
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
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
                      "${widget.category} Encyclopedia",
                      style: TextStyle(
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
          SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              itemCount: labTests.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    leading: Image.asset(
                      widget.image,
                      width: 35,
                      height: 35,
                    ),
                    title: Text(
                      labTests[index].name ?? '',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LabTestDetailsPage(
                              labTest: labTests[index],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          color: Color(0xff7c77d1),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
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
    );
  }
}

class LabTestDetailsPage extends StatelessWidget {
  final LabTest labTest;

  LabTestDetailsPage({required this.labTest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7c77d1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xff7c77d1),
                  borderRadius: BorderRadius.only(
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
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
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
                      "${labTest.name}",
                      style: TextStyle(
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
          SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lab Test Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff7c77d1),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Name: ${labTest.name}',
                    style: TextStyle(fontSize: 14),
                  ),
                  // Display sections
                  if (labTest.sections.isNotEmpty) ...[
                    SizedBox(height: 16),
                    Text(
                      'Sections:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7c77d1),
                      ),
                    ),
                    for (Section section in labTest.sections)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'Title: ${section.title}',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Content: ${section.content}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}