// import 'dart:convert';
// import 'package:banquetbookingz/models/subscriptionmodel.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/utils/banquetbookzapi.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SubscribersNotifier extends StateNotifier<subscription> {
//   SubscribersNotifier() : super(subscription());

//   Future<String?> _getAccessToken() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('accessToken');
//       print("Retrieved token: $token"); // Debug print
//       return token;
//     } catch (e) {
//       print("Error retrieving access token: $e");
//       return null;
//     }
//   }

//   Future<Map<String, dynamic>?> _getUserData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userData = prefs.getString('userData');
//       if (userData != null) {
//         return json.decode(userData) as Map<String, dynamic>;
//       }
//     } catch (e) {
//       print("Error retrieving user data: $e");
//     }
//     return null;
//   }

//   Future<SubscriberResult> addSubscriber(
//     String subname,
//     String annualprice,
//     String quaterlyprice,
//     String combinedFrequency,
//     WidgetRef ref,
//   ) async {
//     final loadingState = ref.watch(loadingProvider.notifier);
//     int responseCode = 0;
//     String? errorMessage;

//     try {
//       loadingState.state = true;

//       final accessToken = await _getAccessToken();
//       final userData = await _getUserData();
//       if (accessToken == null || userData == null) {
//         print("Access token or user data is null");
//         return SubscriberResult(
//           401,
//           errorMessage: 'Authentication not provided',
//         );
//       }

//       final response = await http.post(
//         Uri.parse(Api.subscriptions),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Token $accessToken',
//         },
//         body: json.encode({
//           'pricing': annualprice,
//           'bookings': quaterlyprice,
//           'plan': subname,
//           'frequency': combinedFrequency,
//         }),
//       );

//       print('Access Token: $accessToken');
//       print('Request Headers: ${{
//         'Content-Type': 'application/json',
//         'Authorization': 'Token $accessToken',
//       }}');
//       print('Request Body: ${json.encode({
//             'name': subname,
//             'annualpricing': annualprice,
//             'quaterlypricing': quaterlyprice,
//             'monthlypricing': combinedFrequency,
//             // 'plan': subname,
//             // 'frequency': annualprice,
//           })}');

//       responseCode = response.statusCode;
//       var userDetails = json.decode(response.body);

//       print('Response Code: $responseCode');
//       print('Server Response: $userDetails');

//       if (responseCode == 201) {
//         state = subscription.fromJson(userDetails);
//       } else {
//         errorMessage =
//             userDetails['messages']?.first ?? 'An unknown error occurred.';
//       }
//     } catch (e) {
//       errorMessage = e.toString();
//       print("Error adding subscriber: $errorMessage");
//     } finally {
//       loadingState.state = false;
//     }
//     return SubscriberResult(responseCode, errorMessage: errorMessage);
//   }

//   Future<SubscriberResult> updateSubscriber(
//     String subname,
//     String annualprice,
//     String quaterlyprice,
//     String monthlyprice,
//     WidgetRef ref,
//   ) async {
//     final loadingState = ref.watch(loadingProvider.notifier);
//     int responseCode = 0;
//     String? errorMessage;

//     try {
//       loadingState.state = true;

//       final accessToken = await _getAccessToken();
//       final userData = await _getUserData();
//       if (accessToken == null || userData == null) {
//         print("Access token or user data is null");
//         return SubscriberResult(
//           401,
//           errorMessage: 'Authentication not provided',
//         );
//       }

//       final response = await http.put(
//         Uri.parse(Api.subscriptions),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Token $accessToken',
//         },
//         body: json.encode({
//           'name': subname,
//           'annualpricing': annualprice,
//           'quaterlypricing': quaterlyprice,
//           'monthlypricing': monthlyprice,
//         }),
//       );

//       responseCode = response.statusCode;
//       var userDetails = json.decode(response.body);

//       print('Response Code: $responseCode');
//       print('Server Response: $userDetails');

//       if (responseCode == 200) {
//         state = subscription.fromJson(userDetails);
//       } else {
//         errorMessage =
//             userDetails['messages']?.first ?? 'An unknown error occurred.';
//       }
//     } catch (e) {
//       errorMessage = e.toString();
//       print("Error updating subscriber: $errorMessage");
//     } finally {
//       loadingState.state = false;
//     }
//     return SubscriberResult(responseCode, errorMessage: errorMessage);
//   }

//   Future<void> getSubscribers() async {
//     try {
//       final accessToken = await _getAccessToken();
//       if (accessToken == null) {
//         print("Access token is null");
//         return; // Handle case where access token is missing
//       }

//       final response = await http.get(
//         Uri.parse(Api.subscriptions),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Token $accessToken',
//         },
//       );

//       final res = json.decode(response.body);

//       print('Response Code: ${response.statusCode}');
//       print('Server Response: $res');

//       if (response.statusCode == 200) {
//         state = subscription.fromJson(res);
//       } else {
//         print(
//           'Error fetching subscribers: ${res['messages']?.first ?? 'An unknown error occurred.'}',
//         );
//       }
//     } catch (e) {
//       print("Error fetching subscribers: $e");
//     }
//   }

//   Data? getSubById(int id) {
//     return state.data?.firstWhere(
//       (user) => user.planId == id,
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
