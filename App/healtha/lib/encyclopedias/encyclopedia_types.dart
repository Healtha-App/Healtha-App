import 'package:flutter/material.dart';
import 'package:healtha/encyclopedias/one_encyclopedia.dart';
import 'package:healtha/main.dart';
import '../register_login/join_as.dart';
import '../register_login/sign_up.dart';

class EncyclopediaTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                   // color: MyApp.myPurple,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff7c77d1).withOpacity(0.5),
                        Color(0xff7c77d1).withOpacity(0.7),
                        Color(0xff7c77d1).withOpacity(0.9),
                        Color(0xff7c77d1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.9,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff7c77d1),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dive into medical wisdom!",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: MyApp.myPurple),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "your pocket health encyclopedia",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100,),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EncyclopediaPage('Disease','assets/body-scan-c.png')),
                );
              },
              child: MyContainer('Diseases Encyclopedia','assets/body-scan-c.png'),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EncyclopediaPage('Lab Test','assets/flask.png')),
                );
              },
              child: MyContainer2('Lab Tests Encyclopedia','assets/flask.png'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => joinAs()));
              },
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.060,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                   color: Color(0xff7c77d1),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Join app",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  final String label;
  final String image;

  MyContainer(this.label, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        //color: Color(0xff7c77d1),
        gradient: LinearGradient(
          colors: [
            Color(0xff7c77d1).withOpacity(0.4),
            Color(0xff7c77d1).withOpacity(0.6),
            Color(0xff7c77d1).withOpacity(0.9),
            Color(0xff7c77d1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 80,
            height: 80,
          ),
          SizedBox(height: 20),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17
            ),
          ),

        ],
      ),
    );
  }
}
class MyContainer2 extends StatelessWidget {
  final String label;
  final String image;

  MyContainer2(this.label, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 80,
            height: 80,
          ),
          SizedBox(height: 20),
          Text(
            label,
            style: TextStyle(
              color: Color(0xff7c77d1),
              fontWeight: FontWeight.bold,
              fontSize: 17
            ),
          ),

        ],
      ),
    );
  }
}