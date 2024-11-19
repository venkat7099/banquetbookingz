
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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['messages'] = messages;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['email'] = email;
    data['user_role'] = userRole;
    data['user_status'] = userStatus;
    data['mobile_no'] = mobileNo;
    data['profile_pic'] = profilePic;
    return data;
  }
}
