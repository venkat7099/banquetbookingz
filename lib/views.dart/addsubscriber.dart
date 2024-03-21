import 'package:banquetbookingz/providers/filtersprovider.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/widgets/button.dart';
import 'package:banquetbookingz/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSubscriber extends StatelessWidget {
  const AddSubscriber({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(padding: EdgeInsets.all(15),color: Color(0xFFf5f5f5),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(child: Consumer(builder: (context, ref, child) {
            final addSub=ref.watch(selectionModelProvider.notifier);
            return AppBar(leading: IconButton(onPressed: (){
              addSub.toggleAddSubscriber(false);
              
            }, icon: Icon(Icons.arrow_back,color: Color(0xff6418c3),)),
            backgroundColor: Color(0xfff5f5f5),
            title: Text("Subcdription",style: TextStyle(color: Color(0xff6418c3),fontSize: 20),),);}
          )),
          SizedBox(height: 20,),
          Container(
          padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Subscription details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
SizedBox(height: 20,),
Text("name",style: TextStyle(fontSize: 18,),),
SizedBox(height: 10,),
CustomTextFormField(width: screenWidth*0.8,
hintText: 'name',),
   SizedBox(height: 12,),
   Text("Annual pricing",style: TextStyle(fontSize: 18,),),
SizedBox(height: 10,),
CustomTextFormField(width: screenWidth*0.8,
hintText: 'Annual pricing',),
SizedBox(height: 12,),
   Text("Quarterly pricing",style: TextStyle(fontSize: 18,),),
SizedBox(height: 10,),
CustomTextFormField(width: screenWidth*0.8,
hintText: 'Quarterly pricing',),
SizedBox(height: 12,),
   Text("Monthly pricing",style: TextStyle(fontSize: 18,),),
SizedBox(height: 10,),
CustomTextFormField(width: screenWidth*0.8,
hintText: 'Monthly pricing',),
SizedBox(height: 12,),
   Text("Subcription tags",style: TextStyle(fontSize: 18,),),
SizedBox(height: 10,),
CustomTextFormField(width: screenWidth*0.8,
hintText: 'Subcription tags',),
 SizedBox(height: 8,),
          Consumer(builder: (context, ref, child) {
  final options= ref.watch(filterOptionsProvider).options['Subscription Type'] ?? [];
            return Wrap(
              spacing: 8.0,
              children: options.map((option) => Chip(backgroundColor: Color(0xffeee1ff),
                label: Text(option),
                deleteIcon: Icon(Icons.close),
                onDeleted: () {
                  // Handle delete (removal) of the filter option
                  ref.read(filterOptionsProvider.notifier).removeOption('Subscription Type', option);
                },
              )).toList(),
            );}
          ),
            ],),),
            SizedBox(height: 20,),
            CustomElevateButton(text: "Add Subscriber", borderRadius:10,backGroundColor: Color(0xff6418c3),
            foreGroundColor: Colors.white,width: double.infinity, )
        
        ],),
      ),
    );
  }
}