import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healtha/doctor_ui/doc-profile.dart';
import 'package:url_launcher/url_launcher.dart';

class AllDoctors extends StatefulWidget {
  @override
  _AllDoctorsState createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  List<Doctor> allDoctors = [];
  List<Doctor> filteredDoctors = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchDoctors().then((doctors) {
      setState(() {
        allDoctors = doctors;
        filteredDoctors = doctors;
      });
    });
  }

  Future<List<Doctor>> fetchDoctors() async {
    final response = await http.get(Uri.parse('http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/doctors'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Doctor.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredDoctors = allDoctors.where((doctor) {
        return doctor.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0EEFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF0EEFA),
        title: Text('Discover All Doctors',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                updateSearchQuery(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by name, location or specialty',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                return DoctorCard(doctor: filteredDoctors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Doctor {
  final String name;
  final double rating;

  Doctor({
    required this.name,
    required this.rating,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      rating: 4.5,
    );
  }
}

class DoctorCard extends StatefulWidget {
  final Doctor doctor;

  DoctorCard({required this.doctor});

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: InkWell(
        onTap: () {
          // Navigate to doctor profile
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => drProfile()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("images/dr.PNG"),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctor.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orangeAccent, size: 16.0),
                        Text(widget.doctor.rating.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited ? Color(0xff7c77d1) : Color(0xff7c77d1),
                  size: 18.0,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorited = !_isFavorited;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String location) async {
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$location');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
