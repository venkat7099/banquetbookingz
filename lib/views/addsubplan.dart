import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:banquetbookingz/providers/loader.dart";
import "package:banquetbookingz/providers/subscriptionprovider_0.dart";

class AddSubPlans extends ConsumerStatefulWidget {
  const AddSubPlans({super.key});

  @override
  ConsumerState<AddSubPlans> createState() => _AddSubPlansState();
}

class _AddSubPlansState extends ConsumerState<AddSubPlans> {
  final TextEditingController frequencyControllers = TextEditingController();
  final TextEditingController subPlanControllers = TextEditingController();
  final TextEditingController bookingsControllers = TextEditingController();
  final TextEditingController pricingControllers = TextEditingController();

  String? planName;
  int? planId;

   @override
  void dispose() {
 
    frequencyControllers.dispose();
    subPlanControllers.dispose();
    bookingsControllers.dispose();
    pricingControllers.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch arguments using ModalRoute
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      setState(() {
        planName = args['planName'];
        planId = args['planId'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);
    final subscribersData = ref.watch(subscriptionProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F9), // Background color
      appBar: AppBar(
        title: const Text('Existing Plan Details'),
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Plan Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: planName ?? 'N/A',
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Current Sub-Plans',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
              //  SizedBox(
              //       height: 200, // Fixed height for dynamic data
              //       child: Builder(
              //         builder: (context) {
              //           final data = ref.watch(subscriptionProvider).data;

              //           // Loading State: Show a CircularProgressIndicator while data loads
              //           if (data == null) {
              //             return const Center(child: CircularProgressIndicator());
              //           }

              //           // Filter subplans based on planName
              //           final filteredSubPlans = data.where((subPlan) {
              //             return subPlan['plan_name'] == planName; // Compare with selected planName
              //           }).toList();

              //           // Check for empty filtered list
              //           if (filteredSubPlans.isEmpty) {
              //             return Center(
              //               child: Text("No Sub-Plans for '$planName'"),
              //             );
              //           }

              //           // Display the filtered subplans
              //           return ListView.builder(
              //             itemCount: filteredSubPlans.length,
              //             itemBuilder: (context, index) {
              //               final subPlan = filteredSubPlans[index];
              //               return SubPlanTile(
              //                 subPlanName: subPlan['name'] ?? 'Unknown',
              //                 price: double.tryParse(subPlan['price']?.toString() ?? '0.0') ?? 0.0,
              //               );
              //             },
              //           );
              //         },
              //       ),
              //     ),


                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'Add New Sub-Plan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField("Frequency", frequencyControllers,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 8),
                _buildTextField("Sub-plan", subPlanControllers),
                const SizedBox(height: 8),
                _buildTextField("Bookings", bookingsControllers,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 8),
                _buildTextField("Pricing", pricingControllers,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                 ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        await ref
                            .read(subscriptionProvider.notifier)
                            .addSubSubscriptionDetails(
                              planId: planId!,
                              subPlanName: subPlanControllers.text,
                              frequency: frequencyControllers.text,
                              numBookings: bookingsControllers.text,
                              price: pricingControllers.text,
                            );

                        // Clear text fields after submission
                       
                        frequencyControllers.clear();
                        subPlanControllers.clear();
                        bookingsControllers.clear();
                        pricingControllers.clear();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF6418C3),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Add Subscriber"),
              ),
              ],
            ),
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
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 6),
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
}

class SubPlanTile extends StatelessWidget {
  final String subPlanName;
  final double price;

  const SubPlanTile({
    required this.subPlanName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subPlanName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            'Price: \u0024${price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
