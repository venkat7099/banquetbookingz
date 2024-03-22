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
import 'package:banquetbookingz/views.dart/edituser.dart';
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
        child:  Column(children: [
          StackWidget(hintText: "Search users", text: "Users",onTap: (){
            Navigator.of(context).pushNamed("edituser");
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
                                                         Navigator.of(context).pushNamed("edituser");
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
        ],)
       ,
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
