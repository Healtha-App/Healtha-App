import 'package:flutter/material.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'headerContainer.dart';
import 'profile.dart';
import 'customTextField.dart';

class editPage extends StatelessWidget {
  const editPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        },
        backgroundColor: const Color(0xff7c77d1),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: HeaderCurvedContainer(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  /* child: Text(
                    S.of(context).Profile,
                    style: TextStyle(
                      fontSize: 35.0,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),*/
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/girl.PNG"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: 170,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: S.of(context).Enter_your_Name,
                        hintStyle: const TextStyle(
                            fontSize: 15, color: Colors.black54),
                      ),
                    )),
                const SizedBox(height: 10),
                SizedBox(
                    width: 170,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: S.of(context).Patient_Doctor,
                        hintStyle: const TextStyle(
                            fontSize: 15, color: Colors.black54),
                      ),
                    )),
                customTextField(
                  type: TextInputType.emailAddress,
                  hint: S.of(context).Enter_your_email,
                ),
                const SizedBox(height: 15),
                customTextField(
                  type: TextInputType.number,
                  hint: S.of(context).Enter_your_Phone_Number,
                ),
                const SizedBox(height: 15),
                customTextField(
                  type: TextInputType.text,
                  hint: S.of(context).Enter_your_Address,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
