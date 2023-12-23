class DiseaseDatabase {
  static Map<String, List<Map<String, String>>> _diseasesData = {
    'Disease1': [
      {'title': 'Overview', 'content': 'Brief overview of Disease1.'},
      {
        'title': 'Common Signs and Symptoms',
        'content': 'Common symptoms of Disease1 may include ... It is important to seek medical attention if symptoms worsen.',
      },
      {
        'title': 'Possible Causes',
        'content': 'Possible causes of Disease1 include ... Consult with a healthcare professional for accurate diagnosis.',
      },
      {
        'title': 'Medical Tests Needed',
        'content': 'Common medical tests for Disease1 include ... Consult with a healthcare professional for personalized advice.',
      },
      {
        'title': 'Treatment Procedures',
        'content': 'Treatment procedures for Disease1 may involve ... Consult with a healthcare professional for personalized advice.',
      },
    ],
    'Lab Test1': [
      {'title': 'Test Overview', 'content': 'Brief overview of LabTest1.'},
      {
        'title': 'Why and When to Get Tested?',
        'content': 'LabTest1 is recommended in situations like ... It is crucial to understand when and why you need this test.',
      },
      {
        'title': 'Test Preparations',
        'content': 'Before taking LabTest1, you need to ... Follow these preparations to ensure accurate results.',
      },
      {
        'title': 'What is Being Tested?',
        'content': 'LabTest1 examines ... It helps identify specific markers or conditions.',
      },
      {
        'title': 'What Does the Test Result Mean?',
        'content': 'Interpreting LabTest1 results involves ... Understand the implications of different outcomes.',
      },
      {
        'title': 'Anything Else to Know?',
        'content': 'Additional information about LabTest1 includes ... Stay informed for a better understanding.',
      },
    ],
    // Add more diseases or lab tests as needed
  };

  static List<Map<String, String>> getDetails(String category) {
    // Simulate fetching details for a specific category from the database
    return _diseasesData[category] ?? [];
  }
}
