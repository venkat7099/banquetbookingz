import 'package:banquetbookingz/models/subscriptionmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:banquetbookingz/utils/banquetbookzapi.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banquetbookingz/providers/loader.dart';



class SubscriptionNotifier extends StateNotifier<Subscription> {
    final Ref ref; // Add ref as an instance variable
  SubscriptionNotifier(this.ref) : super(Subscription.initial());

    
  
    Future<String?> _getAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      print("Retrieved token: $token"); // Debug print
      return token;
    } catch (e) {
      print("Error retrieving access token: $e");
      return null;
    }
  }

  Future<void> postSubscriptionDetails({
    required String planName,
    required String userId,
    required String frequency,
    required String subPlanName,
    required String numBookings,
    required String price,
  }) async {
    final uri = Uri.parse(Api.subscriptions);

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

    // Convert fields to appropriate types
    final parsedFrequency = int.tryParse(frequency);
    final parsedNumBookings = int.tryParse(numBookings);
    final parsedPrice = int.tryParse(price);

    // Ensure numeric fields are valid
    if (parsedFrequency == null || parsedNumBookings == null || parsedPrice == null) {
      print('Validation Error: Numeric fields must contain valid numbers.');
      return;
    }

    ref.read(loadingProvider.notifier).state = true; // Set loading to true
    try {
      // Prepare the multipart request
      var request = http.MultipartRequest('POST', uri);

      // Add form fields
      request.fields['plan_name'] = planName.trim();
      request.fields['created_by'] = userId.trim();
      request.fields['frequency'] = parsedFrequency.toString();
      request.fields['sub_plan_name'] = subPlanName.trim();
      request.fields['num_bookings'] = parsedNumBookings.toString();
      request.fields['price'] = parsedPrice.toString();

      // Send the request
      final send = await request.send();
      final res = await http.Response.fromStream(send);

      // Parse the response
      var subscribePlanDetails = json.decode(res.body);

      print('Response status: ${res.statusCode}');
      print('Response body: $subscribePlanDetails');

      if (res.statusCode == 200 || res.statusCode == 201) {
        print('Subscription added successfully.');
      } else {
        print('Error in request: ${res.statusCode}, ${res.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      ref.read(loadingProvider.notifier).state = false; // Reset loading
    }
  }


Future<void> getSubscribers() async {
    try {
      final accessToken = await _getAccessToken();
      if (accessToken == null) {
        print("Access token is null-in -sub");
        return; // Handle case where access token is missing
      }

      final response = await http.get(
        Uri.parse(Api.subscriptions),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      final res = json.decode(response.body);

      print('sub-Response Code: ${response.statusCode}');
      print('sub-Server Response: $res');

      if (response.statusCode == 200) {
        final subscriptionData = Subscription.fromJson(res);
        state = subscriptionData; // Update state with fetched data
        print("subs-data=$subscriptionData");
      } else {
        print(
          'Error fetching subscribers: ${res['messages']?.first ?? 'An unknown error occurred.'}',
        );
      }
    } catch (e) {
      print("Error fetching subscribers: $e");
    }
  }
}


// Provider to manage loading state and API call
final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, Subscription>((ref) {
  return SubscriptionNotifier(ref);
});