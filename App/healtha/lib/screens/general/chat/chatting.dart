//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:healtha/screens/doctor/doc-profile.dart';
 // Import the drProfile page

class Chatting extends StatefulWidget {
  final String doctorName;
  const Chatting({Key? key, required this.doctorName}) : super(key: key);

  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  String? messageText;
 // final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff8882e5),
        title: Row(
          children: [
            ClipOval(
              child: Image.asset('assets/doctor1.png', height: 40, width: 40, fit: BoxFit.cover),
            ),
            SizedBox(width: 10),
            Text(
              widget.doctorName,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => drProfile()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xff7c77d1),
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // _firestore.collection('messages').add({
                      //   'text': messageText,
                      //   'sender': "sarasammir052@gmail.com",
                      //   //signedInUser.email,
                      // });
                    },
                    icon: Icon(
                      Icons.send,
                      color: Color(0xff7c77d1),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
