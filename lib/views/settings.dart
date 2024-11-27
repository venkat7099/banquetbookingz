import 'package:banquetbookingz/providers/authprovider.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';
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

    print("$usersData");
    return Scaffold(
        body: Column(
      children: [
        const StackWidget(text: "Settings"),
        Container(
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
                child: const Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 50.0,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("No data")
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                          final adminData = ref.read(authProvider).data;
                          Navigator.pushNamed(
                            context,
                            'editUser',
                            arguments: {
                              'userId': adminData?.userId,
                              'username': adminData?.username,
                              'email': adminData?.email,
                              'mobileNo': adminData?.mobileNo,
                              'address': adminData?.address,
                              'userRole': adminData?.userRole,
                              'location': adminData?.location,
                            },
                          );
                        },
                  child: const Text(
                    "EditProfile",
                    style: TextStyle(color: Color(0xff000000), fontSize: 15),
                  )),
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
                  )),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    await logout.logoutUser();
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    //   (Route<dynamic> route) => false,
                    // );
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Color(0xff000000), fontSize: 15),
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
