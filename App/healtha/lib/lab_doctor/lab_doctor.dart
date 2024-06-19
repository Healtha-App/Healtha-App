import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtha/generated/l10n.dart';

class laboratory extends StatefulWidget {
  const laboratory({Key? key}) : super(key: key);

  @override
  State<laboratory> createState() => _laboratoryState();
}

Color myPurple = const Color(0xff7c77d1);

class _laboratoryState extends State<laboratory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: myPurple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: 520,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    //SizedBox(height: 5,),
                    Container(
                      // width: double.infinity,
                      height: 500,
                      margin: const EdgeInsets.all(6),
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            item(types[index], context),
                        //separatorBuilder: (context,index)=>SizedBox(height: 20,)
                        itemCount: types.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Padding(
        //   padding:   EdgeInsets.all(10.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       SizedBox(height: 130,),
        //       CircleAvatar(
        //         backgroundImage: AssetImage("assets/health-checkup.gif"),
        //         radius: 30,
        //       ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                S.of(context).Dear_lab_doctor,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: 'Merriweather'),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                S
                    .of(context)
                    .Please_take_the_time_to_revise_the_reports_thoroughly,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white70,
                    fontFamily: 'Merriweather'),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

Widget item(labs l, contxet) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: myPurple.withOpacity(0.30),
            spreadRadius: 3,
            blurRadius: 9,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${l.txt}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle button press to view the lab
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    myPurple), // Change this color
                textStyle: WidgetStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 18)),
                // Add more styles as needed
              ),
              child: Text(
                S.of(contxet).View_report,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Merriweather',
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class labs {
  String? txt;
  labs({this.txt});
}

List<labs> types = [
  labs(txt: "Blood Tests"),
  labs(txt: "Imaging Tests"),
  labs(txt: "Cardiac Tests"),
  labs(txt: "Respiratory Tests"),
  labs(txt: "Gastrointestinal Tests"),
  labs(txt: "Genetic Tests"),
];
