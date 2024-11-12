// import 'dart:convert';
// import 'dart:io' as platform;
// import 'dart:math';
// import 'package:banquetbookingz/models/getuser.dart';
// import 'package:banquetbookingz/models/users.dart';
// import 'package:banquetbookingz/providers/authprovider.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/utils/banquetbookzapi.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserNotifier extends StateNotifier<List<Users>> {
//   UserNotifier() : super([]);
//   void setImageFile(XFile? file) {}
//   Future<platform.File?> getImageFile(BuildContext context) async {
//     // if (state.data != null) {
//     //   final data = state.data![0];
//     //   if (data.xfile == null) {
//     //     return null;
//     //   }
//     //   final platform.File file = platform.File(data.xfile!.path);
//     //   return file;
//     // }

//     return null;
//   }

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

//   Future<UserResult> addUser(
//       XFile imageFile,
//       String firstName,
//       String emailId,
//       String gender,
//       String mobileNo,
//       String password, // Add password parameter
//       WidgetRef ref) async {
//     var uri = Uri.parse(Api.addUser);
//     final loadingState = ref.watch(loadingProvider.notifier);

//     int responseCode = 0;
//     String? errorMessage;
//     print("$emailId,$password,$mobileNo,$gender");
//     try {
//       loadingState.state = true;
//       var request = http.MultipartRequest('POST', uri);

//       // Add the image file to your request.
//       request.files.add(
//           await http.MultipartFile.fromPath('profile_pic', imageFile.path));

//       // Add the other form fields to your request.
//       request.fields['username'] = firstName;
//       request.fields['email'] = emailId;
//       request.fields['gender'] = gender;
//       request.fields['mobileno'] = mobileNo;

//       request.fields['password'] = password; // Add password to the request
//       request.headers['Authorization'] =
//           'Token ${ref.read(authProvider).token}';
//       final send = await request.send();
//       final res = await http.Response.fromStream(send);
//       var userDetails = json.decode(res.body);
//       var statusCode = res.statusCode;
//       responseCode = statusCode;
//       print("statuscode: $statusCode");
//       print("responsebody: ${res.body}");
//       switch (responseCode) {
//         case 400:
//           if (userDetails['email'] != null) {
//             errorMessage = 'Email already exists';
//           } else if (userDetails['username'] != null) {
//             errorMessage = 'username already exists';
//           }
//           break;
//         default:
//       }
//     } catch (e) {
//       loadingState.state = false;
//       errorMessage = e.toString();
//       print("catch: $errorMessage");
//     } finally {
//       loadingState.state = false;
//     }

//     return UserResult(responseCode, errorMessage: errorMessage);
//   }

//   Future<void> getUsers(WidgetRef ref) async {
//     final getaccesstoken = ref.read(authProvider).token;
//     try {
//       final response = await http.get(Uri.parse(Api.retriveusers), headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Token $getaccesstoken',
//       });
//       var res = json.decode(response.body);
//       print('response $res');
//       if (response.statusCode == 200) {
//         List<dynamic> res = json.decode(response.body);
//         List<Users> userProfiles =
//             res.map((data) => Users.fromJson(data)).toList();

//         // Store the list in your provider or state management solution
//         ref.read(usersProvider.notifier).setUserProfiles(userProfiles);

//         print(userProfiles);
//       } else {
//         print('Failed to load user profiles');
//       }

//       print('response $res');
//     } catch (e) {}
//   }

//   void setUserProfiles(List<Users> profiles) {
//     state = profiles;
//   }

//   Future<void> getProfilePic(String userId) async {
//     try {
//       final response = await http.get(Uri.parse(Api.profilePic), headers: {
//         'Content-Type': 'application/json',
//         // Add other headers if needed
//       });
//       print(response);
//       var res = json.decode(response.body);

//       print(res);
//     } catch (e) {}
//     ;
//   }

//   // Data? getUserById(int id) {
//   //   return state.data?.firstWhere(
//   //     (user) => user.id == id,
//   //   );
//   // }
// }

// final usersProvider = StateNotifierProvider<UserNotifier, List<Users>>((ref) {
//   return UserNotifier();
// });

// class UserResult {
//   final int statusCode;
//   final String? errorMessage;

//   UserResult(this.statusCode, {this.errorMessage});
// }

import 'dart:convert';
import 'dart:io' as platform;
import 'dart:math';
import 'package:banquetbookingz/models/users.dart';
import 'package:banquetbookingz/providers/authprovider.dart';
import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends StateNotifier<List<Users>> {
  UserNotifier() : super([]);
  void setImageFile(XFile? file) {}
  Future<platform.File?> getImageFile(BuildContext context) async {
    // if (state.data != null) {
    //   final data = state.data![0];
    //   if (data.xfile == null) {
    //     return null;
    //   }
    //   final platform.File file = platform.File(data.xfile!.path);
    //   return file;
    // }

    return null;
  }

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

  Future<UserResult> addUser(
      XFile imageFile,
      String firstName,
      String emailId,
      String mobileNo,
      String password, // Add password parameter
      WidgetRef ref) async {
    var uri = Uri.parse(Api.addUser);
    final loadingState = ref.watch(loadingProvider.notifier);

    int responseCode = 0;
    String? errorMessage;
   
    try {
      loadingState.state = true;
      var request = http.MultipartRequest('POST', uri);
    
      // Add the image file to your request.
      request.files.add(
          await http.MultipartFile.fromPath('profile_pic', imageFile.path));

      // Add the other form fields to your request.
      request.fields['username'] = firstName;
      request.fields['email'] = emailId;
      request.fields['mobile_no'] = mobileNo;
      request.fields['user_role']='m';
       request.fields['user_status']='1';
      request.fields['password'] = password; // Add password to the request
      
      final send = await request.send();
      final res = await http.Response.fromStream(send);
      var userDetails = json.decode(res.body);
      var statusCode = res.statusCode;
      responseCode = statusCode;
      print("statuscode: $statusCode");
      print("responsebody: ${res.body}");
      switch (responseCode) {
        case 400:
          if (userDetails['email'] != null) {
            errorMessage = 'Email already exists';
          } else if (userDetails['username'] != null) {
            errorMessage = 'username already exists';
          }
          break;
        default:
      }
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("catch: $errorMessage");
    } finally {
      loadingState.state = false;
    }

    return UserResult(responseCode, errorMessage: errorMessage);
  }

  Future<void> getUsers(WidgetRef ref) async {
    print("entered getusers");
    final getaccesstoken = ref.read(authProvider).data?.accessToken;
    try {
      final response = await http.get(Uri.parse(Api.addUser), 
      headers: {
        'Content-Type': 'application/json',
      
      }
      );
      var res = json.decode(response.body);
      print('response $res');
      if (response.statusCode == 200) {
        List<dynamic> res = json.decode(response.body);
        List<Users> userProfiles =
            res.map((data) => Users.fromJson(data)).toList();

        // Store the list in your provider or state management solution
        ref.read(usersProvider.notifier).setUserProfiles(userProfiles);

        print(userProfiles);
      } else {
        print('Failed to load user profiles');
      }

      print('response $res');
    } catch (e) {}
  }

  void setUserProfiles(List<Users> profiles) {
    state = profiles;
  }

  Future<void> getProfilePic(String userId, WidgetRef ref) async {
    final getaccesstoken = ref.read(authProvider).data?.accessToken;
    try {
      final response =
          await http.get(Uri.parse('${Api.profilePic}/$userId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $getaccesstoken',
      });

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        // Assuming the API response contains a URL of the profile picture
        final profilePicUrl = res['profilePicUrl'];

        // Update the user profile picture in the state
        ref
            .read(usersProvider.notifier)
            .updateProfilePic(userId, profilePicUrl);
      } else {
        print("Failed to load profile picture");
      }
    } catch (e) {
      print("Error fetching profile picture: $e");
    }
  }

  Users? getUserById(String username) {
    return state.firstWhere(
      (user) => user.data?.username == username,
    );
  }

  deleteUser(String userId) {}

  void updateProfilePic(String userId, profilePicUrl) {}
}

final usersProvider = StateNotifierProvider<UserNotifier, List<Users>>((ref) {
  return UserNotifier();
});

class UserResult {
  final int statusCode;
  final String? errorMessage;

  UserResult(this.statusCode, {this.errorMessage});
}
