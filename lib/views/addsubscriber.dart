import 'package:banquetbookingz/providers/loader.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/providers/subcsribersprovider.dart';
import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
import 'package:banquetbookingz/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSubscriber extends ConsumerWidget {
  const AddSubscriber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        color: const Color(0xFFf5f5f5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xff6418c3),
                  ),
                ),
                backgroundColor: const Color(0xfff5f5f5),
                title: const Text(
                  "Subscription",
                  style: TextStyle(color: Color(0xff6418c3), fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Subscription details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Plan",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer(builder: (context, ref, child) {
                    final controller =
                        ref.watch(selectionModelProvider.notifier);
                    return CustomTextFormField(
                      width: screenWidth * 0.8,
                      keyBoardType: TextInputType.text,
                      hintText: 'Plan',
                      onChanged: (newValue) {
                        controller.updateSubname(newValue);
                      },
                    );
                  }),
                  const SizedBox(height: 12),
                  const Text(
                    "Frequency",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Consumer(builder: (context, ref, child) {
                        final controller =
                            ref.watch(selectionModelProvider.notifier);
                        return CustomTextFormField(
                          width: screenWidth * 0.6,
                          keyBoardType: TextInputType.number,
                          hintText: 'Frequency',
                          onChanged: (newValue) {
                            controller.updateMonthlyP(newValue);
                          },
                        );
                      }),
                      const SizedBox(width: 10),
                      Consumer(builder: (context, ref, child) {
                        final selectionState =
                            ref.watch(selectionModelProvider);
                        final controller =
                            ref.watch(selectionModelProvider.notifier);

                        return DropdownButton<String>(
                          value: selectionState.selectedFrequency,
                          items: const <String>[
                            'Daily',
                            'Monthly',
                            'Yearly',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              controller.updateFrequency(value);
                            }
                          },
                          icon: const Icon(Icons.arrow_drop_down_circle),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Booking",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer(builder: (context, ref, child) {
                    final controller =
                        ref.watch(selectionModelProvider.notifier);
                    return CustomTextFormField(
                      width: screenWidth * 0.8,
                      keyBoardType: TextInputType.number,
                      hintText: 'Bookings',
                      onChanged: (newValue) {
                        controller.updateQuaterlyP(newValue);
                      },
                    );
                  }),
                  const SizedBox(height: 12),
                  const Text(
                    "Pricing",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer(builder: (context, ref, child) {
                    final controller =
                        ref.watch(selectionModelProvider.notifier);
                    return CustomTextFormField(
                      width: screenWidth * 0.8,
                      keyBoardType: TextInputType.number,
                      hintText: 'Pricing',
                      onChanged: (newValue) {
                        controller.updateAnnualP(newValue);
                      },
                    );
                  }),
                  const SizedBox(height: 12),
                ],
              ),
              const SizedBox(height: 20),
              Consumer(builder: (context, ref, child) {
                final selection = ref.watch(selectionModelProvider);
                final loading = ref.watch(loadingProvider);
                return CustomElevatedButton(
                  text: "Add Subscriber",
                  borderRadius: 10,
                  foreGroundColor: Colors.white,
                  width: double.infinity,
                  backGroundColor: const Color(0XFF6418C3),
                  isLoading: loading,
                  onPressed: loading
                      ? null
                      : () async {
                          // Combine the frequency text and dropdown value
                          String combinedFrequency = selection.monthlyP.text +
                              selection.selectedFrequency;

                          // Validation check to prevent zero values
                          if (selection.subName.text.isEmpty ||
                              selection.annualP.text == '0' ||
                              selection.quaterlyP.text == '0' ||
                              combinedFrequency == '0monthly' ||
                              combinedFrequency == '0quaterly' ||
                              combinedFrequency == '0annually') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text('Validation Error'),
                                  content: Text(
                                      'Please ensure all fields are filled and none of the values are zero.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: null,
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }

                          final SubscriberResult result = await ref
                              .read(subscribersProvider.notifier)
                              .addSubscriber(
                                selection.subName.text,
                                selection.annualP.text,
                                selection.quaterlyP.text,
                                combinedFrequency,
                                ref,
                              );
                          if (result.statusCode == 201) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Icon(Icons.check_circle,
                                            size: 50, color: Color(0XFF6418C3)),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Subscription has been successfully added as a user.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Login details have been mailed to the user.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Consumer(
                                            builder: (context, ref, child) {
                                          final addUser = ref.watch(
                                              selectionModelProvider.notifier);
                                          return CustomElevatedButton(
                                            text: "OK",
                                            borderRadius: 20,
                                            width: 100,
                                            foreGroundColor: Colors.white,
                                            backGroundColor:
                                                const Color(0XFF6418C3),
                                            onPressed: () {
                                              addUser.toggleAddUser(false);
                                              Navigator.of(context)
                                                  .pushNamed("dashboard");
                                            },
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (result.statusCode == 400) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Login Error'),
                                  content: Text(result.errorMessage ??
                                      'An unknown error occurred.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
