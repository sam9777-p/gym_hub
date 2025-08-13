// lib/screens/owner_dashboard.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/colors.dart';
import '../models/members_modal.dart';
import '../models/revenue_modal.dart';
import '../models/trainer_modal.dart';
import '../widgets/custom_widgets.dart';
import '../providers/dashboard_provider.dart';
import '../services/dashboard_data_service.dart';
import '../models/data_models.dart';

// Note: The 'DonutChartPainter' class is included at the end of this file.

class OwnerDashboard extends ConsumerStatefulWidget {
  const OwnerDashboard({super.key});

  @override
  ConsumerState<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends ConsumerState<OwnerDashboard> {
  bool showRevenueModal = false;
  bool showMembersModal = false;
  bool showTrainersModal = false;

  @override
  Widget build(BuildContext context) {
    final dataAsyncValue = ref.watch(dashboardProvider);

    return dataAsyncValue.when(
      data: (_) {
        final members = DashboardDataService.getMembers();
        final trainers = DashboardDataService.getTrainers();

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header Card
                  _buildHeaderCard(members, trainers),
                  const SizedBox(height: 16),
                  // Business Objectives
                  _buildBusinessObjectivesCard(),
                  const SizedBox(height: 16),
                  // -- START: NEW WIDGETS --
                  _buildMembershipAndFacilityRow(),
                  const SizedBox(height: 16),
                  _buildRevenueTrendCard(),
                  const SizedBox(height: 16),
                  _buildSmartAlertsCard(),
                  // -- END: NEW WIDGETS --
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
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  // --- WIDGET BUILDER METHODS --- //

  Widget _buildHeaderCard(List<Member> members, List<Trainer> trainers) {
    return GradientCard(
      gradient: AppColors.ownerGradient,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.shield_outlined, color: Colors.white, size: 40),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FitZone Owner',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Management Dashboard',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 28,
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
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
                onTap: () => setState(() => showRevenueModal = true),
                value: '₹58k',
                label: 'Revenue',
              ),
              const SizedBox(width: 12),
              _buildHeaderButton(
                onTap: () => setState(() => showMembersModal = true),
                value: members.length.toString(),
                label: 'Members',
              ),
              const SizedBox(width: 12),
              _buildHeaderButton(
                onTap: () => setState(() => showTrainersModal = true),
                value: trainers.length.toString(),
                label: 'Trainers',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({VoidCallback? onTap, required String value, required String label}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessObjectivesCard() {
    final objectives = DashboardDataService.getOwnerObjectives();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Business Objectives',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...objectives.map((obj) => _buildObjectiveRow(
              icon: obj.icon,
              title: obj.name,
              progressText: '${obj.current} / ${obj.target}',
              progressValue: obj.progress.toDouble(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildObjectiveRow({
    required String icon,
    required String title,
    required String progressText,
    required double progressValue,
  }) {
    final bool isComplete = progressValue == 100.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(progressText, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: progressValue / 100,
                  backgroundColor: Colors.grey[300],
                  color: isComplete ? Colors.green : AppColors.royalFuchsia,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          isComplete
              ? const Icon(Icons.check_circle, color: Colors.green, size: 28)
              : Text(
            '${progressValue.toInt()}%',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipAndFacilityRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildMembershipsCard()),
        const SizedBox(width: 16),
        Expanded(child: _buildFacilityCard()),
      ],
    );
  }

  Widget _buildMembershipsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Memberships', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: DonutChartPainter(
                  percentages: [78, 15, 7],
                  colors: [Colors.lightGreen, Colors.orange, Colors.red],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildLegend(color: Colors.lightGreen, text: 'Active', percentage: '78%'),
            const SizedBox(height: 4),
            _buildLegend(color: Colors.orange, text: 'Expiring', percentage: '15%'),
            const SizedBox(height: 4),
            _buildLegend(color: Colors.red, text: 'Expired', percentage: '7%'),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend({required Color color, required String text, required String percentage}) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12)),
        const Spacer(),
        Text(percentage, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildFacilityCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Facility', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Center(
              child: Text('72%', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.deepViolet)),
            ),
            const Center(child: Text('Current Usage', style: TextStyle(fontSize: 12, color: Colors.grey))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Peak (6PM):', style: TextStyle(fontSize: 12)),
                const Text('92%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Off-Peak (9PM):', style: TextStyle(fontSize: 12)),
                const Text('34%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueTrendCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Revenue Trend', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('₹58k', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    Text('This Month', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.green, size: 14),
                      Text('+15% Growth', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildBarChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final data = {'Apr': 0.6, 'May': 0.8, 'Jun': 1.0};
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.entries.map((entry) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 80 * entry.value,
                width: 30,
                decoration: BoxDecoration(
                  color: AppColors.royalFuchsia.withOpacity(0.3),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ),
              const SizedBox(height: 4),
              Text(entry.key, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSmartAlertsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                SizedBox(width: 8),
                Text('Smart Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red.withOpacity(0.2))
              ),
              child: Row(
                children: [
                  const Icon(Icons.person_off_outlined, color: Colors.red),
                  const SizedBox(width: 12),
                  const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('5 Members at Risk', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Inactive 15+ days', style: TextStyle(fontSize: 12, color: Colors.grey))
                        ],
                      )
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 20)
                    ),
                    child: const Text('Action'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.withOpacity(0.2))
              ),
              child: const Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.green),
                  SizedBox(width: 12),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Engagement: 78%', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Above average this month', style: TextStyle(fontSize: 12, color: Colors.grey))
                        ],
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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

    for (int i = 0; i < percentages.length; i++) {
      final sweepAngle = 2 * pi * (percentages[i] / 100);
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}