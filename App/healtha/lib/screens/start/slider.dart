import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/screens/generated/l10n.dart';
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
    final Size screenSize = MediaQuery.of(context).size;

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
                const Color(0xff6e54ab),
                [
                  S.of(context).welcome_to,
                  S.of(context).app_name,
                  '',
                  S.of(context).description_1,
                ],
                'images/search.json',
                screenSize,
              ),
              buildPage(
                const Color(0xFF7165D6),
                ['', S.of(context).app_name, '', S.of(context).description_2],
                'images/ency.json',
                screenSize,
              ),
              buildPage(
                const Color(0xff7c77d1),
                [
                  '',
                  S.of(context).app_name,
                  '',
                  'Diseases prediction made easy.consultation with specialists '
                ],
                'images/test.json',
                screenSize,
              ),
              buildPage(
                const Color(0xffa79ef9),
                [
                  '',
                  S.of(context).app_name,
                  '',
                  'Proactive health starts here.insights with smart reports'
                ],
                'images/report1.json',
                screenSize,
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildPage(
    Color color,
    List<String> texts,
    String animationJson,
    Size screenSize,
  ) {
    return Container(
      color: color,
      height: screenSize.height,
      width: screenSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height * 0.05),
            Lottie.asset(
              animationJson,
              width: screenSize.width * 0.7,
              height: screenSize.width * 0.7,
              fit: BoxFit.fill,
            ),
            SizedBox(height: screenSize.height * 0.02),
            RichText(
              text: TextSpan(
                text: texts[0],
                style: TextStyle(
                  fontSize: screenSize.width * 0.1,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: texts[1],
                    style: GoogleFonts.dancingScript(
                      textStyle: TextStyle(
                        fontSize: screenSize.width * 0.1,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: texts[2],
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.015),
            RichText(
              text: TextSpan(
                text: texts[3],
                style: TextStyle(
                  fontSize: screenSize.width * 0.05,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.18),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const option(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: screenSize.height * 0.075,
                width: screenSize.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).Get_Started,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        color: const Color(0xff7c77d1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.02),
                    const Icon(
                      Icons.arrow_forward,
                      color: Color(0xff7c77d1),
                    ),
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
