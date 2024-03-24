// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:banquetbookingz/models/authstate.dart' as auth;

// import 'package:banquetbookingz/models/subscriptionmodel.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/utils/banquetbookzapi.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';

// class UserNotifier extends StateNotifier<subscription> {
//   UserNotifier() : super(subscription());


// Future<void> getSubscribers() async{
//   try{
// final response = await http.get(Uri.parse(Api.subscriptions));
// var res=json.decode(response.body);
// var userData=subscription.fromJson(res);
// state=userData;
// print(userData.data);
// print(res);
 
//   }catch(e){};
// }


// Data? getSubById(int id) {
//   return state.data?.firstWhere((user) => user.id == id, );
// }

// }
//   final getSubProvider = StateNotifierProvider<UserNotifier,subscription >((ref) {
//   return UserNotifier();
// });
