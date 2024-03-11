import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../encyclopedias/encyclopedia_types.dart';
import '../register_login/sign_up.dart';
import 'option.dart';


class slider extends StatefulWidget {
  const slider({Key? key}) : super(key: key);

  @override
  State<slider> createState() => _sliderState();
}

class _sliderState extends State<slider> {
  final _controller = LiquidController();

  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
              enableLoop: false,
              liquidController: _controller,
              onPageChangeCallback: (index) => setState(() {
                    currentPage = index;
                  }),
              pages: [
                buildPage(
                    Color(0xff6e54ab)!,
                    [
                      'welcome to',
                      'Healtha',
                      '',
                      'Medical knowledge in your pocket. Explore medical encyclopedias',
                    ],
                    'images/search.json'),
                buildPage(
                    Color(0xFF7165D6),
                    ['', 'Healtha', '', 'Laboratory tests analysis made easy'],
                    'images/ency.json'),
                buildPage(
                    Color(0xff7c77d1)!,
                    [
                      '',
                      'Healtha',
                      '',
                      'Diseases prediction made easy.consultation with specialists '
                    ],
                    'images/test.json'),
                buildPage(
                    Color(0xffa79ef9)!,
                    [
                      '',
                      'Healtha',
                      '',
                      'Proactive health starts here.insights with smart reports'
                    ],
                    'images/report1.json'),
              ]),
        ],
      ),
    );
  }

  buildPage(
    Color color,
    List<String> texts,
    String animationJson,
  ) {
    controller:
    return Container(
      color: color,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Lottie.asset(
              animationJson,
              width: 350,
              height: 350,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
              text: texts[0],
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                  text: texts[1],
                  style: GoogleFonts.dancingScript(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                )),
                RichText(
                    text: TextSpan(
                  text: texts[2],
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    //   fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            RichText(
                text: TextSpan(
              text: texts[3],
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )),
            SizedBox(height: 150),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => option()));
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff7c77d1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xff7c77d1),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
