import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectionModel {
  final bool checkBox;
  final String gender;
  bool isLoading;
  bool addUser;
  int?index;
  bool addSubscriber;
  bool?subDetails;
  String? errorMessage;
  final TextEditingController email;
  final TextEditingController name;
  final TextEditingController password;
  SelectionModel(
      {this.checkBox = false,
      this.gender="m",
      this.isLoading = false,
      this.addUser = false,
      this.index,
      this.addSubscriber = false,
      this.subDetails=false,
      this.errorMessage,
      TextEditingController? email,
      TextEditingController? name,
      TextEditingController? password,
      // Allow passing a controller
      })
      : email = email ?? TextEditingController(),
        name = name ??
            TextEditingController(),password = password ??
            TextEditingController(); // Use an existing controller or create a new one

  SelectionModel copyWith(
      {bool? checkBox,String?gender, bool? isLoading,bool?addUser,int?index,  bool?addSubscriber,
      bool?subDetails,String? errorMessage,TextEditingController? email,
      TextEditingController? name,
      TextEditingController? password,}) {
    return SelectionModel(
        checkBox: checkBox ?? this.checkBox,
        gender: gender??this.gender,
        isLoading: isLoading ?? this.isLoading,
        addUser: addUser??this.addUser,
        index: index??this.index,
        addSubscriber: addSubscriber??this.addSubscriber,
        subDetails: subDetails??this.subDetails,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password??this.password

        // Preserve the original controller
        );
  }
}
