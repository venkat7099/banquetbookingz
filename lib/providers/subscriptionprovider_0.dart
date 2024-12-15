import 'package:banquetbookingz/models/subscriptionmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';
import 'package:banquetbookingz/providers/loader.dart';

class SubscriptionNotifier extends StateNotifier<Subscription> {
  final Ref ref;
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

  /// Add a new subscription and refresh state
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

    if (parsedFrequency == null || parsedNumBookings == null || parsedPrice == null) {
      print('Validation Error: Numeric fields must contain valid numbers.');
      return;
    }

    ref.read(loadingProvider.notifier).state = true; // Set loading to true
    try {
      // Prepare the multipart request
      var request = http.MultipartRequest('POST', uri);

      request.fields['plan_name'] = planName.trim();
      request.fields['created_by'] = userId.trim();
      request.fields['frequency'] = parsedFrequency.toString();
      request.fields['sub_plan_name'] = subPlanName.trim();
      request.fields['num_bookings'] = parsedNumBookings.toString();
      request.fields['price'] = parsedPrice.toString();

      // Send the request
      final send = await request.send();
      final res = await http.Response.fromStream(send);

      if (res.statusCode == 200 || res.statusCode == 201) {
        final responseJson = json.decode(res.body);
        print('Subscription added successfully: $responseJson');

        // Refresh data after successfully adding a subscription
        await getSubscribers();
      } else {
        print('Error in request: ${res.statusCode}, ${res.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      ref.read(loadingProvider.notifier).state = false; // Reset loading
    }
  }

  
Future<void> editSubscriptionDetails({
     String? type,
     String? planId,
     String? planName,
     String? userId,
     String? frequency,
     String? numBookings,
     String? price,
  }) async {
   
   
    ref.read(loadingProvider.notifier).state = true; // Set loading to true
    try {
    var response = await http.post(
        Uri.parse(Api.subscriptions),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'type': type,
             'plan_id':planId!.trim(),
             'plan_name':planName!.trim(),
             'created_by':userId.toString(),
             'frequency':frequency.toString(),
             'num_bookings':numBookings.toString(),
             'price':price.toString()
           }),
      );
   
      var responseCode = response.statusCode;
      var responseBody = json.decode(response.body);
      print('Response Code: $responseCode');
      print('Server Response: $responseBody');

   if ( responseCode == 200 ||  responseCode == 201) {

        print('Subscription added successfully: $responseBody');

        // Refresh data after successfully adding a subscription
        await getSubscribers();
      } else {
        print('Error in request: $responseCode, $responseBody');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      ref.read(loadingProvider.notifier).state = false; // Reset loading
    }
  }

  /// Fetch subscribers and update the state
  Future<void> getSubscribers() async {
    final accessToken = await _getAccessToken();
    if (accessToken == null) {
      print("Access token is null.");
      return;
    }

    ref.read(loadingProvider.notifier).state = true; // Set loading to true
    try {
      final response = await http.get(
        Uri.parse(Api.subscriptions),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final subscriptionData = Subscription.fromJson(res);
        state = subscriptionData; // Update state with fetched data
        print("Subscribers fetched successfully: $subscriptionData");
      } else {
        final res = json.decode(response.body);
        print(
          'Error fetching subscribers: ${res['messages']?.first ?? 'An unknown error occurred.'}',
        );
      }
    } catch (e) {
      print("Error fetching subscribers: $e");
    } finally {
      ref.read(loadingProvider.notifier).state = false; // Reset loading
    }
  }
}

/// Provider to manage loading state and API calls
final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, Subscription>((ref) {
  return SubscriptionNotifier(ref);
});
