import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../colors.dart';
import '../utils/csv_parser.dart';
import '../widgets/custom_widgets.dart';
import '../models/trainer_clients_modals.dart';
import '../models/trainer_revenue_modal.dart';
import '../models/trainer_schedule_modal.dart';

class TrainerDashboard extends StatefulWidget {
  const TrainerDashboard({super.key});

  @override
  State<TrainerDashboard> createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  bool showClientsModal = false;
  bool showRevenueModal = false;
  bool showScheduleModal = false;

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
                gradient: AppColors.trainerGradient,
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
                                Icons.people,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '👨‍🏫 Sarah Wilson',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.white, size: 12),
                                    SizedBox(width: 4),
                                    Text(
                                      '4.9 Rating',
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
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₹8.2k',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'This Month',
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => showClientsModal = true),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '28',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Clients',
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
                                    '📈',
                                    style: TextStyle(fontSize: 18),
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
                            onTap: () => setState(() => showScheduleModal = true),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '📅',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    'Schedule',
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
              const SizedBox(height: 16),

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
                            '📋 Tasks & Progress',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...CsvParser.getTrainerTasks().map((task) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(task.icon, style: const TextStyle(fontSize: 18)),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${task.current} / ${task.target}',
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
                                      task.status == 'completed'
                                          ? Icons.check_circle
                                          : Icons.play_circle,
                                      color: task.status == 'completed'
                                          ? Colors.green
                                          : AppColors.mediumVioletRed,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${task.progress}%',
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
                            ProgressBar(value: task.progress),
                          ],
                        ),
                      )),
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
                          Icon(Icons.schedule, color: AppColors.patriarch),
                          SizedBox(width: 8),
                          Text(
                            '⏰ Today\'s Schedule',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildScheduleItem('9:00 AM', 'John D.', 'Strength', 'completed'),
                              _buildScheduleItem('11:00 AM', 'Sarah M.', 'Cardio', 'in-progress'),
                              _buildScheduleItem('2:00 PM', 'Mike R.', 'HIIT', 'upcoming'),
                              _buildScheduleItem('4:00 PM', 'Lisa K.', 'Yoga', 'upcoming'),
                            ],
                          ),
                        ),
                      ),
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
                                  '🎯 Client Goals',
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
                                  sections: CsvParser.getClientGoalsDistribution().map((item) =>
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
                            ...CsvParser.getClientGoalsDistribution().take(2).map((item) =>
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
                                Icon(Icons.trending_up, color: AppColors.positive, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  '📊 Metrics',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Column(
                              children: [
                                const Icon(Icons.favorite, color: Colors.red, size: 20),
                                const SizedBox(height: 4),
                                const Text(
                                  '142',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.deepViolet,
                                  ),
                                ),
                                Text(
                                  'Avg BPM',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Column(
                              children: [
                                const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                                const SizedBox(height: 4),
                                const Text(
                                  '450',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.deepViolet,
                                  ),
                                ),
                                Text(
                                  'Avg Calories',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
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
                          Icon(Icons.people, color: AppColors.royalFuchsia),
                          SizedBox(width: 8),
                          Text(
                            '👥 Top Clients',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTopClient('John D.', 'Weight Loss', 75, 'J'),
                      const SizedBox(height: 12),
                      _buildTopClient('Sarah M.', 'Strength', 90, 'S'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80), // Bottom padding
            ],
          ),
        ),
        // Modals
        if (showClientsModal)
          TrainerClientsModal(onClose: () => setState(() => showClientsModal = false)),
        if (showRevenueModal)
          TrainerRevenueModal(onClose: () => setState(() => showRevenueModal = false)),
        if (showScheduleModal)
          TrainerScheduleModal(onClose: () => setState(() => showScheduleModal = false)),
      ],
    );
  }

  Widget _buildScheduleItem(String time, String client, String type, String status) {
    Color borderColor;
    Widget statusIcon;

    switch (status) {
      case 'completed':
        borderColor = AppColors.positive;
        statusIcon = const Icon(Icons.check_circle, color: Colors.green, size: 16);
        break;
      case 'in-progress':
        borderColor = AppColors.mediumVioletRed;
        statusIcon = Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: AppColors.mediumVioletRed,
            shape: BoxShape.circle,
          ),
        );
        break;
      default:
        borderColor = AppColors.patriarch;
        statusIcon = const Icon(Icons.schedule, color: Colors.grey, size: 16);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.neutral,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.schedule, color: AppColors.mediumVioletRed, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$client • $type',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          statusIcon,
        ],
      ),
    );
  }

  Widget _buildTopClient(String name, String goal, int progress, String avatar) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.mediumVioletRed,
            child: Text(
              avatar,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  goal,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                ProgressBar(value: progress, height: 4),
              ],
            ),
          ),
          Text(
            '$progress%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.deepViolet,
            ),
          ),
        ],
      ),
    );
  }
}
