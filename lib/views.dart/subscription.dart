import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banquetbookingz/models/new_subscriptionplan.dart';
import 'package:flutter/material.dart';
import 'package:banquetbookingz/widgets/stackwidget.dart';
import 'package:banquetbookingz/providers/new_subscription_get.dart';
import 'package:banquetbookingz/views.dart/subpackages.dart';

class SelectedPlanNotifier extends StateNotifier<List<SubscriptionPlan>?> {
  SelectedPlanNotifier() : super(null);

  void selectPlan(List<SubscriptionPlan> plans) {
    state = plans;
  }
}

final selectedPlanProvider =
    StateNotifierProvider<SelectedPlanNotifier, List<SubscriptionPlan>?>(
        (ref) => SelectedPlanNotifier());

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
              hintText: "Search Subscriptions",
              text: "Subscription",
              onTap: () {
                Navigator.of(context).pushNamed("addsubscriber");
              },
              arrow: Icons.arrow_back,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
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

                    // Categorize the plans
                    final goldPlans = subscriptionPlans
                        .where(
                            (plan) => plan.plan.toLowerCase().contains('gold'))
                        .toList();
                    final platinumPlans = subscriptionPlans
                        .where((plan) =>
                            plan.plan.toLowerCase().contains('platinum'))
                        .toList();
                    final diamondPlans = subscriptionPlans
                        .where((plan) =>
                            plan.plan.toLowerCase().contains('diamond'))
                        .toList();

                    final screenWidth = MediaQuery.of(context).size.width;
                    final cardWidth = (screenWidth / 3) - 12;

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        if (goldPlans.isNotEmpty)
                          _buildPlanCard(
                              context, "Gold", goldPlans, cardWidth, ref),
                        if (platinumPlans.isNotEmpty)
                          _buildPlanCard(context, "Platinum", platinumPlans,
                              cardWidth, ref),
                        if (diamondPlans.isNotEmpty)
                          _buildPlanCard(
                              context, "Diamond", diamondPlans, cardWidth, ref),
                      ],
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
      List<SubscriptionPlan> plans, double cardWidth, WidgetRef ref) {
    final colors = {
      "Gold": [Colors.amber[600]!, Colors.amber[400]!],
      "Platinum": [Colors.blueGrey[700]!, Colors.blueGrey[500]!],
      "Diamond": [Colors.blue[900]!, Colors.blue[700]!],
    };

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          final selectedPlanNotifier = ref.read(selectedPlanProvider.notifier);
          selectedPlanNotifier.selectPlan(plans);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Subpackages(
                plans: plans,
                title: title,
                cardColor: colors[title]![0],
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8, // Increased elevation for more shadow
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: colors[title]!,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getPlanIcon(title),
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${plans.length} Plans',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getPlanIcon(String title) {
    switch (title) {
      case "Gold":
        return Icons.star;
      case "Platinum":
        return Icons.verified_user;
      case "Diamond":
        return Icons.diamond;
      default:
        return Icons.subscriptions;
    }
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:banquetbookingz/widgets/stackwidget.dart';
// import 'package:banquetbookingz/providers/new_subscription_get.dart';
// import 'package:banquetbookingz/models/new_subscriptionplan.dart';
// import 'package:banquetbookingz/views.dart/gold_subscription.dart';
// import 'package:banquetbookingz/views.dart/diamond_subscription.dart';
// import 'package:banquetbookingz/views.dart/platinum_subscription.dart';

// class Subscription extends ConsumerWidget {
//   const Subscription({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final subscriptionPlansAsyncValue = ref.watch(subscriptionPlansProvider);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             StackWidget(
//               hintText: "Search Subscriptions",
//               text: "Subscription",
//               onTap: () {
//                 Navigator.of(context).pushNamed("addsubscriber");
//               },
//               arrow: Icons.arrow_back,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: 500,
//                 width: double.infinity, // Adjust height as needed
//                 child: subscriptionPlansAsyncValue.when(
//                   data: (subscriptionPlans) {
//                     if (subscriptionPlans.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           "No subscriptions available",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       );
//                     }

//                     // Categorize the plans
//                     final goldPlans = subscriptionPlans
//                         .where(
//                             (plan) => plan.plan.toLowerCase().contains('gold'))
//                         .toList();
//                     final platinumPlans = subscriptionPlans
//                         .where((plan) =>
//                             plan.plan.toLowerCase().contains('platinum'))
//                         .toList();
//                     final diamondPlans = subscriptionPlans
//                         .where((plan) =>
//                             plan.plan.toLowerCase().contains('diamond'))
//                         .toList();

//                     // Get screen width
//                     final screenWidth = MediaQuery.of(context).size.width;

//                     // Calculate card width (with reduced spacing)
//                     final cardWidth = (screenWidth / 3) - 12; // Reduced spacing

//                     // Create the cards
//                     return ListView(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       children: [
//                         if (goldPlans.isNotEmpty)
//                           _buildPlanCard(
//                               context,
//                               "Gold",
//                               goldPlans,
//                               Colors.amber[600]!,
//                               GoldSubscriptionScreen(
//                                 goldPlans: goldPlans,
//                               ),
//                               cardWidth),
//                         if (platinumPlans.isNotEmpty)
//                           _buildPlanCard(
//                               context,
//                               "Platinum",
//                               platinumPlans,
//                               Colors.blueGrey[700]!,
//                               PlatinumSubscriptionScreen(
//                                   platinumPlans: platinumPlans),
//                               cardWidth),
//                         if (diamondPlans.isNotEmpty)
//                           _buildPlanCard(
//                               context,
//                               "Diamond",
//                               diamondPlans,
//                               Colors.blue[900]!,
//                               DiamondSubscriptionScreen(
//                                   diamondPlans: diamondPlans),
//                               cardWidth),
//                       ],
//                     );
//                   },
//                   loading: () =>
//                       const Center(child: CircularProgressIndicator()),
//                   error: (error, stackTrace) => Text('Error: $error'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPlanCard(
//       BuildContext context,
//       String title,
//       List<SubscriptionPlan> plans,
//       Color cardColor,
//       Widget destinationScreen,
//       double cardWidth) {
//     return Container(
//       width: cardWidth,
//       padding: const EdgeInsets.all(4.0), 
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => destinationScreen,
//             ),
//           );
//         },
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           color: cardColor,
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(4.0), 
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   '${plans.length} Plans',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.white70,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
