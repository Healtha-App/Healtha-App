import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiseaseTest extends StatefulWidget {
  @override
  _DiseaseTestState createState() => _DiseaseTestState();
}

class _DiseaseTestState extends State<DiseaseTest> {
  List<bool> selectedSymptoms = List.generate(132, (index) => false); // Assuming 132 symptoms
  String predictedDisease = '';
  List<String> allSymptoms = []; // Store all symptoms from the dataset

  @override
  void initState() {
    super.initState();
    // Fetch all symptoms from the server
    _fetchAllSymptoms();
  }

  Future<void> _fetchAllSymptoms() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.56.1:5000/all_symptoms'));

      if (response.statusCode == 200) {
        setState(() {
          allSymptoms = response.body.split(','); // Assuming the server returns a comma-separated string
        });
      } else {
        print('Failed to fetch all symptoms. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _predictDisease(BuildContext context) async {
    List<String> inputSymptoms = [];

    for (int i = 0; i < selectedSymptoms.length; i++) {
      if (selectedSymptoms[i]) {
        inputSymptoms.add(allSymptoms[i]);
      }
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:5000/predict'),
        body: {'symptoms': inputSymptoms.join(',')},
      );

      setState(() {
        predictedDisease = response.body;
      });

      // Show the predicted disease in a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Predicted Disease'),
            content: Text('Predicted Disease: $predictedDisease'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Prediction'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Symptoms:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Display all symptoms from the dataset in checkboxes
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: allSymptoms
                  .asMap()
                  .entries
                  .map(
                    (entry) => CheckboxListTile(
                  title: Text(entry.value),
                  value: selectedSymptoms[entry.key],
                  onChanged: (value) {
                    setState(() {
                      selectedSymptoms[entry.key] = value!;
                    });
                  },
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _predictDisease(context);
              },
              child: Text('Predict'),
            ),
          ],
        ),
      ),
    );
  }
}
