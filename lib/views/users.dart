import 'package:banquetbookingz/views/adduser.dart';
import 'package:banquetbookingz/views/edituser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banquetbookingz/providers/usersprovider.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';

import '../providers/searchtextnotifier.dart';

class Users extends ConsumerStatefulWidget {
  const Users({super.key});

  @override
  ConsumerState<Users> createState() => _UsersState();
}

class _UsersState extends ConsumerState<Users> {
  

   final TextEditingController _searchController = TextEditingController();

  Future<void> _deleteUser(String userId) async {
    final success = await ref.read(usersProvider.notifier).deleteUser(userId);

    if (success) {
      await ref.read(usersProvider.notifier).getUsers(ref);
    } else {
      print("Failed to delete user");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StackWidget(
             textEditingController: _searchController,
            hintText: "Search users",
            text: "Users",
            onTap: () {
              Navigator.of(context).pushNamed("adduser");
            },
            arrow: Icons.arrow_back,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: DefaultTabController(
              length: 4, // Number of tabs
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: "All "),
                      Tab(text: "Users"),
                      Tab(text: "Vendors"),
                      Tab(text: "Managers"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildUserList(context),
                       _buildUserList(context,filter: 'u'),
                        _buildUserList(context,filter: 'v'),
                        _buildUserList(context,filter: 'm'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildUserList(BuildContext context, {String? filter}) {
  return Consumer(
    builder: (context, ref, child) {
      final usersData = ref.watch(usersProvider);
      final searchText = ref.watch(searchTextProvider);

      print('Users Data: $usersData'); // Debug print
      print('Search Text: $searchText'); // Debug print

      if (usersData == null || usersData.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Filter users based on the user type and search text
        final filteredUsers = usersData.where((user) {
        final matchesFilter = filter == null || user.userType == filter;
        final matchesSearch = searchText.isEmpty ||
            (user.mobileNo?.contains(searchText) ?? false);
        return matchesFilter && matchesSearch;
      }).toList();

      print('Filtered Users: $filteredUsers'); // Debug print

      if (filteredUsers.isEmpty) {
        return const Center(
          child: Text("No users found"),
        );
      }

      return ListView(
        padding: EdgeInsets.zero,
        children: filteredUsers.map((user) {
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 2.0),
            child: ListTile(
              leading: user.profilePic != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          'http://93.127.172.164:8080${user.profilePic!}'),
                      radius: 30,
                    )
                  : const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.grey,
                    ),
              title: Text(
                "User: ${user.username ?? "No Name"}",
                style: const TextStyle(
                  color: Color(0xFF6418c3),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email: ${user.email ?? "No Email"}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Mobile No: ${user.mobileNo ?? "No Mobile"}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Gender: ${user.gender ?? "Not Getting Gender"}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditUser(
                            profilepic:
                                'http://93.127.172.164:8080${user.profilePic}',
                            userName: user.username,
                            email: user.email,
                            mobileNo: user.mobileNo,
                            gender: user.gender,
                            user_id: user.id,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      final userId = user.id;
                      if (userId != null) {
                        _deleteUser(userId as String);
                      } else {
                        print("User ID is null");
                      }
                    },
                  ),
                ],
              ),
              onTap: () {
                // Optionally, navigate to user details screen
              },
            ),
          );
        }).toList(),
      );
    },
  );
}


 
}
