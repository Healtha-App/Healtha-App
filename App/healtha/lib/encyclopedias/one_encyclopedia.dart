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
  List<LabTest> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labTestsFuture = fetchLabTests();
    diseasesFuture = fetchDiseases();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
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

  void _onSearchChanged() {
    searchResults(_searchController.text);
  }

  void searchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    labTestsFuture.then((labTests) {
      setState(() {
        _searchResults = labTests
            .where((labTest) =>
            labTest.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
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
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Color(0xff7c77d1)),
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xff7c77d1), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xff7c77d1), width: 1.5),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<LabTest>>(
              future: labTestsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xff7c77d1)),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load data'),
                  );
                } else {
                  List<LabTest> displayList =
                  _searchController.text.isEmpty ? snapshot.data! : _searchResults;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: displayList.length,
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
                            displayList[index].name ?? '',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: RawMaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LabTestDetailsPage(
                                    labTest: displayList[index],
                                  ),
                                ),
                              );
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
          ],
        ),
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
    ],  ),
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
            SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: labTest.sections.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            labTest.sections[index].title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7c77d1),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            labTest.sections[index].content,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
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

class LabTest {
  final String id;
  final String name;
  final List<Section> sections;

  LabTest({
    required this.id,
    required this.name,
    required this.sections,
  });

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

  Section({
    required this.title,
    required this.content,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'],
      content: json['content'],
    );
  }
}

class Disease {
  final String id;
  final String name;
  final String description;
  final String cause;
  final String symptoms;
  final String treatment;

  Disease({
    required this.id,
    required this.name,
    required this.description,
    required this.cause,
    required this.symptoms,
    required this.treatment,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      cause: json['cause'],
      symptoms: json['symptoms'],
      treatment: json['treatment'],
    );
  }
}


