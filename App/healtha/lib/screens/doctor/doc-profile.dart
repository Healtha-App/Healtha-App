import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healtha/variables.dart';
import 'package:http/http.dart' as http;
import '../patient/lab_analysis/report.dart';
import '../patient/notification/notification_center.dart';
import '../patient/profile/customContainer.dart';
import 'package:healtha/localization/generated/l10n.dart';

class drProfile extends StatefulWidget {
  const drProfile({Key? key}) : super(key: key);

  @override
  State<drProfile> createState() => _drProfileState();
}

class _drProfileState extends State<drProfile> {
  String? skills;
  String? qualifications;

  String? email;
  String? name;
  String? phone;
  String? spec;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse(
        'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/specialistdoctors'));

    if (response.statusCode == 200) {
      List<dynamic> doctorsData = jsonDecode(response.body);
      if (doctorsData.isNotEmpty) {
        Map<String, dynamic> userData = doctorsData.last;
        setState(() {
          email = userData['email'];  // Changed to directly use 'email'
          name = userData['username'];
          phone = userData["contactInformation"];
          spec = userData["specialization"];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
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
        _isLoading = false;
      });
    }
  }
  bool hasNewConfirmedReport() {
    // Implement the logic to check for new confirmed reports
    // This could involve checking a database or a state management solution
    // For this example, we'll just return true
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (hasNewConfirmedReport()) {
        showTopSnackBar(
          context,
          "Dear Dr.${(name!)}, \nYour lab results interpretation is ready. ",
          "View report",
              () {
            // Navigate to the report page
            // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => ReportPage()));
          },
        );
      }
    });

    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: screenSize.width,
                    height: screenSize.height / 2.1,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/dr.PNG"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.onSurface,
                            Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).Patients,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "20",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).Experience,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "5 Years",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).Specialization,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              spec ?? "Loading ..",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height / 2.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).Dr,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color:
                                Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              name ?? "Loading...",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        customContainer(
                          title: S.of(context).email,
                          icon1: Image.asset("assets/at.png"),
                          data: email ?? "Loading...",
                        ),
                        const SizedBox(height: 15),
                        customContainer(
                          title: S.of(context).Phone_Number,
                          icon1: Image.asset("assets/phone-call.png"),
                          data: phone ?? 'loading ..',
                        ),
                        skills != null
                            ? Padding(
                          padding: EdgeInsets.all(
                              screenSize.width * 0.02),
                          child: customContainer(
                            title: S.of(context).Skills,
                            icon1: Image.asset("images/skill.png"),
                            data: skills!,
                          ),
                        )
                            : const SizedBox(height: 10),
                        qualifications != null
                            ? customContainer(
                          title: S.of(context).Qualifications,
                          icon1: Image.asset(
                              "images/certificate2.png"),
                          data: qualifications!,
                        )
                            : const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(screenSize.width * 0.02),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            S.of(context)
                                                .Complete_Your_Info,
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          TextField(
                                            keyboardType:
                                            TextInputType.multiline,
                                            minLines: 1,
                                            maxLines: 5,
                                            onChanged: (value) {
                                              setState(() {
                                                skills = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText:
                                              S.of(context).Skills,
                                              hintText: S
                                                  .of(context)
                                                  .Enter_your_skills,
                                              border:
                                              const OutlineInputBorder(),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextField(
                                            keyboardType:
                                            TextInputType.multiline,
                                            minLines: 1,
                                            maxLines: 5,
                                            onChanged: (value) {
                                              setState(() {
                                                qualifications = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: S
                                                  .of(context)
                                                  .Qualifications,
                                              hintText: S
                                                  .of(context)
                                                  .Enter_your_qualifications,
                                              border:
                                              const OutlineInputBorder(),
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  const Color(
                                                      0xff7c77d1),
                                                ),
                                                child: Text(
                                                  S.of(context).Save,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight
                                                          .w600),
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  Colors.white,
                                                ),
                                                child: Text(
                                                  S.of(context).Cancel,
                                                  style: const TextStyle(
                                                      color: Color(
                                                          0xff7c77d1),
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight
                                                          .w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit,
                                color: Colors.white),
                            label: Text(
                              S.of(context).Complete_your_info,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  const Color(0xff7c77d1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void showTopSnackBar(BuildContext context, String message, String actionLabel, VoidCallback onActionPressed) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry; // Define overlayEntry as nullable


  overlayEntry = OverlayEntry(
    builder: (context) => Center(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.8,
              // margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Report(reportContent: '',)));
                        },
                        child: Text(
                          actionLabel,
                          style: TextStyle(
                            color: AppConfig.myPurple,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text('or'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationCenter()));
                        },
                        child: Text(
                          "View all notifications",
                          style: TextStyle(
                              color: AppConfig.myPurple,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  overlayEntry?.remove(); // Remove the snackbar when close button is pressed
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );

  overlayState?.insert(overlayEntry);

  Future.delayed(Duration(seconds: 3), () {
    if (overlayEntry!.mounted) {
      overlayEntry?.remove();
    }
  });
}
