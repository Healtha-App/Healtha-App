import 'package:flutter/material.dart';

class customContainer extends StatelessWidget {
   customContainer({this.title,this.icon1,this.data});
  String? title;
  Image ? icon1;
  String? data;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -50,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Container(

        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.12,
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
        child:
        ListTile(
          leading: Container(
              width: 30,
              height: 30,
              child: icon1),
          title: Text(title!,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff7c77d1)),),
          subtitle: Text(data!,
            style: TextStyle(fontSize: 18),),
        ),


      ),
    );
  }
}
