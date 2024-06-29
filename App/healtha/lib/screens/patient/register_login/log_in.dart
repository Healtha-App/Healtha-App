import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/screens/patient/register_login/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:healtha/screens/general/home/home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isPasswordVisible = false;

  Future<bool> login(BuildContext context) async {
    String healthaIP =
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/patients';
    final url = healthaIP;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> specialistDoctors = jsonDecode(response.body);

        // Check if there is a user with the provided username and password
        var user = specialistDoctors.firstWhere(
              (doctor) =>
          doctor['email'] == emailController.text &&
              doctor['password'] == passwordController.text,
          orElse: () => null,
        );

        if (user != null) {
          usernameController.text = user['username'];

          // Save the userId to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', user['userid'].toString());

          // Login successful
          return true;
        } else {
          // No user found with the provided username and password
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Error",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              content: Text(S.of(context).Invalid_email_or_password),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(S.of(context).OK),
                ),
              ],
            ),
          );
          return false;
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

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
                EdgeInsets.symmetric(horizontal: screenSize.width * 0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/healtha1.png',
                      color: Colors.white,
                      width: screenSize.width * 0.12,
                      height: screenSize.width * 0.12,
                    ),
                    SizedBox(width: screenSize.width * 0.02),
                    Text(
                      S.of(context).Healtha,
                      style: GoogleFonts.dancingScript(
                        textStyle: TextStyle(
                          fontSize: screenSize.width * 0.08,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Container(
                height: screenSize.height * 0.8,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
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
                        fontSize: screenSize.width * 0.07,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff7c77d1),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(color: Colors.black), // Set entered text color to black
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email_outlined,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(screenSize.width * 0.1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                          ),

                          labelText: S.of(context).Email,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText:
                        !isPasswordVisible, //This will obscure text dynamically
                        decoration: InputDecoration(
                          labelText: S.of(context).Password,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(screenSize.width * 0.1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              color: Theme.of(context).colorScheme.onPrimary,
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                      child: Container(
                        width: double.infinity,
                        height: screenSize.width * 0.13,
                        decoration: BoxDecoration(
                          color:  Color(0xff7c77d1),
                          borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                            splashColor: Colors.white.withOpacity(0.3), // Custom splash color
                            highlightColor: Colors.transparent, // Disable default highlight color
                            onTap: () {
                              login(context).then((success) {
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: SizedBox(
                                        height: 60, // Adjust the height as needed
                                        child: Row(
                                          children: [
                                            const Icon(Icons.check_circle, color: Colors.white70),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                'Login successful, \n '
                                                    'Welcome ${usernameController.text} to HEALTHA!',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      backgroundColor: Colors.green,                                      elevation: 8,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(), // Replace with your home screen
                                    ),
                                  );
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                S.of(context).Login,
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.06,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).Don_t_have_an_account,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            S.of(context).Sign_Up,
                            style: const TextStyle(color: Color(0xff7c77d1)),
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
    );
  }
}
