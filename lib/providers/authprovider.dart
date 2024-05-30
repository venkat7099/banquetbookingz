import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:banquetbookingz/models/authstate.dart';

import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class AuthNotifier extends StateNotifier<AdminAuth> {
  AuthNotifier() : super(AdminAuth());
Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('userData')) {
   final extractData =
    json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
if(state.token==null){
  state = state.copyWith(
  token: extractData['token'],
  username: extractData['username'],
  email: extractData['email'],
  mobileno: extractData['mobileno'],
  usertype: extractData['usertype'],
);
}

  
    return true;
}else{  print('trylogin is false');
      return false;}
   
    // final extractData =
    //     json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

    //     state = state.copyWith(
    //          data: state.data?.copyWith(accessToken: extractData['access_token'], refreshToken: extractData['refresh_token'],
    //          id: extractData['id'],profilePic: extractData['profilePic'],userRole: extractData['userRole'],
    //          emailId: extractData['emailId'],password: extractData['password']),
            
    //       );

          // print('email:${extractData['emailId']}');
    // Check if 'isLoggedIn' key exists and if so, return its value
   
  }
  //
  String generateRandomLetters(int length) {
    var random = Random();
    var letters = List.generate(length, (_) => random.nextInt(26) + 97);
    return String.fromCharCodes(letters);
  }

  Future<LoginResult> adminLogin(
      String username, String password, WidgetRef ref) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
    String? errorMessage;
    try {
      loadingState.state = true;
      var response = await http.post(Uri.parse(Api.login),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'username': username, 'password': password}));

      var userDetails = json.decode(response.body);
      var statuscode = response.statusCode;
      print('$statuscode');
      print('$username');
      print('$password');
      responseCode = statuscode;
      print('server response:$userDetails');
      // switch (response.statusCode) {
      //   case 201:
      //     state = authState.fromJson(userDetails);
      //     loadingState.state = false;

      //     //print('this is from Auth response is:$accessToken');

      //     final prefs = await SharedPreferences.getInstance();
      //     final userData = json.encode({
      //       'id':userDetails['data']['id'],
      //       'profilepic':userDetails['data']['profilePic'],
      //       'refreshToken': userDetails['data']['refresh_token'],
      //       'accessToken': userDetails['data']['access_token'],
      //       'firstName': userDetails['data'][''],
      //       'userRole': userDetails['data']['userRole'],
      //       'password': userDetails['data']['password'],
      //       'emailId':userDetails['data']['emailId']
      //     });

      //     //autologout();

      //     await prefs.setString('userData', userData);
      
      //     break;
      //   default:
      //     if (statuscode != 201) {
      //       loadingState.state = false;
      //     }
      //     // Optionally set a message to show to the user why the login failed
      //     break;
      // }
      if (statuscode == 200) {
        
          loadingState.state = false;
        state = AdminAuth.fromJson(userDetails);
          //print('this is from Auth response is:$accessToken');

         final prefs = await SharedPreferences.getInstance();
print("SharedPreferences fetched successfully");
           
           state=state.copyWith(token:userDetails['token'],username:userDetails['username'],email: userDetails['email'],mobileno: userDetails['mobileno'],usertype: userDetails['usertype'] );

          final userData = json.encode({
            'token':userDetails['token'],
            'username':userDetails['username'],
            'email': userDetails['email'],
            'mobileno':userDetails['mobileno'],
            
            'usertype': userDetails['usertype'],
         
          });

          //autologout();

          bool saveResult = await prefs.setString('userData', userData);
      if (!saveResult) {
        print("Failed to save user data to SharedPreferences.");
      }

      // Assuming `state` and `authState` are part of your state management. 
      // Update them as necessary.
      
      }
      
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("cathe:$errorMessage");
    }
    return LoginResult(responseCode, errorMessage: errorMessage);
  }
Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    await prefs.setBool('isLoggedIn', false);
  }


  

  
}

final authProvider = StateNotifierProvider<AuthNotifier, AdminAuth>((ref) {
  return AuthNotifier();
});

class LoginResult {
  final int statusCode;
  final String? errorMessage;

  LoginResult(this.statusCode, {this.errorMessage});
}
