// lib/models/trends_modal.dart
import 'package:flutter/material.dart';
import '../data/colors.dart';
import '../widgets/custom_widgets.dart';
import '../services/dashboard_data_service.dart';

class TrendsModal extends StatelessWidget {
  final VoidCallback onClose;

  const TrendsModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final personalMilestones = DashboardDataService.getPersonalMilestones(); // This method would need to be created in the new service

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxHeight: 600),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ... Header ...
              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.emoji_events, color: Colors.amber),
                          SizedBox(width: 8),
                          Text(
                            '🏆 Personal Milestones',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...personalMilestones.map((milestone) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(milestone.icon, style: const TextStyle(fontSize: 18)),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          milestone.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${milestone.current} / ${milestone.target}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  '${milestone.progress}%',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.deepViolet,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ProgressBar(value: milestone.progress),
                            const SizedBox(height: 8),
                            // Rankings
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.neutral,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Gym Rank',
                                          style: TextStyle(fontSize: 10, color: Colors.grey),
                                        ),
                                        Text(
                                          '#${milestone.gymRank}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.deepViolet,
                                          ),
                                        ),
                                        Text(
                                          milestone.gymRank <= 10 ? 'Top 10%' : 'Top 25%',
                                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.neutral,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'District',
                                          style: TextStyle(fontSize: 10, color: Colors.grey),
                                        ),
                                        Text(
                                          '#${milestone.districtRank}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.mediumVioletRed,
                                          ),
                                        ),
                                        Text(
                                          milestone.districtRank <= 50 ? 'Top 15%' : 'Top 30%',
                                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.neutral,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'State',
                                          style: TextStyle(fontSize: 10, color: Colors.grey),
                                        ),
                                        Text(
                                          '#${milestone.stateRank}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.royalFuchsia,
                                          ),
                                        ),
                                        Text(
                                          milestone.stateRank <= 200 ? 'Top 20%' : 'Top 40%',
                                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
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