import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/screens/doctor_ui/requested-reports.dart';
import 'package:healtha/screens/register_login/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:healtha/screens/generated/l10n.dart';

import 'package:healtha/main.dart';

import '../../themes/dark.dart';
import 'doc_signUp.dart';

class docLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  docLogin({super.key});

  Future<bool> login(BuildContext context) async {
    String healthaIP =
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/specialistdoctors';
    final url = healthaIP;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> specialistDoctors = jsonDecode(response.body);

        // Check if there is a user with the provided username
        var user = specialistDoctors.firstWhere(
          (doctor) => doctor['email'] == emailController.text,
          orElse: () => null,
        );

        if (user != null) {
          // Check if the password matches
          if (user['password'] == passwordController.text) {
            usernameController.text = user['username'];
            // Login successful
            return true;
          } else {
            // Incorrect password
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  "Error",
                  style: TextStyle(color: Colors.red),
                ),
                content: Text(S.of(context).Incorrect_password),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      S.of(context).OK,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
            return false;
          }
        } else {
          // If user not found in specialistDoctors collection, add to doctorLogin collection
          return signUpDoctor(context);
        }
      } else {
        // Handle other status codes as needed
        print('Failed to fetch data from the server');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> signUpDoctor(BuildContext context) async {
    String healthaIP = 'http://192.168.1.12:4000/api/healtha/doctor-login';
    final url = healthaIP;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Doctor login created successfully
        return true;
      } else {
        // Handle other status codes as needed
        print('Failed to create doctor login');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xff7c77d1).withOpacity(0.5),
                  const Color(0xff7c77d1).withOpacity(0.7),
                  const Color(0xff7c77d1).withOpacity(0.9),
                  const Color(0xff7c77d1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/healtha1.png',
                        color: Colors.white,
                        width: screenSize.width * 0.14,
                        height: screenSize.width * 0.14,
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      Text(
                        S.of(context).Healtha,
                        style: GoogleFonts.dancingScript(
                          textStyle: TextStyle(
                            fontSize: screenSize.width * 0.1,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Container(
                  height: screenSize.height * 0.85,
                  decoration: BoxDecoration(
                    color: darkTheme == darkTheme
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenSize.width * 0.1),
                      topRight: Radius.circular(screenSize.width * 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.1,
                      ),
                      Text(
                        S.of(context).Log_In,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.08,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff7c77d1),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.04),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(screenSize.width * 0.1),
                            ),
                            labelText: S.of(context).Email,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenSize.width * 0.05,
                          horizontal: screenSize.width * 0.04,
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon:
                                const Icon(Icons.remove_red_eye_outlined),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(screenSize.width * 0.1),
                            ),
                            labelText: S.of(context).Password,
                          ),
                          obscureText: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenSize.width * 0.05,
                          horizontal: screenSize.width * 0.04,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: screenSize.width * 0.13,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c77d1),
                            borderRadius:
                                BorderRadius.circular(screenSize.width * 0.1),
                          ),
                          child: MaterialButton(
                            child: Text(
                              S.of(context).Login,
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.06,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              login(context).then((success) {
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: SizedBox(
                                        height:
                                            60, // Adjust the height as needed
                                        child: Row(
                                          children: [
                                            const Icon(Icons.check_circle,
                                                color: Colors.green),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                'Login successful, \n '
                                                'Welcome Dr.${usernameController.text} to HEALTHA!',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      elevation: 8,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RequestedReports(),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).Don_t_have_an_account),
                          SizedBox(
                            width: screenSize.width * 0.02,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => docSignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).Sign_Up,
                              style: const TextStyle(color: Color(0xFF7165D6)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
