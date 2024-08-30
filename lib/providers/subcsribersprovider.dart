// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:banquetbookingz/models/authstate.dart' as auth;
// import 'package:banquetbookingz/models/subscriptionmodel.dart';
// import 'package:banquetbookingz/providers/authprovider.dart';

// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/utils/banquetbookzapi.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/retry.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';

// class SubscribersNotifier extends StateNotifier<subscription> {
//   SubscribersNotifier() : super(subscription());

//   // Future<bool> tryAutoLogin() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   if (!prefs.containsKey('userData')) {
//   //     print('trylogin is false');
//   //     return false;
//   //   }

//   //   final extractData =
//   //       json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
//   //   final profile = prefs.getBool('profile') ?? false;
//   //   final expiryDate = DateTime.parse(extractData['refreshExpiry']);
//   //   final accessExpiry = DateTime.parse(extractData['accessTokenExpiry']);
//   String generateRandomLetters(int length) {
//     var random = Random();
//     var letters = List.generate(length, (_) => random.nextInt(26) + 97);
//     return String.fromCharCodes(letters);
//   }

//   Future<SubscriberResult> addSubscrier(String subname, String annualprice,
//       String quaterlyprice, String monthlyprice, WidgetRef ref) async {
//     final loadingState = ref.watch(loadingProvider.notifier);
//     int responseCode = 0;
//     String? errorMessage;
//     try {
//       loadingState.state = true;
//       var response = await http.post(Uri.parse(Api.subscriptions),
//           headers: {
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: json.encode({
//             'name': subname,
//             'annualpricing': annualprice,
//             'quaterlypricing': quaterlyprice,
//             'monthlypricing': monthlyprice,
//           }));

//       var userDetails = json.decode(response.body);
//       var statuscode = response.statusCode;
//       print('$statuscode');
//       responseCode = statuscode;
//       print('server response:$userDetails');
//       switch (response.statusCode) {
//         case 201:
//           state = subscription.fromJson(userDetails);
//           loadingState.state = false;

//           //print('this is from Auth response is:$accessToken');

//           // // final prefs = await SharedPreferences.getInstance();
//           // // final userData = json.encode({
//           // //   'refreshToken': userDetails['data']['refresh_token'],
//           // //   'accessToken': userDetails['data']['access_token'],
//           // //   'firstName': userDetails['data'][''],
//           // //   'userRole': userDetails['data']['userRole'],
//           // //   'password': userDetails['data']['password']
//           // });

//           //autologout();

//           // await prefs.setString('userData', userData);
//           // await prefs.setBool('isLoggedIn', true);
//           break;
//         default:
//           if (statuscode != 201) {
//             loadingState.state = false;
//           }
//           // Optionally set a message to show to the user why the login failed
//           break;
//       }
//       if (statuscode == 201) {
//         // Handle successful login...
//       } else {
//         // Any other status code means something went wrong
//         // Extract error message from response
//         // Assuming 'messages' is a List of messages and we take the first one.
//         errorMessage =
//             userDetails['messages']?.first ?? 'An unknown error occurred.';
//         // Alternatively, if 'message' is a single String with the error message:
//         // errorMessage = responseJson['message'];
//       }
//     } catch (e) {
//       loadingState.state = false;
//       errorMessage = e.toString();
//       print("cathe:$errorMessage");
//     }
//     return SubscriberResult(responseCode, errorMessage: errorMessage);
//   }

//   Future<SubscriberResult> updateSubscriber(String subname, String annualprice,
//       String quaterlyprice, String monthlyprice, WidgetRef ref) async {
//     final loadingState = ref.watch(loadingProvider.notifier);
//     var subDetails = ref.read(authProvider);
//     int id = 20;
//     int responseCode = 0;
//     String? errorMessage;
//     try {
//       loadingState.state = true;

//       var response = await http.post(Uri.parse(Api.subscriptions),
//           headers: {
//             'Content-Type': 'application/json',
//           },
//           body: json.encode({
//             "id": id.toString(),
//             "name": subname,
//             "annualpricing": annualprice,
//             "quaterlypricing": quaterlyprice,
//             "monthlypricing": monthlyprice
//           }));

//       var userDetails = json.decode(response.body);
//       var statuscode = response.statusCode;
//       print('$statuscode');
//       responseCode = statuscode;
//       print('server response:$userDetails');
//       switch (response.statusCode) {
//         case 201:
//           state = subscription.fromJson(userDetails);
//           loadingState.state = false;

//           //print('this is from Auth response is:$accessToken');

//           final prefs = await SharedPreferences.getInstance();
//           final userData = json.encode({
//             'refreshToken': userDetails['data']['refresh_token'],
//             'accessToken': userDetails['data']['access_token'],
//             'firstName': userDetails['data'][''],
//             'userRole': userDetails['data']['userRole'],
//             'password': userDetails['data']['password']
//           });

//           //autologout();

//           await prefs.setString('userData', userData);
//           await prefs.setBool('isLoggedIn', true);
//           break;
//         default:
//           if (statuscode != 201) {
//             loadingState.state = false;
//           }
//           // Optionally set a message to show to the user why the login failed
//           break;
//       }
//       if (statuscode == 201) {
//         // Handle successful login...
//       } else {
//         // Any other status code means something went wrong
//         // Extract error message from response
//         // Assuming 'messages' is a List of messages and we take the first one.
//         errorMessage =
//             userDetails['messages']?.first ?? 'An unknown error occurred.';
//         // Alternatively, if 'message' is a single String with the error message:
//         // errorMessage = responseJson['message'];
//       }
//     } catch (e) {
//       loadingState.state = false;
//       errorMessage = e.toString();
//       print("cathe:$errorMessage");
//     }
//     return SubscriberResult(responseCode, errorMessage: errorMessage);
//   }

//   Future<void> getSubscribers() async {
//     try {
//       final response = await http.get(Uri.parse(Api.subscriptions));
//       var res = json.decode(response.body);
//       var userData = subscription.fromJson(res);
//       state = userData;
//       print(userData.data);
//       print(res);
//     } catch (e) {}
//     ;
//   }

//   Data? getSubById(int id) {
//     return state.data?.firstWhere(
//       (user) => user.id == id,
//     );
//   }
// }

// final subscribersProvider =
//     StateNotifierProvider<SubscribersNotifier, subscription>((ref) {
//   return SubscribersNotifier();
// });

// class SubscriberResult {
//   final int statusCode;
//   final String? errorMessage;

//   SubscriberResult(this.statusCode, {this.errorMessage});
// }

import 'dart:convert';
import 'package:banquetbookingz/models/subscriptionmodel.dart';
import 'package:banquetbookingz/providers/authprovider.dart';
import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscribersNotifier extends StateNotifier<subscription> {
  SubscribersNotifier() : super(subscription());

  Future<String?> _getAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      print("Retrieved token: $token"); // Debug print
      return token;
    } catch (e) {
      print("Error retrieving access token: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> _getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('userData');
      if (userData != null) {
        return json.decode(userData) as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error retrieving user data: $e");
    }
    return null;
  }

  Future<SubscriberResult> addSubscriber(
    String subname,
    String annualprice,
    String quaterlyprice,
    String combinedFrequency,
    WidgetRef ref,
  ) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
    String? errorMessage;

    try {
      loadingState.state = true;

      final accessToken = await _getAccessToken();
      final userData = await _getUserData();
      if (accessToken == null || userData == null) {
        print("Access token or user data is null");
        return SubscriberResult(
          401,
          errorMessage: 'Authentication not provided',
        );
      }

      final response = await http.post(
        Uri.parse(Api.subscriptions),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
        body: json.encode({
          'pricing': annualprice,
          'bookings': quaterlyprice,
          'plan': subname,
          'frequency': combinedFrequency,
        }),
      );

      print('Access Token: $accessToken');
      print('Request Headers: ${{
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      }}');
      print('Request Body: ${json.encode({
            'name': subname,
            'annualpricing': annualprice,
            'quaterlypricing': quaterlyprice,
            'monthlypricing': combinedFrequency,
            // 'plan': subname,
            // 'frequency': annualprice,
          })}');

      responseCode = response.statusCode;
      var userDetails = json.decode(response.body);

      print('Response Code: $responseCode');
      print('Server Response: $userDetails');

      if (responseCode == 201) {
        state = subscription.fromJson(userDetails);
      } else {
        errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Error adding subscriber: $errorMessage");
    } finally {
      loadingState.state = false;
    }
    return SubscriberResult(responseCode, errorMessage: errorMessage);
  }

  Future<SubscriberResult> updateSubscriber(
    String subname,
    String annualprice,
    String quaterlyprice,
    String monthlyprice,
    WidgetRef ref,
  ) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
    String? errorMessage;

    try {
      loadingState.state = true;

      final accessToken = await _getAccessToken();
      final userData = await _getUserData();
      if (accessToken == null || userData == null) {
        print("Access token or user data is null");
        return SubscriberResult(
          401,
          errorMessage: 'Authentication not provided',
        );
      }

      final response = await http.put(
        Uri.parse(Api.subscriptions),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
        body: json.encode({
          'name': subname,
          'annualpricing': annualprice,
          'quaterlypricing': quaterlyprice,
          'monthlypricing': monthlyprice,
        }),
      );

      responseCode = response.statusCode;
      var userDetails = json.decode(response.body);

      print('Response Code: $responseCode');
      print('Server Response: $userDetails');

      if (responseCode == 200) {
        state = subscription.fromJson(userDetails);
      } else {
        errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Error updating subscriber: $errorMessage");
    } finally {
      loadingState.state = false;
    }
    return SubscriberResult(responseCode, errorMessage: errorMessage);
  }

  Future<void> getSubscribers() async {
    try {
      final accessToken = await _getAccessToken();
      if (accessToken == null) {
        print("Access token is null");
        return; // Handle case where access token is missing
      }

      final response = await http.get(
        Uri.parse(Api.subscriptions),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      final res = json.decode(response.body);

      print('Response Code: ${response.statusCode}');
      print('Server Response: $res');

      if (response.statusCode == 200) {
        state = subscription.fromJson(res);
      } else {
        print(
          'Error fetching subscribers: ${res['messages']?.first ?? 'An unknown error occurred.'}',
        );
      }
    } catch (e) {
      print("Error fetching subscribers: $e");
    }
  }

  Data? getSubById(int id) {
    return state.data?.firstWhere(
      (user) => user.id == id,
    );
  }
}

final subscribersProvider =
    StateNotifierProvider<SubscribersNotifier, subscription>((ref) {
  return SubscribersNotifier();
});

class SubscriberResult {
  final int statusCode;
  final String? errorMessage;

  SubscriberResult(this.statusCode, {this.errorMessage});
}
