
import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
   customTextField({this.hint, this.type}) ;
String ? hint;
TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -50,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 110,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
             // color: Color(0xff7c77d1),
              offset: Offset(0.0, 2.0),
              blurRadius: 1.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child:
        TextField(
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hint,
                hintStyle: TextStyle(color: Color(0xff7c77d1),),
          ),
        ),

      ),
    );
  }
}
