// import 'dart:io';

// import 'package:banquetbookingz/providers/authprovider.dart';
// import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
// import 'package:banquetbookingz/providers/getuserprovider.dart';
// import 'package:banquetbookingz/providers/imageprovider.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/providers/usersprovider.dart';
// import 'package:banquetbookingz/views.dart/example.dart';
// import 'package:banquetbookingz/views.dart/loginpage.dart';
// import 'package:banquetbookingz/views.dart/users.dart';
// import 'package:banquetbookingz/widgets/button2.dart';
// import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
// import 'package:banquetbookingz/widgets/customtextfield.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// class EditUser extends ConsumerStatefulWidget {
//   EditUser({super.key});

//   @override
//   ConsumerState<EditUser> createState() => _EditUserState();
// }

// class _EditUserState extends ConsumerState<EditUser> {

//     @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       // Get the ID passed via arguments

//       final id = ModalRoute.of(context)?.settings.arguments as int?;
//       print(id);
//       final ids=ref.read(selectionModelProvider).userIndex;
//       print(ids);
//       // Get user details from your state notifier
//       final user = ref.read(usersProvider.notifier).getUserById(ids!);

//       if (user != null) {
//         // Update the controllers with the user's data
//         ref.read(selectionModelProvider.notifier).updateEnteredemail(user.emailId ?? '');
//         ref.read(selectionModelProvider.notifier).updateEnteredName(user.firstName ?? '');
//       //    if (user.profilepic != null) {
//       //   ref.read(imageProvider.notifier).setProfilePic(XFile(user.profilepic!));
//       // }
//         // ... do the same for other fields
//       }
//     });
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// Future<ImageSource?> _showImageSourceSelector(BuildContext context) {
//     return showModalBottomSheet<ImageSource>(
//       context: context,
//       builder: (BuildContext context) {

//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text('Camera'),
//                 onTap: () => Navigator.of(context).pop(ImageSource.camera),
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () => Navigator.of(context).pop(ImageSource.gallery),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ScreenHeight=MediaQuery.of(context).size.height;
//     final ScreenWidth=MediaQuery.of(context).size.width;
//       final emailController = ref.watch(selectionModelProvider.select((model) => model.email));
//   final nameController = ref.watch(selectionModelProvider.select((model) => model.name));
//     final TextEditingController _accountType = TextEditingController(text: "Manager");
//     List<Widget> _pages = [
//       DashboardWidget(),
//       Users(),
//       LoginPage()
//     ];
//     return  Scaffold(
//       body: Consumer(builder: (context, ref, child){
//              final _selectedIndex = ref.watch(pageIndexProvider);
//              final AddUser=ref.watch(selectionModelProvider.notifier);
//             return SingleChildScrollView(child: Form(key: _formKey,
//               child: Container(width: ScreenWidth,padding: EdgeInsets.all(20),
//               color: Color(0xFFf5f5f5),
//                 child: Column(children: [SizedBox(height: 20,),
//                   Row(mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                     InkWell(child: Icon(Icons.arrow_back),onTap: (){

//                       Navigator.of(context).pop();
//                     },),
//                     Text("Add User",style: TextStyle(color: Color(0XFF6418C3),fontSize: 18),)
//                   ],),
//                   SizedBox(height: 20,),
//                   Container(
//                                                 padding: EdgeInsets.all(15),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     Row(mainAxisAlignment: MainAxisAlignment.start,
//                                                       children: [Text("Profile Photo",style: TextStyle(fontWeight: FontWeight.bold,
//                                                     fontSize: 20,color: Colors.black),)],),
//                                                SizedBox(height: 15,),
//                                                Consumer(builder: (context, ref, child) {
//                           final pickedImage = ref.watch(imageProvider).profilePic;
//                           return Column(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).pushNamed("uploadphoto");
//                                 },
//                                 child: pickedImage != null
//                                     ? Container(
//                                         width: 150,
//                                         height: 150,
//                                         child: Image.file(File(pickedImage!.path)))
//                                     : Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Color(0xFFb0b0b0), width: 2)),
//                                         width: 150,
//                                         height: 150,
//                                         child: Icon(Icons.person,
//                                             color: Colors.grey[700], size: 120),
//                                       ),
//                               ),
//                               SizedBox(height: 10,),
//                               Text(pickedImage!=null?"":"field required",style: TextStyle(color: Colors.red,fontSize: 12),)
//                             ],
//                           );
//                         }),

//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(height: 20,),
//                                               Container(padding: EdgeInsets.all(15),
//                                                decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                   Text("UserName",style: TextStyle(fontWeight: FontWeight.bold,
//                                                   fontSize: 20,color: Colors.black),),
//                                                   SizedBox(height: 20,),
//                                                   Text("full Name",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                   SizedBox(height: 10,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final controller=ref.watch(selectionModelProvider.notifier);
//                                                     return CustomTextFormField(width: ScreenWidth*0.8,
//                                                     textController: nameController,
//                                                     keyBoardType: TextInputType.text,

//                                                     onChanged: (newVlue){
//                                                       controller.updateEnteredName(newVlue);
//                                                     },
//                                                     applyDecoration: true,hintText: "Type here",
//                                                      validator: (value) {
//                                                                             if (value == null || value.isEmpty) {
//                                                                               return 'Field is required';
//                                                                             }

//                                                                             return null;
//                                                                           },);}
//                                                   ),
//                                                   SizedBox(height: 20,),
//                                                    Text("Email ID",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                   SizedBox(height: 10,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final controller=ref.watch(selectionModelProvider.notifier);
//                                                     return CustomTextFormField(width: ScreenWidth*0.8,
//                                                     textController: emailController,
//                                                     keyBoardType: TextInputType.emailAddress,
//                                                     onChanged: (newValue){
//                                                       controller.updateEnteredemail(newValue);
//                                                     },
//                                                     applyDecoration: true,hintText: "Type here",
//                                                      validator: (value) {
//                                                                                   if (value == null || value.isEmpty) {
//                                                                                     return 'Field is required';
//                                                                                   }
//                                                                                   String pattern =
//                                                                                       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                                                                                   RegExp regex = RegExp(pattern);
//                                                                                   if (!regex.hasMatch(value)) {
//                                                                                     return 'Enter a valid email address';
//                                                                                   }
//                                                                                   return null;
//                                                                                 },);}
//                                                   ),
//                                                   SizedBox(height: 20,),
//                                                    Text("Gender",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                    SizedBox(height:10),
//                                                    Consumer(
//                               builder: (context, ref, child) {
//                                 var selectGender =
//                                     ref.read(selectionModelProvider.notifier);

//                                 return
//                                     Row(children: [
//                                       ref.watch(selectionModelProvider).gender == 'm'
//                                           ? CustomGenderButton(
//                                               borderRadius: 5,
//                                               text: 'Male',
//                                               onPressed: () {
//                                                 selectGender.setGender("m");
//                                               },
//                                             )
//                                           : CustomGenderButton(
//                                               borderRadius: 5,
//                                               text: 'Male',
//                                               onPressed: () {
//                                                 selectGender.setGender("m");
//                                               },
//                                               color: Colors.white,
//                                               foreGroundColor: Color(0xFF6418C3),
//                                               borderColor: Color(0xFF6418C3),
//                                             ),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       ref.watch(selectionModelProvider).gender == 'f'
//                                           ? CustomGenderButton(
//                                               borderRadius: 5,
//                                               text: 'Female',
//                                               onPressed: () {
//                                                 selectGender.setGender("f");
//                                               },
//                                             )
//                                           : CustomGenderButton(
//                                               borderRadius: 5,
//                                               text: 'Female',
//                                               onPressed: () {
//                                                 selectGender.setGender("f");
//                                               },
//                                               color: Colors.white,
//                                               foreGroundColor: Color(0xFF6418C3),
//                                               borderColor: Color(0xFF6418C3),
//                                             ),

//                                     ])
//                                  ;
//                               },
//                             ),
//                             SizedBox(height: 20,),
//                              Text("Account Type",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                   SizedBox(height: 10,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final controller=ref.watch(selectionModelProvider.notifier);
//                                                     return CustomTextFormField(width: ScreenWidth*0.8,
//                                                    readOnly: true,
//                                                    textController: _accountType,
//                                                     applyDecoration: true,
//                                                      );}
//                                                   ),

//                         ],),),
//                  SizedBox(height: 40,),
//                  Consumer(builder: (context, ref, child) {
//                   final pickedImage = ref.watch(imageProvider).profilePic;
//                   final selection=ref.watch(selectionModelProvider);
//                   final loading=ref.watch(loadingProvider);
//                    return CustomElevatedButton(text: "Add User", borderRadius:10,foreGroundColor: Colors.white,
//                    width: double.infinity,
//                    backGroundColor: Color(0XFF6418C3),
//                    isLoading: loading,onPressed: loading
//                                 ? null
//                                 : () async {
//                                     if (_formKey.currentState!.validate()&&pickedImage!=null) {
//                                       If the form is valid, proceed with the login process

//                                       final UserResult result= await ref.read(usersProvider.notifier).addUser(pickedImage,selection.name.text,
//                                       selection.email.text,selection.gender, ref);
//                                       if(result.statusCode==201){
//                                         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Icon(Icons.check_circle, size: 50, color: Color(0XFF6418C3)),
//                     SizedBox(height: 15),
//                     Text(
//                       'Suresh Ramesh has been successfully added as a user.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       'Login details have been mailed to the user.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Consumer(builder: (context, ref, child){
//                       final addUser=ref.watch(selectionModelProvider.notifier);
//                       return CustomElevatedButton(text: "OK", borderRadius:20,width: 100,foreGroundColor: Colors.white,
//                       backGroundColor: Color(0XFF6418C3),onPressed: (){
//                         addUser.toggleAddUser(false);
//                         Navigator.of(context).pushNamed("users");
//                       },);}
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//                                       }else if (result.statusCode == 400) {
//                                         // If an error occurred, show a dialog box with the error message.
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return AlertDialog(
//                                               title: Text('Login Error'),
//                                               content: Text(result.errorMessage ??
//                                                   'An unknown error occurred.'),
//                                               actions: <Widget>[
//                                                 TextButton(
//                                                   child: Text('OK'),
//                                                   onPressed: () {
//                                                     Navigator.of(context)
//                                                         .pop(); // Close the dialog box
//                                                   },
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         );
//                                       }
//                                     }
//                                   },);}
//                  )
//                 ],),
//               ),
//             ));}
//           ),
//     )
//     ;

//   }
// }

// import 'dart:io';
// import 'package:banquetbookingz/providers/authprovider.dart';
// import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
// import 'package:banquetbookingz/providers/getuserprovider.dart';
// import 'package:banquetbookingz/providers/imageprovider.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/providers/usersprovider.dart';
// import 'package:banquetbookingz/views.dart/example.dart';
// import 'package:banquetbookingz/views.dart/loginpage.dart';
// import 'package:banquetbookingz/views.dart/users.dart';
// import 'package:banquetbookingz/widgets/button2.dart';
// import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
// import 'package:banquetbookingz/widgets/customtextfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// class EditUser extends ConsumerStatefulWidget {
//   EditUser({super.key, String? userName});

//   @override
//   ConsumerState<EditUser> createState() => _EditUserState();
// }

// class _EditUserState extends ConsumerState<EditUser> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       // Get the ID passed via arguments

//       final id = ModalRoute.of(context)?.settings.arguments as int?;
//       print(id);
//       final ids = ref.read(selectionModelProvider).userIndex;
//       print(ids);
//     });
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   Future<ImageSource?> _showImageSourceSelector(BuildContext context) {
//     return showModalBottomSheet<ImageSource>(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text('Camera'),
//                 onTap: () => Navigator.of(context).pop(ImageSource.camera),
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () => Navigator.of(context).pop(ImageSource.gallery),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ScreenHeight = MediaQuery.of(context).size.height;
//     final ScreenWidth = MediaQuery.of(context).size.width;
//     final emailController =
//         ref.watch(selectionModelProvider.select((model) => model.email));
//     final nameController =
//         ref.watch(selectionModelProvider.select((model) => model.name));
//     final TextEditingController _accountType =
//         TextEditingController(text: "Manager");
//     List<Widget> _pages = [DashboardWidget(), Users(), LoginPage()];
//     return Scaffold(
//       body: Consumer(builder: (context, ref, child) {
//         final _selectedIndex = ref.watch(pageIndexProvider);
//         final AddUser = ref.watch(selectionModelProvider.notifier);
//         return SingleChildScrollView(
//             child: Form(
//           key: _formKey,
//           child: Container(
//             width: ScreenWidth,
//             padding: EdgeInsets.all(20),
//             color: Color(0xFFf5f5f5),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       child: Icon(Icons.arrow_back),
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     Text(
//                       "Edit Profile",
//                       style: TextStyle(color: Color(0XFF6418C3), fontSize: 18),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Profile Photo",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                                 color: Colors.black),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Consumer(builder: (context, ref, child) {
//                         final pickedImage = ref.watch(imageProvider).profilePic;
//                         return Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context).pushNamed("uploadphoto");
//                               },
//                               child: pickedImage != null
//                                   ? Container(
//                                       width: 150,
//                                       height: 150,
//                                       child:
//                                           Image.file(File(pickedImage!.path)))
//                                   : Container(
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Color(0xFFb0b0b0),
//                                               width: 2)),
//                                       width: 150,
//                                       height: 150,
//                                       child: Icon(Icons.person,
//                                           color: Colors.grey[700], size: 120),
//                                     ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               pickedImage != null ? "" : "field required",
//                               style: TextStyle(color: Colors.red, fontSize: 12),
//                             )
//                           ],
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "UserName",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Colors.black),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "full Name",
//                         style: TextStyle(color: Colors.black, fontSize: 16),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Consumer(builder: (context, ref, child) {
//                         final controller =
//                             ref.watch(selectionModelProvider.notifier);
//                         return CustomTextFormField(
//                           width: ScreenWidth * 0.8,
//                           textController: nameController,
//                           keyBoardType: TextInputType.text,
//                           onChanged: (newVlue) {
//                             controller.updateEnteredName(newVlue);
//                           },
//                           applyDecoration: true,
//                           hintText: "Type here",
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Field is required';
//                             }

//                             return null;
//                           },
//                         );
//                       }),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "Email ID",
//                         style: TextStyle(color: Colors.black, fontSize: 16),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Consumer(builder: (context, ref, child) {
//                         final controller =
//                             ref.watch(selectionModelProvider.notifier);
//                         return CustomTextFormField(
//                           width: ScreenWidth * 0.8,
//                           textController: emailController,
//                           keyBoardType: TextInputType.emailAddress,
//                           onChanged: (newValue) {
//                             controller.updateEnteredemail(newValue);
//                           },
//                           applyDecoration: true,
//                           hintText: "Type here",
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Field is required';
//                             }
//                             String pattern =
//                                 r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                             RegExp regex = RegExp(pattern);
//                             if (!regex.hasMatch(value)) {
//                               return 'Enter a valid email address';
//                             }
//                             return null;
//                           },
//                         );
//                       }),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "Gender",
//                         style: TextStyle(color: Colors.black, fontSize: 16),
//                       ),
//                       SizedBox(height: 10),
//                       Consumer(
//                         builder: (context, ref, child) {
//                           var selectGender =
//                               ref.read(selectionModelProvider.notifier);

//                           return Row(children: [
//                             ref.watch(selectionModelProvider).gender == 'm'
//                                 ? CustomGenderButton(
//                                     borderRadius: 5,
//                                     text: 'Male',
//                                     onPressed: () {
//                                       selectGender.setGender("m");
//                                     },
//                                   )
//                                 : CustomGenderButton(
//                                     borderRadius: 5,
//                                     text: 'Male',
//                                     onPressed: () {
//                                       selectGender.setGender("m");
//                                     },
//                                     color: Colors.white,
//                                     foreGroundColor: Color(0xFF6418C3),
//                                     borderColor: Color(0xFF6418C3),
//                                   ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             ref.watch(selectionModelProvider).gender == 'f'
//                                 ? CustomGenderButton(
//                                     borderRadius: 5,
//                                     text: 'Female',
//                                     onPressed: () {
//                                       selectGender.setGender("f");
//                                     },
//                                   )
//                                 : CustomGenderButton(
//                                     borderRadius: 5,
//                                     text: 'Female',
//                                     onPressed: () {
//                                       selectGender.setGender("f");
//                                     },
//                                     color: Colors.white,
//                                     foreGroundColor: Color(0xFF6418C3),
//                                     borderColor: Color(0xFF6418C3),
//                                   ),
//                           ]);
//                         },
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "Account Type",
//                         style: TextStyle(color: Colors.black, fontSize: 16),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Consumer(builder: (context, ref, child) {
//                         final controller =
//                             ref.watch(selectionModelProvider.notifier);
//                         return CustomTextFormField(
//                           width: ScreenWidth * 0.8,
//                           readOnly: true,
//                           textController: _accountType,
//                           applyDecoration: true,
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Consumer(builder: (context, ref, child) {
//                   final pickedImage = ref.watch(imageProvider).profilePic;
//                   final selection = ref.watch(selectionModelProvider);
//                   final loading = ref.watch(loadingProvider);
//                   return CustomElevatedButton(
//                     text: "Add User",
//                     borderRadius: 10,
//                     foreGroundColor: Colors.white,
//                     width: double.infinity,
//                     backGroundColor: Color(0XFF6418C3),
//                     isLoading: loading,
//                     onPressed: loading
//                         ? null
//                         : () async {
//                             if (_formKey.currentState!.validate() &&
//                                 pickedImage != null) {
//                               // If the form is valid, proceed with the login process

//                               final UserResult result = await ref
//                                   .read(usersProvider.notifier)
//                                   .addUser(
//                                       pickedImage,
//                                       selection.name.text,
//                                       selection.email.text,
//                                       selection.gender,
//                                       selection.email.text,
//                                       selection.name.text,
//                                       ref);
//                               if (result.statusCode == 201) {
//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return Dialog(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                       ),
//                                       child: Container(
//                                         padding: EdgeInsets.all(20),
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.rectangle,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(20)),
//                                         ),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             Icon(Icons.check_circle,
//                                                 size: 50,
//                                                 color: Color(0XFF6418C3)),
//                                             SizedBox(height: 15),
//                                             Text(
//                                               'Profile Has Been Changed',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             SizedBox(height: 15),
//                                             Text(
//                                               'Done Successfully',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 14),
//                                             ),
//                                             SizedBox(height: 20),
//                                             Consumer(
//                                               builder: (context, ref, child) {
//                                                 final addUser = ref.watch(
//                                                     selectionModelProvider
//                                                         .notifier);
//                                                 return CustomElevatedButton(
//                                                   text: "OK",
//                                                   borderRadius: 20,
//                                                   width: 100,
//                                                   foreGroundColor: Colors.white,
//                                                   backGroundColor:
//                                                       Color(0XFF6418C3),
//                                                   onPressed: () {
//                                                     addUser
//                                                         .toggleAddUser(false);
//                                                     Navigator.of(context)
//                                                         .pushNamed("dashboard");
//                                                   },
//                                                 );
//                                               },
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               } else if (result.statusCode == 400) {
//                                 // If an error occurred, show a dialog box with the error message.
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       title: Text('Login Error'),
//                                       content: Text(result.errorMessage ??
//                                           'An unknown error occurred.'),
//                                       actions: <Widget>[
//                                         TextButton(
//                                           child: Text('OK'),
//                                           onPressed: () {
//                                             Navigator.of(context)
//                                                 .pop(); // Close the dialog box
//                                           },
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               }
//                             }
//                           },
//                   );
//                 })
//               ],
//             ),
//           ),
//         ));
//       }),
//     );
//   }
// }

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

  EditUser({
    Key? key,
    this.user_id,
    this.userName,
    this.email,
    this.mobileNo,
    this.gender,
    this.profilepic,
  }) : super(key: key);

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
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  child: Image.file(
                                    _profileImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : widget.profilepic != null &&
                                      widget.profilepic!.startsWith('http')
                                  ? Container(
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
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Row(
                  children: [
                    Text("Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                  ],
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
          border: OutlineInputBorder(),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, child) {
              var selectGender = ref.read(selectionModelProvider.notifier);

              return Row(children: [
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
                        foreGroundColor: const Color(0xFF6418C3),
                        borderColor: const Color(0xFF6418C3),
                      ),
                const SizedBox(
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
                        foreGroundColor: const Color(0xFF6418C3),
                        borderColor: const Color(0xFF6418C3),
                      ),
              ]);
            },
          ),
        ],
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
