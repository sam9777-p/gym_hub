import 'dart:math';
import 'package:flutter/material.dart';
import '../data/colors.dart';
import '../models/trainer_clients_modals.dart';
import '../models/trainer_revenue_modal.dart';
import '../models/trainer_schedule_modal.dart';
import '../widgets/custom_widgets.dart';

// Note: The 'DonutChartPainter' class is included at the end of this file.

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
                                  'Sarah Wilson',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      '4.9 Rating',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
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
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildHeaderButton(
                          onTap: () => setState(() => showClientsModal = true),
                          value: '28',
                          label: 'Clients',
                        ),
                        const SizedBox(width: 12),
                        _buildHeaderButton(
                          onTap: () => setState(() => showRevenueModal = true),
                          icon: Icons.bar_chart,
                          label: 'Revenue',
                        ),
                        const SizedBox(width: 12),
                        _buildHeaderButton(
                          onTap: () => setState(() => showScheduleModal = true),
                          icon: Icons.calendar_today,
                          label: 'Schedule',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // -- START: NEW WIDGETS --
              _buildTasksAndProgressCard(),
              const SizedBox(height: 16),
              _buildGoalsAndMetricsRow(),
              const SizedBox(height: 16),
              _buildTopClientsCard(),
              // -- END: NEW WIDGETS --
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

  // Helper for header buttons
  Widget _buildHeaderButton({VoidCallback? onTap, String? value, IconData? icon, required String label}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              if (value != null)
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else if (icon != null)
                Icon(icon, color: Colors.white, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tasks & Progress Card
  Widget _buildTasksAndProgressCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tasks & Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTaskRow(
              icon: Icons.assessment,
              color: Colors.blue,
              title: 'Client Assessments',
              progressText: '6/8',
              progressValue: 6 / 8,
            ),
            _buildTaskRow(
              icon: Icons.fitness_center,
              color: Colors.green,
              title: 'Workout Plans',
              progressText: '12/12',
              progressValue: 1.0,
            ),
            _buildTaskRow(
              icon: Icons.reviews,
              color: Colors.orange,
              title: 'Progress Reviews',
              progressText: '10/15',
              progressValue: 10 / 15,
            ),
            _buildTaskRow(
              icon: Icons.card_membership,
              color: Colors.purple,
              title: 'Certification Renewal',
              progressText: '1/1',
              progressValue: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  // Row for a single task
  Widget _buildTaskRow({
    required IconData icon,
    required Color color,
    required String title,
    required String progressText,
    required double progressValue,
  }) {
    final bool isComplete = progressValue == 1.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: Colors.grey[300],
                        color: color,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      progressText,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          isComplete
              ? const Icon(Icons.check_circle, color: Colors.green)
              : Text(
            '${(progressValue * 100).toInt()}%',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Row containing Client Goals and Metrics cards
  Widget _buildGoalsAndMetricsRow() {
    return Row(
      children: [
        Expanded(child: _buildClientGoalsCard()),
        const SizedBox(width: 16),
        Expanded(child: _buildMetricsCard()),
      ],
    );
  }

  // Client Goals Card with Donut Chart
  Widget _buildClientGoalsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Client Goals',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: DonutChartPainter(
                  percentages: [40, 35],
                  colors: [const Color(0xFF6A1B9A), const Color(0xFFEC407A)],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildLegend(color: const Color(0xFF6A1B9A), text: 'Weight Loss', percentage: '40%'),
            const SizedBox(height: 4),
            _buildLegend(color: const Color(0xFFEC407A), text: 'Strength', percentage: '35%'),
          ],
        ),
      ),
    );
  }

  // Metrics Card
  Widget _buildMetricsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Metrics',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildMetricItem(
              icon: Icons.favorite,
              color: Colors.red,
              value: '142',
              label: 'Avg BPM',
            ),
            const SizedBox(height: 28),
            _buildMetricItem(
              icon: Icons.local_fire_department,
              color: Colors.orange,
              value: '450',
              label: 'Avg Calories',
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // Helper for chart legend items
  Widget _buildLegend({required Color color, required String text, required String percentage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 10, height: 10, color: color),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        Text(percentage, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Helper for metric items
  Widget _buildMetricItem({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  // Top Clients Card
  Widget _buildTopClientsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Clients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildTopClientRow(
              initial: 'J',
              name: 'John D.',
              goal: 'Weight Loss',
              percentage: 75,
              color: Colors.purple.shade700,
            ),
            const SizedBox(height: 12),
            _buildTopClientRow(
              initial: 'S',
              name: 'Sarah M.',
              goal: 'Strength',
              percentage: 90,
              color: Colors.pink.shade400,
            ),
          ],
        ),
      ),
    );
  }

  // Row for a single top client
  Widget _buildTopClientRow({
    required String initial,
    required String name,
    required String goal,
    required int percentage,
    required Color color,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 20,
          child: Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(goal, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$percentage%', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: percentage / 100,
                color: color,
                backgroundColor: Colors.grey[300],
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom Painter for the Donut Chart
class DonutChartPainter extends CustomPainter {
  final List<double> percentages;
  final List<Color> colors;

  DonutChartPainter({required this.percentages, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final strokeWidth = radius * 0.45;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    double startAngle = -pi / 2;

    // Draw the background ring
    final backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, 0, 2 * pi, false, backgroundPaint);

    // Draw each segment
    for (int i = 0; i < percentages.length; i++) {
      final sweepAngle = 2 * pi * (percentages[i] / 100);
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt; // Use butt for seamless connection

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
