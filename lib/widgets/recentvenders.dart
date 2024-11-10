import 'package:flutter/material.dart';
class VendersWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  const VendersWidget({super.key,
  required this.text1,required this.text2,required this.text3});

  @override
  Widget build(BuildContext context) {
    return Column(
                                            children: [
                                              Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 60.0, // Adjust the size accordingly
                                                    height: 60.0, // Adjust the size accordingly
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[400], // Placeholder color
                                                      borderRadius: BorderRadius.circular(12), // Rounded corners for the icon placeholder
                                                    ),
                                                    child: const Icon(
                                                      Icons.image, // Placeholder icon
                                                      size: 30.0, // Icon size
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16.0), // Spacing between the icon and the text
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          text1,
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold, // Bold text for the title
                                                            fontSize: 16.0, // Adjust the font size accordingly
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8.0), // Spacing between title and subtitle
                                                        Text(
                                                          text2,
                                                          style: const TextStyle(
                                                            color: Color(0xffb4b4b4),
                                                            fontSize: 14.0, // Adjust the font size accordingly
                                                          ),
                                                        ),
                                                        Text(
                                                          text3,
                                                          style: const TextStyle(
                                                            color: Color(0xffb4b4b4), // Grey color for the date text
                                                            fontSize: 12.0, // Adjust the font size accordingly
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(thickness: 1,color: Color(0xffe5d0ff),)
                                            ],
                                          );
  }
}