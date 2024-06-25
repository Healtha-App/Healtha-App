import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healtha/variables.dart';
import 'package:http/http.dart' as http;
import 'package:healtha/screens/patient/profile/customContainer.dart';
import 'package:healtha/localization/generated/l10n.dart';

import '../../general/chat/chat2.dart'; // Import DoctorChat screen

class drProfile2 extends StatefulWidget {
  const drProfile2({Key? key}) : super(key: key);

  @override
  State<drProfile2> createState() => _drProfileState();
}

class _drProfileState extends State<drProfile2> {
  String? skills;
  String? qualifications;
  String? email;
  String? name;
  String? phone;
  String? spec;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse(
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/specialistdoctors'));

    if (response.statusCode == 200) {
      List<dynamic> doctorsData = jsonDecode(response.body);
      if (doctorsData.isNotEmpty) {
        Map<String, dynamic> userData = doctorsData.last;
        setState(() {
          email = userData[S.of(context).email];
          name = userData['username'];
          phone = userData["contactInformation"];
          spec = userData["specialization"];
          _isLoading = false;
        });
      } else {
        _isLoading = false;
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(S.of(context).Failed_to_fetch_user_data),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).OK),
            ),
          ],
        ),
      );
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: screenSize.width,
                    height: screenSize.height / 2.1,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/dr.PNG"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.onSurface,
                            Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).Patients,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "20",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).Experience,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "5 Years",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).Specialization,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              spec ?? "Loading ..",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height / 2.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).Dr,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              name ?? "Loading...",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        customContainer(
                          title: S.of(context).email,
                          icon1: Image.asset("assets/at.png"),
                          data: email ?? "Loading...",
                        ),
                        const SizedBox(height: 15),
                        customContainer(
                          title: S.of(context).Phone_Number,
                          icon1: Image.asset("assets/phone-call.png"),
                          data: phone ?? 'loading ..',
                        ),
                        skills != null
                            ? Padding(
                          padding: EdgeInsets.all(screenSize.width * 0.02),
                          child: customContainer(
                            title: S.of(context).Skills,
                            icon1: Image.asset("images/skill.png"),
                            data: skills!,
                          ),
                        )
                            : const SizedBox(height: 10),
                        qualifications != null
                            ? customContainer(
                          title: S.of(context).Qualifications,
                          icon1: Image.asset("images/certificate2.png"),
                          data: qualifications!,
                        )
                            : const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(screenSize.width * 0.02),
                          child: Text('chat'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DoctorChat()),
            );
          },
          child: Icon(Icons.message, color: Colors.white),
          backgroundColor: Color(0xff7c77d1),
        ),
      ),
    );
  }
}
