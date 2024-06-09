import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healtha/doctor_ui/doc-profile.dart';

class AllDoctors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0EEFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF0EEFA),
        title: Text('Discover All Doctors'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return DoctorCard(doctor: doctors[index]);
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
  final String location;
  final String specialty;
  final double rating;
  final String assetImagePath;

  Doctor({
    required this.name,
    required this.location,
    required this.specialty,
    required this.rating,
    required this.assetImagePath,
  });
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
                backgroundImage: AssetImage(widget.doctor.assetImagePath),
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
                    Text(widget.doctor.specialty),
                    Row(
                      children: [
                        Text(widget.doctor.location),
                        IconButton(
                          icon: Icon(Icons.share_location_outlined, color: Colors.redAccent, size: 18.0),
                          onPressed: () {},
                        ),
                      ],
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
                  color: _isFavorited ? Color(0xff7c77d1) : Colors.white,
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
}

// Sample list of doctors
List<Doctor> doctors = [
  Doctor(
    name: 'Dr.Eman Magdy',
    location: 'El-Sadat City',
    specialty: 'Cardiologist',
    rating: 4.5,
    assetImagePath: 'assets/doctor1.png',
  ),
  Doctor(
    name: 'Dr.Hossam Mohammed',
    location: 'Shibin El-Koum',
    specialty: 'Dermatologist',
    rating: 4.8,
    assetImagePath: 'assets/doctor4.png',
  ),
  Doctor(
    name: 'Dr.Rahma Khaled',
    location: 'El-Sadat City',
    specialty: 'Cardiologist',
    rating: 4.5,
    assetImagePath: 'assets/doctor3.jpg',
  ),
  Doctor(
    name: 'Dr.Mohammed Ali',
    location: 'Cairo, Egypt',
    specialty: 'Dermatologist',
    rating: 4.8,
    assetImagePath: 'assets/doctor2.jpg',
  ),
  Doctor(
    name: 'Dr.Sara Samir',
    location: 'El-Sadat City',
    specialty: 'Cardiologist',
    rating: 4.5,
    assetImagePath: 'assets/doctor5.jpg',
  ),
  Doctor(
    name: 'Dr.Ahmed Nour',
    location: 'Shibin El-Koum',
    specialty: 'Dermatologist',
    rating: 4.8,
    assetImagePath: 'assets/doctor10.png',
  ),
  Doctor(
    name: 'Dr.Aya Elmallah',
    location: 'Cairo, Egypt',
    specialty: 'Cardiologist',
    rating: 4.5,
    assetImagePath: 'assets/doctor7.png',
  ),
  Doctor(
    name: 'Dr.Jane Smith',
    location: 'El-Sadat City',
    specialty: 'Dermatologist',
    rating: 4.8,
    assetImagePath: 'assets/doctor8.jpeg',
  ),
  // Add more doctors here
];
