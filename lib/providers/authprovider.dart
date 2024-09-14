// import 'dart:convert';
// import 'dart:math';
// import 'package:banquetbookingz/models/authstate.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/utils/banquetbookzapi.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthNotifier extends StateNotifier<AdminAuth> {
//   AuthNotifier() : super(AdminAuth());

//   Future<bool> isAuthenticated() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey('userData')) {
//       final extractData =
//           json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
//       if (state.token == null) {
//         state = state.copyWith(
//           token: extractData['token'],
//           username: extractData['username'],
//           email: extractData['email'],
//           mobileno: extractData['mobileno'],
//           usertype: extractData['usertype'],
//         );
//       }
//       return true;
//     } else {
//       print('User not authenticated');
//       return false;
//     }
//   }

//   String generateRandomLetters(int length) {
//     var random = Random();
//     var letters = List.generate(length, (_) => random.nextInt(26) + 97);
//     return String.fromCharCodes(letters);
//   }

//   Future<LoginResult> adminLogin(
//       String username, String password, WidgetRef ref) async {
//     final loadingState = ref.watch(loadingProvider.notifier);
//     int responseCode = 0;
//     String? errorMessage;
//     try {
//       loadingState.state = true;

//       var response = await http.post(
//         Uri.parse(Api.login),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({'username': username, 'password': password}),
//       );

//       var userDetails = json.decode(response.body);
//       responseCode = response.statusCode;
//       print('Response Code: $responseCode');
//       print('Server Response: $userDetails');

//       if (responseCode == 200) {
//         loadingState.state = false;

//         state = AdminAuth.fromJson(userDetails);
//         print('State updated with token: ${userDetails['token']}');

//         final prefs = await SharedPreferences.getInstance();
//         print("SharedPreferences fetched successfully");
//         state = state.copyWith(token: userDetails['token']);
//         final userData = json.encode({
//           'token': userDetails['token'],
//           'username': userDetails['username'],
//           'email': userDetails['email'],
//           'mobileno': userDetails['mobileno'],
//           'usertype': userDetails['usertype'],
//         });
//         await prefs.setString('userData', userData);

//         bool saveResult = await prefs.setString('userData', userData);
//         if (!saveResult) {
//           print("Failed to save user data to SharedPreferences.");
//         }

//         bool tokenSaveResult =
//             await prefs.setString('accessToken', userDetails['token']);
//         if (!tokenSaveResult) {
//           print("Failed to save access token to SharedPreferences.");
//         }
//       } else {
//         loadingState.state = false;
//         errorMessage =
//             userDetails['messages']?.first ?? 'An unknown error occurred.';
//       }
//     } catch (e) {
//       loadingState.state = false;
//       errorMessage = e.toString();
//       print("Catch: $errorMessage");
//     }
//     return LoginResult(responseCode, errorMessage: errorMessage);
//   }

//   Future<void> logoutUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('userData');
//     await prefs.remove('accessToken');
//     await prefs.setBool('isLoggedIn', false);
//   }

//   Future<String?> _getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('accessToken');
//     print("Retrieved token: $token");
//     return token;
//   }
// }

// final authProvider = StateNotifierProvider<AuthNotifier, AdminAuth>((ref) {
//   return AuthNotifier();
// });

// class LoginResult {
//   final int statusCode;
//   final String? errorMessage;

//   LoginResult(this.statusCode, {this.errorMessage});
// }

import 'dart:convert';
import 'dart:math';
import 'package:banquetbookingz/models/authstate.dart';
import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<AdminAuth> {
  AuthNotifier() : super(AdminAuth());

  // Check if the user is authenticated by looking for userData in SharedPreferences
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final extractData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      if (state.token == null) {
        state = state.copyWith(
          token: extractData['token'],
          username: extractData['username'],
          email: extractData['email'],
          mobileno: extractData['mobileno'],
          usertype: extractData['usertype'],
        );
      }
      return true;
    } else {
      print('User not authenticated');
      return false;
    }
  }

  // Helper function to generate random letters
  String generateRandomLetters(int length) {
    var random = Random();
    var letters = List.generate(length, (_) => random.nextInt(26) + 97);
    return String.fromCharCodes(letters);
  }

  // Admin login function
  Future<LoginResult> adminLogin(
      String username, String password, WidgetRef ref) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
    String? errorMessage;
    try {
      loadingState.state = true;

      var response = await http.post(
        Uri.parse(Api.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'username': username, 'password': password}),
      );

      var userDetails = json.decode(response.body);
      responseCode = response.statusCode;
      print('Response Code: $responseCode');
      print('Server Response: $userDetails');

      if (responseCode == 200) {
        loadingState.state = false;

        state = AdminAuth.fromJson(userDetails);
        print('State updated with token: ${userDetails['token']}');

        final prefs = await SharedPreferences.getInstance();
        print("SharedPreferences fetched successfully");
        state = state.copyWith(token: userDetails['Token']);
        final userData = json.encode({
          'token': userDetails['token'],
          'username': userDetails['username'],
          'email': userDetails['email'],
          'mobileno': userDetails['mobileno'],
          'usertype': userDetails['usertype'],
        });
        await prefs.setString('userData', userData);

        bool saveResult = await prefs.setString('userData', userData);
        if (!saveResult) {
          print("Failed to save user data to SharedPreferences.");
        }

        bool tokenSaveResult =
            await prefs.setString('accessToken', userDetails['token']);
        if (!tokenSaveResult) {
          print("Failed to save access token to SharedPreferences.");
        }
      } else {
        loadingState.state = false;
        errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';
      }
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("Catch: $errorMessage");
    }
    return LoginResult(responseCode, errorMessage: errorMessage);
  }


  Future<LoginResult> addSubscrier(
      String subname, String annualprice,String quaterlyprice,String monthlyprice, WidgetRef ref) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
    String? errorMessage;
    try {
      loadingState.state = true;
      var response = await http.post(Uri.parse(Api.subscriptions),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({'name': subname,'annualpricing': annualprice,
          'quaterlypricing': quaterlyprice,'monthlypricing': monthlyprice,}));

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

          // // final prefs = await SharedPreferences.getInstance();
          // // final userData = json.encode({
          // //   'refreshToken': userDetails['data']['refresh_token'],
          // //   'accessToken': userDetails['data']['access_token'],
          // //   'firstName': userDetails['data'][''],
          // //   'userRole': userDetails['data']['userRole'],
          // //   'password': userDetails['data']['password']
          // });

          //autologout();

          // await prefs.setString('userData', userData);
          // await prefs.setBool('isLoggedIn', true);
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
        loadingState.state = false;
        errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';
      }
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("Catch: $errorMessage");
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

// Model class to represent the login result
class LoginResult {
  final int statusCode;
  final String? errorMessage;

  LoginResult(this.statusCode, {this.errorMessage});
}
