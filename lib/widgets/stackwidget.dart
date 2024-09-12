import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StackWidget extends StatelessWidget {
  final String? hintText;
  final IconData? arrow;
  final String text;
  final VoidCallback? onTap;
  final VoidCallback? tabarrow;
  const StackWidget(
      {super.key,
      required this.hintText,
      this.arrow,
      required this.text,
      this.onTap,
      this.tabarrow});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, ref, child) {
      final _selectedIndex = ref.watch(pageIndexProvider);
      return Stack(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.25,
                width: screenWidth,
                color: Color(0xFFf5f5f5),
              ),
            ],
          ),
          Positioned(
            child: Stack(
              children: [
                Container(
                  height: screenHeight * 0.22,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 20,
                    child: Row(
                      children: [
                        Consumer(builder: (context, ref, child) {
                          return IconButton(
                              onPressed: tabarrow,
                              icon: Icon(
                                arrow,
                                color: Colors.white,
                              ));
                        }),
                        Text(
                          text,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    )),
                // The search icon
                Positioned(
                    top: 50,
                    right: 20,
                    child: InkWell(
                      onTap: onTap,
                      child: _selectedIndex == 2
                          ? Icon(
                              Icons.add_circle_outline_rounded,
                              size: 50,
                              color: Colors.white,
                            )
                          : Stack(
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.verified_user,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                              ],
                            ),
                    )),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0), // Add horizontal padding if needed
              child: SizedBox(
                width: screenWidth * 0.85,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: hintText,
                    prefixIcon: Icon(Icons.search, color: Color(0xff6418c3)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
