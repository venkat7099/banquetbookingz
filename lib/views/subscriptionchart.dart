import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MySubscriptionRatioChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0, // No space between sections
        centerSpaceRadius: 70, // The radius of the center hole
        startDegreeOffset: -90, // Adjust the start angle of the chart
        sections: [
          PieChartSectionData(
            color: const Color(0xFF6418c3),
            value: 25, // Pro - 54%
            title: '',
            radius: 50, // Adjust the size of each section
            titleStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          ),
          PieChartSectionData(
            color: Color(0xff5dcfff),
            value: 25, // Expert - 20%
            title: '',
            radius: 50,
            titleStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          ),
          PieChartSectionData(
            color: Color(0xffe328af),
            value: 25, // Basic - 14%
            title: '',
            radius: 50,
            titleStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          ),
          PieChartSectionData(
            color: const Color(0xFFc4c4c4),
            value: 25, // Pro Plus - 10%
            title: '',
            radius: 50,
            titleStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          ),
        ],
      ),
    );
  }
}
