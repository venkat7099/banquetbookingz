import 'package:flutter/material.dart';
import 'package:banquetbookingz/models/new_subscriptionplan.dart';

class DiamondSubscriptionScreen extends StatelessWidget {
  final List<SubscriptionPlan> diamondPlans;

  const DiamondSubscriptionScreen({Key? key, required this.diamondPlans})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diamond Subscriptions'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: diamondPlans.length,
          itemBuilder: (context, index) {
            final plan = diamondPlans[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.plan,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Frequency: ${plan.frequency}'),
                    Text('Bookings: ${plan.bookings}'),
                    Text('Pricing: ${plan.pricing.toString()}'),
                    Text(
                      'Created At: ${plan.createdAt}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
