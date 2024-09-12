import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banquetbookingz/models/new_subscriptionplan.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';
import 'package:banquetbookingz/providers/new_subscription_get.dart';
import 'package:banquetbookingz/views/subpackages.dart';

class Subscription extends ConsumerWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionPlansAsyncValue = ref.watch(subscriptionPlansProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StackWidget(
              text: "Subscription",
              onTap: () {
                Navigator.of(context).pushNamed("addsubscriber");
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: subscriptionPlansAsyncValue.when(
                data: (subscriptionPlans) {
                  if (subscriptionPlans.isEmpty) {
                    return const Center(
                      child: Text(
                        "No subscriptions available",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  final groupedPlans = <String, List<SubscriptionPlan>>{};
                  for (var plan in subscriptionPlans) {
                    if (!groupedPlans.containsKey(plan.plan)) {
                      groupedPlans[plan.plan] = [];
                    }
                    groupedPlans[plan.plan]!.add(plan);
                  }

                  return Column(
                    children: groupedPlans.entries.map((entry) {
                      final planTitle = entry.key;
                      final plans = entry.value;

                      return _buildPlanCard(
                        context,
                        planTitle,
                        plans,
                        ref,
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title,
      List<SubscriptionPlan> plans, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final selectedPlanNotifier = ref.read(selectedPlanProvider.notifier);
        selectedPlanNotifier.selectPlan(plans);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Subpackages(
              plans: plans,
              title: title,
              cardColor: Colors.white,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Subscribed: ${plans.length}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Revenue Generated: ₹89,928",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Last Subscribed: 28th Feb, 2024 at 06:35 PM",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              
            ],
          ),
        ),
      ),
    );
  }
}



// class EditSubscriptionScreen extends StatelessWidget {
//   final SubscriptionPlan plan;

//   const EditSubscriptionScreen({super.key, required this.plan});

//   @override
//   Widget build(BuildContext context) {
//     // Implement the UI and logic for editing the subscription
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Subscription"),
//       ),
//       body: Center(
//         child: Text("Edit subscription details for ${plan.plan}"),
//       ),
//     );
//   }
// }
