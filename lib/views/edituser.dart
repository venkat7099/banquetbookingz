import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/usersprovider.dart';

class EditUser extends ConsumerStatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends ConsumerState<EditUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  late Map<String, dynamic> args;
  bool _initialized = false; // Flag to ensure initialization only happens once

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final receivedArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (receivedArgs != null) {
        args = receivedArgs;
        _nameController.text = args['username'] ?? '';
        _emailController.text = args['email'] ?? '';
        _mobileController.text = args['mobileNo'] ?? '';
      } else {
        _showAlertDialog('Error', 'Invalid arguments passed.');
      }
      _initialized = true;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showAlertDialog('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> _saveUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final userId = args['userid'];
    if (userId == null) {
      _showAlertDialog('Error', 'User ID is missing.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userNotifier = ref.read(usersProvider.notifier);

      await userNotifier.updateUser(
        userId,
        _nameController.text,
        _emailController.text,
        _mobileController.text,
        _profileImage,
      );

      _showAlertDialog('Success', 'User updated successfully!');
    } catch (e) {
      _showAlertDialog('Error', 'An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (title == 'Success') {
                Navigator.of(context).pushReplacementNamed('users');
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final profilePic = args['profilePic'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0XFF6418C3)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xfff5f5f5),
        title: const Text(
          "Edit User",
          style: TextStyle(color: Color(0XFF6418C3), fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Profile Photo",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _showImageSourceSelector(),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFb0b0b0), width: 2),
                              borderRadius: BorderRadius.circular(75),
                            ),
                            width: 150,
                            height: 150,
                            child: _profileImage != null
                                ? Image.file(_profileImage!, fit: BoxFit.cover)
                                : (profilePic != null
                                    ? Image.network(profilePic, fit: BoxFit.cover)
                                    : const Icon(Icons.person, size: 120)),
                          ),
                          if (_isLoading) const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "User Name",
                    hintText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email ID",
                    hintText: "Email Address",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    hintText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _saveUser(),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: const Color(0XFF6418C3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
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
      ),
    );
  }
}
