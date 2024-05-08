import 'package:http/http.dart' as http;
import 'dart:convert';

class SymtomServices {

  Future<String?> initSession() async {
  String url = 'https://api.endlessmedical.com/v1/dx/InitSession';
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data['SessionID'];
  } else {
    print('Error occurred: ${response.body}');
    return null;
  }
}

Future<bool> acceptTermsOfUse(String sessionID) async {
  String url = 'https://api.endlessmedical.com/v1/dx/AcceptTermsOfUse';
  String passphrase =
      'I have read, understood and I accept and agree to comply with the Terms of Use of EndlessMedicalAPI and Endless Medical services. The Terms of Use are available on endlessmedical.com';
  http.Response response = await http.post(
    Uri.parse('$url?SessionID=$sessionID&passphrase=$passphrase'),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    print(data);
    return data['status'] == 'ok';
  } else {
    print('Error occurred: ${response.body}');
    return false;
  }
}

Future<bool> updateFeature(String sessionID, String featureName, String featureValue) async {
  String url = 'https://api.endlessmedical.com/v1/dx/UpdateFeature';
  http.Response response = await http.post(
    Uri.parse('$url?SessionID=$sessionID&name=$featureName&value=$featureValue'),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data['status'] == 'ok';
  } else {
    print('Error occurred: ${response.body}');
    return false;
  }
}

Future<Map<String, dynamic>?> analyzeFeatures(String sessionID) async {
  String url = 'https://api.endlessmedical.com/v1/dx/Analyze';
  http.Response response = await http.post(
    Uri.parse('$url?SessionID=$sessionID'),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print('Error occurred: ${response.body}');
    return null;
  }
}

}