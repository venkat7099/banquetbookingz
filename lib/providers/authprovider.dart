import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:banquetbookingz/models/authstate.dart';
import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class AuthNotifier extends StateNotifier<authState> {
  AuthNotifier() : super(authState());

  // Future<bool> tryAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('userData')) {
  //     print('trylogin is false');
  //     return false;
  //   }

  //   final extractData =
  //       json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
  //   final profile = prefs.getBool('profile') ?? false;
  //   final expiryDate = DateTime.parse(extractData['refreshExpiry']);
  //   final accessExpiry = DateTime.parse(extractData['accessTokenExpiry']);
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
          body: json.encode({'email': username, 'password': password}));

      var userDetails = json.decode(response.body);
      var statuscode = response.statusCode;
      print('$statuscode');
      responseCode = statuscode;
      print('server response:$userDetails');
      switch (response.statusCode) {
        case 201:
          state = authState.fromJson(userDetails);
          loadingState.state = false;

          //print('this is from Auth response is:$accessToken');

          final prefs = await SharedPreferences.getInstance();
          final userData = json.encode({
            'refreshToken': userDetails['data']['refresh_token'],
            'accessToken': userDetails['data']['access_token'],
            'firstName': userDetails['data'][''],
            'userRole': userDetails['data']['userRole'],
            'password': userDetails['data']['password']
          });

          //autologout();

          await prefs.setString('userData', userData);
          await prefs.setBool('isLoggedIn', true);
          break;
        default:
          if (statuscode != 201) {
            loadingState.state = false;
          }
          // Optionally set a message to show to the user why the login failed
          break;
      }
      if (statuscode == 201) {
        // Handle successful login...
      } else {
        // Any other status code means something went wrong
        // Extract error message from response
        // Assuming 'messages' is a List of messages and we take the first one.
        errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';
        // Alternatively, if 'message' is a single String with the error message:
        // errorMessage = responseJson['message'];
      }
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("cathe:$errorMessage");
    }
    return LoginResult(responseCode, errorMessage: errorMessage);
  }

Future<LoginResult> addUser(XFile imageFile, String firstName, String emailId,String gender,String?password,WidgetRef ref) async {
    var uri = Uri.parse(Api.addUser);
    final loadingState = ref.watch(loadingProvider.notifier);
    String generateLetters = generateRandomLetters(10);
    int responseCode = 0;
    String? errorMessage;

   final data={};
  data["firstName"]=firstName;
  data["emailId"]=emailId;
  data["gender"]=gender;
  data["userRole"]="m";
  data["profilepic"]="profile_$generateLetters";
  data["password"]=password;
  // Add the encoded JSON string to your request fields.
  try{
    loadingState.state=true;
var request = http.MultipartRequest('POST', uri);
  // Add the image file to your request.
  request.files.add(await http.MultipartFile.fromPath('imagefile[]', imageFile.path));

    
      Map<String, String> obj = {"attributes": json.encode(data).toString()};
    request.fields.addAll(obj);
    final send = await request.send();
    final res = await http.Response.fromStream(send);
    var userDetails=json.decode(res.body);
    var statuscode = res.statusCode;
    responseCode=statuscode;
    print("statuscode:$statuscode");
    print("responsebody:${res.body}");
    if (statuscode == 201) {
      loadingState.state=false;
    }
     errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';
    } catch (e) {
      // state = AsyncValue.error('Error occurred: $e');
      var errorMessage = e.toString();
      print("cathe:$errorMessage");
         loadingState.state=false;
    }
    return LoginResult(responseCode, errorMessage: errorMessage);
  }
  
}

final authProvider = StateNotifierProvider<AuthNotifier, authState>((ref) {
  return AuthNotifier();
});

class LoginResult {
  final int statusCode;
  final String? errorMessage;

  LoginResult(this.statusCode, {this.errorMessage});
}
