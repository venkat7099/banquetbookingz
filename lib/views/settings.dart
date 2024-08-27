import 'package:banquetbookingz/providers/authprovider.dart';
import 'package:banquetbookingz/providers/usersprovider.dart';
import 'package:banquetbookingz/views/loginpage.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        StackWidget(text: "Settings"),
        Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
          color: Color(0xFFf5f5f5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
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
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("edituser");
                  },
                  child: Text(
                    "EditProfile",
                    style: TextStyle(color: Color(0xff000000), fontSize: 15),
                  )),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("alltransactions");
                  },
                  child: Text(
                    "Wallet",
                    style: TextStyle(color: Color(0xff000000), fontSize: 15),
                  )),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    await logout.logoutUser();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
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
