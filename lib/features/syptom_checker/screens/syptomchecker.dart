import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medihub/features/syptom_checker/screens/symptom_analyze.dart';

class SymptomsPage extends StatefulWidget {
  static const String routeName = '/symptom';

  const SymptomsPage({Key? key});

  @override
  State<SymptomsPage> createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  Map<String, dynamic>? selectedSymptom;
  List<Map<String, dynamic>> symptoms = [];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredSymptoms = [];
  List<Map<String, dynamic>> selectedSymptoms = [];

  @override
  void initState() {
    super.initState();
    loadSymptoms();
  }

  Future<void> loadSymptoms() async {
    // Load symptom data from JSON file
    String data =
        await DefaultAssetBundle.of(context).loadString('assets/symptoms.json');
    List<dynamic> jsonList = json.decode(data);
    setState(() {
      symptoms = jsonList.cast<Map<String, dynamic>>();
      filteredSymptoms = List.from(symptoms);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Symptoms'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Symptoms',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                final symptom = symptoms[index];
                final searchText = searchController.text.toLowerCase();
                final symptomText = symptom['text'].toLowerCase();
                final isMatch =
                    searchText.isEmpty || symptomText.contains(searchText);
                return isMatch
                    ? ListTile(
                        title: Text(symptom['text']),
                        onTap: () {
                          setState(() {
                            selectedSymptom = symptom;
                          });
                        },
                      )
                    : SizedBox.shrink();
              },
            ),
          ),
          if (selectedSymptom != null) ...[
            ListTile(
              title: Text(selectedSymptom!['text']),
              subtitle: _buildInputField(selectedSymptom!),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedSymptoms.add(selectedSymptom!);
                  selectedSymptom = null;
                });
              },
              child: Text('Add Symptom'),
            ),
          ],
          if (selectedSymptoms.isNotEmpty) ...[
            Divider(),
            Text(
              'Selected Symptoms:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedSymptoms
                  .map(
                    (symptom) => ListTile(
                      title: Text(symptom['text']),
                      subtitle: Text(
                        'Selected Choice: ${_getSelectedChoiceText(symptom)}',
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _analyzeSymptoms,
              child: Text('Analyze Symptoms'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputField(Map<String, dynamic> symptom) {
    if (symptom['type'] == 'categorical') {
      List<dynamic> choices = symptom['choices'];
      return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropdownButtonFormField(
          value: symptom['value'], // Set the value
          items: choices.map<DropdownMenuItem<dynamic>>((choice) {
            return DropdownMenuItem<dynamic>(
              value: choice['value'],
              child: Text(choice['text']),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              symptom['value'] = value; // Update the selected value
            });
          },
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Enter value',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Handle input value
            // You can store the entered value in a variable or state
          },
        ),
      );
    }
  }

  String _getSelectedChoiceText(Map<String, dynamic> symptom) {
    List<dynamic> choices = symptom['choices'];
    dynamic selectedValue = symptom['value'];
    for (var choice in choices) {
      if (choice['value'] == selectedValue) {
        return choice['text'];
      }
    }
    return '';
  }

 void _analyzeSymptoms() {
  for (var symptom in selectedSymptoms) {
    dynamic symptomName = symptom['name']; // Change to dynamic
    dynamic symptomValue = symptom['value']; // Change to dynamic
    print('Name: $symptomName, Value: $symptomValue');

    // Navigate to AnalyzeSymptom for each symptom
    Navigator.pushNamed(
      context,
      AnalyzeSymptom.routeName,
      arguments: {
        'name': symptomName.toString(), // Ensure conversion to String
        'value': symptomValue.toString(), // Ensure conversion to String
      },
    );
  }
}



}
