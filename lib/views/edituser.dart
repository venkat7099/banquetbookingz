import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../models/users.dart'; // Import the User model
import '../providers/usersprovider.dart';

class EditUser extends ConsumerStatefulWidget {
  // final User user; // Accept User object as a parameter

  const EditUser({Key? key, }) : super(key: key);

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
  late Map<String, dynamic> args; // Change to late and remove null-safety issues.
  

  @override
   void didChangeDependencies() {
    super.didChangeDependencies();

     // Fetch the arguments safely
    final receivedArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

  

    // Assign to args and initialize controllers
    args = receivedArgs!;
    _nameController.text = args['username'] ?? '';
    _emailController.text = args['email'] ?? '';
    _mobileController.text = args['mobileNo'] ?? '';
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
   final userid = args['userid'];
   print(userid);
  if (userid == null) { // Check the passed `userid`
    _showAlertDialog('Error', 'User ID is missing.');
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final userNotifier = ref.read(usersProvider.notifier);

    await userNotifier.updateUser(
      userid,
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
              Navigator.of(context).pop(); // Close the dialog
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
      //  final id = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic> ;
      // var userid=id['userid'];
       final receivedArgs =ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
       var userid=receivedArgs!['userid'].toString();
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
              _buildProfileImagePicker(),
              const SizedBox(height: 5),
              _buildTextField(_nameController, "User Name", "Full Name"),
              const SizedBox(height: 5),
              _buildTextField(
                _emailController,
                "Email ID",
                "Email Address",
                TextInputType.emailAddress,
                _validateEmail,
              ),
              const SizedBox(height: 5),
              _buildTextField(
                _mobileController,
                "Mobile Number",
                "Phone Number",
                TextInputType.phone,
                _validatePhoneNumber,
              ),
              const SizedBox(height: 10),
              _buildSaveButton(screenWidth,userid),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker() {
  final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  final profilePic = args?['profilePic'];

  return Container(
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
            Text(
              "Profile Photo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _showImageSourceSelector,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // _profileImage != null
              //     ? Image.file(
              //         _profileImage!,
              //         width: 150,
              //         height: 150,
              //         fit: BoxFit.cover,
              //       )
              //     : (profilePic != null && profilePic.isNotEmpty)
              //         ? Image.network(
              //             profilePic,
              //             width: 150,
              //             height: 150,
              //             fit: BoxFit.cover,
              //             errorBuilder: (context, error, stackTrace) {
              //               return const Icon(Icons.error, size: 120, color: Colors.red);
              //             },
              //           )
              //         :
              Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFb0b0b0), width: 2),
                            borderRadius: BorderRadius.circular(75),
                          ),
                          width: 150,
                          height: 150,
                          child: Icon(Icons.person, size: 120, color: Colors.grey[700]),
                        ),
              if (_isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildTextField(TextEditingController controller, String labelText, String hintText,
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
    if (value == null || value.isEmpty) return 'Please enter an email';
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a phone number';
    if (value.length != 10) return 'Please enter a valid 10-digit phone number';
    return null;
  }

  Widget _buildSaveButton(double screenWidth ,String userId) {
   

    return GestureDetector(
    onTap: () => _saveUser(), // Wrap the function call in a lambda
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
