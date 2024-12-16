import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/authprovider.dart';
import '../providers/subscriptionprovider_0.dart';
import 'package:banquetbookingz/providers/loader.dart';

class EditSubscriber extends ConsumerStatefulWidget {
  const EditSubscriber({super.key});

  @override
  ConsumerState<EditSubscriber> createState() => _EditSubscriberState();
}



class _EditSubscriberState extends ConsumerState<EditSubscriber> {
  final TextEditingController planControllers = TextEditingController();
  final TextEditingController frequencyControllers = TextEditingController();
  final TextEditingController subPlanControllers = TextEditingController();
  final TextEditingController bookingsControllers = TextEditingController();
  final TextEditingController pricingControllers = TextEditingController();

  bool isDeleting = false;
  String? types;
  int? planId;
  int? createdby;

  @override
  void dispose() {
    planControllers.dispose();
    frequencyControllers.dispose();
    subPlanControllers.dispose();
    bookingsControllers.dispose();
    pricingControllers.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch subscription data to populate fields
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {

      types = args['type']; // Type: plan or sub_plan
      planId = args['planId']??'';
      //  is int ? args['planId'] : int.tryParse(args['planId'].toString());
      createdby = args['Createdby']??'';
      //  is int ? args['Createdby'] : int.tryParse(args['Createdby'].toString());

      planControllers.text = args['planName'] ?? '';
      frequencyControllers.text = args['frequency'] ?? '';
      subPlanControllers.text = args['subPlanName'] ?? '';
      bookingsControllers.text = args['numOfBookings'] ?? '';
      pricingControllers.text = args['price'] ?? '';
      print("Received arguments: ${args}");


      print('types: $types, planId: $planId, createdby: $createdby planname-${planControllers.text},freqeuncy-${frequencyControllers.text},subplanname-${subPlanControllers.text},booking-${bookingsControllers.text},price-${pricingControllers.text}');
    }
  }

@override
Widget build(BuildContext context) {
  final currentUser = ref.watch(authProvider);
  final userId = currentUser.data?.userId ?? '';
  final isLoading = ref.watch(loadingProvider);

  return Scaffold(
    appBar: AppBar(
      title: const Text("Edit Subscription"),
      backgroundColor: const Color(0xff6418c3),
      foregroundColor: Colors.white,
    ),
    body: Container(
      padding: const EdgeInsets.all(15),
      color: const Color(0xFFf5f5f5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Edit Subscription Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            // Plan field: Editable if type == "plan", read-only otherwise
            _buildTextField(
              "Plan",
              planControllers,
              isReadOnly: types != "plan",
            ),
            const SizedBox(height: 10),
            // Conditionally display fields based on type == "sub_plan"
            if (types == "sub_plan") ...[
              _buildTextField("Frequency", frequencyControllers,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _buildTextField("Sub-plan", subPlanControllers),
              const SizedBox(height: 10),
              _buildTextField("Bookings", bookingsControllers,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _buildTextField("Pricing", pricingControllers,
                  keyboardType: TextInputType.number),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (planId == null) {
                              _showSnackBar(context, "Error: Plan ID is missing.");
                              return;
                            }

                            if (types == "plan") {
                              await ref
                                  .read(subscriptionProvider.notifier)
                                  .editSubscriptionDetails(
                                    type: "plan",
                                    planId: planId,
                                    planName: planControllers.text,
                                    userId: createdby,
                                  );
                            } else if (types == "sub_plan") {
                              await ref
                                  .read(subscriptionProvider.notifier)
                                  .editSubscriptionDetails(
                                    type: "sub_plan",
                                    planId: planId,
                                    planName: subPlanControllers.text,
                                    frequency: frequencyControllers.text,
                                    userId: createdby,
                                    numBookings: bookingsControllers.text,
                                    price: pricingControllers.text,
                                  );
                            } else {
                              _showSnackBar(context, "Error: Unknown type.");
                              return;
                            }

                            _showSnackBar(
                                context, "Subscription updated successfully!");
                            Navigator.of(context).pop(); // Navigate back after update
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF6418C3),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Save"),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6418C3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}
Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool isReadOnly = false, // Add a read-only flag
  }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 18)),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: isReadOnly, // Apply the read-only behavior
        decoration: InputDecoration(
          hintText: label,
          border: const OutlineInputBorder(),
          filled: isReadOnly, // Grey out read-only fields
          fillColor: isReadOnly ? Colors.grey.shade200 : Colors.white,
        ),
      ),
    ],
  );
}
void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: const Color(0xff6418c3), // Customize background color
      behavior: SnackBarBehavior.floating, // Optional: Floating snack bar
    ),
  );
}
