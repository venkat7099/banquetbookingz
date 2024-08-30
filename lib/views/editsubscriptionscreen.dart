// import 'package:flutter/material.dart';
// import 'package:banquetbookingz/models/new_subscriptionplan.dart';

// class EditSubscriptionScreen extends StatelessWidget {
//   final SubscriptionPlan plan;

//   const EditSubscriptionScreen({Key? key, required this.plan})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Subscription Plan'),
//         backgroundColor: Colors.blue[900],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               initialValue: plan.plan,
//               decoration: const InputDecoration(labelText: 'Plan'),
//             ),
//             TextFormField(
//               initialValue: plan.frequency.toString(),
//               decoration: const InputDecoration(labelText: 'Frequency'),
//             ),
//             TextFormField(
//               initialValue: plan.bookings.toString(),
//               decoration: const InputDecoration(labelText: 'Bookings'),
//             ),
//             TextFormField(
//               initialValue: plan.pricing.toString(),
//               decoration: const InputDecoration(labelText: 'Pricing'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle saving the edited subscription details
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banquetbookingz/models/new_subscriptionplan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditSubscriptionScreen extends StatelessWidget {
  final SubscriptionPlan plan;

  const EditSubscriptionScreen({Key? key, required this.plan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController planController =
        TextEditingController(text: plan.plan);
    final TextEditingController frequencyController =
        TextEditingController(text: plan.frequency.toString());
    final TextEditingController bookingsController =
        TextEditingController(text: plan.bookings.toString());
    final TextEditingController pricingController =
        TextEditingController(text: plan.pricing.toString());

    Future<void> updateSubscriptionPlan(SubscriptionPlan updatedPlan) async {
      final url =
          'http://93.127.172.164:8080/api/subscription-plans/${updatedPlan.id}/';
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
        body: jsonEncode({
          'bookings': updatedPlan.bookings,
          'pricing': updatedPlan.pricing,
        }),
      );
      print('Server Response Code: ${response.statusCode}');
      print('widget User id: ${updatedPlan.id}');
      print('Server Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Successfully updated the subscription plan
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Subscription plan updated successfully!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle errors or show a message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to update the subscription plan.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Subscription Plan'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: bookingsController,
              decoration: const InputDecoration(labelText: 'Bookings'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: pricingController,
              decoration: const InputDecoration(labelText: 'Pricing'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Create an updated SubscriptionPlan object
                final updatedPlan = SubscriptionPlan(
                  id: plan.id,
                  plan: planController.text,
                  frequency: frequencyController.text,
                  bookings: int.parse(bookingsController.text),
                  pricing: double.parse(pricingController.text),
                  createdAt: plan.createdAt,
                );

                // Call the API to update the subscription plan
                updateSubscriptionPlan(updatedPlan);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
