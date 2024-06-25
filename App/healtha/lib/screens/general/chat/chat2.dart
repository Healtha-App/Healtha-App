import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/screens/doctor/doc-profile.dart';

class DoctorChat extends StatefulWidget {
  @override
  _DoctorChatState createState() => _DoctorChatState();
}

class _DoctorChatState extends State<DoctorChat> {
  List<ChatMessage> messages = [
    ChatMessage(text: 'السلام عليكم, ازي حضرتك ي دكتور ايمان اتمني تكوني بخير', isUser: true),
    ChatMessage(text: 'وعليكم السلام الحمد لله خير', isUser: false),
    ChatMessage(text: 'كنت عاوزة اسأل حضرتك عن حاجة يعني استشارة طبية سريعة', isUser: true),
    ChatMessage(text: 'طبعا اتفضلي', isUser: false),
    ChatMessage(text: 'بالنسبة للتحاليل الي حضرتك قولتلي عليها انا عرفت من ابليكيشن هيلثا دا انه تمام مفيش حاجة فهل دا صحيح؟', isUser: true),
    ChatMessage(text: 'ايوا فعلا الحمد لله تحاليلك كويسة ومفيهاش حاجة وانا الي عاملة ال confirmation بنفسي', isUser: false),
    ChatMessage(text: 'طيب الحمد لله رأيك اعمل ايه دلوقتي ي دكتور', isUser: true),
    ChatMessage(text: 'هكتبلك بس علي شوية فيتامينات ومقويات ومتقلقيش كله هيبقي تمام', isUser: false),
    ChatMessage(text: 'طيب اقدر اجي ازور حضرتك امتي', isUser: true),
    ChatMessage(text: 'نفس مواعيد العبادة كلمي الاسيستانت تحجزي معاه', isUser: false),
    ChatMessage(text: 'تمام هبقي اجي لحضرتك ', isUser: true),
    ChatMessage(text: 'طيب اقدر ابقي استشير حضرتك هنا لو استشارة خفيفة؟', isUser: true),
    ChatMessage(text: 'اه طبعا مفيش مشكلة', isUser: false),
  ];

  TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      messages.add(ChatMessage(text: text, isUser: true)); // شكرا جدا لحضرتك ي دكتور
      // Simulating a response from Healtha
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          messages.add(ChatMessage(text: "العفو, علي الرحب", isUser: false));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7c77d1),
        title: Row(
          children: [
            ClipOval(
              child: Image.asset('assets/doctor1.png', height: 40, width: 40, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10.0),
            Text(
              "Dr. Eman",
              style: GoogleFonts.dancingScript(
                textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => drProfile()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 80,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type something',
                      border: InputBorder.none,
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _handleSubmitted(_textController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: message.isUser ? Color(0xff7c77d1) : Color(0xffEFEAFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: message.isUser ? Radius.circular(20) : Radius.circular(0),
            bottomRight: message.isUser ? Radius.circular(0) : Radius.circular(20),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
