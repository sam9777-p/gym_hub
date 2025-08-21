import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../colors.dart';
import '../utils/csv_parser.dart';

class TrainerRevenueModal extends StatelessWidget {
  final VoidCallback onClose;

  const TrainerRevenueModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness to determine if it's dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '📈 Revenue Analytics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: textColor,
                      ),
                    ),
                    IconButton(
                      onPressed: onClose,
                      icon: Icon(Icons.close, color: textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Revenue Breakdown',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 150,
                            child: PieChart(
                              PieChartData(
                                sections: CsvParser.getTrainerRevenueBreakdown().map((item) =>
                                    PieChartSectionData(
                                      value: item.percentage.toDouble(),
                                      color: CsvParser.getColorFromHex(item.color),
                                      radius: 60,
                                      title: '${item.percentage}%',
                                      titleStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                ).toList(),
                                centerSpaceRadius: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...CsvParser.getTrainerRevenueBreakdown().map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: CsvParser.getColorFromHex(item.color),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      item.category,
                                      style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: textColor),
                                    ),
                                  ],
                                ),
                                Text(
                                  '₹${(item.amount / 1000).toStringAsFixed(1)}k',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Column(
                  children: [
                    Text(
                      'Monthly Earnings Trend',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 10000,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final earnings = CsvParser.getTrainerMonthlyEarnings();
                                  if (value.toInt() < earnings.length) {
                                    return Text(
                                      earnings[value.toInt()]['month'],
                                      style: TextStyle(fontSize: 10, fontFamily: 'Inter', color: textColor),
                                    );
                                  }
                                  return Text('', style: TextStyle(color: textColor));
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: CsvParser.getTrainerMonthlyEarnings()
                              .asMap()
                              .entries
                              .map((e) => BarChartGroupData(
                            x: e.key,
                            barRods: [
                              BarChartRodData(
                                toY: e.value['earnings'].toDouble(),
                                color: AppColors.mediumVioletRed,
                                width: 20,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                              ),
                            ],
                          ))
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '₹8.2k',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.deepViolet,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              'This Month',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              '+20%',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              'Growth',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
