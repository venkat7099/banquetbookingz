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

class UserNotifier extends StateNotifier<List<User>> {
  UserNotifier() : super([]);

  void setImageFile(XFile? file) {}

  void deleteUser(String userId, WidgetRef ref) async {
    final url = Uri.parse('https://www.gocodecreations.com/bbadminlogin');
    try {
      final response = await http.delete(
        Uri.parse(Api.login), // Use the correct DELETE API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': userId}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          // Remove the user from the state
          state =
              state.where((user) => user.userId.toString() != userId).toList();

          // Show success message
          ScaffoldMessenger.of(ref.context).showSnackBar(
            const SnackBar(content: Text('User deleted successfully')),
          );
        } else {
          ScaffoldMessenger.of(ref.context).showSnackBar(
            SnackBar(
                content: Text(responseData['messages']?.join(', ') ??
                    'Error deleting user')),
          );
        }
      } else {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          const SnackBar(content: Text('Failed to delete user')),
        );
      }
    } catch (e) {
      print("Error deleting user: $e");
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<platform.File?> getImageFile(BuildContext context) async {
    return null;
  }

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
      request.fields['user_role'] = 'm';
      request.fields['user_status'] = '1';
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
            errorMessage = 'Username already exists';
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
    print("entered getUsers");

    try {
      // Ensure the correct endpoint for fetching users is used.
      final response = await http.get(
        Uri.parse(Api.addUser), // Use the appropriate endpoint here.
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);

        // Parse response using UserResponse to handle metadata and user data.
        UserResponse userResponse = UserResponse.fromJson(decodedResponse);

        // Update state with the list of users
        if (userResponse.data != null) {
          ref.read(usersProvider.notifier).setUserProfiles(userResponse.data!);
          print(userResponse.data);
        } else {
          print('No users found in response');
        }
      } else {
        print('Failed to load user profiles');
      }
    } catch (e) {
      print("Error message: $e");
    }
  }

  void setUserProfiles(List<User> profiles) {
    state = profiles;
  }

  Future<void> getProfilePic(String userId, WidgetRef ref) async {
    final accessToken = ref.read(authProvider).data?.accessToken;
    try {
      final response =
          await http.get(Uri.parse('${Api.profilePic}/$userId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
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

  User? getUserById(String username) {
    return state.firstWhere(
      (user) => user.username == username,
      // returns null if no matching user is found
    );
  }

  void updateProfilePic(String userId, String? profilePicUrl) {
    // Update the user's profile picture in the state
    state = [
      for (final user in state)
        if (user.userId.toString() == userId)
          user.copyWith(profilePic: profilePicUrl)
        else
          user,
    ];
  }
}

final usersProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  return UserNotifier();
});

class UserResult {
  final int statusCode;
  final String? errorMessage;

  UserResult(this.statusCode, {this.errorMessage});
}
