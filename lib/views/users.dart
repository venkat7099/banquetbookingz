import 'package:banquetbookingz/views/adduser.dart';
import 'package:banquetbookingz/views/edituser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banquetbookingz/providers/usersprovider.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';

class Users extends ConsumerStatefulWidget {
  const Users({super.key});

  @override
  ConsumerState<Users> createState() => _UsersState();
}

class _UsersState extends ConsumerState<Users> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await ref.read(usersProvider.notifier).getUsers(ref);

    final users = ref.read(usersProvider);
    for (final user in users) {
      await ref
          .read(usersProvider.notifier)
          .getProfilePic(user.id as String, ref);
    }
  }

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
                        _buildUsers(context),
                        _buildVendors(context),
                        _buildManagers(context),
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

  Widget _buildUserList(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final usersData = ref.watch(usersProvider);

        if (usersData == null || usersData.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: usersData.map((user) {
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

  Widget _buildUsers(BuildContext context) {
    // Implement your logic for Active Users tab here
    return Center(child: Text("Users Screen"));
  }

  Widget _buildVendors(BuildContext context) {
    // Implement your logic for Inactive Users tab here
    return Center(child: Text("Vendors Screen"));
  }

  Widget _buildManagers(BuildContext context) {
    // Implement your logic for Pending Users tab here
    return Center(child: Text("Managers Screen"));
  }
}
