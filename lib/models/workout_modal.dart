import 'package:flutter/material.dart';
import '../colors.dart';
import '../utils/csv_parser.dart';

class WorkoutModal extends StatelessWidget {
  final VoidCallback onClose;

  const WorkoutModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxHeight: 600),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.fitness_center, color: AppColors.royalFuchsia),
                        SizedBox(width: 8),
                        Text(
                          '🏋️ Workout History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: CsvParser.getWorkoutHistory().map((workout) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.neutral,
                          borderRadius: BorderRadius.circular(12),
                          border: const Border(
                            left: BorderSide(color: AppColors.royalFuchsia, width: 4),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppColors.mediumVioletRed, AppColors.flamingoPink],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  workout.icon,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Date and Type
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        workout.date,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.deepViolet,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          workout.type,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Exercises
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                        fontFamily: "Inter"
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Exercises: ',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Inter"),
                                        ),
                                        TextSpan(
                                          text: workout.exercises.join(', '),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Duration and Calories
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 12,
                                              color: Colors.grey[500],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${workout.duration} min',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              size: 12,
                                              color: Colors.orange[500],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${workout.calories} cal',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
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
                    )).toList(),
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
