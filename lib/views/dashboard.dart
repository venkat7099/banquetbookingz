import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // appBar: AppBar(
        //   bottom: TabBar(
        //     tabs: [
        //       Tab(text: 'New'), // First tab
        //       Tab(text: 'Admin'), // Second tab
        //       Tab(text: 'Moderator'), // Third tab
        //       // Add more tabs here for 'All' etc.
        //     ],
        //   ),
        //   title: Text('Tab Example'),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.4,
                        width: screenWidth,
                        color: const Color(0xFFf5f5f5),
                      ),
                    ],
                  ),
                  Positioned(
                    child: Stack(
                      children: [
                        Container(
                          height: 130,
                          decoration: const BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                        const Positioned(
                            top: 20,
                            left: 20,
                            child: Text(
                              'text',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                        // The search icon
                        Positioned(
                            top: 20,
                            right: 20,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                const Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.verified_user,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0), // Add horizontal padding if needed
                      child: SizedBox(
                        width: screenWidth * 0.85,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'hintText',
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.purple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: AppBar(
                      bottom: const TabBar(
                        tabs: [
                          Tab(text: 'New'), // First tab
                          Tab(text: 'Admin'), // Second tab
                          Tab(text: 'Moderator'), // Third tab
                          // Add more tabs here for 'All' etc.
                        ],
                      ),
                      title: const Text('Tab Example'),
                    ),
                  )
                ],
              ),
              // TabBarView(
              //   children: [
              //     // Replace with your content pages
              //     DashboardWidget(),
              //     MainPage(),
              //     LoginPage()
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
// import 'package:banquetbookingz/views.dart/dashboardpage.dart';
// import 'package:banquetbookingz/views.dart/loginpage.dart';
// import 'package:banquetbookingz/views.dart/mainpage.dart';
// import 'package:banquetbookingz/views.dart/subscriptionchart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     List<Widget> _pages = [
//       MyWidget(),
//       MainPage(),
//       LoginPage()
//     ];

    
//     return Scaffold(
//       body: Consumer(builder: (context, ref, child) {
//         final _selectedIndex = ref.watch(pageIndexProvider);
//         return _selectedIndex==0? Column(
//           children: [
//             Stack(
//               children: [
//                 Column(
//                   children: [
//                     Container(
                      
//                       alignment: Alignment.center,
                      
//                       width: screenWidth,
//                       color: Colors.amber,
//                       child: Column(children: [Text("BanquetBookz Admin Dashboard")],),
//                     ),
//                   ],
//                 ),
//                 Positioned(
//                   child: Column(
//                     children: [
//                       Stack(
//                         alignment: Alignment.center,
//                         children: <Widget>[
//                           // The purple box
//                           Container(
//                             height: 130,
//                             decoration: BoxDecoration(
//                               color: Colors.purple,
//                               borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(15),
//                                   bottomRight: Radius.circular(15)),
//                             ),
//                           ),
//                           // The user icon
//                           Positioned(
//                               left: 20,
//                               child: Text(
//                                 "Banquet Bookz",
//                                 style: TextStyle(color: Colors.white, fontSize: 25),
//                               )),
//                           // The search icon
//                           Positioned(
//                             right: 20,
//                             child: Icon(
//                               Icons.person,
//                               size: 50,
//                               color: Colors.white,
//                             ),
//                           ),
//                           // The text
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 100,
//                   left: 30,
//                   right: 30,
//                   child: Container(
                   
                    
//                     width: screenWidth * 0.7,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                               width: screenWidth * 0.85,
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   hintText: 'Search with user or vendor name',
//                                   prefixIcon: Icon(Icons.search, color: Colors.purple), // left icon
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(30.0), // rounded corners
//                                     borderSide: BorderSide.none, // no border
//                                   ),
//                                   contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0), // padding inside the textfield
//                                 ),
//                               )),
//                           SizedBox(height: 20),
//                           Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(15),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.white,
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Icon(
//                                           Icons.person,
//                                           size: 50,
//                                           color: Colors.purple,
//                                         ),
//                                         Text(
//                                           "12",
//                                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                                         ),
//                                         Text(
//                                           "new vendors",
//                                           style: TextStyle(fontSize: 15),
//                                         )
//                                       ],
//                                     ),
//                                   ),
                                  
//                                   Container(
//                                     padding: EdgeInsets.all(15),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.white,
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Icon(
//                                           Icons.person,
//                                           size: 50,
//                                           color: Colors.purple,
//                                         ),
//                                         Text(
//                                           "42",
//                                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                                         ),
//                                         Text(
//                                           "subscribed",
//                                           style: TextStyle(fontSize: 15),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 15),
//                               Container(
//                                 padding: EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "14 subscriptions",
//                                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                                         ),
//                                         Text(
//                                           "in last month",
//                                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                                         ),
//                                         Text(
//                                           "Total earned ₹10000 in",
//                                           style: TextStyle(fontSize: 15),
//                                         ),
//                                         Text(
//                                           "last 30 days",
//                                           style: TextStyle(fontSize: 15),
//                                         )
//                                       ],
//                                     ),
//                                     Icon(
//                                       Icons.person,
//                                       size: 50,
//                                       color: Colors.purple,
//                                     ),
//                                   ],
//                                 ),
//                               ),
                             
//                               SizedBox(height: 15),
//                               Container(
//                                 padding: EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Column(
//                                           children: [
//                                             Text("Earnings", style: TextStyle(fontSize: 25)),
//                                             Text("₹89,928", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23))
//                                           ],
//                                         ),
//                                         Text("Last 7 Days", style: TextStyle(fontSize: 15))
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
                              
//                               SizedBox(height: 15),
//                               Container(
//                                 padding: EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "Recent Vendors",
//                                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                                         ),
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             // Your action here
//                                           },
//                                          child: Row(children: [
//                                           Text("View All",style: TextStyle(color: Colors.purple),),
//                                           Icon(Icons.arrow_forward,color: Colors.purple,)
//                                          ],),
//                                           style: ElevatedButton.styleFrom(
//                                             foregroundColor: Colors.purple, // Background color
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(10.0), 
//                                               side: BorderSide(color: Colors.purple,width: 1),
//                                             // The rounded corners
//                                             ),
//                                             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // The padding inside the button
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(height: 10),
//                                     Column(
//                                       children: [
//                                         Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Container(
//                                               width: 60.0, // Adjust the size accordingly
//                                               height: 60.0, // Adjust the size accordingly
//                                               decoration: BoxDecoration(
//                                                 color: Colors.grey[400], // Placeholder color
//                                                 borderRadius: BorderRadius.circular(12), // Rounded corners for the icon placeholder
//                                               ),
//                                               child: Icon(
//                                                 Icons.image, // Placeholder icon
//                                                 size: 30.0, // Icon size
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                             SizedBox(width: 16.0), // Spacing between the icon and the text
//                                             Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   'Swagat Grand Banquet Hall',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold, // Bold text for the title
//                                                     fontSize: 16.0, // Adjust the font size accordingly
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 8.0), // Spacing between title and subtitle
//                                                 Text(
//                                                   'Bachupally, Hyderabad',
//                                                   style: TextStyle(
//                                                     fontSize: 14.0, // Adjust the font size accordingly
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'Registered on Aug 25, 2023',
//                                                   style: TextStyle(
//                                                     color: Colors.grey, // Grey color for the date text
//                                                     fontSize: 12.0, // Adjust the font size accordingly
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         Divider(thickness: 1,color: Colors.purple,)
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 15,),
//                              Container(
//                                 padding: EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child: Center(
//                                   child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "Recent Vendors",
//                                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                                           ),
//                                            ElevatedButton(
//                                           onPressed: () {
//                                             // Your action here
//                                           },
//                                          child: Row(children: [
//                                           Text("View All",style: TextStyle(color: Colors.purple),),
//                                           Icon(Icons.arrow_forward,color: Colors.purple,)
//                                          ],),
//                                           style: ElevatedButton.styleFrom(
//                                             foregroundColor: Colors.purple, // Background color
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(10.0), 
//                                               side: BorderSide(color: Colors.purple,width: 1),
//                                             // The rounded corners
//                                             ),
//                                             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // The padding inside the button
//                                           ),
//                                         )
//                                         ],
//                                       ),
//                                       SizedBox(height: 10),
//                                       Center(
//                                         child: Column(
//                                           children: [
//                                             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Container(
//                                                   width: 60.0, // Adjust the size accordingly
//                                                   height: 60.0, // Adjust the size accordingly
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.grey[400], // Placeholder color
//                                                     borderRadius: BorderRadius.circular(12), // Rounded corners for the icon placeholder
//                                                   ),
//                                                   child: Icon(
//                                                     Icons.image, // Placeholder icon
//                                                     size: 30.0, // Icon size
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 16.0), // Spacing between the icon and the text
//                                                 Column(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     Text(
//                                                       'Swagat Grand Banquet Hall',
//                                                       style: TextStyle(
//                                                         fontWeight: FontWeight.bold, // Bold text for the title
//                                                         fontSize: 16.0, // Adjust the font size accordingly
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 8.0), // Spacing between title and subtitle
//                                                     Text(
//                                                       'Bachupally, Hyderabad',
//                                                       style: TextStyle(
//                                                         fontSize: 14.0, // Adjust the font size accordingly
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       'Start:25th Feb, 2024',
//                                                       style: TextStyle(
//                                                         color: Colors.grey, // Grey color for the date text
//                                                         fontSize: 12.0, // Adjust the font size accordingly
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       'End:25th Mar, 2024',
//                                                       style: TextStyle(
//                                                         color: Colors.grey, // Grey color for the date text
//                                                         fontSize: 12.0, // Adjust the font size accordingly
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(height: 8,),
//                                             SizedBox(width: double.infinity,
//                                               child: ElevatedButton(onPressed: (){}, child:Text("Subscribed to Pro"),
//                                               style: ElevatedButton.styleFrom(foregroundColor: Colors.purple,
//                                              shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(10.0), 
                                              
//                                             // The rounded corners
//                                             ),
//                                               backgroundColor: Color.fromARGB(255, 237, 197, 245),
//                                               ),)),
//                                             Divider(thickness: 1,color: Colors.purple,)
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 15,),
//                                Container(
//                                 padding: EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child:
//                               Column(
//                                 children: [Row(mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Subscription Ratio",style: TextStyle(fontWeight: FontWeight.bold,
//                                     fontSize: 20),),
//                                   ],
//                                 ),
//                                   SizedBox(height: 310,
//                                   width: screenWidth*0.8,
//                                     child: MySubscriptionRatioChart()),
//                                 ],
//                               )
//                               ),
//                               SizedBox(height: 15,),
//                                Container(
//                                 padding: EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child: Center(
//                                   child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Row(mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                           Text("Top Subscriptions",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
//                                         ],
//                                       ),
//                                       SizedBox(height: 10),
//                                       Center(
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                            Container(padding: EdgeInsets.all(10),
//                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//                                              color: Color.fromARGB(255, 229, 189, 236),),
                                          
//                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                             Text("Basic(54%)",style: TextStyle(color: Colors.purple)),
//                                             Text("50",style: TextStyle(color: Colors.purple),)
//                                            ],),),
//                                            SizedBox(height: 5,),
//                                             Container(padding: EdgeInsets.all(10),
//                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//                                              color: Color.fromARGB(255, 229, 189, 236),),
                                          
//                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                             Text("Pro(11%)",style: TextStyle(color: Colors.purple)),
//                                             Text("21",style: TextStyle(color: Colors.purple),)
//                                            ],),),
//                                            SizedBox(height: 5,),
//                                             Container(padding: EdgeInsets.all(10),
//                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//                                              color: Color.fromARGB(255, 229, 189, 236),),
                                          
//                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                             Text("Pro Plus(20%)",style: TextStyle(color: Colors.purple)),
//                                             Text("18",style: TextStyle(color: Colors.purple),)
//                                            ],),),
//                                            SizedBox(height: 5,),
//                                             Container(padding: EdgeInsets.all(10),
//                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//                                              color: Color.fromARGB(255, 229, 189, 236),),
                                          
//                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                             Text("Bsic(20%)",style: TextStyle(color: Colors.purple)),
//                                             Text("18",style: TextStyle(color: Colors.purple),)
//                                            ],),)
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
                            
                          
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ):_pages.elementAt(_selectedIndex);}
//       ),
//             bottomNavigationBar: Consumer(builder: (context, ref, child){
//              final _selectedIndex = ref.watch(pageIndexProvider);
//               return BottomNavigationBar(
//                       items: const <BottomNavigationBarItem>[
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard),
//               label: 'Dashboard',
//                         ),
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.people),
//               label: 'Users',
//                         ),
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.business),
//               label: 'Vendors',
//                         ),
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.subscriptions),
//               label: 'Subs',
//                         ),
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//                         ),
//                       ],
//                       onTap: (index) {
//           // This is where you update the index
//           ref.read(pageIndexProvider.notifier).setPage(index);
//         },
//                       currentIndex: _selectedIndex,
//                       selectedItemColor: Colors.purple,
//                       unselectedItemColor: Colors.grey,
                      
//                       type: BottomNavigationBarType.fixed,
//                     );}
//             ),
//     );
//   }
// }
