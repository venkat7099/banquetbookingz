import 'dart:convert';
import 'package:banquetbookingz/models/subscriptionmodel.dart';
import 'package:banquetbookingz/providers/authprovider.dart';
import 'package:banquetbookingz/views.dart/addsubscriber.dart';
import 'package:banquetbookingz/views.dart/adduser.dart';
import 'package:banquetbookingz/views.dart/alltransactions.dart';
import 'package:banquetbookingz/views.dart/dashboard.dart';
import 'package:banquetbookingz/views.dart/editsubscriber.dart';
import 'package:banquetbookingz/views.dart/edituser.dart';
import 'package:banquetbookingz/views.dart/example.dart';
import 'package:banquetbookingz/views.dart/loginpage.dart';
import 'package:banquetbookingz/views.dart/mainpage.dart';
import 'package:banquetbookingz/views.dart/subscription.dart';
import 'package:banquetbookingz/views.dart/uploadphoto.dart';
import 'package:banquetbookingz/views.dart/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('Main.dart build');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF6418C3), // Email / Username icon color
        // hintColor: Color(0xFF000), // Used for the 'Delete Plan' button
        // backgroundColor: Color(0xFFE0E0E0), // Background color of input fields

        // Define the default font family.
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.

        // Define the default button theme
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF6418c3), // Login button color
          textTheme: ButtonTextTheme.primary,
        ),

        // Other customizations like input decoration, etc.

        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff6418c3)),
        useMaterial3: true,
      ),
      home: Consumer(builder: (context, ref, child) {
        final authState = ref.watch(authProvider);
        return FutureBuilder(
          future: ref.watch(authProvider.notifier).isAuthenticated(),
          builder: (context, snapshot) {
            print('${snapshot.data}');
            // Check the authentication status
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                // If the user is logged in, go to the main page
                return DashboardWidget();
              } else {
                // If the user is not logged in, go to the login page
                return LoginPage();
              }
            } else {
              // Show a loading spinner while checking authentication status
              return const CircularProgressIndicator();
            }
          },
        );
      }),
      routes: {
        // "mainpage":(context) => const MainPage(),
        "uploadphoto": (context) => UploadPhoto(),
        "dashboard": (context) => DashboardWidget(),
        "users": (context) => Users(),
        "adduser": (context) => AddUser(),
        "edituser": (context) => EditUser(),
        "alltransactions": (context) => AllTransactions(),
        "editsubscriber": (context) => EditSubscriber(),
        "addsubscriber": (context) => AddSubscriber(),
        "getsubscriptions": (context) => Subscription(),
      },
    );
  }
}
