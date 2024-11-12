import 'package:image_picker/image_picker.dart';

class GetUser {
  int? statusCode;
  bool? success;
  List<String>? messages;
  List<Data>? data;

  GetUser({this.statusCode, this.success, this.messages, this.data});

  GetUser.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? username;
  String? email;
  String? userRole;
  bool? userStatus;
  String? mobileNo;
  String? profilePic;

  Data(
      {this.userId,
      this.username,
      this.email,
      this.userRole,
      this.userStatus,
      this.mobileNo,
      this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    userRole = json['user_role'];
    userStatus = json['user_status'];
    mobileNo = json['mobile_no'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['user_role'] = this.userRole;
    data['user_status'] = this.userStatus;
    data['mobile_no'] = this.mobileNo;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}
