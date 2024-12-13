import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../providers/authprovider.dart';
import '../providers/loader.dart';

class AddSubscriber extends ConsumerStatefulWidget {
  const AddSubscriber({super.key});

  @override
  ConsumerState<AddSubscriber> createState() => _AddSubscriberState();
}

class _AddSubscriberState extends ConsumerState<AddSubscriber> {
  // Define controllers as instance variables
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
    // Dispose of controllers to prevent memory leaks
    planController.dispose();
    frequencyController.dispose();
    subPlanController.dispose();
    bookingsController.dispose();
    pricingController.dispose();
    super.dispose();
  }

  Future<void> postSubscriptionDetails({
    required String userId,
    required String planName,
    required String frequency,
    required String subPlanName,
    required String numBookings,
    required String price,
    required WidgetRef ref,
  }) async {
    final url = Uri.parse('http://www.gocodedesigners.com/bbaddplan');
    ref.read(loadingProvider.notifier).state = true;

    // Log the details before making the request
    print('Posting subscription details:');
    print({
      'created_by': userId,
      'plan_name': planName,
      'frequency': frequency,
      'sub_plan_name': subPlanName,
      'num_bookings': numBookings,
      'price': price,
    });

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'created_by': userId,
          'plan_name': planName,
          'frequency': frequency,
          'sub_plan_name': subPlanName,
          'num_bookings': numBookings,
          'price': price,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Subscription added successfully: ${response.body}');
      } else {
        print('Failed to add subscription: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authProvider);
    final userId = currentUser.data?.userId ?? '';

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
                  const Text("Plan", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: planController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Plan',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                          value: selectedValue, // The currently selected value
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue; // Update the selected value
                            });
                          },
                          items: items.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                  const Text("Frequency", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: frequencyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Frequency',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Sub-plan", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: subPlanController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Sub-plan',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Bookings", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: bookingsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Bookings',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Pricing", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: pricingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Pricing',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Consumer(builder: (context, ref, child) {
                final loading = ref.watch(loadingProvider);

                return ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                          await postSubscriptionDetails(
                            userId: '$userId',
                            planName: planController.text,
                            frequency: frequencyController.text,
                            subPlanName: subPlanController.text,
                            numBookings: bookingsController.text,
                            price: pricingController.text,
                            ref: ref,
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
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Add Subscriber"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
