import 'dart:convert';
import 'dart:io' as platform;

import 'dart:math';
import 'dart:typed_data';
import 'package:banquetbookingz/models/authstate.dart' as auth;
import 'package:banquetbookingz/models/getuser.dart';
import 'package:banquetbookingz/providers/getsubscribers.dart';
import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class UserNotifier extends StateNotifier<getUser> {
  UserNotifier() : super(getUser());
  void setImageFile(XFile? file) {

    }
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

  

Future<UserResult> addUser(XFile imageFile, String firstName, String emailId,String gender,WidgetRef ref) async {
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
    return UserResult(responseCode, errorMessage: errorMessage);
  }

  Future<void> getUsers() async{
  try{
final response = await http.get(Uri.parse(Api.addUser));
var res=json.decode(response.body);
var userData=getUser.fromJson(res);
state=userData;
print(userData.data);
print(res);
 
  }catch(e){};
}



Future<void> getProfilePic(String userId) async{
 
  try{
final response = await http.get(Uri.parse(Api.profilePic),headers: {
    'Content-Type': 'application/json',
    // Add other headers if needed
  });
print(response);
var res=json.decode(response.body);
var userData=getUser.fromJson(res);
state=userData;
print(userData.data);
print(res);
 
  }catch(e){};
}

Data? getUserById(int id) {
  return state.data?.firstWhere((user) => user.id == id, );
}
  
}

final usersProvider = StateNotifierProvider<UserNotifier, getUser>((ref) {
  return UserNotifier();
});

class UserResult {
  final int statusCode;
  final String? errorMessage;

  UserResult(this.statusCode, {this.errorMessage});
}
