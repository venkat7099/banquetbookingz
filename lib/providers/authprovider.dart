import 'dart:convert';
import 'dart:math';
import 'package:banquetbookingz/models/authstate.dart';
import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<AdminAuth> {
  AuthNotifier() : super(AdminAuth.initial()) {
    _loadUserFromPrefs();
  }

  // Load user data from SharedPreferences on startup
  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      final data = json.decode(userData) as Map<String, dynamic>;
      state = AdminAuth.fromJson(data);
      print('User loaded on app startup: ${state.data?.userRole}');
    }
  }

  // Check if the user is authenticated
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken != null && accessToken.isNotEmpty) {
      return true;
    }

    if (prefs.containsKey('userData')) {
      final extractData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      if (state.data?.accessToken == null) {
        state = AdminAuth.fromJson(extractData);
      }
      return true;
    } else {
      print('User not authenticated');
      return false;
    }
  }

  // Fetch the user's role from the current state or SharedPreferences
  Future<String> getUserRole() async {
    if (state.data?.userRole != null) {
      return state.data!.userRole!;
    }

    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      final data = json.decode(userData) as Map<String, dynamic>;
      final role = data['user_role'] ?? 'Unknown';
      return role;
    }

    return 'No Role Found';
  }

  // Admin login function
  Future<LoginResult> adminLogin(
      String email, String password, WidgetRef ref) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
    String? errorMessage;

    try {
      loadingState.state = true;

      // Making the API request with email and password in the body
      var response = await http.post(
        Uri.parse(Api.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'email': email, 'password': password}),
      );

      responseCode = response.statusCode;
      var responseBody = json.decode(response.body);
      print('Response Code: $responseCode');
      print('Server Response: $responseBody');

      if (responseCode == 200 && responseBody['success'] == true) {
        loadingState.state = false;

        // Parse the response body to AdminAuth model
        AdminAuth adminAuth = AdminAuth.fromJson(responseBody);

        // Update the state with the returned data
        state = adminAuth;
        print(
            'State updated with access token: ${adminAuth.data?.accessToken}');

        // Storing data in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        print("SharedPreferences fetched successfully");

        // Store the entire AdminAuth object in SharedPreferences
        final userData = json.encode(adminAuth.toJson());
        bool saveResult = await prefs.setString('userData', userData);

        if (!saveResult) {
          print("Failed to save user data to SharedPreferences.");
        }

        // Also saving the access token separately if needed
        bool tokenSaveResult = await prefs.setString(
            'accessToken', adminAuth.data?.accessToken ?? '');
        if (!tokenSaveResult) {
          print("Failed to save access token to SharedPreferences.");
        }
      } else {
        loadingState.state = false;
        errorMessage =
            responseBody['messages']?.first ?? 'An unknown error occurred.';
      }
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("Catch: $errorMessage");
    }

    return LoginResult(responseCode, errorMessage: errorMessage);
  }

  // Function to log out the user
  Future<void> logoutUser() async {
    print('Logging out...');
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = AdminAuth.initial(); // Clear the state after logout
    print('User logged out and state cleared.');
  }

  // Update admin state
  void updateAdminState(AdminAuth updatedAdmin) {
    state = updatedAdmin;

    // Optionally save to SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('userData', json.encode(updatedAdmin.toJson()));
    });

    print('Admin state updated with new data: ${updatedAdmin.toJson()}');
  }

  // Helper function to generate random letters (if needed elsewhere)
  String generateRandomLetters(int length) {
    var random = Random();
    var letters = List.generate(length, (_) => random.nextInt(26) + 97);
    return String.fromCharCodes(letters);
  }
}

// Riverpod provider for AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AdminAuth>((ref) {
  return AuthNotifier();
});

// Model class to represent the login result
class LoginResult {
  final int statusCode;
  final String? errorMessage;

  LoginResult(this.statusCode, {this.errorMessage});
}
