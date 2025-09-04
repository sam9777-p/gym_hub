import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../colors.dart';
import '../utils/csv_parser.dart';
import '../widgets/custom_widgets.dart';
import '../models/trends_modal.dart';
import '../models/workout_modal.dart';
import '../models/workout_distribution_modal.dart';
import '../models/attendance_modal.dart';

class MemberDashboard extends StatefulWidget {
  const MemberDashboard({super.key});

  @override
  State<MemberDashboard> createState() => _MemberDashboardState();
}

class _MemberDashboardState extends State<MemberDashboard> {
  // State variables to control the visibility of different modal pop-ups.
  bool showTrendsModal = false;
  bool showWorkoutModal = false;
  bool showWorkoutDistributionModal = false;
  bool showAttendanceModal = false;

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness to determine if it's dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header Card
              GradientCard(
                gradient: AppColors.primaryGradient,
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
                                Icons.fitness_center,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '💪 Alex Johnson',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Premium Member',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '15',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Days Left',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
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
                            onTap: () => setState(() => showWorkoutDistributionModal = true),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Workouts',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
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
                            onTap: () => setState(() => showTrendsModal = true),
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
                                    'Trends',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
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
                            onTap: () => setState(() => showAttendanceModal = true),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '85%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Attendance',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
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

              // Workout Heatmap
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.calendar_view_week, color: AppColors.mediumVioletRed),
                          SizedBox(width: 8),
                          Text(
                            '🔥 Workout Heatmap',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                            .map((day) => Text(
                          day,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: CsvParser.getWorkoutHeatmap().map((week) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: week.map((intensity) {
                                Color color;
                                switch (intensity) {
                                  case 0:
                                    color = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;
                                    break;
                                  case 1:
                                    color = AppColors.flamingoPink.withOpacity(0.6);
                                    break;
                                  case 2:
                                    color = AppColors.royalFuchsia;
                                    break;
                                  default:
                                    color = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;
                                }
                                return Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Less',
                            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 4),
                          Container(width: 12, height: 12, decoration: BoxDecoration(color: isDarkMode ? Colors.grey[800] : Colors.grey[200], borderRadius: BorderRadius.circular(2))),
                          const SizedBox(width: 2),
                          Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.flamingoPink.withOpacity(0.6), borderRadius: BorderRadius.circular(2))),
                          const SizedBox(width: 2),
                          Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.royalFuchsia, borderRadius: BorderRadius.circular(2))),
                          const SizedBox(width: 4),
                          Text(
                            'More',
                            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Today's Classes
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.schedule, color: AppColors.deepViolet),
                          SizedBox(width: 8),
                          Text(
                            '📅 Today\'s Classes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...CsvParser.getTodaysClasses().map((classItem) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Theme.of(context).cardColor : AppColors.neutral,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(classItem.icon, style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      classItem.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${classItem.time} • ${classItem.instructor}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${classItem.participants}/${classItem.maxParticipants}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.deepViolet,
                                    ),
                                  ),
                                  Text(
                                    '${classItem.duration} min',
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
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Goals & Progress
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
                            '🎯 Goals & Progress',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...CsvParser.getMemberGoals().map((goal) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(goal.icon, style: const TextStyle(fontSize: 18)),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          goal.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${goal.current} / ${goal.target}',
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
                                  '${goal.progress}%',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.deepViolet,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ProgressBar(value: goal.progress),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Workouts Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.fitness_center, color: AppColors.mediumVioletRed),
                              SizedBox(width: 8),
                              Text(
                                '🏋️ Recent Workouts',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => setState(() => showWorkoutModal = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.royalFuchsia,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...CsvParser.getWorkoutHistory().take(2).map((workout) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Theme.of(context).cardColor : AppColors.neutral,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(workout.icon, style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workout.type,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
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
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${workout.duration} min',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.deepViolet,
                                    ),
                                  ),
                                  Text(
                                    '${workout.calories} cal',
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
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Recent Feedback
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.feedback, color: AppColors.positiveGreen),
                          SizedBox(width: 8),
                          Text(
                            '💬 Recent Feedback',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...CsvParser.getRecentFeedback().map((feedback) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Theme.of(context).cardColor : AppColors.neutral,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    feedback.trainerName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < feedback.rating ? Icons.star : Icons.star_border,
                                        size: 16,
                                        color: AppColors.warningYellow,
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                feedback.comment,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    feedback.workoutType,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.royalFuchsia,
                                    ),
                                  ),
                                  Text(
                                    feedback.date,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Recent Achievements
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.emoji_events, color: AppColors.positiveGreen),
                          SizedBox(width: 8),
                          Text(
                            '🏆 Recent Achievements',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.positiveGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.positiveGreen.withOpacity(0.3)),
                              ),
                              child: const Column(
                                children: [
                                  Text('🔥', style: TextStyle(fontSize: 24)),
                                  SizedBox(height: 4),
                                  Text(
                                    '7-Day Streak',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.royalFuchsia.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.royalFuchsia.withOpacity(0.3)),
                              ),
                              child: const Column(
                                children: [
                                  Text('💪', style: TextStyle(fontSize: 24)),
                                  SizedBox(height: 4),
                                  Text(
                                    'Strength Goal',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.mediumVioletRed.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.mediumVioletRed.withOpacity(0.3)),
                              ),
                              child: const Column(
                                children: [
                                  Text('⏱️', style: TextStyle(fontSize: 24)),
                                  SizedBox(height: 4),
                                  Text(
                                    'Time Record',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80), // Bottom padding for navigation
            ],
          ),
        ),

        // MODALS
        if (showTrendsModal) TrendsModal(onClose: () => setState(() => showTrendsModal = false)),
        if (showWorkoutModal) WorkoutModal(onClose: () => setState(() => showWorkoutModal = false)),
        if (showWorkoutDistributionModal) WorkoutDistributionModal(onClose: () => setState(() => showWorkoutDistributionModal = false)),
        if (showAttendanceModal) AttendanceModal(onClose: () => setState(() => showAttendanceModal = false)),
      ],
    );
  }
}