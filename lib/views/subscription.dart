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
              child: Container(
                width: double.infinity,
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

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 2,
                        childAspectRatio: 4.2 / 2,
                      ),
                      itemCount: groupedPlans.length,
                      itemBuilder: (context, index) {
                        final planTitle = groupedPlans.keys.elementAt(index);
                        final plans = groupedPlans[planTitle]!;

                        return _buildPlanCard(
                          context,
                          planTitle,
                          plans,
                          ref,
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Text('Error: $error'),
                ),
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => EditSubscriptionScreen(
                              //       plan: plans.first,
                              //     ),
                              //   ),
                              // );
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6418C3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Subscribed: ${plans.length}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        "Revenue Generated: ₹89,928",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        "Last Subscribed: 28th Feb, 2024 at 06:35 PM",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        // "Status: ${subscriptionStatus[title] ?? 'Not Subscribed'}",
                        "Status: Subscribed",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
