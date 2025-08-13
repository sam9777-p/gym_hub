import 'package:flutter/material.dart';
import '../models/data_models.dart';
import 'colors.dart';

class SampleData {
  static final List<PersonalMilestone> personalMilestones = [
    PersonalMilestone(
      name: 'Weight Loss Goal',
      icon: '⚖️',
      current: 8,
      target: 15,
      progress: 53,
      gymRank: 12,
      districtRank: 45,
      stateRank: 180,
    ),
    PersonalMilestone(
      name: 'Strength Training',
      icon: '💪',
      current: 25,
      target: 50,
      progress: 50,
      gymRank: 8,
      districtRank: 32,
      stateRank: 156,
    ),
    PersonalMilestone(
      name: 'Cardio Endurance',
      icon: '🏃',
      current: 18,
      target: 30,
      progress: 60,
      gymRank: 15,
      districtRank: 67,
      stateRank: 234,
    ),
  ];

  static final List<WorkoutHistory> workoutHistory = [
    WorkoutHistory(
      date: 'Today',
      type: 'Strength',
      icon: '💪',
      duration: 45,
      calories: 420,
      exercises: ['Deadlift', 'Bench Press', 'Rows'],
    ),
    WorkoutHistory(
      date: 'Yesterday',
      type: 'Cardio',
      icon: '🏃',
      duration: 35,
      calories: 380,
      exercises: ['Treadmill', 'Cycling', 'Burpees'],
    ),
    WorkoutHistory(
      date: '2 days ago',
      type: 'Legs',
      icon: '🦵',
      duration: 50,
      calories: 450,
      exercises: ['Squats', 'Leg Press', 'Calf Raises'],
    ),
    WorkoutHistory(
      date: '3 days ago',
      type: 'Flexibility',
      icon: '🧘',
      duration: 30,
      calories: 180,
      exercises: ['Yoga', 'Stretching', 'Meditation'],
    ),
    WorkoutHistory(
      date: '4 days ago',
      type: 'Upper Body',
      icon: '💪',
      duration: 40,
      calories: 350,
      exercises: ['Pull-ups', 'Lat Pulldown', 'Bicep Curls'],
    ),
    WorkoutHistory(
      date: '5 days ago',
      type: 'HIIT',
      icon: '⚡',
      duration: 25,
      calories: 320,
      exercises: ['HIIT', 'Jump Rope', 'Mountain Climbers'],
    ),
  ];

  static final List<MemberGoal> memberGoals = [
    MemberGoal(
      name: 'Weight Loss',
      icon: '⚖️',
      current: 8,
      target: 15,
      progress: 53,
    ),
    MemberGoal(
      name: 'Muscle Gain',
      icon: '💪',
      current: 3,
      target: 8,
      progress: 38,
    ),
    MemberGoal(
      name: 'Cardio Fitness',
      icon: '❤️',
      current: 18,
      target: 30,
      progress: 60,
    ),
  ];

  static final List<RevenueBreakdown> revenueBreakdown = [
    RevenueBreakdown(category: 'Memberships', amount: 35000, percentage: 60, color: '#360167'),
    RevenueBreakdown(category: 'Personal Training', amount: 15000, percentage: 26, color: '#CF268A'),
    RevenueBreakdown(category: 'Classes', amount: 5000, percentage: 9, color: '#E65C9C'),
    RevenueBreakdown(category: 'Supplements', amount: 3000, percentage: 5, color: '#FB8CAB'),
  ];

  static final List<MonthlyRevenue> monthlyRevenueData = [
    MonthlyRevenue(month: 'Jan', total: 45000),
    MonthlyRevenue(month: 'Feb', total: 48000),
    MonthlyRevenue(month: 'Mar', total: 52000),
    MonthlyRevenue(month: 'Apr', total: 55000),
    MonthlyRevenue(month: 'May', total: 58000),
    MonthlyRevenue(month: 'Jun', total: 58000),
  ];

  static final List<Member> membersData = [
    Member(
      id: 1,
      name: 'John Smith',
      status: 'active',
      joinDate: '2024-01-15',
      plan: 'Premium',
      monthlyFee: 2500,
      lastVisit: '2024-12-08',
      totalVisits: 45,
    ),
    Member(
      id: 2,
      name: 'Sarah Johnson',
      status: 'expiring',
      joinDate: '2024-03-20',
      plan: 'Basic',
      monthlyFee: 1500,
      lastVisit: '2024-12-07',
      totalVisits: 32,
    ),
    Member(
      id: 3,
      name: 'Mike Wilson',
      status: 'expired',
      joinDate: '2023-11-10',
      plan: 'Premium',
      monthlyFee: 2500,
      lastVisit: '2024-11-28',
      totalVisits: 78,
    ),
    Member(
      id: 4,
      name: 'Emily Davis',
      status: 'retained',
      joinDate: '2023-08-05',
      plan: 'Premium',
      monthlyFee: 2500,
      lastVisit: '2024-12-08',
      totalVisits: 156,
    ),
  ];

  static final List<Trainer> trainersData = [
    Trainer(
      id: 1,
      name: 'Sarah Wilson',
      specialization: 'Strength & Conditioning',
      rating: 4.9,
      experience: '5 years',
      monthlyRevenue: 8200,
      dailyClasses: 6,
      totalClients: 28,
      successRate: 92,
    ),
    Trainer(
      id: 2,
      name: 'Mike Rodriguez',
      specialization: 'Cardio & Weight Loss',
      rating: 4.7,
      experience: '3 years',
      monthlyRevenue: 6500,
      dailyClasses: 5,
      totalClients: 22,
      successRate: 88,
    ),
    Trainer(
      id: 3,
      name: 'Lisa Chen',
      specialization: 'Yoga & Flexibility',
      rating: 4.8,
      experience: '4 years',
      monthlyRevenue: 5800,
      dailyClasses: 4,
      totalClients: 35,
      successRate: 95,
    ),
    Trainer(
      id: 4,
      name: 'David Thompson',
      specialization: 'CrossFit & HIIT',
      rating: 4.6,
      experience: '6 years',
      monthlyRevenue: 7200,
      dailyClasses: 5,
      totalClients: 25,
      successRate: 90,
    ),
  ];

  static final List<TrainerClient> trainerClients = [
    TrainerClient(
      id: 1,
      name: 'Alex Johnson',
      status: 'active',
      joinDate: '2024-01-15',
      plan: 'Personal Training',
      monthlyFee: 4000,
      lastSession: '2024-12-08',
      totalSessions: 24,
    ),
    TrainerClient(
      id: 2,
      name: 'Maria Garcia',
      status: 'expiring',
      joinDate: '2024-03-20',
      plan: 'Group Training',
      monthlyFee: 2000,
      lastSession: '2024-12-07',
      totalSessions: 18,
    ),
    TrainerClient(
      id: 3,
      name: 'James Brown',
      status: 'expired',
      joinDate: '2023-11-10',
      plan: 'Personal Training',
      monthlyFee: 4000,
      lastSession: '2024-11-28',
      totalSessions: 45,
    ),
    TrainerClient(
      id: 4,
      name: 'Jennifer Lee',
      status: 'retained',
      joinDate: '2023-08-05',
      plan: 'Premium Training',
      monthlyFee: 5000,
      lastSession: '2024-12-08',
      totalSessions: 67,
    ),
  ];

  static final List<RevenueBreakdown> trainerRevenueBreakdown = [
    RevenueBreakdown(category: 'Personal Training', amount: 5000, percentage: 61, color: '#360167'),
    RevenueBreakdown(category: 'Group Classes', amount: 2000, percentage: 24, color: '#CF268A'),
    RevenueBreakdown(category: 'Nutrition Coaching', amount: 800, percentage: 10, color: '#E65C9C'),
    RevenueBreakdown(category: 'Online Sessions', amount: 400, percentage: 5, color: '#FB8CAB'),
  ];

  static final List<MonthlyRevenue> trainerMonthlyRevenueData = [
    MonthlyRevenue(month: 'Jan', total: 6800),
    MonthlyRevenue(month: 'Feb', total: 7200),
    MonthlyRevenue(month: 'Mar', total: 7800),
    MonthlyRevenue(month: 'Apr', total: 8000),
    MonthlyRevenue(month: 'May', total: 8200),
    MonthlyRevenue(month: 'Jun', total: 8200),
  ];

  static final List<TrainerSchedule> trainerDetailedSchedule = [
    TrainerSchedule(
      id: 1,
      className: 'Morning Strength',
      time: '6:00 AM - 7:00 AM',
      type: 'Group Class',
      duration: 60,
      participants: 12,
      location: 'Main Floor',
      description: 'Full body strength training with compound movements',
    ),
    TrainerSchedule(
      id: 2,
      className: 'Personal Training - Alex',
      time: '8:00 AM - 9:00 AM',
      type: 'Personal Training',
      duration: 60,
      participants: 1,
      location: 'Private Room 1',
      description: 'Weight loss focused training with cardio intervals',
    ),
    TrainerSchedule(
      id: 3,
      className: 'HIIT Bootcamp',
      time: '10:00 AM - 11:00 AM',
      type: 'Group Class',
      duration: 60,
      participants: 15,
      location: 'Studio A',
      description: 'High intensity interval training for all fitness levels',
    ),
    TrainerSchedule(
      id: 4,
      className: 'Personal Training - Maria',
      time: '2:00 PM - 3:00 PM',
      type: 'Personal Training',
      duration: 60,
      participants: 1,
      location: 'Private Room 2',
      description: 'Strength building and muscle toning program',
    ),
    TrainerSchedule(
      id: 5,
      className: 'Evening Cardio',
      time: '6:00 PM - 7:00 PM',
      type: 'Group Class',
      duration: 60,
      participants: 20,
      location: 'Main Floor',
      description: 'Mixed cardio workout with music and motivation',
    ),
  ];

  static final List<OwnerObjective> ownerObjectives = [
    OwnerObjective(
      name: 'Monthly Revenue',
      icon: '💰',
      current: 58,
      target: 75,
      progress: 77,
    ),
    OwnerObjective(
      name: 'Member Retention',
      icon: '👥',
      current: 168,
      target: 200,
      progress: 84,
    ),
    OwnerObjective(
      name: 'Equipment Upgrade',
      icon: '🏋️',
      current: 3,
      target: 5,
      progress: 60,
    ),
    OwnerObjective(
      name: 'Trainer Certification',
      icon: '🎓',
      current: 2,
      target: 4,
      progress: 50,
    ),
  ];

  static final List<WorkoutDistribution> workoutDistribution = [
    WorkoutDistribution(
      type: 'Strength',
      icon: '💪',
      count: 8,
      color: AppColors.deepViolet,
    ),
    WorkoutDistribution(
      type: 'Cardio',
      icon: '🏃',
      count: 6,
      color: AppColors.royalFuchsia,
    ),
    WorkoutDistribution(
      type: 'Flexibility',
      icon: '🧘',
      count: 4,
      color: AppColors.raspberryPink,
    ),
    WorkoutDistribution(
      type: 'HIIT',
      icon: '⚡',
      count: 3,
      color: AppColors.flamingoPink,
    ),
  ];

  static final List<List<int>> workoutHeatmap = [
    [1, 2, 0, 1, 2, 1, 0], // Week 1
    [2, 1, 1, 2, 1, 0, 1], // Week 2
    [1, 2, 2, 1, 0, 2, 1], // Week 3
    [0, 1, 2, 2, 1, 1, 2], // Week 4
    [2, 0, 1, 1, 2, 1, 0], // Week 5
  ];

  static final List<TodaysClass> todaysClasses = [
    TodaysClass(
      name: 'Morning Yoga',
      icon: '🧘',
      time: '7:00 AM',
      instructor: 'Lisa Chen',
      duration: 60,
      participants: 12,
      maxParticipants: 15,
    ),
    TodaysClass(
      name: 'HIIT Bootcamp',
      icon: '⚡',
      time: '10:00 AM',
      instructor: 'David Thompson',
      duration: 45,
      participants: 18,
      maxParticipants: 20,
    ),
    TodaysClass(
      name: 'Strength Training',
      icon: '💪',
      time: '6:00 PM',
      instructor: 'Sarah Wilson',
      duration: 60,
      participants: 14,
      maxParticipants: 16,
    ),
    TodaysClass(
      name: 'Cardio Blast',
      icon: '🏃',
      time: '7:30 PM',
      instructor: 'Mike Rodriguez',
      duration: 45,
      participants: 22,
      maxParticipants: 25,
    ),
  ];

  static final List<RecentFeedback> recentFeedback = [
    RecentFeedback(
      trainerName: 'Sarah Wilson',
      comment: 'Excellent form corrections and motivating coaching!',
      rating: 5,
      workoutType: 'Strength Training',
      date: 'Dec 7, 2024',
    ),
    RecentFeedback(
      trainerName: 'Mike Rodriguez',
      comment: 'Great cardio session, pushed me to my limits safely.',
      rating: 4,
      workoutType: 'Cardio',
      date: 'Dec 5, 2024',
    ),
    RecentFeedback(
      trainerName: 'Lisa Chen',
      comment: 'Very relaxing and helped improve my flexibility.',
      rating: 5,
      workoutType: 'Yoga',
      date: 'Dec 3, 2024',
    ),
  ];
}
