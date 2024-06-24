import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/screens/doctor/doc-profile.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AllDoctors extends StatefulWidget {
  const AllDoctors({Key? key}) : super(key: key);

  @override
  _AllDoctorsState createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  List<Doctor> allDoctors = [];
  List<Doctor> filteredDoctors = [];
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _spokenText = "";

  @override
  void initState() {
    super.initState();
    fetchDoctors().then((doctors) {
      setState(() {
        allDoctors = doctors;
        filteredDoctors = doctors;
      });
    });
    _searchController.addListener(_onSearchChanged);
    initSpeechRecognizer();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void initSpeechRecognizer() async {
    bool available = await _speechToText.initialize(
      onError: (error) => print('Error: $error'),
      onStatus: (status) => print('Status: $status'),
    );
    if (available) {
      setState(() {});
    } else {
      print('Speech recognition not available');
    }
  }

  void startListening() async {
    if (!_isListening) {
      bool listening = await _speechToText.listen(
        onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords.trim();
            _searchController.text = _spokenText; // Set recognized text to search
          });
          updateSearchQuery(_spokenText);
        },
      ) ?? false;
      if (listening) {
        setState(() {
          _isListening = true;
        });
      }
    }
  }

  void stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  Future<List<Doctor>> fetchDoctors() async {
    final response = await http.get(
      Uri.parse('http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/doctors'),
    );

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
        // Check if doctor's name or location contains the search query
        return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
            doctor.location.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onSearchChanged() {
    updateSearchQuery(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Discover_All_Doctors,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white), // Change text color to white
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (!_isListening) {
                      startListening();
                    } else {
                      stopListening();
                    }
                  },
                ),
                hintText: S.of(context).Search_by_name_location_or_specialty,
                hintStyle: TextStyle(color: Colors.white70), // Set hint color to light gray
                filled: true,
                fillColor: Colors.grey[800], // Set background color of TextField
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
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
  final String location;

  Doctor({
    required this.name,
    required this.location,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      location: json['location'],
    );
  }
}

class DoctorCard extends StatefulWidget {
  final Doctor doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
              const CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("images/dr.PNG"),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctor.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.doctor.location,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited
                      ? const Color(0xff7c77d1)
                      : const Color(0xff7c77d1),
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
