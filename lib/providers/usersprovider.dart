import 'dart:convert';
import 'dart:io' as platform;

import 'dart:math';
import 'dart:typed_data';
import 'package:banquetbookingz/models/authstate.dart' as auth;
import 'package:banquetbookingz/models/getuser.dart';
import 'package:banquetbookingz/providers/authprovider.dart';
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

  

Future<UserResult> addUser(
  XFile imageFile, 
  String firstName, 
  String emailId, 
  String gender, 
  String mobileNo, 
   
  String password, // Add password parameter
  WidgetRef ref
) async {
  var uri = Uri.parse(Api.addUser);
  final loadingState = ref.watch(loadingProvider.notifier);

  int responseCode = 0;
  String? errorMessage;
print("$emailId,$password,$mobileNo,$gender");
  try {
    loadingState.state = true;
    var request = http.MultipartRequest('POST', uri);
    
    // Add the image file to your request.
    request.files.add(await http.MultipartFile.fromPath('profile_pic', imageFile.path));

    // Add the other form fields to your request.
    request.fields['username'] = firstName;
    request.fields['email'] = emailId;
    request.fields['gender'] = gender;
    request.fields['mobileno'] = mobileNo;
    
    
    request.fields['password'] = password; // Add password to the request
request.headers['Authorization']='Token ${ref.read(authProvider).token}';
    final send = await request.send();
    final res = await http.Response.fromStream(send);
    var userDetails = json.decode(res.body);
    var statusCode = res.statusCode;
    responseCode = statusCode;
    print("statuscode: $statusCode");
    print("responsebody: ${res.body}");
    switch (responseCode) {
      case 400:
        if(userDetails['email']!=null){
errorMessage='Email already exists';
        }else if(userDetails['username']!=null){
errorMessage='username already exists';
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
