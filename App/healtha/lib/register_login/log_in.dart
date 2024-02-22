import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/register_login/sign_up.dart';
import 'package:http/http.dart' as http;

import '../home/home_screen.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> login(BuildContext context) async {
    final url = 'http://192.168.1.12:4000/api/healtha/patients';

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
          // Login successful
          return true;
        } else {
          // No user found with the provided username and password
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Error',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              content: Text('Invalid email or password'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7c77d1),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),              child: Row(
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
            SizedBox(
              height: 60,
            ),
            Container(
              height: 650,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff7c77d1),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: emailController,
                      decoration:  InputDecoration(
                        // prefixIcon: Icon(Icons.email_outlined),
                        suffixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),                    child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.email_outlined),
                      suffixIcon: Icon(Icons.remove_red_eye_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      labelText: 'password',
                    ),
                    obscureText: true,
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),                    child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Color(0xff7c77d1),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: MaterialButton(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      onPressed: () {
                        login(context).then((success) {
                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
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
                      Text("Don't have an account?"),
                      SizedBox(
                        width: 10.0,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Color(0xFF7165D6)),
                          ))
                    ],
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
