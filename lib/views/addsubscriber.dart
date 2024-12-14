import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/authprovider.dart';
import '../providers/subscriptionprovider_0.dart';
import 'package:banquetbookingz/providers/loader.dart';

class AddSubscriber extends ConsumerStatefulWidget {
  const AddSubscriber({super.key});

  @override
  ConsumerState<AddSubscriber> createState() => _AddSubscriberState();
}

class _AddSubscriberState extends ConsumerState<AddSubscriber> {
  final TextEditingController planController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final TextEditingController subPlanController = TextEditingController();
  final TextEditingController bookingsController = TextEditingController();
  final TextEditingController pricingController = TextEditingController();

  String? selectedValue = "Apple";

  // List of items in the dropdown
  final List<String> items = [
    "Apple",
    "Banana",
    "Orange",
    "Grapes",
    "Mango",
  ];

  @override
  void dispose() {
    planController.dispose();
    frequencyController.dispose();
    subPlanController.dispose();
    bookingsController.dispose();
    pricingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authProvider);
    final userId = currentUser.data?.userId ?? '';
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        color: const Color(0xFFf5f5f5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xff6418c3),
                  ),
                ),
                backgroundColor: const Color(0xfff5f5f5),
                title: const Text(
                  "Subscription",
                  style: TextStyle(color: Color(0xff6418c3), fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Subscription details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 18),
                  _buildTextField("Plan", planController),
                  const SizedBox(height: 10),
                  _buildTextField("Frequency", frequencyController,
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 10),
                  _buildTextField("Sub-plan", subPlanController),
                  const SizedBox(height: 10),
                  _buildTextField("Bookings", bookingsController,
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 10),
                  _buildTextField("Pricing", pricingController,
                      keyboardType: TextInputType.number),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        await ref
                            .read(subscriptionProvider.notifier)
                            .postSubscriptionDetails(
                              planName: planController.text,
                              userId: '$userId',
                              frequency: frequencyController.text,
                              subPlanName: subPlanController.text,
                              numBookings: bookingsController.text,
                              price: pricingController.text,
                            );

                        // Clear text fields after submission
                        planController.clear();
                        frequencyController.clear();
                        subPlanController.clear();
                        bookingsController.clear();
                        pricingController.clear();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF6418C3),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Add Subscriber"),
              ),
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
}
