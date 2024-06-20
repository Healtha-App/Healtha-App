import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtha/generated/l10n.dart';
import 'package:healtha/lab_doctor/lab_doctor.dart';
import 'package:healtha/main.dart';
import 'package:healtha/profile/settings.dart';
import 'package:healtha/register_login/log_in.dart';
import 'package:healtha/variables.dart';
import '../register_login/log_in.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Add this line

  String? email;
  String? name;
  String? phone;
  String? DoB;
  bool _isLoading = true; // Add a flag to track loading state

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the page loads
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Make an HTTP request to fetch user data
    final response = await http.get(Uri.parse(
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/patients'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      List<dynamic> doctorsData = jsonDecode(response.body);
      if (doctorsData.isNotEmpty) {
        // Retrieve the data for the last doctor signed up
        Map<String, dynamic> userData = doctorsData.last;
        // Update the state variables with the retrieved user data
        setState(() {
          email = userData['email'];
          name = userData['username'];
          phone = userData["contactInformation"];
          DoB = userData["dateOfBirth"];
          _isLoading = false; // Set loading flag to false
          // Update other variables if needed
        });
      } else {
        // Handle the case where the list is empty
        setState(() {
          _isLoading = false; // Set loading flag to false
        });
      }
    } else {
      // If the request fails, show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(S.of(context).Failed_to_fetch_user_data),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).OK),
            ),
          ],
        ),
      );
      setState(() {
        _isLoading = false; // Set loading flag to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Set the key here
      appBar: AppBar(
        backgroundColor: AppConfig.myPurple,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // Use the key to open the drawer
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 60.0, // Reduced height
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(16.0),
                child: Text(S.of(context).Menu,
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: myPurple),
              title: Text(S.of(context).Favorites),
              onTap: () {
                // Handle Favorites tap
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark, color: myPurple),
              title: Text(S.of(context).Saved),
              onTap: () {
                // Handle Saved tap
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: myPurple),
              title: Text(S.of(context).Help_Support),
              onTap: () {
                // Handle Help and Support tap
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: myPurple),
              title: Text(S.of(context).Settings),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(
                            onThemeChanged: (ThemeData) {},
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_sharp, color: myPurple),
              title: Text(S.of(context).Privacy),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: myPurple),
              title: Text(S.of(context).Log_Out),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const editPage()),
          );
        },
        backgroundColor: const Color(0xff7c77d1),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: HeaderCurvedContainer(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          _isLoading
              ? const CircularProgressIndicator() // Show loading indicator if data is still loading
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
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
                        name ?? "loading..",
                        style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        S.of(context).patient,
                        style: const TextStyle(
                            fontSize: 15.0, color: Colors.black),
                      ),
                      const SizedBox(height: 25),
                      customContainer(
                        title: S.of(context).Email,
                        icon1: Image.asset("assets/at.png"),
                        data: email ?? "loading ..",
                      ),
                      const SizedBox(height: 15),
                      customContainer(
                        title: S.of(context).Phone_Number,
                        icon1: Image.asset("assets/phone-call.png"),
                        data: phone ?? "loading ..",
                      ),
                      const SizedBox(height: 15),
                      customContainer(
                        title: S.of(context).Date_of_Birth,
                        icon1: Image.asset("assets/house-chimney.png"),
                        data: DoB ?? "loading ..",
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
