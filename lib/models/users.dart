class Users {
  int? statusCode;
  bool? success;
  List<String>? messages;
  Data? data;

  Users({this.statusCode, this.success, this.messages, this.data});

  Users.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    messages = List<String>.from(json['messages'] ?? []);
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  String? profilePic;

  Data({
    this.userId,
    this.username,
    this.email,
    this.userRole,
    this.userStatus,
    this.profilePic,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    userRole = json['user_role'];
    userStatus = json['user_status'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['email'] = email;
    data['user_role'] = userRole;
    data['user_status'] = userStatus;
    data['profile_pic'] = profilePic;
    return data;
  }
}
