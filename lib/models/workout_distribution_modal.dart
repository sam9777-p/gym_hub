import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../colors.dart';
import '../utils/csv_parser.dart';

class WorkoutDistributionModal extends StatefulWidget {
  final VoidCallback onClose;

  const WorkoutDistributionModal({super.key, required this.onClose});

  @override
  State<WorkoutDistributionModal> createState() => _WorkoutDistributionModalState();
}

class _WorkoutDistributionModalState extends State<WorkoutDistributionModal> {
  String selectedWorkoutType = '';
  bool showWorkoutDetailsModal = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '📊 Workout Distribution',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onClose,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: PieChart(
                            PieChartData(
                              sections: CsvParser.getWorkoutDistribution().map((data) {
                                return PieChartSectionData(
                                  value: data.count.toDouble(),
                                  color: data.color,
                                  title: '${data.count}',
                                  radius: 60,
                                  titleStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              }).toList(),
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                              pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  if (event is FlTapUpEvent && pieTouchResponse?.touchedSection != null) {
                                    final index = pieTouchResponse!.touchedSection!.touchedSectionIndex;
                                    setState(() {
                                      selectedWorkoutType = CsvParser.getWorkoutDistribution()[index].type;
                                      showWorkoutDetailsModal = true;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: CsvParser.getWorkoutDistribution().map((data) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: data.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${data.icon} ${data.type}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showWorkoutDetailsModal)
          _buildWorkoutDetailsModal(),
      ],
    );
  }

  Widget _buildWorkoutDetailsModal() {
    final workoutData = CsvParser.getWorkoutDistribution().firstWhere(
          (w) => w.type == selectedWorkoutType,
      orElse: () => CsvParser.getWorkoutDistribution().first,
    );

    final relatedWorkouts = CsvParser.getWorkoutHistory()
        .where((w) => w.type.toLowerCase().contains(selectedWorkoutType.toLowerCase()))
        .toList();

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${workoutData.icon} $selectedWorkoutType Details',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => showWorkoutDetailsModal = false),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Total Sessions: ${workoutData.count}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recent Sessions:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...relatedWorkouts.take(3).map((workout) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.type,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            workout.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${workout.duration} min',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepViolet,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}