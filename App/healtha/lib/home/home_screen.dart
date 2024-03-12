import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/main.dart';
import '../chatbot/chat_screen.dart';
import '../encyclopedias/encyclopedia_types.dart';
import '../lab_analysis/upload_analysis.dart';
import '../navigation.dart';
import '../prediction/disease_prediction.dart';
import '../profile/home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';

List LabTestsAssets = [
  'images/poster1.jpg',
  'images/poster2.jpg',
  'images/poster3.jpg',
  'images/poster4.jpg',
  'images/poster5.jpg',
  'images/poster6.jpg',
  'images/poster7.jpg',
  'images/poster8.jpg',
];

List LabTestsDiscription = [
  "CBC, Complete Blood Count \nMeasures your red blood cells, white blood cells, and platelets.",
  "Urinalysis \nAnalyzes all of the properties of your urine.",
  "TSH, Thyroid Stimulating Hormone \n A hormone that regulates the function of the thyroid gland.",
  "Glucose \nA sugar molecule that is the body's main source of energy",
  "Liver function \nMeasure the levels of enzymes and other substances produced by the liver",
  "Thyroid function\nMeasure the levels of thyroid hormones in the blood.",
  "Calcium \nImportant for building and maintaining strong bones and teeth.",
  "Pregnancy \nA state in which a woman has a developing fetus inside her uterus.",
];

final iconBot = Image.asset(
  'images/bot1.png',
  color: Color(0xff7c77d1), // Set desired icon color
  width: 60.0, // Adjust icon width
  height: 60.0, // Adjust icon height
);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hello Habiba! \nWelcome to",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            "\nHealtha",
                            style: GoogleFonts.dancingScript(
                              textStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff7c77d1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkResponse(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("images/girl.PNG"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Popular Laboratory Tests",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff161515),
                    ),
                  ),
                ),
                CarouselSlider(
                  items: LabTestsList(),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.25,
                    padEnds: false,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:  Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                /* SizedBox(
                  height: 70,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: symptoms.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F6FA),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            symptoms[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF7165D6),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ), */
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EncyclopediaTypes()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                         // color: Color(0xff7c77d1),
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
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,

                              ),
                              child: ImageIcon(
                                AssetImage("images/body.png"),
                                size: 35.0, // Adjust size as needed
                                color:
                                    Color(0xff7c77d1), // Modify color if desired
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Explore healtha encyclopedias",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Lab analysis encyclopedia and diseases encyclopedia",
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UploadPage()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF0EEFA),
                                shape: BoxShape.circle,
                              ),
                              child: ImageIcon(
                                AssetImage("images/ency2.png"),
                                size: 35.0, // Adjust size as needed
                                color:
                                    Color(0xff7c77d1), // Modify color if desired
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Generate Laboratory Test Report ",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Discover how could you get your lab report via Healtha!",
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Disease()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                        //  color: Color(0xff7c77d1),
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
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: ImageIcon(
                                AssetImage("images/symbtoms.png"),
                                size: 35.0, // Adjust size as needed
                                color:
                                    Color(0xff7c77d1), // Modify color if desired
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Track your symptomes",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Make use of the diseases prediction feature and show your symptomes",
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                /* Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Popular lab analysis",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ), */
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.21,
          height: MediaQuery.of(context).size.height * 0.21,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xff7c77d1).withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 12,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              elevation: 7.0,
              fillColor: Colors.white, // Set button color
              child: iconBot,
              padding: EdgeInsets.all(12.0),
              shape: CircleBorder(),
            ),
          ),
        ),

      ),
    );
  }
}

List<Widget> LabTestsList() {
  List<Widget> posters = [];
  for (var i = 0; i < LabTestsAssets.length; i++) {
    posters.add(TestsPoster(
        description: LabTestsDiscription[i], imageAsset: LabTestsAssets[i]));
  }
  return posters;
}

class TestsPoster extends StatelessWidget {
  const TestsPoster({
    super.key,
    required this.description,
    required this.imageAsset,
  });

  final String description;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(children: [
            SizedBox(
              height: 250,
              width: 350,
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Padding(
                padding:  EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    description,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black45.withOpacity(.8),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
