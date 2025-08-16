// lib/services/dashboard_data_service.dart
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import '../models/data_models.dart';
import '../data/colors.dart';

class DashboardDataService {
  static List<List<dynamic>>? _csvData;

  static Future<void> loadData() async {
    if (_csvData == null) {
      const String csvString = """
user_id,user_type,name,status,plan,monthly_fee,last_visit,total_visits,trainer_id,specialization,rating,experience,monthly_revenue,daily_classes,total_clients,success_rate,session_id,class_name,time,type,duration,participants,location,description,goal_name,goal_icon,current_value,target_value,progress,gym_rank,district_rank,state_rank,workout_date,workout_type,workout_icon,calories,exercises,revenue_category,revenue_amount,revenue_percentage,revenue_color,feedback_trainer_name,feedback_comment,feedback_rating,feedback_workout_type,feedback_date
1,owner,Alex Ray,active,Premium,2500,2024-12-08,45,1,Strength & Conditioning,4.9,5 years,8200,6,28,92,1,Morning Strength,6:00 AM - 7:00 AM,Group Class,60,12,Main Floor,Full body strength training with compound movements,Weight Loss Goal,⚖️,8,15,53,12,45,180,2024-12-08,Strength,💪,420,Deadlift|Bench Press|Rows,Memberships,35000,60,#360167,Sarah Wilson,Excellent form corrections and motivating coaching!,5,Strength Training,Dec 7, 2024
2,owner,Alex Ray,active,Basic,1500,2024-12-07,32,1,Strength & Conditioning,4.9,5 years,8200,6,28,92,2,Personal Training - Alex,8:00 AM - 9:00 AM,Personal Training,60,1,Private Room 1,Weight loss focused training with cardio intervals,Strength Training,💪,25,50,50,8,32,156,2024-12-07,Cardio,🏃,380,Treadmill|Cycling|Burpees,Personal Training,15000,26,#CF268A,Mike Rodriguez,Great cardio session, pushed me to my limits safely.,4,Cardio,Dec 5, 2024
3,owner,Alex Ray,expired,Premium,2500,2024-11-28,78,2,Cardio & Weight Loss,4.7,3 years,6500,5,22,88,3,HIIT Bootcamp,10:00 AM - 11:00 AM,Group Class,60,15,Studio A,High intensity interval training for all fitness levels,Cardio Endurance,🏃,18,30,60,15,67,234,2024-11-28,Legs,🦵,450,Squats|Leg Press|Calf Raises,Classes,5000,9,#E65C9C,Lisa Chen,Very relaxing and helped improve my flexibility.,5,Yoga,Dec 3, 2024
4,owner,Alex Ray,retained,Premium,2500,2024-12-08,156,2,Cardio & Weight Loss,4.7,3 years,6500,5,22,88,4,Personal Training - Maria,2:00 PM - 3:00 PM,Personal Training,60,1,Private Room 2,Strength building and muscle toning program,Weight Loss,⚖️,8,15,53,12,45,180,2024-12-06,Flexibility,🧘,180,Yoga|Stretching|Meditation,Supplements,3000,5,#FB8CAB,null,null,null,null,null
5,owner,Alex Ray,null,null,null,null,null,3,Yoga & Flexibility,4.8,4 years,5800,4,35,95,5,Evening Cardio,6:00 PM - 7:00 PM,Group Class,60,20,Main Floor,Mixed cardio workout with music and motivation,Muscle Gain,💪,3,8,38,8,32,156,2024-12-05,Upper Body,💪,350,Pull-ups|Lat Pulldown|Bicep Curls,null,null,null,null,null,null,null,null,null
6,owner,Alex Ray,null,null,null,null,null,4,CrossFit & HIIT,4.6,6 years,7200,5,25,90,null,null,null,null,null,null,null,null,Cardio Fitness,❤️,18,30,60,15,67,234,2024-12-04,HIIT,⚡,320,HIIT|Jump Rope|Mountain Climbers,null,null,null,null,null,null,null,null,null
7,member,John Smith,active,Premium,2500,2024-12-08,45,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Weight Loss Goal,⚖️,8,15,53,12,45,180,2024-12-08,Strength,💪,420,Deadlift|Bench Press|Rows,null,null,null,null,null,null,null,null,null
8,member,Sarah Johnson,expiring,Basic,1500,2024-12-07,32,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Strength Training,💪,25,50,50,8,32,156,2024-12-07,Cardio,🏃,380,Treadmill|Cycling|Burpees,null,null,null,null,null,null,null,null,null
9,member,Mike Wilson,expired,Premium,2500,2024-11-28,78,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Cardio Endurance,🏃,18,30,60,15,67,234,2024-11-28,Legs,🦵,450,Squats|Leg Press|Calf Raises,null,null,null,null,null,null,null,null,null
10,member,Emily Davis,retained,Premium,2500,2024-12-08,156,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Weight Loss,⚖️,8,15,53,12,45,180,2024-12-06,Flexibility,🧘,180,Yoga|Stretching|Meditation,null,null,null,null,null,null,null,null,null
11,member,Alex Johnson,active,Personal Training,4000,2024-12-08,24,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Muscle Gain,💪,3,8,38,8,32,156,2024-12-05,Upper Body,💪,350,Pull-ups|Lat Pulldown|Bicep Curls,null,null,null,null,null,null,null,null,null
12,member,Maria Garcia,expiring,Group Training,2000,2024-12-07,18,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Cardio Fitness,❤️,18,30,60,15,67,234,2024-12-04,HIIT,⚡,320,HIIT|Jump Rope|Mountain Climbers,null,null,null,null,null,null,null,null,null
13,member,James Brown,expired,Personal Training,4000,2024-11-28,45,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
14,member,Jennifer Lee,retained,Premium Training,5000,2024-12-08,67,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
15,trainer,Sarah Wilson,null,null,null,null,null,null,Strength & Conditioning,4.9,5 years,8200,6,28,92,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Personal Training,5000,61,#360167,Sarah Wilson,Excellent form corrections and motivating coaching!,5,Strength Training,Dec 7, 2024
16,trainer,Mike Rodriguez,null,null,null,null,null,null,Cardio & Weight Loss,4.7,3 years,6500,5,22,88,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Group Classes,2000,24,#CF268A,Mike Rodriguez,Great cardio session, pushed me to my limits safely.,4,Cardio,Dec 5, 2024
17,trainer,Lisa Chen,null,null,null,null,null,null,Yoga & Flexibility,4.8,4 years,5800,4,35,95,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Nutrition Coaching,800,10,#E65C9C,Lisa Chen,Very relaxing and helped improve my flexibility.,5,Yoga,Dec 3, 2024
18,trainer,David Thompson,null,null,null,null,null,null,CrossFit & HIIT,4.6,6 years,7200,5,25,90,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Online Sessions,400,5,#FB8CAB,null,null,null,null,null
19,member,John Doe,active,Personal Training,4000,2024-12-08,24,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
20,member,Jane Smith,expiring,Group Training,2000,2024-12-07,18,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
21,member,Mark Johnson,expired,Personal Training,4000,2024-11-28,45,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
22,member,Emily Brown,retained,Premium Training,5000,2024-12-08,67,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
23,member,Alex Johnson,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Weight Loss Goal,⚖️,8,15,53,12,45,180,null,null,null,null,null,null,null,null,null,null,null,null,null,null
24,member,Alex Johnson,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Strength Training,💪,25,50,50,8,32,156,null,null,null,null,null,null,null,null,null,null,null,null,null,null
25,member,Alex Johnson,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Cardio Endurance,🏃,18,30,60,15,67,234,null,null,null,null,null,null,null,null,null,null,null,null,null,null
""";
      _csvData = const CsvToListConverter().convert(csvString, eol: '\n');
    }
  }

  static List<Member> getMembers() {
    return _csvData!
        .where((row) => row[1] == 'member' && row.length > 7 && row[3].toString().isNotEmpty)
        .map((row) => Member(
      id: int.tryParse(row[0].toString()) ?? 0,
      name: row[2].toString(),
      status: row[3].toString(),
      joinDate: 'N/A', // Data not available in current CSV, using placeholder
      plan: row[4].toString(),
      monthlyFee: int.tryParse(row[5].toString()) ?? 0,
      lastVisit: row[6].toString(),
      totalVisits: int.tryParse(row[7].toString()) ?? 0,
    ))
        .toList();
  }

  static List<Trainer> getTrainers() {
    return _csvData!
        .where((row) => row[1] == 'trainer' && row.length > 15 && row[2].toString().isNotEmpty)
        .map((row) => Trainer(
      id: int.tryParse(row[0].toString()) ?? 0,
      name: row[2].toString(),
      specialization: row[9].toString(),
      rating: double.tryParse(row[10].toString()) ?? 0.0,
      experience: row[11].toString(),
      monthlyRevenue: int.tryParse(row[12].toString()) ?? 0,
      dailyClasses: int.tryParse(row[13].toString()) ?? 0,
      totalClients: int.tryParse(row[14].toString()) ?? 0,
      successRate: int.tryParse(row[15].toString()) ?? 0,
    ))
        .toList();
  }

  static List<WorkoutHistory> getWorkoutHistory() {
    return _csvData!
        .where((row) => row.length > 37 && row[32].toString().isNotEmpty)
        .map((row) {
      final exercises = row[37].toString().split('|');
      return WorkoutHistory(
        date: row[32].toString(),
        type: row[33].toString(),
        icon: row[34].toString(),
        duration: int.tryParse(row[35].toString()) ?? 0,
        calories: int.tryParse(row[36].toString()) ?? 0,
        exercises: exercises,
      );
    }).toList();
  }

  static List<WorkoutDistribution> getWorkoutDistribution() {
    final workoutCounts = <String, int>{};
    final workoutIcons = <String, String>{};
    _csvData!
        .where((row) => row.length > 34 && row[33].toString().isNotEmpty)
        .forEach((row) {
      final type = row[33].toString();
      final icon = row[34].toString();
      workoutCounts[type] = (workoutCounts[type] ?? 0) + 1;
      workoutIcons[type] = icon;
    });

    final colors = [AppColors.deepViolet, AppColors.royalFuchsia, AppColors.raspberryPink, AppColors.flamingoPink];
    int colorIndex = 0;
    return workoutCounts.entries.map((entry) {
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      return WorkoutDistribution(
        type: entry.key,
        icon: workoutIcons[entry.key] ?? '',
        count: entry.value,
        color: color,
      );
    }).toList();
  }

  static List<MemberGoal> getMemberGoals() {
    return _csvData!
        .where((row) => row.length > 28 && row[24].toString().isNotEmpty)
        .map((row) => MemberGoal(
      name: row[24].toString(),
      icon: row[25].toString(),
      current: int.tryParse(row[26].toString()) ?? 0,
      target: int.tryParse(row[27].toString()) ?? 0,
      progress: int.tryParse(row[28].toString()) ?? 0,
    ))
        .toList();
  }

  static List<TodaysClass> getTodaysClasses() {
    return _csvData!
        .where((row) => row.length > 22 && row[17].toString().isNotEmpty)
        .map((row) => TodaysClass(
      name: row[17].toString(),
      icon: 'N/A', // Icon data is not in this specific row
      time: row[18].toString(),
      instructor: 'N/A',
      duration: int.tryParse(row[20].toString()) ?? 0,
      participants: int.tryParse(row[21].toString()) ?? 0,
      maxParticipants: int.tryParse(row[22].toString()) ?? 0,
    ))
        .toList();
  }

  static List<RecentFeedback> getRecentFeedback() {
    return _csvData!
        .where((row) => row.length > 46 && row[42].toString().isNotEmpty)
        .map((row) => RecentFeedback(
      trainerName: row[42].toString(),
      comment: row[43].toString(),
      rating: int.tryParse(row[44].toString()) ?? 0,
      workoutType: row[45].toString(),
      date: row[46].toString(),
    ))
        .toList();
  }

  static List<PersonalMilestone> getPersonalMilestones() {
    return _csvData!
        .where((row) => row.length > 31 && row[24].toString().isNotEmpty)
        .map((row) => PersonalMilestone(
      name: row[24].toString(),
      icon: row[25].toString(),
      current: int.tryParse(row[26].toString()) ?? 0,
      target: int.tryParse(row[27].toString()) ?? 0,
      progress: int.tryParse(row[28].toString()) ?? 0,
      gymRank: int.tryParse(row[29].toString()) ?? 0,
      districtRank: int.tryParse(row[30].toString()) ?? 0,
      stateRank: int.tryParse(row[31].toString()) ?? 0,
    ))
        .toList();
  }

  static List<RevenueBreakdown> getOwnerRevenueBreakdown() {
    return _csvData!
        .where((row) => row.length > 41 && row[38].toString().isNotEmpty && row[1] == 'owner')
        .map((row) => RevenueBreakdown(
      category: row[38].toString(),
      amount: int.tryParse(row[39].toString()) ?? 0,
      percentage: int.tryParse(row[40].toString()) ?? 0,
      color: row[41].toString(),
    ))
        .toList();
  }

  static List<MonthlyRevenue> getOwnerMonthlyRevenue() {
    // This is hardcoded as the provided CSV does not contain a full 6-month trend.
    return [
      MonthlyRevenue(month: 'Jan', total: 45000),
      MonthlyRevenue(month: 'Feb', total: 48000),
      MonthlyRevenue(month: 'Mar', total: 52000),
      MonthlyRevenue(month: 'Apr', total: 55000),
      MonthlyRevenue(month: 'May', total: 58000),
      MonthlyRevenue(month: 'Jun', total: 58000),
    ];
  }

  static List<TrainerClient> getTrainerClients() {
    // This is a simplified version, as the CSV has trainers and members in separate rows.
    // In a real application, a more complex join would be needed.
    return _csvData!
        .where((row) => row.length > 7 && row[1] == 'member' && row[3].toString().isNotEmpty)
        .map((row) => TrainerClient(
      id: int.tryParse(row[0].toString()) ?? 0,
      name: row[2].toString(),
      status: row[3].toString(),
      joinDate: 'N/A', // Placeholder
      plan: row[4].toString(),
      monthlyFee: int.tryParse(row[5].toString()) ?? 0,
      lastSession: row[6].toString(),
      totalSessions: int.tryParse(row[7].toString()) ?? 0,
    ))
        .toList();
  }

  static List<RevenueBreakdown> getTrainerRevenueBreakdown() {
    return _csvData!
        .where((row) => row.length > 41 && row[38].toString().isNotEmpty && row[1] == 'trainer')
        .map((row) => RevenueBreakdown(
      category: row[38].toString(),
      amount: int.tryParse(row[39].toString()) ?? 0,
      percentage: int.tryParse(row[40].toString()) ?? 0,
      color: row[41].toString(),
    ))
        .toList();
  }

  static List<MonthlyRevenue> getTrainerMonthlyRevenueData() {
    // Hardcoded as the provided CSV lacks sufficient data to generate this trend dynamically.
    return [
      MonthlyRevenue(month: 'Jan', total: 6800),
      MonthlyRevenue(month: 'Feb', total: 7200),
      MonthlyRevenue(month: 'Mar', total: 7800),
      MonthlyRevenue(month: 'Apr', total: 8000),
      MonthlyRevenue(month: 'May', total: 8200),
      MonthlyRevenue(month: 'Jun', total: 8200),
    ];
  }

  static List<TrainerSchedule> getTrainerDetailedSchedule() {
    return _csvData!
        .where((row) => row.length > 23 && row[17].toString().isNotEmpty)
        .map((row) => TrainerSchedule(
      id: int.tryParse(row[16].toString()) ?? 0,
      className: row[17].toString(),
      time: row[18].toString(),
      type: row[19].toString(),
      duration: int.tryParse(row[20].toString()) ?? 0,
      participants: int.tryParse(row[21].toString()) ?? 0,
      location: row[22].toString(),
      description: row[23].toString(),
    ))
        .toList();
  }

  static List<OwnerObjective> getOwnerObjectives() {
    // This data is not available in a single CSV row in a parsable format, so it is hardcoded to maintain functionality.
    return [
      OwnerObjective(name: 'Monthly Revenue Target', icon: '💰', current: 58, target: 75, progress: 77),
      OwnerObjective(name: 'Member Retention', icon: '👥', current: 92, target: 95, progress: 92),
      OwnerObjective(name: 'Equipment Upgrades', icon: '🏋️', current: 5, target: 5, progress: 100),
      OwnerObjective(name: 'Staff Training', icon: '🎓', current: 6, target: 8, progress: 75),
    ];
  }
}