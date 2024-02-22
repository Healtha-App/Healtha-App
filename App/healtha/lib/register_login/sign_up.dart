import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import '../home/home_screen.dart';
import 'log_in.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationPasswordController =
  TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController contactInformationController =
  TextEditingController();

  Future<void> signUp(BuildContext context) async {
    final url = 'http://192.168.1.12:4000/api/healtha/patients';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text,
          'confirmationPassword': confirmationPasswordController.text,
          'email': emailController.text,
          'dateOfBirth': dateOfBirthController.text,
          'gender': genderController.text,
          'contactInformation': contactInformationController.text
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Account created successfully, \nWELCOME ${usernameController.text} TO HEALTHA !',
                      style: TextStyle(
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

        Future.delayed(Duration(seconds: 5), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sign-up failed. Please try again ..',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7c77d1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/healtha1.png',
                    color: Colors.white,
                    width: 70.0,
                    height: 70.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Healtha',
                    style: GoogleFonts.dancingScript(
                      textStyle: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff7c77d1),
                        ),
                      ),
                      SizedBox(height: 20),
                      buildTextFormField(
                        controller: usernameController,
                        labelText: 'Name',
                        suffixIcon: Icons.person,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Username';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        controller: emailController,
                        labelText: 'Email',
                        suffixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      buildTextFormField(
                        controller: passwordController,
                        labelText: 'Password',
                        suffixIcon: Icons.remove_red_eye_outlined,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Your password must be larger than 6 characters';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        controller: confirmationPasswordController,
                        labelText: 'Confirm Password',
                        suffixIcon: Icons.remove_red_eye,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Your password must be larger than 6 characters';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        controller: dateOfBirthController,
                        labelText: 'Date of Birth',
                        suffixIcon: Icons.date_range_outlined,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your birth date';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        controller: genderController,
                        labelText: 'Gender',
                        suffixIcon: Icons.person_search,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your gender';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        controller: contactInformationController,
                        labelText: 'Contact Info',
                        suffixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xff7c77d1),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: MaterialButton(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signUp(context);
                              }
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Text(
                              'Log in',
                              style: TextStyle(color: Color(0xFF7165D6)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData suffixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: Icon(suffixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}