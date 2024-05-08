import 'package:flutter/material.dart';
import 'package:medihub/features/syptom_checker/services/symptom_services.dart';

class AnalyzeSymptom extends StatefulWidget {
  static const String routeName = '/analyze';
  final String name ;
  final String value;
  const AnalyzeSymptom({super.key,required this.name,required this.value});

  @override
  State<AnalyzeSymptom> createState() => _AnalyzeSymptomState();
}

class _AnalyzeSymptomState extends State<AnalyzeSymptom> {

  @override
  void initState() {
    super.initState();
    check_symptoms(widget.name, widget.value);
  }

  final SymtomServices symtomServices = SymtomServices();

  void check_symptoms(String featureName, String value) async{

    String? sessionID = await symtomServices.initSession();
  if (sessionID != null) {
    print('SessionID: $sessionID');
    bool termsAccepted = await symtomServices.acceptTermsOfUse(sessionID);
    if (termsAccepted) {
      print('Terms of use accepted successfully');
      bool featureUpdated = await symtomServices.updateFeature(sessionID, 'feature_name', 'feature_value');
      if (featureUpdated) {
        print('Feature updated successfully');
        Map<String, dynamic>? analysisResult = await symtomServices.analyzeFeatures(sessionID);
        if (analysisResult != null) {
          print('Analysis Result:');
          print(analysisResult);
        } else {
          print('Failed to analyze features');
        }
      } else {
        print('Failed to update feature');
      }
    } else {
      print('Failed to accept terms of use');
    }
  } else {
    print('Failed to initialize session');
  }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Analysis"),),
      body : Text('${widget.name}: ${widget.value}'),
    );
  }
}