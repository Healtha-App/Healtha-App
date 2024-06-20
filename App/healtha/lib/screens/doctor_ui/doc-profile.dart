import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtha/variables.dart';
import 'package:http/http.dart' as http;
import '../profile/customContainer.dart';
import 'package:healtha/screens/generated/l10n.dart';

class drProfile extends StatefulWidget {
  const drProfile({Key? key}) : super(key: key);

  @override
  State<drProfile> createState() => _drProfileState();
}

class _drProfileState extends State<drProfile> {
  String? skills;
  String? qualifications;

  String? email;
  String? name;
  String? phone;
  String? spec;

  bool _isLoading = true; // Add a flag to track loading state

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the page loads
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Make an HTTP request to fetch user data
    final response = await http.get(Uri.parse(
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/specialistdoctors'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      List<dynamic> doctorsData = jsonDecode(response.body);
      if (doctorsData.isNotEmpty) {
        // Retrieve the data for the last doctor signed up
        Map<String, dynamic> userData = doctorsData.last;
        // Update the state variables with the retrieved user data
        setState(() {
          email = userData[S.of(context).email];
          name = userData['username'];
          phone = userData["contactInformation"];
          spec = userData["specialization"];
          _isLoading = false; // Set loading flag to false
          // Update other variables if needed
        });
      } else {
        // Handle the case where the list is empty
        _isLoading = false; // Set loading flag to false
      }
    } else {
      // If the request fails, show an error message
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
      _isLoading = false; // Set loading flag to false
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator if data is still loading
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
                                  AppConfig.myPurple,
                                  AppConfig.myPurple.withOpacity(0.5),
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
                              // Experience widget
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
                              // Specialization widget
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
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    name ?? "Loading...",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              customContainer(
                                title: S.of(context).email,
                                icon1: Image.asset("assets/at.png"),
                                data: email ??
                                    "Loading...", // Display "Loading..." if email is null
                              ),
                              const SizedBox(height: 15),
                              customContainer(
                                title: S.of(context).Phone_Number,
                                icon1: Image.asset("assets/phone-call.png"),
                                data: phone ?? 'loading ..',
                              ),
                              // New customContainers to display skills and qualifications
                              skills != null
                                  ? Padding(
                                      padding: EdgeInsets.all(
                                          screenSize.width * 0.02),
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
                                      icon1: Image.asset(
                                          "images/certificate2.png"),
                                      data: qualifications!,
                                    )
                                  : const SizedBox(height: 10),
                              Padding(
                                padding:
                                    EdgeInsets.all(screenSize.width * 0.02),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  S
                                                      .of(context)
                                                      .Complete_Your_Info,
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 20.0),
                                                TextField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 1,
                                                  maxLines: 5,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      skills = value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        S.of(context).Skills,
                                                    hintText: S
                                                        .of(context)
                                                        .Enter_your_skills,
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                TextField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 1,
                                                  maxLines: 5,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      qualifications = value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: S
                                                        .of(context)
                                                        .Qualifications,
                                                    hintText: S
                                                        .of(context)
                                                        .Enter_your_qualifications,
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // Save skills and qualifications
                                                        // You can handle saving the data to your database here
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xff7c77d1),
                                                        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                                      ),
                                                      child: Text(
                                                        S.of(context).Save,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                                      ),
                                                      child: Text(
                                                        S.of(context).Cancel,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff7c77d1),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                  label: Text(
                                    S.of(context).Complete_your_info,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                            const Color(0xff7c77d1)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
