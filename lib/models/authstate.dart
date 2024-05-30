class AdminAuth {
  final String? token;
  final String? username;
  final String? email;
  final String? mobileno;
  final String? usertype;

  // Default constructor with all fields optional and initially set to null
  AdminAuth({
    this.token,
    this.username,
    this.email,
    this.mobileno,
    this.usertype,
  });

  // Factory constructor to initialize all fields with default values
  factory AdminAuth.initial() {
    return AdminAuth(
      token: '',
      username: '',
      email: '',
      mobileno: '',
      usertype: '',
    );
  }

  // Method to create a new instance with modified fields
  AdminAuth copyWith({
    String? token,
    String? username,
    String? email,
    String? mobileno,
    String? usertype,
  }) {
    return AdminAuth(
      token: token ?? this.token,
      username: username ?? this.username,
      email: email ?? this.email,
      mobileno: mobileno ?? this.mobileno,
      usertype: usertype ?? this.usertype,
    );
  }

  // Constructor to create an instance from a JSON object
  AdminAuth.fromJson(Map<String, dynamic> json)
    : token = json['token'] as String?,
      username = json['username'] as String?,
      email = json['email'] as String?,
      mobileno = json['mobileno'] as String?,
      usertype = json['usertype'] as String?;

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() => {
    'token' : token,
    'username' : username,
    'email' : email,
    'mobileno' : mobileno,
    'usertype' : usertype,
  };
}
