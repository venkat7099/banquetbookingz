import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Provider to manage loading state and API call
final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, bool>((ref) {
  return SubscriptionNotifier();
});

class SubscriptionNotifier extends StateNotifier<bool> {
  SubscriptionNotifier() : super(false);

  Future<void> postSubscriptionDetails({
    required String planName,
    required String userId,
    required String frequency,
    required String subPlanName,
    required String numBookings,
    required String price,
  }) async {
    final url = Uri.parse('http://www.gocodedesigners.com/bbaddplan');

    // Validate fields
    if (planName.isEmpty ||
        userId.isEmpty ||
        frequency.isEmpty ||
        subPlanName.isEmpty ||
        numBookings.isEmpty ||
        price.isEmpty) {
      print('Validation Error: All fields must be provided.');
      return;
    }

    final body = {
      'plan_name': planName.trim(),
      'created_by': userId.trim(),
      'frequency': int.tryParse(frequency) ?? 0,
      'sub_plan_name': subPlanName.trim(),
      'num_bookings': int.tryParse(numBookings) ?? 0,
      'price': int.tryParse(price) ?? 0,
    };

    // Ensure all fields are properly converted to avoid null values
    if (body.containsValue(null)) {
      print('Data type error: Conversion failed!');
      print('Request body: $body');
      return;
    }

    state = true; // Set loading to true
    try {
      final response = await http.post(
        url,
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
      );
      print('Request body: $body');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Subscription added successfully.');
      } else {
        print('Error in request: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      state = false; // Reset loading to false
    }
  }
}
