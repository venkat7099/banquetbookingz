import 'package:banquetbookingz/models/getuser.dart';
import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
import 'package:banquetbookingz/providers/getuserprovider.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/views/dashboard.dart';
import 'package:banquetbookingz/views/dashboardpage.dart';
import 'package:banquetbookingz/views/loginpage.dart';
import 'package:banquetbookingz/views/mainpage.dart';
import 'package:banquetbookingz/views/settings.dart';
import 'package:banquetbookingz/views/subscription.dart';
import 'package:banquetbookingz/views/subscriptionchart.dart';
import 'package:banquetbookingz/views/users.dart';
import 'package:banquetbookingz/widgets/custompaint.dart';
import 'package:banquetbookingz/widgets/recentvenders.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';
import 'package:banquetbookingz/widgets/subscriptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../providers/authprovider.dart';
import '../providers/usersprovider.dart';

class DashboardWidget extends ConsumerStatefulWidget {
  const DashboardWidget({super.key});

  @override
  ConsumerState<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends ConsumerState<DashboardWidget> {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final usertype = ref.watch(authProvider);
    List<Widget> _pages = [
      const DashboardWidget(),
      const Users(),
     if(usertype.usertype=='a') Subscription(),
      Settings()
    ];

    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final _selectedIndex = ref.watch(pageIndexProvider);
        final dashboard = ref.watch(selectionModelProvider).dashboard;
        //  final get=ref.watch(getUserProvider.notifier);
        return _selectedIndex == 0 && dashboard == true
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    const StackWidget(
                      hintText: 'Search with user or vendor name',
                      text: "Banquet Bookz",
                    ),
                    Container(
                      padding: const EdgeInsets.all(40),
                      color: Color(0xFFf5f5f5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                            0xffdfecf2), // Container's background color
                                        shape: BoxShape
                                            .circle, // Making the container circular
                                      ),
                                      child: Icon(
                                        Icons.person, // The person icon
                                        color: Color(0xff5dcfff), // Icon color
                                        size: 30.0, // Icon size
                                      ),
                                      padding: EdgeInsets.all(10),
                                    ),
                                    Text(
                                      "12",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "new vendors",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                            0xffffcff2), // Container's background color
                                        shape: BoxShape
                                            .circle, // Making the container circular
                                      ),
                                      child: Icon(
                                        Icons.person, // The person icon
                                        color: Color(0xffe328af), // Icon color
                                        size: 30.0, // Icon size
                                      ),
                                      padding: EdgeInsets.all(
                                          10), // Padding to create space around the icon inside the container
                                    ),
                                    Text(
                                      "42",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "subscribed",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "14 subscriptions",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    Text(
                                      "in last month",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    Text(
                                      "Total earned ₹10000 in",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "last 30 days",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Color(0XFF6418C3),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text("Earnings",
                                            style: TextStyle(fontSize: 25)),
                                        Text("₹89,928",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 23))
                                      ],
                                    ),
                                    Text("Last 7 Days",
                                        style: TextStyle(fontSize: 15))
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: screenHeight * 0.2,
                                  width: screenWidth * 0.7,
                                  child: LineChart(
                                    LineChartData(
                                      gridData: FlGridData(
                                        show: true,
                                        drawVerticalLine:
                                            true, // Enable the vertical grid lines
                                        getDrawingVerticalLine: (value) {
                                          return FlLine(
                                            color: const Color(
                                                0xff37434d), // Color for vertical lines
                                            strokeWidth: 1,
                                          );
                                        },
                                        // getDrawingHorizontalLine: (value) {
                                        //   return FlLine(
                                        //     color: const Color(0xff37434d), // Color for horizontal lines
                                        //     strokeWidth: 1,
                                        //   );
                                        // },
                                      ),
                                      titlesData: FlTitlesData(show: false),
                                      borderData: FlBorderData(show: false),
                                      minX: 0,
                                      maxX: 2,
                                      minY: 0,
                                      maxY: 10,
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: [
                                            FlSpot(0, 1),
                                            FlSpot(1, 3),
                                            FlSpot(2, 10),
                                            // Add other spots here
                                          ],
                                          isCurved: true,
                                          color: Colors.blue, // Line color
                                          barWidth: 4,
                                          isStrokeCapRound: true,
                                          dotData: FlDotData(show: false),
                                          belowBarData:
                                              BarAreaData(show: false),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Recent Vendors",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Your action here
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "View All",
                                            style: TextStyle(
                                                color: Color(0XFF6418C3)),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Color(0XFF6418C3),
                                          )
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Color(
                                            0XFF6418C3), // Background color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: Color(0XFF6418C3),
                                              width: 1),
                                          // The rounded corners
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical:
                                                12), // The padding inside the button
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                VendersWidget(
                                  text1: 'Swagat Grand Banquet Hall',
                                  text2: 'Bachupally, Hyderabad',
                                  text3: 'Registered on Aug 25, 2023',
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Recent Vendors",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Your action here
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "View All",
                                              style: TextStyle(
                                                  color: Color(0XFF6418C3)),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Color(0XFF6418C3),
                                            )
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Color(
                                              0XFF6418C3), // Background color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Color(0XFF6418C3),
                                                width: 1),
                                            // The rounded corners
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical:
                                                  12), // The padding inside the button
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  SubscriptionsWidget(
                                      text1: 'Swagat Grand Banquet Hall',
                                      text2: 'Bachupally, Hyderabad',
                                      text3: 'Start:25th Feb, 2024',
                                      text4: 'End:25th Mar, 2024')
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Subscription Ratio",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: 310,
                                      width: screenWidth * 0.8,
                                      child: MySubscriptionRatioChart()),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  color: Color(0xFF6418C3),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Pro-25%",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  color: Color(0XFF5DCFFF),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("Expert-25%",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  color: Color(0XFFE328AF),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Basic-25%",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  color: Color(0xFFC4C4C4),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("Pro-Plus-25%",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        )
                                      ])
                                ],
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Top Subscriptions",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0XFFEEE1FF),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Basic(54%)",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0XFF6418C3))),
                                              Text(
                                                "50",
                                                style: TextStyle(
                                                    color: Color(0XFF6418C3)),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0XFFEEE1FF),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Pro(11%)",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0XFF6418C3))),
                                              Text(
                                                "21",
                                                style: TextStyle(
                                                    color: Color(0XFF6418C3)),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0XFFEEE1FF),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Pro Plus(20%)",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff6418c3))),
                                              Text(
                                                "18",
                                                style: TextStyle(
                                                    color: Color(0xff6418c3)),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0xffeee1ff),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Bsic(20%)",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff6418c3))),
                                              Text(
                                                "18",
                                                style: TextStyle(
                                                    color: Color(0xff6418c3)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                "BanquetBookz Admin Dashboard",
                                style: TextStyle(
                                    color: Color(
                                      0xFFb4b4b4,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                "Made with in india by GoCode Creations",
                                style: TextStyle(
                                    color: Color(
                                      0xFFb4b4b4,
                                    ),
                                    fontSize: 13),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : _pages.elementAt(_selectedIndex);
      }),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        final _selectedIndex = ref.watch(pageIndexProvider);
        return BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Users',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.business),
            //   label: 'Vendors',
            // ),
           if(usertype.usertype=='a')
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: 'Subs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            // This is where you update the index

            ref.read(pageIndexProvider.notifier).setPage(index);
          },
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xff6418c3),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        );
      }),
    );
  }
}
