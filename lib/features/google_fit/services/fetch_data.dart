// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class SymptomsPage extends StatefulWidget {
//   static const String routeName = '/symptom';
  
//   const SymptomsPage({super.key});

//   @override
//   State<SymptomsPage> createState() => _SymptomsPageState();
// }

// class _SymptomsPageState extends State<SymptomsPage> {
//     Map<String, dynamic>? selectedSymptom;

//   List<Map<String, dynamic>> symptoms = [];

//   TextEditingController searchController = TextEditingController();
//   List<Map<String, dynamic>> filteredSymptoms = [];

//   @override
//   void initState() {
//     super.initState();
//     loadSymptoms();
//   }

//    Future<void> loadSymptoms() async {
//     // Load symptom data from JSON file
//     String data = await DefaultAssetBundle.of(context)
//         .loadString('assets/symptoms.json');
//     List<dynamic> jsonList = json.decode(data);
//     setState(() {
//       symptoms = jsonList.cast<Map<String, dynamic>>();
//       filteredSymptoms = List.from(symptoms);
//     });
//   }

//    @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Select Symptoms'),
//     ),
//     body: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: searchController,
//             decoration: InputDecoration(
//               labelText: 'Search Symptoms',
//               border: OutlineInputBorder(),
//             ),
//             onChanged: (value) {
//               setState(() {});
//             },
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: symptoms.length,
//             itemBuilder: (context, index) {
//               final symptom = symptoms[index];
//               final searchText = searchController.text.toLowerCase();
//               final symptomText = symptom['text'].toLowerCase();
//               final isMatch = searchText.isEmpty || symptomText.contains(searchText);
//               return isMatch
//                   ? ListTile(
//                       title: Text(symptom['text']),
//                       onTap: () {
//                         setState(() {
//                           selectedSymptom = symptom;
//                         });
//                       },
//                     )
//                   : SizedBox.shrink();
//             },
//           ),
//         ),
//         if (selectedSymptom != null) ...[
//           ListTile(
//             title: Text(selectedSymptom!['text']),
//             subtitle: _buildInputField(selectedSymptom!),
//           ),
//           ElevatedButton(
//             onPressed: () {
              
//             },
//             child: Text('Add Symptom'),
//           ),
//         ],
//       ],
//     ),
//   );
// }

//   Widget _buildInputField(Map<String, dynamic> symptom) {
//   if (symptom['type'] == 'categorical') {
//     List<dynamic> choices = symptom['choices'];
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[200], // Change background color as needed
//         borderRadius: BorderRadius.circular(8.0), // Optional: Add rounded corners
//       ),
//       child: DropdownButtonFormField(
//         items: choices.map<DropdownMenuItem<dynamic>>((choice) {
//           return DropdownMenuItem<dynamic>(
//             value: choice['value'],
//             child: Text(choice['text']),
//           );
//         }).toList(),
//         onChanged: (value) {
//           // Handle symptom value selection
//           // You can store the selected value in a variable or state
//         },
//       ),
//     );
//   } else {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[200], // Change background color as needed
//         borderRadius: BorderRadius.circular(8.0), // Optional: Add rounded corners
//       ),
//       child: TextFormField(
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           labelText: 'Enter value',
//           border: InputBorder.none, // Remove border
//         ),
//         onChanged: (value) {
//           // Handle input value
//           // You can store the entered value in a variable or state
//         },
//       ),
//     );
//   }
// }
// }