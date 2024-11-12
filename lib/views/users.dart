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
              length: 4,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: "All"),
                      Tab(text: "Users"),
                      Tab(text: "Vendors"),
                      Tab(text: "Managers"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildUserList(context),
                        _buildUserList(context, filter: 'u'),
                        _buildUserList(context, filter: 'v'),
                        _buildUserList(context, filter: 'm'),
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

      if (usersData.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Filter users based on the user type and search text
      final filteredUsers = usersData.where((user) {
        final matchesFilter = filter == null || user.data?.userRole == filter;
        final matchesSearch = searchText.isEmpty ||
            (user.data!.email?.contains(searchText) ?? false);
        return matchesFilter && matchesSearch;
      }).toList();

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
              leading: user.data?.profilePic != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          'http://93.127.172.164:8080${user.data?.profilePic}'),
                      radius: 30,
                    )
                  : const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.grey,
                    ),
              title: Text(
                "User: ${user.data?.username ?? "No Name"}",
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
                    "Email: ${user.data?.email ?? "No Email"}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Mobile No: ${user.data?.mobileNo ?? "No Mobile"}",
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
                                'http://93.127.172.164:8080${user.data?.profilePic}',
                            userName: user.data?.username,
                            email: user.data?.email,
                            mobileNo: user.data?.mobileNo,
                            user_id: user.data?.userId,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      final userId = user.data?.userId;
                      _deleteUser(userId.toString());
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    },
  );
}
}
