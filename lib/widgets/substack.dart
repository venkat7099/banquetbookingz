import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubStack extends StatelessWidget {
  final String? text;
  final String? editBtn;
  final double? width;
  final VoidCallback? onTap;
  const SubStack({super.key, this.text,this.width,this.editBtn,this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Stack(children: [
                                  Container(height: screenHeight*0.23,
                                  width: screenWidth*0.9,
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xffeee1ff),
                                    ),
                                                                  
                                  ),
                                  Positioned(top: 0,
                                    child:Container(
                                      width: width,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                       child: Column(children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          Text(text??"",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                      InkWell(onTap: onTap,
                                                        child: Text(editBtn??"",style: TextStyle(fontSize: 18,color: Color(0xff6418c3)),)),
                                        ],),
                                        SizedBox(height: 20,),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          Text("Subscribers",style: TextStyle(fontSize: 15,color: Color(0xffb4b4b4)),),
              Text("₹0",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                        ],),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          Text("Revenue Generated",style: TextStyle(fontSize: 15,color: Color(0xffb4b4b4)),),
              Text("0",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                        ],),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          Text("Last Subscribed",style: TextStyle(fontSize: 15,color: Color(0xffb4b4b4)),),
              Text("-",style: TextStyle(fontSize: 15,color: Color(0xff000000)),),
                                        ],),
                      
                                       ],),                           
                                  ),),
                                  Positioned(bottom: 10,left: 120,
                                    child: Text("value for money",style: TextStyle(color: Color(0xff6418c3)),))
                                ],);
  }
}