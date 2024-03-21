import 'package:banquetbookingz/models/authstate.dart';
import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
import 'package:banquetbookingz/providers/getuserprovider.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/views.dart/adduser.dart';
import 'package:banquetbookingz/views.dart/example.dart';
import 'package:banquetbookingz/views.dart/loginpage.dart';
import 'package:banquetbookingz/views.dart/subcriptiondetails.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [true, false, false, false];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
        child: user.addUser==false && user.subDetails==false? Column(children: [
          StackWidget(hintText: "Search users", text: "< Users",onTap: (){
            ref.watch(selectionModelProvider.notifier).toggleAddUser(true);
          },icon: Icons.search,),
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
                
                
                return usersData.data==null?InkWell(onTap: (){
                  ref.watch(selectionModelProvider.notifier).subDetails(true);
                },
                  child: Container(height: screenHeight,width: screenWidth,color:Color(0xfff5f5f5),
                  child: Center(child: Text("No data available",style: TextStyle(color: Color(0xffb4b4b4),fontSize: 17),)),)): 
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
                                                         selection.toggleAddUser(true);
                                                 Navigator.of(context).pushNamed("edituser",arguments: userId);  
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
        ],): user.addUser==true&&user.subDetails==false? AddUser():SubscriptionDetils(),
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
