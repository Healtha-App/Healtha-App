import 'package:flutter/material.dart';
import 'package:healtha/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../lab_doctor/lab_doctor.dart';
class Disease {
  final String id;
  final String name;
  final List<Section> sections;

  Disease({required this.id, required this.name, required this.sections});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['_id'],
      name: json['name'],
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

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
  late Future<List<LabTest>> labTestsFuture;
  late Future<List<Disease>> diseasesFuture;

  @override
  void initState() {
    super.initState();

    labTestsFuture = fetchLabTests();
    diseasesFuture = fetchDiseases();
  }

  Future<List<LabTest>> fetchLabTests() async {
    try {
      String labTestEnd =
          'http://192.168.56.1:4000/api/healtha/lab-tests';
      final response = await http.get(Uri.parse(labTestEnd));
      print('Lab Tests Response status: ${response.statusCode}');
      print('Lab Tests Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((labTest) => LabTest.fromJson(labTest)).toList();
      } else {
        throw Exception('Failed to load lab tests');
      }
    } catch (e) {
      print('Error fetching lab tests: $e');
      throw e;
    }
  }
  Future<List<Disease>> fetchDiseases() async {
    try {
      String diseaseEnd = 'http://192.168.56.1:4000/api/healtha/disease';
      final response = await http.get(Uri.parse(diseaseEnd));
      print('Diseases Response status: ${response.statusCode}');
      print('Diseases Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((disease) => Disease.fromJson(disease)).toList();
      } else {
        throw Exception('Failed to load diseases');
      }
    } catch (e) {
      print('Error fetching diseases: $e');
      throw e;
    }
  }

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
                      Color(0xff7c77d1).withOpacity(0.5),
                      Color(0xff7c77d1).withOpacity(0.7),
                      Color(0xff7c77d1).withOpacity(0.9),
                      Color(0xff7c77d1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
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
            child: FutureBuilder<List<LabTest>>(
              future: labTestsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(MyApp.myPurple),),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load data'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          leading: Image.asset(
                            widget.image,
                            width: 35,
                            height: 35,
                          ),
                          title: Text(
                            snapshot.data![index].name ?? '',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: RawMaterialButton(
                            onPressed: () {
                              if (widget.category == 'Lab Tests') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LabTestDetailsPage(
                                      labTest: snapshot.data![index],
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LabTestDetailsPage(
                                      labTest: snapshot.data![index],
                                    ),
                                  ),
                                );
                              }
                            },
                            elevation: 2.0,
                            fillColor: Color(0xFF7C77D1),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 17.0,
                            ),
                            padding: EdgeInsets.all(12.0),
                            shape: CircleBorder(),
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
    );
  }
}

class LabTestDetailsPage extends StatelessWidget {
  final LabTest labTest;

  LabTestDetailsPage({required this.labTest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                //0.08
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // color: Color(0xff7c77d1),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff7c77d1).withOpacity(0.5),
                      Color(0xff7c77d1).withOpacity(0.7),
                      Color(0xff7c77d1).withOpacity(0.9),
                      Color(0xff7c77d1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Text(
                      'Lab Test Details:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7c77d1),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Name: ${labTest.name}',
                      style: TextStyle(fontSize: 16),
                    ),
                    // Display sections
                    if (labTest.sections.isNotEmpty) ...[
                      SizedBox(height: 16),
                      Text(
                        'Sections:',
                        style: TextStyle(
                          fontSize: 20,
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
                              '${section.title}',
                              style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${section.content}',
                              style: TextStyle(fontSize: 14),
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
class DiseaseDetailsPage extends StatelessWidget {
  final Disease disease;

  DiseaseDetailsPage({required this.disease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                //0.08
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // color: Color(0xff7c77d1),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff7c77d1).withOpacity(0.5),
                      Color(0xff7c77d1).withOpacity(0.7),
                      Color(0xff7c77d1).withOpacity(0.9),
                      Color(0xff7c77d1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
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
                      "${disease.name}",
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Text(
                      'Lab Test Details:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7c77d1),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Name: ${disease.name}',
                      style: TextStyle(fontSize: 16),
                    ),
                    // Display sections
                    if (disease.sections.isNotEmpty) ...[
                      SizedBox(height: 16),
                      Text(
                        'Sections:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7c77d1),
                        ),
                      ),
                      for (Section section in disease.sections)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              '${section.title}',
                              style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${section.content}',
                              style: TextStyle(fontSize: 14),
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
