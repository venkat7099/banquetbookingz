class UserResponse {
  int? statusCode;
  bool? success;
  List<String>? messages;
  List<User>? data;

  UserResponse({this.statusCode, this.success, this.messages, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    messages = List<String>.from(json['messages'] ?? []);
    data = (json['data'] as List<dynamic>?)
        ?.map((item) => User.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['statusCode'] = statusCode;
    json['success'] = success;
    json['messages'] = messages;
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class User {
  int? userId;
  String? username;
  String? email;
  String? userRole;
  bool? userStatus;
  String? mobileNo;
  String? profilePic;

  var data;

  User({
    this.userId,
    this.username,
    this.email,
    this.userRole,
    this.userStatus,
    this.mobileNo,
    this.profilePic,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    userRole = json['user_role'];
    userStatus = json['user_status'] == 1;
    mobileNo = json['mobile_no'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['email'] = email;
    data['user_role'] = userRole;
    data['user_status'] = userStatus == true ? 1 : 0; // Convert bool to int
    data['mobile_no'] = mobileNo;
    data['profile_pic'] = profilePic;
    return data;
  }
}
extension UserCopyWith on User {
  User copyWith({String? profilePic}) {
    return User(
      userId: userId,
      username: username,
      email: email,
      userRole: userRole,
      userStatus: userStatus,
      mobileNo: mobileNo,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}
