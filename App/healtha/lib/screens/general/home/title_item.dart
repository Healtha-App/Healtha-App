import 'package:flutter/material.dart';
import 'package:healtha/screens/doctor/all-doctors.dart';

import 'package:healtha/localization/generated/l10n.dart';

class TitleItem extends StatelessWidget {
  final String mainText;
  final VoidCallback onpressed;

  const TitleItem({super.key, required this.mainText, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            S.of(context).Top_Doctors,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Color(0xff161515),
            ),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllDoctors()),
            );
          },
          child: Text(
            S.of(context).See_All,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xff7c77d1),
            ),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
