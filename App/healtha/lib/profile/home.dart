import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'editPage.dart';
import 'package:http/http.dart' as http;
import 'headerContainer.dart';
import 'customContainer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;
  String? name;
  String? phone;
  String? DoB;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the page loads
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Make an HTTP request to fetch user data
    final response = await http.get(Uri.parse('http://ec2-18-220-246-59.us-east-2.compute.amazonaws.com:4000/api/healtha/patients'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      List<dynamic> doctorsData = jsonDecode(response.body);
      if (doctorsData.isNotEmpty) {
        // Retrieve the data for the last doctor signed up
        Map<String, dynamic> userData = doctorsData.last;
        // Update the state variables with the retrieved user data
        setState(() {
          email = userData['email'];
          name=userData['username'];
          phone=userData["contactInformation"];
          DoB=userData["dateOfBirth"];
          // Update other variables if needed
        });
      } else {
        // Handle the case where the list is empty
      }
    } else {
      // If the request fails, show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch user data'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
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
                      image: AssetImage("assets/girl.PNG"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name??"loading..",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: Colors.black),
                ),
                const SizedBox(height: 5),
                const Text(
                  "patient",
                  style: TextStyle(fontSize: 15.0,color: Colors.black),
                ),
                const SizedBox(height: 25),
                customContainer(
                  title: "Email",
                  icon1: Image.asset("assets/at.png"),
                  data: email??"loading ..",
                ),
                const SizedBox(height: 15),
                customContainer(
                    title: "Phone Number",
                    icon1: Image.asset("assets/phone-call.png"),
                    data: phone??"loading .."
                ),
                const SizedBox(height: 15),
                customContainer(
                  title: "Date of Birth",
                  icon1: Image.asset("assets/house-chimney.png"),
                  data: DoB??"loading ..",
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