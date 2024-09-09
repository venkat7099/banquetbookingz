class Users {
  final int id;
  final String? profilePic;
  final String? username;
  final String? email;
  final String? mobileNo;
  final String? userType;
  final String? gender;

  Users({
    required this.id,
    this.profilePic,
    this.username,
    this.email,
    this.mobileNo,
    this.userType,
    this.gender,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      profilePic: json['profile_pic'],
      username: json['username'],
      email: json['email'],
      mobileNo: json['mobileno'],
      userType: json['user_type'],
      gender: json['gender'],
    );
  }

  // get id => null;

  Map<String, dynamic> toJson() {
    return {
      'profile_pic': profilePic,
      'username': username,
      'email': email,
      'mobileno': mobileNo,
      'gender': gender,
    };
  }
}
