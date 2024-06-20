import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtha/screens/encyclopedias/one_encyclopedia.dart';
import 'package:healtha/main.dart';
import 'package:healtha/variables.dart';
import '../../bloc/themes/themes_bloc.dart';
import '../register_login/join_as.dart';
import '../register_login/sign_up.dart';
import 'package:healtha/screens/generated/l10n.dart';

class EncyclopediaTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesBloc, ThemesState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: MyApp.myPurple,
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xff7c77d1).withOpacity(0.5),
                              const Color(0xff7c77d1).withOpacity(0.7),
                              const Color(0xff7c77d1).withOpacity(0.9),
                              const Color(0xff7c77d1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -50,
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                //color: Color(0xff7c77d1),
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
                                S.of(context).Dive_into_medical_wisdom,
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.myPurple),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                S.of(context).your_pocket_health_encyclopedia,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EncyclopediaPage(
                                'Disease', 'assets/body-scan-c.png')),
                      );
                    },
                    child: const MyContainer(
                        'Diseases Encyclopedia', 'assets/body-scan-c.png'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EncyclopediaPage('Lab Test', 'assets/flask.png')),
                      );
                    },
                    child: const MyContainer2(
                        'Lab Tests Encyclopedia', 'assets/flask.png'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute<void>(builder: (context) => joinAs()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.060,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color(0xff7c77d1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).Join_app,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
);
  }
}

class MyContainer extends StatelessWidget {
  final String label;
  final String image;

  const MyContainer(this.label, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        //color: Color(0xff7c77d1),
        gradient: LinearGradient(
          colors: [

            const Color(0xff7c77d1).withOpacity(0.6),
            const Color(0xff7c77d1).withOpacity(0.9),
            const Color(0xff7c77d1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 20),
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
    );
  }
}

class MyContainer2 extends StatelessWidget {
  final String label;
  final String image;

  const MyContainer2(this.label, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
           // color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 20),
          Text(
            label,
            style: const TextStyle(
              //  color: Color(0xff7c77d1),
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ],
      ),
    );
  }
}
