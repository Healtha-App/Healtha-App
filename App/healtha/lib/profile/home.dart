import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'editPage.dart';
import 'headerContainer.dart';

import 'customContainer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => editPage()),
          );
        },
        backgroundColor:Color(0xff7c77d1),
        child: Icon(Icons.edit,color: Colors.white,),

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  /* child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 35.0,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),*/
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/habiba1.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Habiba Mohammed Ali",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: Colors.white),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Gastroenterology Doctor",
                  style: TextStyle(fontSize: 15.0,color: Colors.white),
                ),
                const SizedBox(height: 25),
                customContainer(
                  title: "Email",
                  icon1: Image.asset("assets/at.png"),
                  data: "habibahali30@gmail.com",
                ),
                const SizedBox(height: 15),
                customContainer(
                  title: "Phone Number",
                  icon1: Image.asset("assets/phone-call.png"),
                  data: "+1211040679"
                ),
                const SizedBox(height: 15),
                customContainer(
                  title: "Address",
                  icon1: Image.asset("assets/house-chimney.png"),
                  data: "Sadat City, Egypt",
                ),
                const SizedBox(height: 15),



              ],
            ),
          ],
        ),
      ),

    );
  }
}