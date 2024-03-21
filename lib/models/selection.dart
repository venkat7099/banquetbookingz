import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectionModel {
  final String? sub;
  final bool checkBox;
  final String gender;
  final bool isLoading;
 final bool?dashboard;
  final bool addUser;
  final bool editUser;
  final int?index;
  final bool addSubscriber;
 final bool?subDetails;
  final String? errorMessage;
  final TextEditingController email;
  final TextEditingController name;
  final TextEditingController password;
  final TextEditingController subName;
  final TextEditingController annualP;
  final TextEditingController quaterlyP;
  final TextEditingController monthlyP;
  SelectionModel(
      {this.sub="d",
        this.checkBox = false,
      this.gender="m",
      this.isLoading = false,
      this.dashboard=true,
      this.addUser = false,
        this.editUser = false,
      this.index,
      this.addSubscriber = false,
      this.subDetails=false,
      this.errorMessage,
      TextEditingController? email,
      TextEditingController? name,
      TextEditingController? password,
      TextEditingController? subName,
      TextEditingController? annualP,
      TextEditingController? quaterlyP,
      TextEditingController? monthlyP,
      // Allow passing a controller
      })
      : email = email ?? TextEditingController(),
        name = name ??
            TextEditingController(),password = password ??
            TextEditingController(),subName = subName ?? TextEditingController(),annualP = annualP ?? TextEditingController(),
            quaterlyP = quaterlyP ?? TextEditingController(),monthlyP = monthlyP ?? TextEditingController(); // Use an existing controller or create a new one

  SelectionModel copyWith(
      { String?sub, bool? checkBox,String?gender, bool? isLoading,bool?dashboard,bool?addUser,bool? editUser,  int?index,  bool?addSubscriber,
      bool?subDetails,String? errorMessage,TextEditingController? email,
      TextEditingController? name,
      TextEditingController? password,
      TextEditingController? subName,
      TextEditingController? annualP ,TextEditingController? quaterlyP,
      TextEditingController? monthlyP,}) {
    return SelectionModel(
      sub: sub??this.sub,
        checkBox: checkBox ?? this.checkBox,
        gender: gender??this.gender,
        isLoading: isLoading ?? this.isLoading,
        dashboard: dashboard??this.dashboard,
        addUser: addUser??this.addUser,
        editUser: editUser??this.editUser,
        index: index??this.index,
        addSubscriber: addSubscriber??this.addSubscriber,
        subDetails: subDetails??this.subDetails,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password??this.password,
        subName: subName??this.subName,
        annualP: annualP??this.annualP,
        quaterlyP: quaterlyP??this.quaterlyP,
        monthlyP: monthlyP??this.monthlyP

        // Preserve the original controller
        );
  }
}
