import 'package:flutter/material.dart';
import 'package:healtha/register_login/sign_up.dart';

import '../doctor_ui/doc_signUp.dart';

class ZoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7c77d1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Text('Join as :',style: TextStyle(fontWeight: FontWeight.w600,
                  fontSize: 30,color: Colors.white),),
              SizedBox(height: 70),
              Container(
                height: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ZoomableContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => docSignUpPage()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Doctor",style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600
                                      ),)
                                    ],),
                                  SizedBox(width: 70,),
                                  Container(
                                    margin: EdgeInsets.all(12),
                                    width: 160,
                                    height: 200,
                                    child:     Image(image: AssetImage("images/doc.jpg")),

                                  ),


                                ]
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),

                                  blurRadius: 9,
                                  offset: Offset(0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ZoomableContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => SignUp()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            child: Row(
                                children:[
                                  Container(
                                    margin: EdgeInsets.all(12),
                                    width: 160,
                                    height: 200,
                                    child:     Image(image: AssetImage("images/patient.jpg")),

                                  ),
                                  SizedBox(width: 70,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Patient",style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600
                                      ),)
                                    ],),


                                ]
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),

                                  blurRadius: 9,
                                  offset: Offset(0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ZoomableContainer extends StatefulWidget {
  final Widget child;

  const ZoomableContainer({Key? key, required this.child}) : super(key: key);

  @override
  _ZoomableContainerState createState() => _ZoomableContainerState();
}

class _ZoomableContainerState extends State<ZoomableContainer> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _scale = 1.5;
        });
      },
      onTapUp: (_) {
        setState(() {
          _scale = 1.0;
        });
      },
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
