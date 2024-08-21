import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/providers/usersprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final id = ModalRoute.of(context)?.settings.arguments as int?;
    if (id != null) {
      print(id);

      final ids = ref.read(selectionModelProvider).userIndex;
      if (ids != null) {
        print(ids);

        // Fetch user details using the obtained ID
        final user =
            await ref.read(usersProvider.notifier).getUserById(id as String);

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
    } else {
      print("ID is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final usersData = ref.watch(usersProvider);

          return ListView(
            children: [
              StackWidget(
                hintText: "Search users",
                text: "Users",
                onTap: () {
                  Navigator.of(context).pushNamed("adduser");
                },
                arrow: Icons.arrow_back,
              ),
              if (usersData == null || usersData.isEmpty)
                Center(
                  child: Text(
                    "No data available",
                    style: TextStyle(
                      color: Color(0xffb4b4b4),
                      fontSize: 17,
                    ),
                  ),
                )
              else
                ...usersData.map((user) {
                  return ListTile(
                    leading: user.profilePic != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic!),
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
                        final userId = user.id;
                        if (userId != null) {
                          ref
                              .read(selectionModelProvider.notifier)
                              .userIndex(userId);
                          Navigator.of(context).pushNamed("edituser");
                        } else {
                          print("User ID is null");
                        }
                      },
                    ),
                  );
                }).toList(),
            ],
          );
        },
      ),
    );
  }
}
