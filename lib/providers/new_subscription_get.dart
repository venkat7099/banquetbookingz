import 'package:banquetbookingz/models/new_subscriptionplan.dart';
import 'package:banquetbookingz/providers/authprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:banquetbookingz/utils/banquetbookzapi.dart';
import 'package:http/http.dart' as http;

final subscriptionPlansProvider =
    FutureProvider<List<SubscriptionPlan>>((ref) async {
  final getaccesstoken = ref.read(authProvider).data?.accessToken;
  try {
    if (getaccesstoken == null) {
      print("Access token is null");
      return []; // Return an empty list if the access token is missing
    }

    final response = await http.get(
      Uri.parse(Api.subscriptions),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $getaccesstoken',
      },
    );

    print('Response Code: ${response.statusCode}');
    print('Server Response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print('Full Response: $jsonResponse');

      List<SubscriptionPlan> subscriptionPlans = [];

      jsonResponse.forEach((key, value) {
        List<dynamic> plansJson = value as List<dynamic>;
        subscriptionPlans.addAll(
            plansJson.map((data) => SubscriptionPlan.fromJson(data)).toList());
      });

      if (subscriptionPlans.isEmpty) {
        print('No subscription data found');
      }

      return subscriptionPlans;
    } else {
      print('Error fetching subscriptions: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print("Error fetching subscriptions: $e");
    return [];
  }
});

class SelectedPlanNotifier extends StateNotifier<List<SubscriptionPlan>?> {
  SelectedPlanNotifier() : super(null);

  void selectPlan(List<SubscriptionPlan> plans) {
    state = plans;
  }
}

final selectedPlanProvider =
    StateNotifierProvider<SelectedPlanNotifier, List<SubscriptionPlan>?>(
        (ref) => SelectedPlanNotifier());
