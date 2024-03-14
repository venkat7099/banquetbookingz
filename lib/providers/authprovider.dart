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

  Future<int> adminLogin(
      String username, String password, WidgetRef ref) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
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
      print(userDetails);
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
      }
    } catch (e) {
      loadingState.state = false;
    }
    return responseCode;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, authState>((ref) {
  return AuthNotifier();
});
