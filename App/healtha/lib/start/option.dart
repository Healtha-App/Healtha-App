import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/encyclopedias/encyclopedia_types.dart';
import 'package:healtha/register_login/join_as.dart';

class option extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<option>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff7c77d1).withOpacity(0.5),
              Color(0xff7c77d1).withOpacity(0.7),
              Color(0xff7c77d1).withOpacity(0.9),
              Color(0xff7c77d1),
            ],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  top: MediaQuery.of(context).size.height * _animation.value,
                  left: MediaQuery.of(context).size.width * _animation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  top: MediaQuery.of(context).size.height * (1 - _animation.value),
                  left: MediaQuery.of(context).size.width * (1 - _animation.value),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
               // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Step into a world of holistic\nhealth with",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),),

                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        " \nHealtha",
                        style: GoogleFonts.dancingScript(
                          textStyle: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color:Colors.white,
                          ),
                        ),
                      ),
                    ],

                  ),
                  SizedBox(height: 300,),
                  Container(
                    width: 400,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EncyclopediaTypes()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: Colors.white, // Change border color here
                          ), // Remove border
                        ),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: Center(
                          child: Text(
                            'Show encyclopedia',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: 400,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => joinAs()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: Colors.white, // Change border color here
                          ), // Remove border
                        ),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: Center(
                          child: Text(
                            'Start using app',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
