// import 'dart:io';
// import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
// import 'package:banquetbookingz/providers/getsubscribers.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/providers/subcsribersprovider.dart';
// import 'package:banquetbookingz/views.dart/addsubscriber.dart';
// import 'package:banquetbookingz/widgets/stackwidget.dart';
// import 'package:banquetbookingz/widgets/substack.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Subscription extends ConsumerStatefulWidget {
//   const Subscription({super.key});

//   @override
//   ConsumerState<Subscription> createState() => _SubscriptionState();
// }

// class _SubscriptionState extends ConsumerState<Subscription> {
//   @override
//   void initState() {
//     super.initState();
//     // Call getUsers() when the widget is inserted into the widget tree
//     ref.read(subscribersProvider.notifier).getSubscribers();
//     // ref.read(getUserProvider.notifier).getProfilePic();
//     // Future.microtask(() {
//     //   // Get the ID passed via arguments

//     //   final id = ModalRoute.of(context)?.settings.arguments as int?;
//     //   print(id);
//     //   final ids=ref.read(selectionModelProvider).index;
//     //   print(ids);
//     //   // Get user details from your state notifier
//     //   final user = ref.read(getUserProvider.notifier).getUserById(ids!);

//     //   if (user != null) {
//     //     // Update the controllers with the user's data
//     //     ref.read(selectionModelProvider.notifier).updateEnteredemail(user.emailId ?? '');
//     //     ref.read(selectionModelProvider.notifier).updateEnteredName(user.firstName ?? '');
//     //   //    if (user.profilepic != null) {
//     //   //   ref.read(imageProvider.notifier).setProfilePic(XFile(user.profilepic!));
//     //   // }
//     //     // ... do the same for other fields
//     //   }
//     // });
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     List<bool> isSelected = [true, false, false, false];
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     final usersData = ref.watch(subscribersProvider);

//     return Scaffold(
//       body: Consumer(builder: (context, ref, child) {
//         final _selectedIndex = ref.watch(pageIndexProvider);
//         final selection = ref.watch(selectionModelProvider.notifier);
//         final user = ref.watch(selectionModelProvider);
//         return SingleChildScrollView(
//             child: Column(
//           children: [
//             StackWidget(
//               hintText: "Search Subscriptions",
//               text: "Subscription",
//               onTap: () {
//                 Navigator.of(context).pushNamed("addsubscriber");
//               },
//               arrow: Icons.arrow_back,
//             ),
//             Container(
//               width: screenWidth,
//               padding: EdgeInsets.all(30),
//               color: Color(0xFFf5f5f5),
//               child: Column(
//                 children: [
//                   Consumer(builder: (context, ref, child) {
//                     return usersData.data == null
//                         ? Container(
//                             height: screenHeight,
//                             width: screenWidth,
//                             color: Color(0xfff5f5f5),
//                             child: Center(
//                                 child: InkWell(
//                                     onTap: () {
//                                       Navigator.of(context)
//                                           .pushNamed("editsubsriber");
//                                     },
//                                     child: Text(
//                                       "No data available",
//                                       style: TextStyle(
//                                           color: Color(0xffb4b4b4),
//                                           fontSize: 17),
//                                     ))),
//                           )
//                         : Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                             ),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   ListView.builder(
//                                     shrinkWrap:
//                                         true, // Important to work inside a Column

//                                     itemCount: usersData.data!.length,
//                                     itemBuilder: (context, index) {
//                                       final user = usersData.data![index];
//                                       return SingleChildScrollView(
//                                         child: Column(
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 InkWell(
//                                                     onTap: () {
//                                                       ref
//                                                           .watch(
//                                                               selectionModelProvider
//                                                                   .notifier)
//                                                           .subDetails(true);
//                                                     },
//                                                     child: SubStack(
//                                                       text: usersData
//                                                           .data![index].name,
//                                                       width:
//                                                           screenWidth * 0.795,
//                                                       editBtn: "Edit",
//                                                       onTap: () {
//                                                         int? userId = usersData
//                                                             .data![index].id;
//                                                         selection
//                                                             .subscriberIndex(
//                                                                 userId);
//                                                         Navigator.of(context)
//                                                             .pushNamed(
//                                                                 "editsubscriber");
//                                                       },
//                                                     )),
//                                                 Divider(
//                                                   thickness: 1,
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                   }),
//                 ],
//               ),
//             )
//           ],
//         ));
//       }),
//       //
//     );
//   }
// }

// Widget _buildToggleButton(String text, bool isSelected) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 8),
//     child: Text(
//       text,
//       style: TextStyle(
//         fontSize: 16,
//         color: isSelected ? Colors.purple : Colors.black,
//         decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
//       ),
//     ),
//   );
// }

// import 'dart:io';
// import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
// import 'package:banquetbookingz/providers/getsubscribers.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/providers/subcsribersprovider.dart';
// import 'package:banquetbookingz/views.dart/addsubscriber.dart';
// import 'package:banquetbookingz/widgets/stackwidget.dart';
// import 'package:banquetbookingz/widgets/substack.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Subscription extends ConsumerStatefulWidget {
//   const Subscription({super.key});

//   @override
//   ConsumerState<Subscription> createState() => _SubscriptionState();
// }

// class _SubscriptionState extends ConsumerState<Subscription> {
//   @override
//   void initState() {
//     super.initState();
//     // Call getUsers() when the widget is inserted into the widget tree
//     ref.read(subscribersProvider.notifier).getSubscribers();
//     // ref.read(getUserProvider.notifier).getProfilePic();
//     // Future.microtask(() {
//     //   // Get the ID passed via arguments

//     //   final id = ModalRoute.of(context)?.settings.arguments as int?;
//     //   print(id);
//     //   final ids=ref.read(selectionModelProvider).index;
//     //   print(ids);
//     //   // Get user details from your state notifier
//     //   final user = ref.read(getUserProvider.notifier).getUserById(ids!);

//     //   if (user != null) {
//     //     // Update the controllers with the user's data
//     //     ref.read(selectionModelProvider.notifier).updateEnteredemail(user.emailId ?? '');
//     //     ref.read(selectionModelProvider.notifier).updateEnteredName(user.firstName ?? '');
//     //   //    if (user.profilepic != null) {
//     //   //   ref.read(imageProvider.notifier).setProfilePic(XFile(user.profilepic!));
//     //   // }
//     //     // ... do the same for other fields
//     //   }
//     // });
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     List<bool> isSelected = [true, false, false, false];
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     final usersData = ref.watch(subscribersProvider);

//     return Scaffold(
//       body: Consumer(builder: (context, ref, child) {
//         final _selectedIndex = ref.watch(pageIndexProvider);
//         final selection = ref.watch(selectionModelProvider.notifier);
//         final user = ref.watch(selectionModelProvider);
//         return SingleChildScrollView(
//             child: Column(
//           children: [
//             StackWidget(
//               hintText: "Search Subscriptions  ",
//               text: "Subscription",
//               onTap: () {
//                 Navigator.of(context).pushNamed("addsubscriber");
//               },
//               arrow: Icons.arrow_back,
//             ),
//             Container(
//               width: screenWidth,
//               padding: EdgeInsets.all(30),
//               color: Color(0xFFf5f5f5),
//               child: Column(
//                 children: [
//                   Consumer(builder: (context, ref, child) {
//                     return usersData.data == null
//                         ? Container(
//                             height: screenHeight,
//                             width: screenWidth,
//                             color: Color(0xfff5f5f5),
//                             child: Center(
//                                 child: InkWell(
//                                     onTap: () {
//                                       Navigator.of(context)
//                                           .pushNamed("editsubsriber");
//                                     },
//                                     child: Text(
//                                       "No data available",
//                                       style: TextStyle(
//                                           color: Color(0xffb4b4b4),
//                                           fontSize: 17),
//                                     ))),
//                           )
//                         : Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                             ),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   ListView.builder(
//                                     shrinkWrap:
//                                         true, // Important to work inside a Column

//                                     itemCount: usersData.data!.length,
//                                     itemBuilder: (context, index) {
//                                       final user = usersData.data![index];
//                                       return SingleChildScrollView(
//                                         child: Column(
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 InkWell(
//                                                     onTap: () {
//                                                       ref
//                                                           .watch(
//                                                               selectionModelProvider
//                                                                   .notifier)
//                                                           .subDetails(true);
//                                                     },
//                                                     child: SubStack(
//                                                       text: usersData
//                                                           .data![index].name,
//                                                       width:
//                                                           screenWidth * 0.795,
//                                                       editBtn: "Edit",
//                                                       onTap: () {
//                                                         int? userId = usersData
//                                                             .data![index].id;
//                                                         selection
//                                                             .subscriberIndex(
//                                                                 userId);
//                                                         Navigator.of(context)
//                                                             .pushNamed(
//                                                                 "editsubscriber");
//                                                       },
//                                                     )),
//                                                 Divider(
//                                                   thickness: 1,
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                   }),
//                 ],
//               ),
//             )
//           ],
//         ));
//       }),
//       //
//     );
//   }
// }

// Widget _buildToggleButton(String text, bool isSelected) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 8),
//     child: Text(
//       text,
//       style: TextStyle(
//         fontSize: 16,
//         color: isSelected ? Colors.purple : Colors.black,
//         decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
//       ),
//     ),
//   );
// }
import 'dart:io';
import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
import 'package:banquetbookingz/providers/getsubscribers.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/providers/subcsribersprovider.dart';
import 'package:banquetbookingz/views.dart/addsubscriber.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';
import 'package:banquetbookingz/widgets/substack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Subscription extends ConsumerStatefulWidget {
  const Subscription({super.key});

  @override
  ConsumerState<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends ConsumerState<Subscription> {
  @override
  void initState() {
    super.initState();
    // Fetch subscribers when the widget is inserted into the widget tree
    ref.read(subscribersProvider.notifier).getSubscribers();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final usersData = ref.watch(subscribersProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StackWidget(
              hintText: "Search Subscriptions",
              text: "Subscription",
              onTap: () {
                Navigator.of(context).pushNamed("addsubscriber");
              },
              arrow: Icons.arrow_back,
            ),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(30),
              color: const Color(0xFFf5f5f5),
              child: Column(
                children: [
                  usersData.data == null
                      ? Container(
                          height: screenHeight,
                          width: screenWidth,
                          color: const Color(0xfff5f5f5),
                          child: Center(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed("editsubscriber");
                                  },
                                  child: const Text(
                                    "No data available",
                                    style: TextStyle(
                                        color: Color(0xffb4b4b4), fontSize: 17),
                                  ))),
                        )
                      : Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: usersData.data!.length,
                            itemBuilder: (context, index) {
                              final user = usersData.data![index];
                              return InkWell(
                                onTap: () {
                                  int? userId = usersData.data![index].id;
                                  ref
                                      .watch(selectionModelProvider.notifier)
                                      .subscriberIndex(userId);
                                  Navigator.of(context)
                                      .pushNamed("editsubscriber");
                                },
                                // child: SubStack(
                                //   text: user.name,
                                //   width: screenWidth * 0.795,
                                //   editBtn: "Edit",
                                //   onTap: () {
                                //     // Handle edit button click
                                //   },
                                // ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildToggleButton(String text, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
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
