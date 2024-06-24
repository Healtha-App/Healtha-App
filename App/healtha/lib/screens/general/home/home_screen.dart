import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:healtha/screens/general/home/encyclopediaTypes2.dart';
import 'package:healtha/screens/patient/profile/drProfile2.dart';
import 'package:healtha/variables.dart';
import 'package:http/http.dart' as http;
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/screens/general/home/Lipid-Panel.dart';
import 'package:healtha/screens/general/home/title_item.dart';
import 'package:healtha/screens/patient/register_login/log_in.dart';
import 'package:healtha/screens/patient/register_login/sign_up.dart';
import 'package:healtha/screens/patient/chatbot/chat_screen.dart';
import 'package:healtha/screens/doctor/doc-profile.dart';
import '../encyclopedias/encyclopedia_types.dart';
import 'package:healtha/screens/patient/lab_analysis/upload_analysis.dart';
import 'package:healtha/screens/patient/prediction/disease_prediction.dart';
import 'package:healtha/screens/patient/profile/profile.dart';
import 'ACE.dart';
import 'Calcium.dart';
import 'Liver-function.dart';
import 'Pregnancy.dart';
import 'Thyroid -function.dart';
import 'Urinalysis.dart';
import 'cbc.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> LabTestsAssets = [
  'images/poster1.jpg',
  'images/poster2.jpg',
  'images/poster3.jpg',
  'images/poster4.jpg',
  'images/poster5.jpg',
  'images/poster6.jpg',
  'images/poster7.jpg',
  'images/poster8.jpg',
];

List<String> LabTestsDiscription = [
  "CBC, Complete Blood Count \nMeasures your red blood cells, white blood cells, and platelets.",
  "Urinalysis \nAnalyzes all of the properties of your urine.",
  "Lipid Panel \n blood test that measures various types of cholesterol and triglycerides in the bloodstream.",
  "ACE, Angiotensin-Converting Enzyme \nan enzyme primarily found in the lungs and blood vessels",
  "Liver function \nMeasure the levels of enzymes and other substances produced by the liver",
  "Thyroid function\nMeasure the levels of thyroid hormones in the blood.",
  "Calcium \nImportant for building and maintaining strong bones and teeth.",
  "Pregnancy \nA state in which a woman has a developing fetus inside her uterus.",
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
  Doctor(name: 'Dr.Hossam', photoAsset: 'assets/doctor10.png'),
  Doctor(name: 'Dr.Rahma', photoAsset: 'assets/doctor7.png'),
  Doctor(name: 'Dr.Mohammed', photoAsset: 'assets/doctor4.png'),
  Doctor(name: 'Dr.Sara', photoAsset: 'assets/doctor5.jpg'),
  Doctor(name: 'Dr.Ahmed', photoAsset: 'assets/doctor2.jpg'),
  Doctor(name: 'Dr.Aya', photoAsset: 'assets/doctor3.jpg'),
  Doctor(name: 'Dr.John', photoAsset: 'assets/doctor8.jpeg'),
  Doctor(name: 'Dr.Emily', photoAsset: 'assets/doctor9.png'),
  Doctor(name: 'Dr.Michael', photoAsset: 'assets/doctor10.png'),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the page loads
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Make an HTTP request to fetch user data
      final response = await http.get(Uri.parse(
          'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/patients'));

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
          print("No data available");
        }
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name != null
                              ? S.of(context).Hello(name!)
                              : S.of(context).Hello('There'),
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        Text(
                          S.of(context).Welcome_to_Healtha,
                          style: GoogleFonts.dancingScript(
                            textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff7c77d1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("images/girl.PNG"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  S.of(context).Popular_Laboratory_Tests,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                CarouselSlider(
                  items: LabTestsList(context),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.22,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                ),
                const SizedBox(height: 20),
                TitleItem(mainText: 'Top Doctors', onpressed: (){}),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: Doctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(doctor: Doctors[index]);
                    },
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EncyclopediaTypes2()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 10),
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
                              color: Colors.white54,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const ImageIcon(
                                AssetImage("images/body.png"),
                                size: 35.0,
                                color: Color(0xff7c77d1),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              S.of(context).Explore_healtha_encyclopedias,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              S
                                  .of(context)
                                  .Lab_analysis_encyclopedia_and_diseases_encyclopedia,
                              style: const TextStyle(
                                color: Colors.white70,
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
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(20),
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
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white54,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF0EEFA),
                                shape: BoxShape.circle,
                              ),
                              child: const ImageIcon(
                                AssetImage("images/ency2.png"),
                                size: 35.0,
                                color: Color(0xff7c77d1),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              S.of(context).Generate_Laboratory_Test_Report,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              S
                                  .of(context)
                                  .Discover_how_could_you_get_your_lab_report_via_Healtha,
                              style: const TextStyle(
                                color: Colors.white70,
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
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(20),
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
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white54,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const ImageIcon(
                                AssetImage("images/symbtoms.png"),
                                size: 35.0,
                                color: Color(0xff7c77d1),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              S.of(context).Track_your_symptoms,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              S
                                  .of(context)
                                  .Make_use_of_the_diseases_prediction_feature_and_show_your_symptomes,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
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
                child: Padding(
                  padding: const EdgeInsets.all(12),
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

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => drProfile2()),
              );
            },
            child: CircleAvatar(
              backgroundColor: AppConfig.myPurple,
              radius: 30,
              backgroundImage: AssetImage(doctor.photoAsset),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            doctor.name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
