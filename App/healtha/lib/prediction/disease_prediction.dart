import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


bool isExpanded = false;

bool checkboxValue1= false;
bool checkboxValue2 = false;
bool checkboxValue3 = false;
bool checkboxValue4 = false;
bool _isEnabled = true;
bool showAfterAnimation= false;



class disease extends StatefulWidget {
  const disease({Key? key}) : super(key: key);


  @override
  State<disease> createState() => _diseaseState();
}

class _diseaseState extends State<disease> {
  static const Color myPurple = Color(0xff7c77d1);

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body:   SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: myPurple,
                    borderRadius: BorderRadius.only(
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
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: myPurple,
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
                          "Your healtha our periority!",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: myPurple,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Disease prediction made easy ",textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60,),


            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  Text('what are you feeling?',textAlign: TextAlign.start, style:
                  TextStyle(fontSize: 18
                      ,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
        SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(12),
                          width: 90,
                          height: 40,
                          child:  Image(image: AssetImage("assets/mental-health.png")),
                        ),
                        Text('Mental symptoms',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:myPurple,
                        ),),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Icon(
                              isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ],
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
                  if (isExpanded)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CheckboxListTile(
                              value: checkboxValue1,
                              onChanged: (bool? value) {
                                setState(() {

                                  checkboxValue1 = value!;
                                });
                              },
                              activeColor: Colors.black, // Change the checkbox color when checked
                              checkColor: Colors.white, // Change the checkmark color
                              title:  Text("Depression and Vitamin D Deficiency",style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                fontSize: 16
                              ),),
                              subtitle:  Text('\nSymptom: Persistent low mood, fatigue, lack of motivation',style: TextStyle(
                                fontSize: 14
                              ),),
                            ),
                          ),
                          Divider(height: 10,thickness: 1,),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CheckboxListTile(
                              value: checkboxValue2,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkboxValue2 = value!;
                                });
                              },
                              activeColor: Colors.black, // Change the checkbox color when checked
                              checkColor: Colors.white, //
                              title: const Text('Anxiety and Hypoglycemia',style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                              ),),
                              subtitle: const Text(
                                  '\nSymptom: Excessive worry, racing thoughts, dizziness, shakiness',style: TextStyle(
                                  fontSize: 14
                              ),),
                            ),
                          ),
                          Divider(height: 10,thickness: 1,),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CheckboxListTile(
                              value: checkboxValue3,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkboxValue3 = value!;
                                });
                              },
                              activeColor: Colors.black, // Change the checkbox color when checked
                              checkColor: Colors.white, //
                              title: const Text('Mania and Thyroid Hormone Levels',style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                              ),),
                              subtitle: const Text(
                                  "\nSymptom: Elevated mood, hyperactivity, "
                                      "racing thoughts, impulsivity",style: TextStyle(
                                  fontSize: 14
                              ),),
                              isThreeLine: true,
                            ),
                          ),
                          Divider(height: 10,thickness: 1,),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CheckboxListTile(
                              value: checkboxValue4,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkboxValue4 = value!;
                                });
                              },
                              activeColor: Colors.black, // Change the checkbox color when checked
                              checkColor: Colors.white, //
                              title: const Text('Cognitive Decline and Dementia',style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                              ),),
                              subtitle: const Text(
                                  "\nSymptom: Memory problems, confusion, difficulty with "
                                      "thinking and reasoning",style: TextStyle(
                                  fontSize: 14
                              ),),
                              isThreeLine: true,
                            ),
                          ),
                          Divider(height: 10,thickness: 1,),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(12),
                          width: 90,
                          height: 40,
                          child:  Image(image: AssetImage("assets/specification.png")),
                        ),
                        Text('Physical symptoms',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: myPurple,
                        ),),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Icon(
                            isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                            size: 32.0,
                          ),
                        ),
                      ],
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


                ],
              ),
            ),

          SizedBox(height: 20,),

            if (_isEnabled == false)
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    """Your healtha report is being generated with care...
        
We will notify you as soon as it is ready

Thank you for allowing us the time to ensure accuracy!""",
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    // textStyle: TextStyle(fontSize: 30.0),
                    speed: Duration(milliseconds: 40),
                  ),
                ],
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
                //pause: const Duration(milliseconds: 500),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
                repeatForever: false,
                onFinished: () {
                  setState(() {
                    // Update state to show the widget after finishing the animation
                    showAfterAnimation = true;
                  });
                },


              ),
           Container(
             width: double.infinity,
             height: 300,
             child: Padding(
               padding: const EdgeInsets.all(100.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ElevatedButton(
                     onPressed: _isEnabled
                         ? () {
                       setState(() {
                         _isEnabled = false;
                       });
                     }
                         : null,
                     child: Text('Generate'),
                     style: ButtonStyle(
                       //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                         RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                       ),
                       foregroundColor: MaterialStateProperty.all(
                           _isEnabled ? Colors.white : Color(0xff7c77d1).withOpacity(0)),
                       backgroundColor: MaterialStateProperty.all(
                           _isEnabled ? Color(0xff7c77d1) : Color(0xff7c77d1).withOpacity(0)),
                     ),
                   ),
                 ],
               ),
             ),
           )
          ],
        ),
      ),
    );
  }



  Widget checkbox(){
    return Container(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              value: checkboxValue1,
              onChanged: (bool? value) {
                setState(() {

                  checkboxValue1 = value!;
                });
              },
              activeColor: myPurple, // Change the checkbox color when checked
              checkColor: Colors.white, // Change the checkmark color
              title:  Text("Depression and Vitamin D Deficiency",style: TextStyle(
                  fontWeight: FontWeight.w600
              ),),
              subtitle:  Text('\nSymptom: Persistent low mood, fatigue, lack of motivation'),
            ),
            Divider(height: 3),
            CheckboxListTile(
              value: checkboxValue2,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue2 = value!;
                });
              },
              activeColor: Colors.black, // Change the checkbox color when checked
              checkColor: Colors.white, //
              title: const Text('Anxiety and Hypoglycemia',style: TextStyle(
                  fontWeight: FontWeight.w600
              ),),
              subtitle: const Text(
                  '\nSymptom: Excessive worry, racing thoughts, dizziness, shakiness'),
            ),
            Divider(height: 3),
            CheckboxListTile(
              value: checkboxValue3,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue3 = value!;
                });
              },
              activeColor: Colors.black, // Change the checkbox color when checked
              checkColor: Colors.white, //
              title: const Text('Mania and Thyroid Hormone Levels',style: TextStyle(
                  fontWeight: FontWeight.w600
              ),),
              subtitle: const Text(
                  "\nSymptom: Elevated mood, hyperactivity, "
                      "racing thoughts, impulsivity"),
              isThreeLine: true,
            ),
            Divider(height: 3),
            CheckboxListTile(
              value: checkboxValue4,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue4 = value!;
                });
              },
              activeColor: Colors.black, // Change the checkbox color when checked
              checkColor: Colors.white, //
              title: const Text('Cognitive Decline and Dementia',style: TextStyle(
                fontWeight: FontWeight.w600
              ),),
              subtitle: const Text(
                  "\nSymptom: Memory problems, confusion, difficulty with "
                      "thinking and reasoning"),
              isThreeLine: true,
            ),
            Divider(height: 3),
          ],
        ),
      ),
      decoration: BoxDecoration(
       color: Colors.white,

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: myPurple,


             //  changes position of shadow
          ),
       ],
      ),
    );
  }



}


class header{
  String? symptoms;
  header({this.symptoms});
}
List<header> items=[
  header(
      symptoms:'Mental symptoms'
  ),
  header(
      symptoms:'Physical symptoms'
  )
];









class box{
  String? txt1;
  String? txt2;
  box({this.txt1,this.txt2});
}

List<box> items2=[
  box(
      txt1:"Depression and Vitamin D Deficiency",
    txt2: '\nSymptom: Persistent low mood, fatigue, lack of motivation'
  ),
  box(
      txt1:"Anxiety and Hypoglycemia",
      txt2:  '\nSymptom: Excessive worry, racing thoughts, dizziness, shakiness'
  ),
  box(
      txt1:"Mania and Thyroid Hormone Levels",
      txt2:  "\nSymptom: Elevated mood, hyperactivity, "
          "racing thoughts, impulsivity"
  ),

];

/*    Expanded(
        child: Container(
          width: double.infinity,
          height: 120,
          padding: EdgeInsets.all(6.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 90,
                      height: 60,
                      child:  Image(image: AssetImage("images/mental-health.png")),
                    ),

                    Text('Mental symptoms',style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      color: Color(0xff7c77d1),
                    ),),
                    GestureDetector(
                      onTap: toggleExpanded,
                      child: Icon(
                        isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        size: 50.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: isExpanded ? 380.0 : 0.0,
                  width: double.infinity,
                  color: Colors.white,
                  child: isExpanded
                      ? Center(
                    child: checkbox()
                  )
                      : null,
                ),

              ],
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
      ),*/