import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banquetbookingz/widgets/button2.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';

class EditUser extends StatefulWidget {
  final int? user_id;
  final String? userName;
  final String? email;
  final String? mobileNo;
  final String? gender;
  final String? profilepic;

  const EditUser({
    super.key,
    this.user_id,
    this.userName,
    this.email,
    this.mobileNo,
    this.gender,
    this.profilepic,
  });

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllerName.text = widget.userName ?? '';
    _controllerEmail.text = widget.email ?? '';
    _controllerMobile.text = widget.mobileNo ?? '';

    if (widget.profilepic != null) {
      if (widget.profilepic!.startsWith('http')) {
        _profileImage = null;
      } else {
        _profileImage = File(widget.profilepic!);
      }
    }

    // if (widget.gender != null) {
    //   ref.read(selectionModelProvider.notifier).setGender(widget.gender!);
    // }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Map<String, dynamic> userData = {
      'user_id': widget.user_id,
      'username': _controllerName.text,
      'email': _controllerEmail.text,
      'mobile': _controllerMobile.text,
      // 'gender': ref.read(selectionModelProvider).gender ?? '',
    };

    if (_profileImage != null) {
      final bytes = await _profileImage!.readAsBytes();
      String base64Image = base64Encode(bytes);
      userData['profilepic'] = base64Image;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      print("Retrieved token: $accessToken");

      final response = await http.put(
        Uri.parse('http://93.127.172.164:8080/api/update_user_admin/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
        body: jsonEncode(userData),
      );

      print('Server Response Code: ${response.statusCode}');
      print('widget User id: ${widget.user_id}');
      print('Server Response Body: ${response.body}');

      if (response.statusCode == 200) {
        _showAlertDialog('Success', 'User updated successfully!');
      } else {
        _showAlertDialog('Error', 'Server error, please try again later');
      }
    } catch (e) {
      print('Error: $e');
      _showAlertDialog('Error', 'Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0XFF6418C3)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xfff5f5f5),
        title: const Text("Edit User",
            style: TextStyle(color: Color(0XFF6418C3), fontSize: 20)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Profile Photo",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _showImageSourceSelector,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _profileImage != null
                              ? SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Image.file(
                                    _profileImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : widget.profilepic != null &&
                                      widget.profilepic!.startsWith('http')
                                  ? SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: Image.network(
                                        widget.profilepic!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFFb0b0b0),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(75),
                                      ),
                                      width: 150,
                                      height: 150,
                                      child: Icon(Icons.person,
                                          color: Colors.grey[700], size: 120),
                                    ),
                          if (_isLoading)
                            const Positioned(
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _profileImage == null && widget.profilepic == null
                          ? "Field required"
                          : "",
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              _buildTextField(_controllerName, "User Name", "Full Name"),
              const SizedBox(height: 5),
              _buildTextField(_controllerEmail, "Email ID", "Email Address",
                  TextInputType.emailAddress, _validateEmail),
              const SizedBox(height: 5),
              _buildTextField(_controllerMobile, "Mobile Number",
                  "Phone Number", TextInputType.phone, _validatePhoneNumber),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),

              ),
              _buildGenderSelection(), // Gender Selection UI
              const SizedBox(height: 5),
              _buildSaveButton(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, String hintText,
      [TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator]) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  Widget _buildGenderSelection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),

    );
  }

  Widget _buildSaveButton(double screenWidth) {
    return GestureDetector(
      onTap: _saveUser,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0XFF6418C3),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        width: screenWidth,
        child: const Center(
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _showImageSourceSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
