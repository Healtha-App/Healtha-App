import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:healtha/home/Lipid-Panel.dart';
import 'package:healtha/home/title_item.dart';
import 'package:healtha/register_login/log_in.dart';
import 'package:healtha/register_login/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:healtha/main.dart';
import '../chatbot/chat_screen.dart';
import '../doctor_ui/doc-profile.dart';
import '../encyclopedias/encyclopedia_types.dart';
import '../lab_analysis/upload_analysis.dart';
import '../navigation.dart';
import '../prediction/disease_prediction.dart';
import '../profile/home.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ACE.dart';
import 'Calcium.dart';
import 'Liver-function.dart';
import 'Pregnancy.dart';
import 'Thyroid -function.dart';
import 'Urinalysis.dart';
import 'cbc.dart';

List LabTestsAssets = [
  'images/poster1.jpg',
  'images/poster2.jpg',
  'images/poster3.jpg',
  'images/poster4.jpg',
  'images/poster5.jpg',
  'images/poster6.jpg',
  'images/poster7.jpg',
  'images/poster8.jpg',
];

List LabTestsDiscription = [
  "CBC, Complete Blood Count \nMeasures your red blood cells, white blood cells, and platelets.",
  "Urinalysis \nAnalyzes all of the properties of your urine.",
  "Lipid Panel \n blood test that measures various types of cholesterol and triglycerides in the bloodstream.",
  "ACE, Angiotensin-Converting Enzyme \nan enzyme primarily found in the lungs and blood vessels",
  "Liver function \nMeasure the levels of enzymes and other substances produced by the liver",
  "Thyroid function\nMeasure the levels of thyroid hormones in the blood.",
  "Calcium \nImportant for building and maintaining strong bones and teeth.",
  "Pregnancy \nA state in which a woman has a developing fetus inside her uterus.",
];

final iconBot = Image.asset(
  'images/bot1.png',
  color: Color(0xff7c77d1), // Set desired icon color
  width: 60.0, // Adjust icon width
  height: 60.0, // Adjust icon height
);

List<String> doctorImages = [
  'images/doctor1.jpg',
  'images/doctor2.jpg',
  'images/doctor3.jpg',
  'images/doctor4.jpg',
  'images/doctor5.jpg',
  'images/doctor6.jpg',
  'images/doctor7.jpg',
  'images/doctor8.jpg',
  'images/doctor9.jpg',
  'images/doctor10.jpg',
];

List<String> doctorNames = [
  "Dr.Eman Magdy",
  "Dr.Hossam Mohammed",
  "Dr.Rahma Khaled",
  "Dr.Mohammed Ali",
  "Dr.Sara Samir",
  "Dr.Ahmed Nour",
  "Dr.Aya Elmallah",
  "Dr.John Smith",
  "Dr.Emily Davis",
  "Dr.Michael Brown",
];

final List<Doctor> Doctors = [
  Doctor(name: 'Dr.Eman', photoAsset: 'assets/doctor1.png'),
  Doctor(name: 'Dr.Hossam', photoAsset: 'assets/doctor4.png'),
  Doctor(name: 'Dr.Rahma', photoAsset: 'assets/doctor3.jpg'),
  Doctor(name: 'Dr.Mohammed', photoAsset: 'assets/doctor4.png'),
  Doctor(name: 'Dr.Sara', photoAsset: 'assets/doctor5.jpg'),
  Doctor(name: 'Dr.Ahmed', photoAsset: 'assets/doctor2.jpg'),
  Doctor(name: 'Dr.Aya', photoAsset: 'assets/doctor7.png'),
  Doctor(name: 'Dr.John', photoAsset: 'assets/doctor8.jpeg'),
  Doctor(name: 'Dr.Emily', photoAsset: 'assets/doctor9.png'),
  Doctor(name: 'Dr.Michael', photoAsset: 'assets/doctor10.png'),
];
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  String? name;

  void initState() {
    super.initState();
    // Call the function to fetch user data when the page loads
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Make an HTTP request to fetch user data
    final response = await http.get(Uri.parse('http://ec2-18-220-246-59.us-east-2.compute.amazonaws.com:4000/api/healtha/patients'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      List<dynamic> doctorsData = jsonDecode(response.body);
      if (doctorsData.isNotEmpty) {
        // Retrieve the data for the last doctor signed up
        Map<String, dynamic> userData = doctorsData.last;
        // Update the state variables with the retrieved user data
        setState(() {
          name = userData['username'];
        });
      } else {
        print("error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Hello ${name}!",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                "Welcome to Healtha",
                                style: GoogleFonts.dancingScript(
                                  textStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff7c77d1),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      InkResponse(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("images/girl.PNG"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Popular Laboratory Tests",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
                CarouselSlider(
                  items: LabTestsList(context),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.22,
                    padEnds: false,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:  Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(height: 20,),


                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: Doctors.length,
                      itemBuilder: (context, index) {
                        return DoctorCard(doctor: Doctors[index]);
                      },
                                      ),
                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to the see all doctors screen
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7c77d1),
                        ),
                      ),
                    ),
                  ),
                ),*/
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EncyclopediaTypes()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
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
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: ImageIcon(
                                AssetImage("images/body.png"),
                                size: 35.0,
                                color: Color(0xff7c77d1),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Explore healtha encyclopedias",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Lab analysis encyclopedia and diseases encyclopedia",
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UploadPage()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF0EEFA),
                                shape: BoxShape.circle,
                              ),
                              child: ImageIcon(
                                AssetImage("images/ency2.png"),
                                size: 35.0,
                                color: Color(0xff7c77d1),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Generate Laboratory Test Report ",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Discover how could you get your lab report via Healtha!",
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Disease()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
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
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: ImageIcon(
                                AssetImage("images/symbtoms.png"),
                                size: 35.0,
                                color: Color(0xff7c77d1),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Track your symptoms",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Make use of the diseases prediction feature and show your symptomes",
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> LabTestsList(BuildContext context) {
  List<Widget> posters = [];
  for (var i = 0; i < LabTestsAssets.length; i++) {
    posters.add(
      TestsPoster(
        description: LabTestsDiscription[i],
        imageAsset: LabTestsAssets[i],
        onTap: () {
          switch (i) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CBC()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Urinalysis()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LipidPanel()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ACE()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Liver()),
              );
              break;
            case 5:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Thyroid()),
              );
              break;
            case 6:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calcium()),
              );
              break;
            case 7:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pregnancy()),
              );
              break;
          }
        },
      ),
    );
  }
  return posters;
}

class TestsPoster extends StatelessWidget {
  const TestsPoster({
    Key? key,
    required this.description,
    required this.imageAsset,
    required this.onTap,
  }) : super(key: key);

  final String description;
  final String imageAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              SizedBox(
                height: 250,
                width: 350,
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black45.withOpacity(.8),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Doctor {
  final String name;
  final String photoAsset;

  Doctor({required this.name, required this.photoAsset});
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => drProfile()),
                );
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(doctor.photoAsset),
              )),
          const SizedBox(height: 8.0),
          Text(doctor.name),
        ],
      ),
    );
  }
}
