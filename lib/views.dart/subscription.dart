import 'package:banquetbookingz/models/authstate.dart';
import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
import 'package:banquetbookingz/providers/getuserprovider.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/views.dart/addsubscriber.dart';
import 'package:banquetbookingz/views.dart/adduser.dart';
import 'package:banquetbookingz/views.dart/example.dart';
import 'package:banquetbookingz/views.dart/loginpage.dart';
import 'package:banquetbookingz/views.dart/users.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';

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
    
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [true, false, false, false];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final usersData=ref.watch(getUserProvider);
    
    List<Widget> _pages = [
      DashboardWidget(),
      Users(),
      Subscription()
    ];
    return Scaffold(body:  Consumer(builder: (context, ref, child) {
      final _selectedIndex = ref.watch(pageIndexProvider);
      final addSubscriber=ref.watch(selectionModelProvider).addSubscriber;
      return SingleChildScrollView(
        child: addSubscriber==false? Column(children: [
          StackWidget(hintText: "Search users", text: "< Users",onTap: (){
            ref.watch(selectionModelProvider.notifier).toggleAddSubscriber(true);
          },icon: Icons.add_circle_outline_rounded,),
          Container(child: Text("No data"),)
        ],):AddSubscriber(),
      );}
    ),
    //
    );
  }
}
Widget _buildToggleButton(String text, bool isSelected) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: isSelected ? Color(0xff6418c3) : Colors.black,
        decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
      ),
    ),
  );
}
