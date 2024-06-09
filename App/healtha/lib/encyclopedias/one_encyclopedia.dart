import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<LabTest> allLabTests = [];
  List<Disease> allDiseases = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labTestsFuture = fetchLabTests();
    diseasesFuture = fetchDiseases();
  }

  Future<List<LabTest>> fetchLabTests() async {
    final response = await http.get(Uri.parse('http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/lab-tests'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((labTest) => LabTest.fromJson(labTest)).toList();
    } else {
      throw Exception('Failed to load lab tests');
    }
  }

  Future<List<Disease>> fetchDiseases() async {
    final response = await http.get(Uri.parse('http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/disease'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((disease) => Disease.fromJson(disease)).toList();
    } else {
      throw Exception('Failed to load diseases');
    }
  }

  List<LabTest> searchLabTests(String query) {
    return allLabTests.where((labTest) {
      return labTest.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<Disease> searchDiseases(String query) {
    return allDiseases.where((disease) {
      return disease.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {});
            },

            decoration: InputDecoration(
              hintText: '   Search...',
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
      
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<LabTest>>(
              future: labTestsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load lab tests'),
                  );
                } else {
                  allLabTests = snapshot.data!;
                  if (searchController.text.isNotEmpty) {
                    return _buildLabTestsListView(searchLabTests(searchController.text));
                  } else {
                    return _buildLabTestsListView(allLabTests);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLabTestsListView(List<LabTest> labTests) {
    return ListView.builder(
      itemCount: labTests.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
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
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              // Navigate to lab test details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LabTestDetailsPage(labTest: labTests[index]),
                ),
              );
            },
          ),
        );
      },
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
          title: Text('Lab Test Details'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(
        'Name: ${labTest.name}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        if (labTest.sections.isNotEmpty)
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
      'Sections:',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    for (var section in labTest.sections)
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(height: 5),
    Text(
      section.title,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
      Text(
        section.content,
        style: TextStyle(fontSize: 14),
      ),
    ],
    ),
      ],
    ),
          ],
        ),
        ),
            ],
        ),
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
      sections: (json['sections'] as List).map((section) => Section.fromJson(section)).toList(),
    );
  }
}

class Disease {
  final String id;
  final String name;
  final List<Section> sections;

  Disease({required this.id, required this.name, required this.sections});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['_id'],
      name: json['name'],
      sections: (json['sections'] as List).map((section) => Section.fromJson(section)).toList(),
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
