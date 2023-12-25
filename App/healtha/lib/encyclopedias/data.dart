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
    'Complete Blood Count (CBC)': [
      {'title': 'Why Get Tested?', 'content': 'To determine your general health status: to screen for, diagnose, or monitor any one of a variety of diseases and conditions that affect blood cells, such as anemia, infection, inflammation, bleeding disorder or cancer.'},
      {
        'title': 'When to Get Tested?',
        'content': 'As part of a routine medical exam; when you have signs and symptoms that may be related to a condition that affects blood cells; at regular intervals to monitor treatment or when you are receiving treatment known to affect blood cells.',
      },
      {
        'title': 'Sample Required',
        'content': 'A blood sample drawn from a vein in your arm or a fingerstick or heelstick (newborns).',
      },
      {
        'title': 'How is the test used?',
        'content': 'The complete blood count (CBC) is often used as a broad screening test to determine an individual\'s general health status. It can be used to:\n'
  '• Screen for a wide range of conditions and diseases \n'
      '• Help diagnose various conditions, such as anemia, infection, inflammation, bleeding disorder or leukemia, to name just a few\n'
      '• Monitor the condition and/or effectiveness of treatment after a diagnosis is established\n'
      '• Monitor treatment that is known to affect blood cells, such as chemotherapy or radiation therapy.',
      },

    ],
    // Add more diseases or lab tests as needed
  };

  static List<Map<String, String>> getDetails(String category) {
    // Simulate fetching details for a specific category from the database
    return _diseasesData[category] ?? [];
  }
}
