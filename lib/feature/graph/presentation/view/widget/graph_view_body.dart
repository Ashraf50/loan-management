import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:loan_management/core/constant/app_styles.dart';

import '../../../../../core/widget/custom_scaffold.dart';

class GraphViewBody extends StatelessWidget {
  const GraphViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Installment Payment Progress',
              style: AppStyles.textStyle18black,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                    horizontalInterval: 4000,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 4000,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      axisNameWidget: const Text(
                        'Amount (EGP)',
                        style: AppStyles.textStyle20,
                      ),
                      axisNameSize: 40,
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          final months = [
                            'Jan',
                            'Feb',
                            'Mar',
                            'Apr',
                            'May',
                            'Jun'
                          ];
                          return Text(
                            months[value.toInt() % months.length],
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                      axisNameWidget:
                          const Text('Months', style: AppStyles.textStyle20),
                      axisNameSize: 20,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 10000,
                  lineBarsData: [
                    // Paid Line
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 2000),
                        const FlSpot(1, 2000),
                        const FlSpot(2, 2000),
                        const FlSpot(3, 2000),
                        const FlSpot(4, 2000),
                      ],
                      isCurved: false,
                      color: Colors.blue,
                      barWidth: 4,
                      isStrokeCapRound: true,
                    ),
                    // Remaining Line
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 8000),
                        const FlSpot(1, 6000),
                        const FlSpot(2, 4000),
                        const FlSpot(3, 2000),
                        const FlSpot(4, 0),
                      ],
                      isCurved: true,
                      color: Colors.orange,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dashArray: [5, 5],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
