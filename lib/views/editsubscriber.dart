import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/authprovider.dart';
import '../providers/subscriptionprovider_0.dart';
import 'package:banquetbookingz/providers/loader.dart';

class EditSubscriber extends ConsumerStatefulWidget {
  const EditSubscriber({super.key});

  @override
  ConsumerState<EditSubscriber> createState() => _EditSubscriberState();
}

class _EditSubscriberState extends ConsumerState<EditSubscriber> {
  final TextEditingController planControllers = TextEditingController();
  final TextEditingController frequencyControllers = TextEditingController();
  final TextEditingController subPlanControllers = TextEditingController();
  final TextEditingController bookingsControllers = TextEditingController();
  final TextEditingController pricingControllers = TextEditingController();

  bool isDeleting = false;

  @override
  void dispose() {
    planControllers.dispose();
    frequencyControllers.dispose();
    subPlanControllers.dispose();
    bookingsControllers.dispose();
    pricingControllers.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch subscription data to populate fields
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      planControllers.text = args['planName'] ?? '';
      frequencyControllers.text = args['frequency'] ?? '';
      subPlanControllers.text = args['subPlanName'] ?? '';
      bookingsControllers.text = args['bookings'] ?? '';
      pricingControllers.text = args['pricing'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authProvider);
    final userId = currentUser.data?.userId ?? '';
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Subscription"),
        backgroundColor: const Color(0xff6418c3),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: const Color(0xFFf5f5f5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Edit Subscription Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 18),
              _buildTextField("Plan", planControllers),
              const SizedBox(height: 10),
              _buildTextField("Frequency", frequencyControllers, keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _buildTextField("Sub-plan", subPlanControllers),
              const SizedBox(height: 10),
              _buildTextField("Bookings", bookingsControllers, keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _buildTextField("Pricing", pricingControllers, keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {

                            if(type=="plan"){
                                await ref.read(subscriptionProvider.notifier).editSubscriptionDetails(

                                    type:"plan",
                                    planId: "7",
                                    
                                    planName: "bronze",
                                    createdby: "33",
                               
                            
                                  );
                            }
                            else{
                                   await ref.read(subscriptionProvider.notifier).editSubscriptionDetails(

                                    type:"sub_plan",
                                    planId: "7",
                                    planName: subPlanControllers.text,
                                  
                                    frequency: frequencyControllers.text,
                                   
                                    numBookings: bookingsControllers.text,
                                    price: pricingControllers.text,
                                  );
                            }
                             
                              _showSnackBar(context, "Subscription updated successfully!");
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF6418C3),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Save"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  
                  ElevatedButton(
                      onPressed: (){
                       
                       
                      },
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                         ),
                       child:const Text("Delete")
                      // isDeleting
                      //     ? null
                      //     : () async {
                      //         setState(() => isDeleting = true);
                      //         await ref.read(subscriptionProvider.notifier).deleteSubscription();
                      //         setState(() => isDeleting = false);
                      //         Navigator.of(context).pop();
                      //         _showSnackBar(context, "Subscription deleted successfully!");
                      //       },
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Colors.red,
                      //   padding: const EdgeInsets.symmetric(vertical: 15),
                      // ),
                      // child: isDeleting
                      //     ? const CircularProgressIndicator(color: Colors.white)
                      //     : const Text("Delete"),
                    ),
                
                ],
              ),

              // Row(
              //   children: [
              //       ElevatedButton(
              //         onPressed: () {
                        
              //           print("Button Pressed!");
              //         },
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: const Color(0xFF6418C3), // Button color
              //           foregroundColor: Colors.white, // Text color
              //           padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Padding
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8), // Rounded corners
              //           ),
              //           elevation: 5, // Shadow elevation
              //         ),
              //         child: const Text(
              //           "Save",
              //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //         ),
              //       ),
              //       const SizedBox(width: 10,),
              //       ElevatedButton(
              //           onPressed: () {
              //             // Action to perform when button is pressed
              //             print("Button Pressed!");
              //           },
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: const Color(0xFF6418C3), // Button color
              //             foregroundColor: Colors.white, // Text color
              //             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Padding
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(8), // Rounded corners
              //             ),
              //             elevation: 5, // Shadow elevation
              //           ),
              //           child: const Text(
              //             "Delete",
              //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //           ),
              //         ),

               
              // ],)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: label,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
