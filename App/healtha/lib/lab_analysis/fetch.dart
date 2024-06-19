import 'dart:convert';
import 'package:healtha/generated/l10n.dart';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

// Reusable AiResultWidget with improved error handling
class AiResultWidget extends StatefulWidget {
  final String prompt;

  const AiResultWidget(this.prompt, {Key? key}) : super(key: key);

  @override
  _AiResultWidgetState createState() => _AiResultWidgetState();
}

class _AiResultWidgetState extends State<AiResultWidget> {
  Future<String> _fetchResult() async {
    try {
      // Implement logic to fetch data from your Python server here
      // based on your corrected approach (ensure server is running):
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/get_analysis'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'prompt': widget.prompt}), // Pass prompt in body
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['result'];
      } else {
        throw Exception('Failed to load data: Code ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error during request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchResult(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          );
        } else if (snapshot.hasError) {
          return Text(S.of(context).Error(snapshot.error!));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

// Improved main class with clear structure and explanation
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _prompt =
      "Write a user-friendly lab analysis report for..."; // Update with your desired prompt

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Flutter_AI_Integration),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Fetch result when button is pressed
                setState(() {}); // Rebuild to show loading indicator
              },
              child: Text(S.of(context).Fetch_AI_Result),
            ),
          ),
          const SizedBox(height: 20), // Vertical spacing
          // Display fetched result using the AiResultWidget
          AiResultWidget(_prompt),
        ],
      ),
    );
  }
}
