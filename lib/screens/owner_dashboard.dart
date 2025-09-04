import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../colors.dart';
import '../utils/csv_parser.dart';
import '../widgets/custom_widgets.dart';
import '../models/revenue_modal.dart';
import '../models/members_modal.dart';
import '../models/trainers_modal.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  // State variables for controlling the visibility of different management modals.
  bool showRevenueModal = false;
  bool showMembersModal = false;
  bool showTrainersModal = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header Card
              GradientCard(
                gradient: AppColors.ownerGradient,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.business,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '🏢 FitZone Owner',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Management Dashboard',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    // opacity: 0.9,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 20,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => showRevenueModal = true),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '₹58k',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Revenue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      // opacity: 0.9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => showMembersModal = true),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '168',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Members',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      // opacity: 0.9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => showTrainersModal = true),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '4',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Trainers',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      // opacity: 0.9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16 ),
              // A card dedicated to tracking and visualizing the gym's main business objectives.
              // Business Objectives

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.track_changes, color: AppColors.royalFuchsia),
                          SizedBox(width: 8),
                          Text(
                            '🎯 Business Objectives',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...CsvParser.getOwnerObjectives().map((objective) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(objective.icon, style: const TextStyle(fontSize: 18)),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          objective.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${objective.current} / ${objective.target}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      objective.progress == 100
                                          ? Icons.check_circle
                                          : Icons.play_circle,
                                      color: objective.progress == 100
                                          ? Colors.green
                                          : AppColors.mediumVioletRed,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${objective.progress}%',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deepViolet,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ProgressBar(value: objective.progress),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.pie_chart, color: AppColors.mediumVioletRed, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  '👥 Memberships',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 96,
                              child: PieChart(
                                PieChartData(
                                  sections: CsvParser.getMembershipDistribution().map((item) =>
                                      PieChartSectionData(
                                        value: item.value.toDouble(),
                                        color: item.color,
                                        radius: 30,
                                        showTitle: false,
                                      ),
                                  ).toList(),
                                  centerSpaceRadius: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...CsvParser.getMembershipDistribution().map((item) =>
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: item.color,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            item.name,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${item.value}%',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
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
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.business, color: AppColors.patriarch, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  '🏢 Facility',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              '72%',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.deepViolet,
                              ),
                            ),
                            Text(
                              'Current Usage',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Peak (6PM):',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const Text(
                                      '92%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Off-Peak (9PM):',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const Text(
                                      '34%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                ],
              ),
              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.trending_up, color: AppColors.positive),
                          SizedBox(width: 8),
                          Text(
                            '💵 Revenue Trend',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹58k',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.deepViolet,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Text(
                                'This Month',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '+15%',
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
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 80,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const months = ['Mar', 'Apr', 'May', 'Jun'];
                                    if (value.toInt() < months.length) {
                                      return Text(
                                        months[value.toInt()],
                                        style: const TextStyle(fontSize: 10, fontFamily: 'Inter'),
                                      );
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: const [
                                  FlSpot(0, 52),
                                  FlSpot(1, 55),
                                  FlSpot(2, 58),
                                  FlSpot(3, 58),
                                ],
                                isCurved: true,
                                color: AppColors.royalFuchsia,
                                barWidth: 3,
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: AppColors.royalFuchsia.withOpacity(0.1),
                                ),
                                dotData: const FlDotData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.warning, color: AppColors.alert),
                          SizedBox(width: 8),
                          Text(
                            '⚠️ Smart Alerts',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: const Border(left: BorderSide(color: AppColors.alert, width: 4)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.warning, color: AppColors.alert, size: 16),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '5 Members at Risk',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Inactive 15+ days',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.alert,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                minimumSize: Size.zero,
                              ),
                              child: const Text(
                                'Action',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: const Border(left: BorderSide(color: AppColors.positive, width: 4)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.trending_up, color: AppColors.positive, size: 16),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Engagement: 78%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Above average this month',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80), // Bottom padding
            ],
          ),
        ),
        // Modals
        if (showRevenueModal)
          RevenueModal(onClose: () => setState(() => showRevenueModal = false)),
        if (showMembersModal)
          MembersModal(onClose: () => setState(() => showMembersModal = false)),
        if (showTrainersModal)
          TrainersModal(onClose: () => setState(() => showTrainersModal = false)),
      ],
    );
  }
}
