import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home_screen.dart';
import 'log_in.dart';

class SignUp extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _email;
    String _password;

    return Scaffold(
      backgroundColor: Color(0xff7c77d1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 20,
            ),
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
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff7c77d1),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.person),
                                // prefixIcon: Icon(Icons.drive_file_rename_outline),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                labelText: 'Name'),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            onChanged: (value) => _email = value,
                            validator: (value) => value!.contains('@gmail.com')
                                ? 'Email must contain @gmail.com'
                                : null,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.email_outlined),
                                // prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                labelText: 'Email'),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            onChanged: (value) => _password = value,
                            validator: (value) => value!.length < 6
                                ? 'Your password must be larger than 6 characters'
                                : null,
                            obscureText: true,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                                // prefixIcon: Icon(Icons.password_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                labelText: 'Password'),
                            keyboardType: TextInputType.number,
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            onChanged: (value) => _password = value,
                            validator: (value) => value!.length < 6
                                ? 'Your password must be larger than 6 characters'
                                : null,
                            obscureText: true,
                            decoration: InputDecoration(
                                // prefixIcon: Icon(Icons.password),
                                suffixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                labelText: 'Conferm Password'),
                            keyboardType: TextInputType.number,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Color(0xff7c77d1),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: MaterialButton(
                              child: Text('Sign Up',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white)),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ));
                                }
                              }),
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
                                    ));
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(color: Color(0xFF7165D6)),
                              ))
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
}
