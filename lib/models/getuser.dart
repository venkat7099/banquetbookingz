import 'package:image_picker/image_picker.dart';

class getUser {
  int? statusCode;
  bool? success;
  List<String>? messages;
  List<Data>? data;

  getUser({this.statusCode, this.success, this.messages, this.data});

  getUser.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? profilepic;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? height;
  String? weight;
  String? dob;
  String? location;
  String? address;
  String? address2;
  String? city;
  String? zip;
  String? emailId;
  String? password;
  int? mobileNo;
  String? gender;
  String? userrole;
  Null userstatus;
  XFile? _xfile;

  Data({
    this.id,
    this.profilepic,
    this.firstName,
    this.lastName,
    this.height,
    this.weight,
    this.dob,
    this.location,
    this.address,
    this.address2,
    this.city,
    this.zip,
    this.emailId,
    this.password,
    this.mobileNo,
    this.gender,
    this.userrole,
    this.userstatus,
    XFile? xfile,
  }) : _xfile = xfile;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilepic = json['profilepic'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    height = json['height'];
    weight = json['weight'];
    dob = json['dob'];
    location = json['location'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    zip = json['zip'];
    emailId = json['emailId'];
    password = json['password'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
    userrole = json['userrole'];
    userstatus = json['userstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profilepic'] = profilepic;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['height'] = height;
    data['weight'] = weight;
    data['dob'] = dob;
    data['location'] = location;
    data['address'] = address;
    data['address2'] = address2;
    data['city'] = city;
    data['zip'] = zip;
    data['emailId'] = emailId;
    data['password'] = password;
    data['mobileNo'] = mobileNo;
    data['gender'] = gender;
    data['userrole'] = userrole;
    data['userstatus'] = userstatus;
    return data;
  }
}
