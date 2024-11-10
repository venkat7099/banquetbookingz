import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  // Future<void> logoutUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('userData');
  //   await prefs.setBool('isLoggedIn', false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Click for logout"),
            ElevatedButton(
              onPressed: () {
                // await logoutUser();
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(builder: (context) => LoginPage()),
                //   (Route<dynamic> route) => false,
                // );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
