import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/screens/navigation/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import '../home/home_screen.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

int? patientId;

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  bool isMale = false; // New state for gender selection
  bool isFemale = false; // New state for gender selection
  final TextEditingController contactInformationController =
      TextEditingController();

  // New state for password visibility
  bool isPasswordVisible = false;

  Future<int?> signUp(BuildContext context) async {
    String healthaIP =
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/patients';

    final url = healthaIP;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text,
          'email': emailController.text,
          'dateOfBirth': dateOfBirthController.text,
          'gender': isMale ? S.of(context).Male : S.of(context).Female,
          'contactInformation': contactInformationController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      log(response.body);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SizedBox(
              height: 60,
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S
                          .of(context)
                          .Account_created_successfully_nWELCOME_TO_HEALTHA(
                              usernameController.text),
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
     //       backgroundColor: Colors.white,
            elevation: 8,
            behavior: SnackBarBehavior.floating,
          ),
        );
        // Patient created successfully, parse response JSON to get the patient ID
        final parsedResponse = jsonDecode(response.body);
        patientId = parsedResponse['userid']; // Access the auto-generated ID
        print(patientId);

        // Navigate to the home screen immediately after displaying the SnackBar
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Navbar(),
          ),
          (route) => false,
        );
        return patientId;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).Sign_up_failed_Please_try_again,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.grey,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.02),
              Padding(
                padding: EdgeInsets.all(screenSize.width * 0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/healtha1.png',
                      color: Colors.white,
                      width: screenSize.width * 0.1,
                      height: screenSize.width * 0.1,
                    ),
                    SizedBox(width: screenSize.width * 0.02),
                    Text(
                      S.of(context).Healtha,
                      style: GoogleFonts.dancingScript(
                        textStyle: TextStyle(
                          fontSize: screenSize.width * 0.08,
                          fontWeight: FontWeight.w700,
                        //  color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenSize.width * 0.05),
                    topRight: Radius.circular(screenSize.width * 0.05),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenSize.height * 0.04),
                        Text(
                          S.of(context).Sign_Up,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.07,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff7c77d1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        buildTextFormField(
                          controller: usernameController,
                          labelText: S.of(context).Username,
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
                          labelText: S.of(context).Email,
                          suffixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
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
                        buildTextFormField(
                          controller: passwordController,
                          labelText: S.of(context).Password,
                          suffixIcon: isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          obscureText: !isPasswordVisible,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.length < 8 ||
                                !RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])')
                                    .hasMatch(value)) {
                              return 'Password must be at least 8 characters with a mix of uppercase, lowercase, and numbers';
                            }
                            return null;
                          },
                          onTapSuffix: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        buildTextFormField(
                          controller: dateOfBirthController,
                          labelText: S.of(context).Date_of_Birth,
                          suffixIcon: Icons.date_range_outlined,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your birth date';
                            }
                            return null;
                          },
                          onTapSuffix: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (selectedDate != null &&
                                selectedDate != DateTime.now()) {
                              setState(() {
                                dateOfBirthController.text = selectedDate
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];
                              });
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.01,
                              horizontal: screenSize.width * 0.05),
                          child: Row(
                            children: [
                              Text(S.of(context).Gender),
                              Checkbox(
                                value: isMale,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isMale = newValue!;
                                    if (isMale) {
                                      isFemale = false;
                                    }
                                  });
                                },
                              ),
                              Text(S.of(context).Male),
                              Checkbox(
                                value: isFemale,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isFemale = newValue!;
                                    if (isFemale) {
                                      isMale = false;
                                    }
                                  });
                                },
                              ),
                              Text(S.of(context).Female),
                            ],
                          ),
                        ),
                        buildTextFormField(
                          controller: contactInformationController,
                          labelText: S.of(context).Contact_Info,
                          suffixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your number';
                            } else if (value.length != 11) {
                              return 'Phone number must be 11 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.01,
                              horizontal: screenSize.width * 0.05),
                          child: Container(
                            width: double.infinity,
                            height: screenSize.height * 0.07,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c77d1),
                              borderRadius:
                                  BorderRadius.circular(screenSize.width * 0.1),
                            ),
                            child: MaterialButton(
                              child: Text(
                                S.of(context).Sign_Up,
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.06,
                            //      color: Colors.white,
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
                            Text(S.of(context).Have_an_account),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                              child: Text(
                                S.of(context).Log_in,
                                style:
                                    const TextStyle(color: Color(0xFF7165D6)),
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
    VoidCallback? onTapSuffix,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: onTapSuffix,
            child: Icon(suffixIcon),
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}