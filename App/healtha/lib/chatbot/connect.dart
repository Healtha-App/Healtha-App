// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class APIKey {
//   static const apiKey =
//       "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";
// }
//
// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _textEditingController = TextEditingController();
//   final List<Message> _messages = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff7c77d1),
//         title: Row(
//           children: [
//             Image.asset(
//               'images/healtha1.png',
//               color: Colors.white,
//               width: 50.0,
//               height: 50.0,
//             ),
//             SizedBox(width: 10.0),
//             Text(
//               'Healtha',
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 80),
//         children: _messages.map((message) => _buildMessage(message)).toList(),
//       ),
//       bottomSheet: _buildBottomSheet(),
//     );
//   }
//
//   Widget _buildBottomSheet() {
//     return Container(
//       height: 65,
//       decoration: BoxDecoration(color: Colors.white, boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 2,
//           blurRadius: 10,
//           offset: Offset(0, 3),
//         ),
//       ]),
//       child: Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 8),
//             child: Icon(
//               Icons.add,
//               size: 30,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 5),
//             child: Icon(
//               Icons.emoji_emotions_outlined,
//               size: 30,
//               color: Color(0xff7c77d1),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 10),
//             child: Container(
//               alignment: Alignment.centerRight,
//               width: 230,
//               child: TextFormField(
//                 controller: _textEditingController,
//                 decoration: InputDecoration(
//                   hintText: "Type something",
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           Spacer(),
//           Padding(
//             padding: EdgeInsets.only(right: 10),
//             child: IconButton(
//               icon: Icon(
//                 Icons.send,
//                 size: 30,
//                 color: Color(0xff7c77d1),
//               ),
//               onPressed: () async {
//                 if (_textEditingController.text.isNotEmpty) {
//                   await _sendMessage(_textEditingController.text);
//                   _textEditingController.clear();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessage(Message message) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               message.sender,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               message.text,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _sendMessage(String text) async {
//     Message userMessage = Message(sender: 'You', text: text);
//     setState(() {
//       _messages.add(userMessage);
//     });
//
//     try {
//       String response = await sendMessageToChatGpt(userMessage);
//       Message chatGptMessage = Message(sender: 'Healtha', text: response);
//       setState(() {
//         _messages.add(chatGptMessage);
//       });
//     } catch (e) {
//       print('Error: $e');
//       // Handle the error appropriately, e.g., show a snackbar
//     }
//   }
//
//   Future<String> sendMessageToChatGpt(Message message) async {
//     final uri = Uri.parse("https://api.openai.com/v1/chat/completions");
//     final body = {
//       "model": "gpt-3.5-turbo",
//       "messages": [
//         {"role": message.sender, "content": message.text}
//       ],
//       "max_tokens": 500,
//     };
//
//     try {
//       final response = await http.post(
//         uri,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer ${APIKey.apiKey}",
//         },
//         body: json.encode(body),
//       );
//
//       if (response.statusCode == 200) {
//         Map<String, dynamic> parsedResponse = json.decode(response.body);
//         return parsedResponse['choices'][0]['message']['content'];
//       } else {
//         throw Exception(
//             'Failed to send message to ChatGPT. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to send message to ChatGPT. Error: $e');
//     }
//   }
// }
//
// class Message {
//   final String sender;
//   final String text;
//
//   Message({required this.sender, required this.text});
// }
