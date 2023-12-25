import 'package:flutter/material.dart';
import 'package:healtha/main.dart';

import 'encyclopedia_types.dart';
import 'one_item_details.dart';

class EncyclopediaPage extends StatelessWidget {
  final String category;
  final String image;

  EncyclopediaPage(this.category, this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.myPurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: MyApp.myPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
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
                  child: Center(
                    child: Text(
                      "$category Encyclopedia",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MyApp.myPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50,),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Adjust the number of items as needed
              itemBuilder: (context, index) {
                return Card(

                  elevation: 3,
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white, // Adjust the elevation as needed
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 25), // Adjust the vertical padding as needed
                    leading: Image.asset(
                      image,
                      width: 35, // Adjust the width as needed
                      height: 35, // Adjust the height as needed
                    ),
                    title: Text(
                      '$category Type $index',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailsPage('$category$index')),
                        );
                      },
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          color: MyApp.myPurple,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )

                );
              },
            ),
          ),

        ],
      ),
    );
  }
}