import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/providers/usersprovider.dart';
import 'package:flutter/material.dart';
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
    Future.microtask(() async {
      await ref.read(usersProvider.notifier).getUsers(ref);

      // Get the ID passed via arguments
      final id = ModalRoute.of(context)?.settings.arguments as int?;
      if (id != null) {
        print(id);
      } else {
        print("ID is null");
      }

      final ids = ref.read(selectionModelProvider).userIndex;
      if (ids != null) {
        print(ids);

        // Get user details from your state notifier
        final user = ref.read(usersProvider.notifier).getUserById("sdf");

        if (user != null) {
          // Update the controllers with the user's data
          ref
              .read(selectionModelProvider.notifier)
              .updateEnteredemail(user.email ?? '');
          ref
              .read(selectionModelProvider.notifier)
              .updateEnteredName(user.username ?? '');
        } else {
          print("User not found");
        }
      } else {
        print("IDs are null");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // UI code remains the same
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final _selectedIndex = ref.watch(pageIndexProvider);
        final selection = ref.watch(selectionModelProvider.notifier);
        final usersData = ref.watch(usersProvider);

        return SingleChildScrollView(
          child: Column(
            children: [
              // Your UI widgets like StackWidget, etc.
              // ...
              // Display user data or a message if no data is available
              usersData == null || usersData.isEmpty
                  ? Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(
                          color: Color(0xffb4b4b4),
                          fontSize: 17,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: usersData.length,
                      itemBuilder: (context, index) {
                        final user = usersData[index];
                        return ListTile(
                          leading: user.profilePic != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user.profilePic!),
                                )
                              : Icon(Icons.account_circle),
                          title: Text(user.username ?? "No Name"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.email ?? "No Email"),
                              Text(user.mobileNo ?? "No Mobile"),
                              Text(user.gender ?? "Not Getting Gender"),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit, color: Colors.purple),
                            onPressed: () {
                              final userId = usersData[index].id;
                              if (userId != null) {
                                selection.userIndex(userId);
                                Navigator.of(context).pushNamed("edituser");
                              } else {
                                print("User ID is null");
                              }
                            },
                          ),
                        );
                      },
                    ),
            ],
          ),
        );
      }),
    );
  }
}




// class Users extends ConsumerStatefulWidget {
//   const Users({super.key});

//   @override
//   ConsumerState<Users> createState() => _UsersState();
// }

// class _UsersState extends ConsumerState<Users> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<bool> isSelected = [true, false, false, false];

  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     // Fetch users when the widget is inserted into the widget tree
  //     ref.read(usersProvider.notifier).getUsers();

  //     final id = ModalRoute.of(context)?.settings.arguments as int?;
  //     print(id);

  //     final ids = ref.read(selectionModelProvider).userIndex;
  //     print(ids);

  //     final user = ref.read(usersProvider.notifier).getUserById(ids!);

  //     if (user != null) {
  //       ref
  //           .read(selectionModelProvider.notifier)
  //           .updateEnteredemail(user.emailId ?? '');
  //       ref
  //           .read(selectionModelProvider.notifier)
  //           .updateEnteredName(user.firstName ?? '');
  //       // Handle other fields similarly
  //     }
  //   }
  //   );
  // }

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
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final usersData = ref.watch(usersProvider);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             StackWidget(
//               hintText: "Search users",
//               text: "Users",
//               onTap: () {
//                 Navigator.of(context).pushNamed("adduser");
//               },
//               arrow: Icons.arrow_back,
//             ),
//             Container(
//               width: screenWidth,
//               padding: EdgeInsets.all(30),
//               color: Color(0xFFf5f5f5),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Colors.white,
//                     ),
//                     child: ToggleButtons(
//                       borderColor: Colors.white,
//                       fillColor: Colors.transparent,
//                       borderWidth: 0.0,
//                       selectedBorderColor: Colors.white,
//                       isSelected: isSelected,
//                       onPressed: (index) {
//                         setState(() {
//                           for (int i = 0; i < isSelected.length; i++) {
//                             isSelected[i] = i == index;
//                           }
//                         });
//                       },
//                       children: [
//                         _buildToggleButton('New', isSelected[0]),
//                         _buildToggleButton('Admin', isSelected[1]),
//                         _buildToggleButton('Moderator', isSelected[2]),
//                         _buildToggleButton('All', isSelected[3]),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   usersData.data == null
//                       ? Container(
//                           height: screenHeight,
//                           width: screenWidth,
//                           color: Color(0xfff5f5f5),
//                           child: Center(
//                             child: Text(
//                               "No data available",
//                               style: TextStyle(
//                                 color: Color(0xffb4b4b4),
//                                 fontSize: 17,
//                               ),
//                             ),
//                           ),
//                         )
//                       : Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white,
//                           ),
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: usersData.data.length,
//                             itemBuilder: (context, index) {
//                               final user = usersData.data[index];
//                               return Container(
//                                 margin: EdgeInsets.all(10),
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         CircleAvatar(
//                                             radius: 30,
//                                             backgroundImage: Users.profilePic =
//                                                 NetworkImage(
//                                                     Users.profilePic!)),
//                                         SizedBox(width: 10),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Username: ${user.username}',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             SizedBox(height: 5),
//                                             Text(
//                                               'Email: ${user.email}',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             SizedBox(height: 5),
//                                             Text(
//                                               'Mobile Number: ${user.mobileNo}',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildToggleButton(String text, bool isSelected) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 16,
//           color: isSelected ? Colors.purple : Colors.black,
//           decoration:
//               isSelected ? TextDecoration.underline : TextDecoration.none,
//         ),
//       ),
//     );
//   }
// }
