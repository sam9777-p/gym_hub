import 'dart:ui';

// Data model for a personal milestone, tracking a member's progress against a target.
class PersonalMilestone {
  final String name;
  final String icon;
  final int current;
  final int target;
  final int progress;
  final int gymRank;
  final int districtRank;
  final int stateRank;

  PersonalMilestone({
    required this.name,
    required this.icon,
    required this.current,
    required this.target,
    required this.progress,
    required this.gymRank,
    required this.districtRank,
    required this.stateRank,
  });
}

// Data model for a single workout session, including exercises, duration, and calories.
class WorkoutHistory {
  final String date;
  final String type;
  final String icon;
  final int duration;
  final int calories;
  final List<String> exercises;

  WorkoutHistory({
    required this.date,
    required this.type,
    required this.icon,
    required this.duration,
    required this.calories,
    required this.exercises,
  });
}

class MemberGoal {
  final String name;
  final String icon;
  final int current;
  final int target;
  final int progress;

  MemberGoal({
    required this.name,
    required this.icon,
    required this.current,
    required this.target,
    required this.progress,
  });
}

class RevenueBreakdown {
  final String category;
  final int amount;
  final int percentage;
  final String color;

  RevenueBreakdown({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
  });
}

class MonthlyRevenue {
  final String month;
  final int total;

  MonthlyRevenue({
    required this.month,
    required this.total,
  });
}

class AttendanceRecord {
  final String date;
  final String status; // e.g., 'Present', 'Absent'
  final String details; // e.g., 'Check-in Time', 'No Check-in'

  AttendanceRecord({
    required this.date,
    required this.status,
    required this.details,
  });
}

class Member {
  final int id;
  final String name;
  final String status;
  final String joinDate;
  final String plan;
  final int monthlyFee;
  final String lastVisit;
  final int totalVisits;

  Member({
    required this.id,
    required this.name,
    required this.status,
    required this.joinDate,
    required this.plan,
    required this.monthlyFee,
    required this.lastVisit,
    required this.totalVisits,
  });
}

class Trainer {
  final int id;
  final String name;
  final String specialization;
  final double rating;
  final String experience;
  final int monthlyRevenue;
  final int dailyClasses;
  final int totalClients;
  final int successRate;

  Trainer({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
    required this.monthlyRevenue,
    required this.dailyClasses,
    required this.totalClients,
    required this.successRate,
  });
}

class TrainerClient {
  final int id;
  final String name;
  final String status;
  final String joinDate;
  final String plan;
  final int monthlyFee;
  final String lastSession;
  final int totalSessions;

  TrainerClient({
    required this.id,
    required this.name,
    required this.status,
    required this.joinDate,
    required this.plan,
    required this.monthlyFee,
    required this.lastSession,
    required this.totalSessions,
  });
}

class TrainerSchedule {
  final int id;
  final String className;
  final String time;
  final String type;
  final int duration;
  final int participants;
  final String location;
  final String description;

  TrainerSchedule({
    required this.id,
    required this.className,
    required this.time,
    required this.type,
    required this.duration,
    required this.participants,
    required this.location,
    required this.description,
  });
}

class OwnerObjective {
  final String name;
  final String icon;
  final int current;
  final int target;
  final int progress;

  OwnerObjective({
    required this.name,
    required this.icon,
    required this.current,
    required this.target,
    required this.progress,
  });
}

class WorkoutDistribution {
  final String type;
  final String icon;
  final int count;
  final Color color;

  WorkoutDistribution({
    required this.type,
    required this.icon,
    required this.count,
    required this.color,
  });
}

class TodaysClass {
  final String name;
  final String icon;
  final String time;
  final String instructor;
  final int duration;
  final int participants;
  final int maxParticipants;

  TodaysClass({
    required this.name,
    required this.icon,
    required this.time,
    required this.instructor,
    required this.duration,
    required this.participants,
    required this.maxParticipants,
  });
}

class RecentFeedback {
  final String trainerName;
  final String comment;
  final int rating;
  final String workoutType;
  final String date;

  RecentFeedback({
    required this.trainerName,
    required this.comment,
    required this.rating,
    required this.workoutType,
    required this.date,
  });
}

class TrainerTask {
  final String name;
  final String icon;
  final int current;
  final int target;
  final int progress;
  final String status;

  TrainerTask({
    required this.name,
    required this.icon,
    required this.current,
    required this.target,
    required this.progress,
    required this.status,
  });
}

class MembershipDistribution {
  final String name;
  final int value;
  final Color color;

  MembershipDistribution({
    required this.name,
    required this.value,
    required this.color,
  });
}

class ClientGoalsDistribution {
  final String name;
  final int value;
  final Color color;

  ClientGoalsDistribution({
    required this.name,
    required this.value,
    required this.color,
  });
}
