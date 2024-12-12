import 'package:banquetbookingz/providers/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final logout = ref.watch(authProvider.notifier);
    final usersData = ref.watch(authProvider);

    final adminData = usersData.data;

    print("$usersData");
    return Scaffold(
      appBar: PreferredSize(
      preferredSize:  Size.fromHeight(screenHeight * 0.15), // Adjust the height as needed
      child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
         bottom: Radius.circular(20), // Set the radius here
         ),
       child: AppBar(
       title: const Text(
        "Settings",
        style: TextStyle(color: Colors.white,fontSize: 25),
      ),
      backgroundColor: const Color(0xFF6418C3),
    ),
  ),
),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        color: const Color(0xFFf5f5f5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 50.0,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    adminData != null
                        ? "Name: ${adminData.username ?? 'No Name'}"
                        : "No user data available",
                    style: const TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                final adminData = ref.watch(authProvider).data;
                print("admi_data${usersData.data}");
                print("admin_id${adminData?.userId}");
                print("admin_name${adminData?.username}");
                print("admin_email${adminData?.email}");
                print("admin_mobileNo${adminData?.mobileNo}");
                Navigator.pushNamed(
                  context,
                  'editUser',
                  arguments: {
                    'userid': adminData?.userId,
                    'username': adminData?.username,
                    'email': adminData?.email,
                    'mobileNo': adminData?.mobileNo,
                    'address': adminData?.address,
                    'userRole': adminData?.userRole,
                    'location': adminData?.location,
                    'admin': true,
                  },
                );
              },
              child: const Text(
                "EditProfile",
                style: TextStyle(color: Color(0xff000000), fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("alltransactions");
              },
              child: const Text(
                "Wallet",
                style: TextStyle(color: Color(0xff000000), fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                await logout.logoutUser();
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Color(0xff000000), fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
