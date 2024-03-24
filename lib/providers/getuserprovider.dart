// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:banquetbookingz/models/authstate.dart' as auth;
// import 'package:banquetbookingz/models/getuser.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/utils/banquetbookzapi.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';

// class UserNotifier extends StateNotifier<getUser> {
//   UserNotifier() : super(getUser());
// Future<void> getUsers() async{
//   try{
// final response = await http.get(Uri.parse(Api.addUser));
// var res=json.decode(response.body);
// var userData=getUser.fromJson(res);
// state=userData;
// print(userData.data);
// print(res);
 
//   }catch(e){};
// }



// Future<void> getProfilePic(String userId) async{
//   var data={};
//   data["id"]=userId;
//   try{
// final response = await http.get(Uri.parse(Api.profilePic),headers: {
//     'Content-Type': 'application/json',
//     // Add other headers if needed
//   });
// print(response);
// var res=json.decode(response.body);
// var userData=getUser.fromJson(res);
// state=userData;
// print(userData.data);
// print(res);
 
//   }catch(e){};
// }

// Data? getUserById(int id) {
//   return state.data?.firstWhere((user) => user.id == id, );
// }

// }
//   final getUserProvider = StateNotifierProvider<UserNotifier,getUser >((ref) {
//   return UserNotifier();
// });
