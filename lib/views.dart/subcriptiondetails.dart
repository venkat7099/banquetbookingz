import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/widgets/recenttransactions.dart';
import 'package:banquetbookingz/widgets/subscriptions.dart';
import 'package:banquetbookingz/widgets/substack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionDetils extends StatelessWidget {
  const SubscriptionDetils({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Container(padding: EdgeInsets.all(10),
    color: Color(0xfff5f5f5),
      child: SingleChildScrollView(
        child: Column(children: [
           Container(child: Consumer(builder: (context, ref, child) {
                final addSub=ref.watch(selectionModelProvider.notifier);
                return AppBar(leading: IconButton(onPressed: (){
                  addSub.subDetails(false);
                  
                }, icon: Icon(Icons.arrow_back,color: Color(0xff6418c3),)),
                backgroundColor: Color(0xfff5f5f5),
                title: Text("Subscription details",style: TextStyle(color: Color(0xff6418c3),fontSize: 20),),);}
              )),
              SizedBox(height: 20,),
              
              SubStack(),
                                SizedBox(height: 20,),
                                Container(width: screenWidth*0.9,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Recent Transactions",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                ),
                                                 ElevatedButton(
                                                onPressed: () {
                                                  // Your action here
                                                },
                                               child: Row(children: [
                                                Text("View All",style: TextStyle(color: Color(0XFF6418C3)),),
                                                Icon(Icons.arrow_forward,color: Color(0XFF6418C3),)
                                               ],),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Color(0XFF6418C3), // Background color
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0), 
                                                    side: BorderSide(color: Color(0XFF6418C3),width: 1),
                                                  // The rounded corners
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // The padding inside the button
                                                ),
                                              )
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                           InkWell(
                                            onTap: (){
                                              Navigator.of(context).pushNamed("alltransactions");
                                            },
                                             child: RecentTransactions(text1: "Paid for Pro",text2: "28 feb, 2024 at 6:00am",
                                             text3: "SFHB46Hc566",text4: "₹86,968",),
                                           )     
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                     Container(
                                      width: screenWidth*0.9,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Recent Subscribers",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                ),
                                                 ElevatedButton(
                                                onPressed: () {
                                                  // Your action here
                                                },
                                               child: Row(children: [
                                                Text("View All",style: TextStyle(color: Color(0XFF6418C3)),),
                                                Icon(Icons.arrow_forward,color: Color(0XFF6418C3),)
                                               ],),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Color(0XFF6418C3), // Background color
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0), 
                                                    side: BorderSide(color: Color(0XFF6418C3),width: 1),
                                                  // The rounded corners
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // The padding inside the button
                                                ),
                                              )
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                           
                                           SubscriptionsWidget(text1: 'Swagat Grand Banquet Hall', text2: 'Bachupally, Hyderabad', text3: 'Start:25th Feb, 2024', text4: 'End:25th Mar, 2024')
                                          ],
                                        ),
                                      ),
                                    ),
        ],),
      ),
    );
  }
}