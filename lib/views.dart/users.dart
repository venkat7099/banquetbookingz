import 'dart:io';

import 'package:banquetbookingz/models/authstate.dart';
import 'package:banquetbookingz/providers/authprovider.dart';
import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
import 'package:banquetbookingz/providers/getuserprovider.dart';
import 'package:banquetbookingz/providers/imageprovider.dart';
import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/views.dart/addsubscriber.dart';
import 'package:banquetbookingz/views.dart/adduser.dart';
import 'package:banquetbookingz/views.dart/example.dart';
import 'package:banquetbookingz/views.dart/loginpage.dart';
import 'package:banquetbookingz/views.dart/subcriptiondetails.dart';
import 'package:banquetbookingz/widgets/button2.dart';
import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
import 'package:banquetbookingz/widgets/customtextfield.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Users extends ConsumerStatefulWidget {
  const Users({super.key});

  @override
  ConsumerState<Users> createState() => _UsersState();
}

class _UsersState extends ConsumerState<Users> {
  @override
  void initState() {
    super.initState();
    // Call getUsers() when the widget is inserted into the widget tree
    ref.read(getUserProvider.notifier).getUsers();
    // ref.read(getUserProvider.notifier).getProfilePic();
    Future.microtask(() {
      // Get the ID passed via arguments
     
      final id = ModalRoute.of(context)?.settings.arguments as int?;
      print(id);
      final ids=ref.read(selectionModelProvider).index;
      print(ids);
      // Get user details from your state notifier
      final user = ref.read(getUserProvider.notifier).getUserById(ids!);

      if (user != null) {
        // Update the controllers with the user's data
        ref.read(selectionModelProvider.notifier).updateEnteredemail(user.emailId ?? '');
        ref.read(selectionModelProvider.notifier).updateEnteredName(user.firstName ?? '');
      //    if (user.profilepic != null) {
      //   ref.read(imageProvider.notifier).setProfilePic(XFile(user.profilepic!));
      // }
        // ... do the same for other fields
      }
    });
  }

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
Future<ImageSource?> _showImageSourceSelector(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
      
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [true, false, false, false];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final emailController = ref.watch(selectionModelProvider.select((model) => model.email));
  final nameController = ref.watch(selectionModelProvider.select((model) => model.name));
    final usersData=ref.watch(getUserProvider);
    
    List<Widget> _pages = [
      DashboardWidget(),
      Users(),
      LoginPage()
    ];
    return Scaffold(body:  Consumer(builder: (context, ref, child) {
      final _selectedIndex = ref.watch(pageIndexProvider);
      final selection=ref.watch(selectionModelProvider.notifier);
      final user=ref.watch(selectionModelProvider);
      return SingleChildScrollView(
        child: user.addUser==false && user.subDetails==false && user.editUser==false? Column(children: [
          StackWidget(hintText: "Search users", text: "Users",onTap: (){
            ref.watch(selectionModelProvider.notifier).toggleAddUser(true);
          },arrow: Icons.arrow_back,tabarrow: (){
            ref.read(pageIndexProvider.notifier).setPage(0);
          },),
          Container(width: screenWidth,
          
          padding: EdgeInsets.all(30),color: Color(0xFFf5f5f5),
            child: Column(children: [
              Container(padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.white,
                                        ),
                                        child: ToggleButtons(
          borderColor: Colors.white,
          fillColor: Colors.transparent,
          borderWidth: 0.0,
          selectedBorderColor: Colors.white,
          isSelected: isSelected,
          onPressed: (index) {
            setState(() {
        for (int i = 0; i < isSelected.length; i++) {
          isSelected[i] = i == index;
        }
            });
          },
          children: [
            _buildToggleButton('New', isSelected[0]),
            _buildToggleButton('Admin', isSelected[1]),
            _buildToggleButton('Moderator', isSelected[2]),
            _buildToggleButton('All', isSelected[3]),
          ],
        ),
        ),SizedBox(height: 20,),
              Consumer(builder: (context, ref, child) {
                
                
                return usersData.data==null?Container(height: screenHeight,width: screenWidth,color:Color(0xfff5f5f5),
                child: Center(child: Text("No data available",style: TextStyle(color: Color(0xffb4b4b4),fontSize: 17),)),): 
                 Container(padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                   child: SingleChildScrollView(
                     child: Column(
                       children: [
                         ListView.builder(
                           shrinkWrap: true, // Important to work inside a Column
                            
                                itemCount: usersData.data!.length,
                                itemBuilder: (context, index) {
                                  final user = usersData.data![index];
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                ref.watch(selectionModelProvider.notifier).subDetails(true);
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.account_circle, size: 40.0), // Placeholder for profile picture
                                                title: Text(user.firstName!??"no name"),
                                                subtitle: Text(user.userrole=="m"?"manager":"user"),
                                                trailing: IconButton(
                                                     icon: Icon(Icons.edit,color: Colors.purple,),
                                                     onPressed: () {
                                                               int? userId = usersData.data![index].id;
                                                         selection.Index(userId);
                                                         selection.toggleEditUser(true);
                                                //  Navigator.of(context).pushNamed("edituser",arguments: userId);  
                                                //  ref.watch(getUserProvider.notifier).getProfilePic(userId.toString());        // Add action for edit icon press
                                                     },
                                                ),
                                              ),
                                            ),
                                            Divider(thickness: 1,)
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                       ],
                     ),
                   ),
                 );}
              ),],),
          )
        ],): user.addUser==true&&user.subDetails==false && user.editUser==false? AddUser():
        user.addUser==false&& user.editUser==true&&user.subDetails==false? Consumer(builder: (context, ref, child){
             final _selectedIndex = ref.watch(pageIndexProvider);
             final AddUser=ref.watch(selectionModelProvider.notifier);
            return SingleChildScrollView(child: Form(key: _formKey,
              child: Container(width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(20),
              color: Color(0xFFf5f5f5),
                child: Column(children: [SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    InkWell(child: Icon(Icons.arrow_back),onTap: (){
                      
                      AddUser.toggleEditUser(false);
                    },),
                    Text("Add User",style: TextStyle(color: Color(0XFF6418C3),fontSize: 18),)
                  ],),
                  SizedBox(height: 20,),
                  Container(
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [Text("Profile Photo",style: TextStyle(fontWeight: FontWeight.bold,
                                                    fontSize: 20,color: Colors.black),)],),
                                               SizedBox(height: 15,),
                                               Consumer(builder: (context, ref, child) {
                          final pickedImage = ref.watch(imageProvider).profilePic;
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed("uploadphoto");
                                },
                                child: pickedImage != null
                                    ? Container(
                                        width: 150,
                                        height: 150,
                                        child: Image.file(File(pickedImage!.path)))
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFFb0b0b0), width: 2)),
                                        width: 150,
                                        height: 150,
                                        child: Icon(Icons.person,
                                            color: Colors.grey[700], size: 120),
                                      ),
                              ),
                              SizedBox(height: 10,),
                              Text(pickedImage!=null?"":"field required",style: TextStyle(color: Colors.red,fontSize: 12),)
                            ],
                          );
                        }),
                                                    
                                                    
                                                   
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Container(padding: EdgeInsets.all(15),
                                               decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                  Text("UserName",style: TextStyle(fontWeight: FontWeight.bold,
                                                  fontSize: 20,color: Colors.black),),
                                                  SizedBox(height: 20,),
                                                  Text("full Name",style: TextStyle(color: Colors.black,fontSize: 16),),
                                                  SizedBox(height: 10,),
                                                  Consumer(builder: (context, ref, child){
                                                    final controller=ref.watch(selectionModelProvider.notifier);
                                                    return CustomTextFormField(width: MediaQuery.of(context).size.width*0.8,
                                                    textController: nameController,
                                                    keyBoardType: TextInputType.text,
                                                
                                                    onChanged: (newVlue){
                                                      controller.updateEnteredName(newVlue);
                                                    },
                                                    applyDecoration: true,hintText: "Type here",
                                                     validator: (value) {
                                                                            if (value == null || value.isEmpty) {
                                                                              return 'Field is required';
                                                                            }
                                                    
                                                                            
                                                                            return null;
                                                                          },);}
                                                  ),
                                                  SizedBox(height: 20,),
                                                   Text("Email ID",style: TextStyle(color: Colors.black,fontSize: 16),),
                                                  SizedBox(height: 10,),
                                                  Consumer(builder: (context, ref, child){
                                                    final controller=ref.watch(selectionModelProvider.notifier);
                                                    return CustomTextFormField(width:MediaQuery.of(context).size.width*0.8,
                                                    textController: emailController,
                                                    keyBoardType: TextInputType.emailAddress,
                                                    onChanged: (newValue){
                                                      controller.updateEnteredemail(newValue);
                                                    },
                                                    applyDecoration: true,hintText: "Type here",
                                                     validator: (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return 'Field is required';
                                                                                  }
                                                                                  String pattern =
                                                                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                                                  RegExp regex = RegExp(pattern);
                                                                                  if (!regex.hasMatch(value)) {
                                                                                    return 'Enter a valid email address';
                                                                                  }
                                                                                  return null;
                                                                                },);}
                                                  ),
                                                  SizedBox(height: 20,),
                                                   Text("Gender",style: TextStyle(color: Colors.black,fontSize: 16),),
                                                   SizedBox(height:10),
                                                   Consumer(
                              builder: (context, ref, child) {
                                var selectGender =
                                    ref.read(selectionModelProvider.notifier);
              
                                return
                                    Row(children: [
                                      ref.watch(selectionModelProvider).gender == 'm'
                                          ? CustomGenderButton(
                                              borderRadius: 5,
                                              text: 'Male',
                                              onPressed: () {
                                                selectGender.setGender("m");
                                              },
                                            )
                                          : CustomGenderButton(
                                              borderRadius: 5,
                                              text: 'Male',
                                              onPressed: () {
                                                selectGender.setGender("m");
                                              },
                                              color: Colors.white,
                                              foreGroundColor: Color(0xFF6418C3),
                                              borderColor: Color(0xFF6418C3),
                                            ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ref.watch(selectionModelProvider).gender == 'f'
                                          ? CustomGenderButton(
                                              borderRadius: 5,
                                              text: 'Female',
                                              onPressed: () {
                                                selectGender.setGender("f");
                                              },
                                            )
                                          : CustomGenderButton(
                                              borderRadius: 5,
                                              text: 'Female',
                                              onPressed: () {
                                                selectGender.setGender("f");
                                              },
                                              color: Colors.white,
                                              foreGroundColor: Color(0xFF6418C3),
                                              borderColor: Color(0xFF6418C3),
                                            ),
                                     
                                    ])
                                 ;
                              },
                            ),
                            SizedBox(height: 20,),
                             Text("Account Type",style: TextStyle(color: Colors.black,fontSize: 16),),
                                                  SizedBox(height: 10,),
                                                  Consumer(builder: (context, ref, child){
                                                    final controller=ref.watch(selectionModelProvider.notifier);
                                                    return CustomTextFormField(width: MediaQuery.of(context).size.width*0.8,
                                                   readOnly: true,
                                                   
                                                    applyDecoration: true,
                                                     );}
                                                  ),
              
                        ],),),
                 SizedBox(height: 40,),
                 Consumer(builder: (context, ref, child) {
                  final pickedImage = ref.watch(imageProvider).profilePic;
                  final selection=ref.watch(selectionModelProvider);
                  final loading=ref.watch(loadingProvider);
                   return CustomElevatedButton(text: "Add User", borderRadius:10,foreGroundColor: Colors.white,
                   width: double.infinity,
                   backGroundColor: Color(0XFF6418C3),
                   isLoading: loading,onPressed: loading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()&&pickedImage!=null) {
                                      // If the form is valid, proceed with the login process
                                      
                                      final LoginResult result= await ref.read(authProvider.notifier).addUser(pickedImage,selection.name.text,
                                      selection.email.text,selection.gender,selection.password.text, ref);
                                      if(result.statusCode==201){
                                        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.check_circle, size: 50, color: Color(0XFF6418C3)),
                    SizedBox(height: 15),
                    Text(
                      'Suresh Ramesh has been successfully added as a user.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Login details have been mailed to the user.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 20),
                    Consumer(builder: (context, ref, child){
                      final addUser=ref.watch(selectionModelProvider.notifier);
                      return CustomElevatedButton(text: "OK", borderRadius:20,width: 100,foreGroundColor: Colors.white,
                      backGroundColor: Color(0XFF6418C3),onPressed: (){
                        addUser.toggleAddUser(false);
                        Navigator.of(context).pushNamed("users");
                      },);}
                    )
                  ],
                ),
              ),
            );
          },
        );
                                      }else if (result.statusCode == 400) {
                                        // If an error occurred, show a dialog box with the error message.
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Login Error'),
                                              content: Text(result.errorMessage ??
                                                  'An unknown error occurred.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog box
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },);}
                 )
                ],),
              ),
            ));}
          ) :SubscriptionDetils(),
      );}
    ),
    //
    );
  }
}
Widget _buildToggleButton(String text, bool isSelected) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: isSelected ? Colors.purple : Colors.black,
        decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
      ),
    ),
  );
}
