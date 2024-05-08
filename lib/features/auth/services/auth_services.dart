import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medihub/constants/error_handler.dart';
import 'package:medihub/constants/utils.dart';
import 'package:medihub/features/home/screens/home1.dart';
import 'package:medihub/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:medihub/providers/user_provider.dart';
import 'package:medihub/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {

  void signUp({
    required BuildContext context,
    required name,
    required email,
    required password
  }) async {
    
      try{

        User user = User(
          id : '',
          name : name ,
          email : email ,
          password : password,
          address : '',
          type : '',
          token : '',
          cart : []
        );

        http.Response response =  await http.post(Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        );

        httpErrorHanlder(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account Created! Login.');
        },
      );

        // print(response.body);

      }catch(e){

        print(e.toString());
        
      }
  }


      void signIn({
        required BuildContext context,
        required email,
        required  password,
      }) async{

        try{

           http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // print(response.body);

       httpErrorHanlder(
        response: response,
        context: context,
        onSuccess: () async {
          final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final userData = responseData;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false)
              .setUser(User.fromMap(userData));
          await prefs.setString(
              'x-auth-token', jsonDecode(response.body)['token']);
          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Home1(), // Replace HomeScreen with your home screen
                              ),
                            );
        },
      );

        }catch(e){


        }

      }

  
}