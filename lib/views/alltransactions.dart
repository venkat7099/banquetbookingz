import 'package:banquetbookingz/providers/filtersprovider.dart';
import 'package:banquetbookingz/widgets/recenttransactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllTransactions extends StatelessWidget {
  const AllTransactions({super.key});
  void _showFiltersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Action to clear all selections
                    },
                    child: const Text(
                      'Clear all',
                      style: TextStyle(
                        color: Colors.purple, // Your theme color here
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              Consumer(builder: (context, ref, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterSection(
                        'Subscription Type',
                        ref
                                .watch(filterOptionsProvider)
                                .options['Subscription Type'] ??
                            []),
                    _buildFilterSection(
                        'Billing Type',
                        ref
                                .watch(filterOptionsProvider)
                                .options['Billing Type'] ??
                            []),
                    _buildFilterSection(
                        'Payment Type',
                        ref
                                .watch(filterOptionsProvider)
                                .options['Payment Type'] ??
                            []),
                  ],
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6418c3), // Your theme color here
                  minimumSize: const Size(double.infinity,
                      36), // double.infinity is the width and 36 is the height
                ),
                onPressed: () {
                  // Save filter selections
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("dashboard");
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff6418c3),
          ),
        ),
        title: const Text(
          "All Transactions",
          style: TextStyle(color: Color(0xff6418c3)),
        ),
        backgroundColor: const Color(0xfff5f5f5),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: const Color(0xfff5f5f5),
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.85,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "search",
                    prefixIcon: const Icon(Icons.search, color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "All Transactions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Define the action when the button is pressed
                              _showFiltersBottomSheet(context);
                            },
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors
                                  .black, // Use the theme's accent color or any other color
                            ),
                            label: const Text(
                              'Filters',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("alltransactions");
                        },
                        child: const RecentTransactions(
                          text1: "Paid for Pro",
                          text2: "28 feb, 2024 at 6:00am",
                          text3: "SFHB46Hc566",
                          text4: "₹86,968",
                        ),
                      )
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

Widget _buildFilterSection(String title, List<String> options) {
  return Consumer(builder: (context, ref, child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 8.0,
            children: options
                .map((option) => Chip(
                      backgroundColor: const Color(0xffe5d0ff),
                      label: Text(option),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        // Handle delete (removal) of the filter option
                        ref
                            .read(filterOptionsProvider.notifier)
                            .removeOption(title, option);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  });
}
