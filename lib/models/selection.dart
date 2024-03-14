import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectionModel {
  final bool checkBox;
  bool isLoading;
  String? errorMessage;
  final TextEditingController email;
  final TextEditingController password;

  SelectionModel(
      {this.checkBox = false,
      this.isLoading = false,
      this.errorMessage,
      TextEditingController? email,
      TextEditingController? password
      // Allow passing a controller
      })
      : email = email ?? TextEditingController(),
        password = password ??
            TextEditingController(); // Use an existing controller or create a new one

  SelectionModel copyWith(
      {bool? checkBox, bool? isLoading, String? errorMessage}) {
    return SelectionModel(
        checkBox: checkBox ?? this.checkBox,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
        password: password ?? this.password

        // Preserve the original controller
        );
  }
}
