import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SavedReport extends StatefulWidget {
  @override
  _SavedReportState createState() => _SavedReportState();
}

class _SavedReportState extends State<SavedReport> {
  String _fileName = 'No file chosen';
  bool showAfterAnimation= false;
  bool _isEnabled = true;

  int _selectedIndex = 0;
  static const Color myPurple = Color(0xff7c77d1);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*.20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: myPurple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: MediaQuery.of(context).size.width * 0.20,
              right: MediaQuery.of(context).size.width * 0.20,
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
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
                      "Your saved reports",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: myPurple),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),

        Expanded(child:
        SingleChildScrollView(
        child: Column(
        children: [
        // List of cards for saved reports
          ListView.builder(
            shrinkWrap: true, // Use if inside a Column
            physics: NeverScrollableScrollPhysics(), // Use if inside a SingleChildScrollView
            itemCount: savedReports.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8.0),
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
                child: Card(
                  elevation: 0.0, // Set elevation to 0 as the shadow is provided by the BoxDecoration
                  child: ListTile(
                    title: Text(savedReports[index]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Handle the 'View' button tap
                        // You can navigate to the details page or show a dialog, etc.
                        // For now, let's print a message to the console.
                        print('Viewing details for ${savedReports[index]}');
                      },
                      style: ButtonStyle(
                        //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(
                            _isEnabled ? Colors.white : myPurple.withOpacity(0)),
                        backgroundColor: MaterialStateProperty.all(
                            _isEnabled ? myPurple : myPurple.withOpacity(0)),
                      ),
                      child: Text('View Report'),
                    ),
                    // Customize ListTile content as needed
                  ),
                ),
              );
            },
          )

        ],
    ),
    ),
        )

      ],
    );
  }
}
final List<String> savedReports = [
  'S.Cholesterol (11-11-2020)',
  'TSH (10-10-2020)',
  'S.Calcium (10-10-2020)',
  'S.Cholesterol (10-10-2020)',
  'TSH (9-9-2020)',
  'S.Calcium (9-9-2020)',
  // Add more report names as needed
];