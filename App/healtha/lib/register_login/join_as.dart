import 'package:flutter/material.dart';
import 'package:healtha/register_login/sign_up.dart';
import '../doctor_ui/doc_signUp.dart';

class joinAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff7c77d1).withOpacity(0.5),
                Color(0xff7c77d1).withOpacity(0.7),
                Color(0xff7c77d1).withOpacity(0.9),
                Color(0xff7c77d1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.1),
              Text(
                'Join as :',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: screenSize.width * 0.08,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Container(
                height: screenSize.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenSize.width * 0.1),
                    topRight: Radius.circular(screenSize.width * 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.1),
                    Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.03),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => docSignUpPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: screenSize.height * 0.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Doctor",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.06,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: screenSize.width * 0.1),
                              Container(
                                //margin: EdgeInsets.all(screenSize.width * 0.025),
                                width: screenSize.width * 0.4,
                                height: screenSize.height * 0.2,
                                child: Image(image: AssetImage("images/doc.jpg")),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(screenSize.width * 0.03)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: screenSize.width * 0.018,
                                offset: Offset(0, screenSize.width * 0.025), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.03),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: screenSize.height * 0.2,
                          child: Row(
                            children: [
                              Container(
                                //margin: EdgeInsets.all(screenSize.width * 0.025),
                                width: screenSize.width * 0.4,
                                height: screenSize.height * 0.2,
                                child: Image(image: AssetImage("images/patient.jpg")),
                              ),
                              SizedBox(width: screenSize.width * 0.1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Patient",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.06,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(screenSize.width * 0.03)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: screenSize.width * 0.018,
                                offset: Offset(0, screenSize.width * 0.025), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
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
