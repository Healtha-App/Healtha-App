import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/screens/doctor/requested-reports.dart';
import '../../localization/generated/l10n.dart';
import '../../themes/dark.dart';
import 'doc_login.dart';

class docSignUpPage extends StatefulWidget {
  const docSignUpPage({super.key});

  @override
  _docSignUpPageState createState() => _docSignUpPageState();
}

class _docSignUpPageState extends State<docSignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();

  bool isMale = false;
  bool isFemale = false;
  String gender = '';
  bool isPasswordVisible = false;

  Future<void> signUp(BuildContext context) async {
    String healthaIP =
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/specialistdoctors';
    final url = healthaIP;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text,
          'email': emailController.text,
          'gender': gender,
          'contactInformation': contactInfoController.text,
          'specialization': specializationController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SizedBox(
              height: 60, // Adjust the height as needed
              child: Row(
                children: [
                  const Icon(Icons.check_circle,  color: Colors.white70),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Account created successfully, \n '
                      'WELCOME Dr.${usernameController.text} TO HEALTHA !',
                      style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.green,
            elevation: 8,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RequestedReports(),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).Sign_up_failed_Please_try_again,
              style: const TextStyle(
                color: Colors.white,
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
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                      SizedBox(height: screenSize.height * 0.1),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.18),
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
                      SizedBox(height: screenSize.height * 0.04),
                      SingleChildScrollView(
                        child: Container(
                          height: screenSize.height * 0.9,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(screenSize.width * 0.1),
                              topRight: Radius.circular(screenSize.width * 0.1),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenSize.width * 0.05),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    S.of(context).Sign_Up,
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.08,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff7c77d1),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      labelText: S.of(context).Username,
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        // Change this to your desired color
                                      ),
                                      suffixIcon: Icon(Icons.person,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenSize.width * 0.1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Username';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                        child: Icon(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      labelText: S.of(context).Password,
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        // Change this to your desired color
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenSize.width * 0.1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                                      ),
                                    ),
                                    obscureText: !isPasswordVisible,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Password';
                                      } else if (value.length < 8) {
                                        return 'Password must be at least 8 characters';
                                      } else if (!RegExp(
                                              r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])')
                                          .hasMatch(value)) {
                                        return 'Password must contain at least one lowercase letter, one uppercase letter, and one digit';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: S.of(context).Email,
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        // Change this to your desired color
                                      ),
                                      suffixIcon:
                                           Icon(Icons.email_outlined,
                                             color: Theme.of(context).colorScheme.onPrimary,
                                           ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenSize.width * 0.1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Email';
                                      } else if (!RegExp(
                                              r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  Row(
                                    children: [
                                      Text(S.of(context).Gender,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),),
                                      Checkbox(
                                        checkColor: Theme.of(context).colorScheme.onPrimary,
                                        value: isMale,
                                        onChanged: (bool? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              isMale = newValue;
                                              isFemale = !newValue;
                                            });
                                          }
                                        },
                                      ),
                                      Text(S.of(context).Male,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),),
                                      Checkbox(
                                        checkColor: Theme.of(context).colorScheme.onPrimary,
                                        value: isFemale,
                                        onChanged: (bool? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              isFemale = newValue;
                                              isMale = !newValue;
                                            });
                                          }
                                        },
                                      ),
                                      Text(S.of(context).Female,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    controller: contactInfoController,
                                    decoration: InputDecoration(
                                      labelText:
                                          S.of(context).Contact_Information,
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        // Change this to your desired color
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenSize.width * 0.1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Contact Information';
                                      } else if (value.length != 11) {
                                        return 'Phone number must be 11 digits';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  TextFormField(

                                    style: TextStyle(color: Colors.black),
                                    controller: specializationController,
                                    decoration: InputDecoration(
                                      labelText: S.of(context).Specialization,
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        // Change this to your desired color
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenSize.width * 0.1),

                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Specialization';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  SizedBox(
                                    width: double.infinity,
                                    height: screenSize.width * 0.13,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          signUp(context);
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                          const Color(0xff7c77d1),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                screenSize.width * 0.1),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        S.of(context).Sign_Up,
                                        style: TextStyle(
                                          fontSize: screenSize.width * 0.06,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(S.of(context).Have_an_account,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => docLogin(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          S.of(context).Log_in,
                                          style: const TextStyle(
                                              color: Color(0xFF7165D6)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
}
