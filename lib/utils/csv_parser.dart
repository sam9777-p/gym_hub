import 'dart:io';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import '../models/data_models.dart';
import '../colors.dart';

// Utility class for loading and parsing data from a CSV file.
// It handles file I/O, data structuring, and converting raw CSV rows into
// specific data models used across the app.

class CsvParser {
  static Map<String, List<List<dynamic>>> _parsedData = {};
  static bool _isLoaded = false;

  static Future<void> loadData() async {
    if (_isLoaded) return;
    try {
      final String csvString = await rootBundle.loadString('assets/gym_data.csv');
      _parsedData = _parseCsvString(csvString);
      _isLoaded = true;
    } catch (e) {
      print('[v0] Error loading CSV data from assets: $e');
      _isLoaded = false;
    }
  }

  static Future<void> loadDataFromFile(String filePath) async {
    try {
      final String csvString = await File(filePath).readAsString();
      _parsedData = _parseCsvString(csvString);
      _isLoaded = true;
    } catch (e) {
      print('[v0] Error loading CSV data from file: $e');
      _isLoaded = false;
    }
  }

  static Map<String, List<List<dynamic>>> _parseCsvString(String csvString) {
    Map<String, List<List<dynamic>>> parsedMap = {};
    final List<List<dynamic>> rows = const CsvToListConverter().convert(csvString);

    String? currentSection;
    for (var row in rows) {
      if (row.isNotEmpty && row[0] == 'SECTION') {
        currentSection = row[1].toString();
        parsedMap[currentSection!] = [];
      } else if (currentSection != null && row.isNotEmpty && row[0].toString().toLowerCase() != 'name' && row[0].toString().toLowerCase() != 'role' && row.any((element) => element.toString().isNotEmpty)) {
        parsedMap[currentSection]!.add(row);
      }
    }
    return parsedMap;
  }

  static List<PersonalMilestone> getPersonalMilestones() {
    final data = _parsedData['PersonalMilestones'] ?? [];
    return data.map((row) {
      if (row.length < 8) return null;
      return PersonalMilestone(
        name: row[0].toString(),
        icon: row[1].toString(),
        current: int.tryParse(row[2].toString()) ?? 0,
        target: int.tryParse(row[3].toString()) ?? 0,
        progress: int.tryParse(row[4].toString()) ?? 0,
        gymRank: int.tryParse(row[5].toString()) ?? 0,
        districtRank: int.tryParse(row[6].toString()) ?? 0,
        stateRank: int.tryParse(row[7].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<PersonalMilestone>().toList();
  }

  static List<WorkoutHistory> getWorkoutHistory() {
    final data = _parsedData['WorkoutHistory'] ?? [];
    return data.map((row) {
      if (row.length < 6) return null;
      return WorkoutHistory(
        date: row[0].toString(),
        type: row[1].toString(),
        icon: row[2].toString(),
        duration: int.tryParse(row[3].toString()) ?? 0,
        calories: int.tryParse(row[4].toString()) ?? 0,
        exercises: row[5].toString().split(','),
      );
    }).where((item) => item != null).cast<WorkoutHistory>().toList();
  }

  static List<MemberGoal> getMemberGoals() {
    final data = _parsedData['MemberGoals'] ?? [];
    return data.map((row) {
      if (row.length < 5) return null;
      return MemberGoal(
        name: row[0].toString(),
        icon: row[1].toString(),
        current: int.tryParse(row[2].toString()) ?? 0,
        target: int.tryParse(row[3].toString()) ?? 0,
        progress: int.tryParse(row[4].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<MemberGoal>().toList();
  }

  static List<RevenueBreakdown> getRevenueBreakdown() {
    final data = _parsedData['RevenueBreakdown'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      return RevenueBreakdown(
        category: row[0].toString(),
        amount: int.tryParse(row[1].toString()) ?? 0,
        percentage: int.tryParse(row[2].toString()) ?? 0,
        color: row[3].toString(),
      );
    }).where((item) => item != null).cast<RevenueBreakdown>().toList();
  }

  static List<MonthlyRevenue> getMonthlyRevenue() {
    final data = _parsedData['MonthlyRevenue'] ?? [];
    return data.map((row) {
      if (row.length < 2) return null;
      return MonthlyRevenue(
        month: row[0].toString(),
        total: int.tryParse(row[1].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<MonthlyRevenue>().toList();
  }

  static List<Member> getMembers() {
    final data = _parsedData['Members'] ?? [];
    return data.map((row) {
      if (row.length < 8) return null;
      return Member(
        id: int.tryParse(row[0].toString()) ?? 0,
        name: row[1].toString(),
        status: row[2].toString(),
        joinDate: row[3].toString(),
        plan: row[4].toString(),
        monthlyFee: int.tryParse(row[5].toString()) ?? 0,
        lastVisit: row[6].toString(),
        totalVisits: int.tryParse(row[7].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<Member>().toList();
  }

  static List<Trainer> getTrainers() {
    final data = _parsedData['Trainers'] ?? [];
    return data.map((row) {
      if (row.length < 9) return null;
      return Trainer(
        id: int.tryParse(row[0].toString()) ?? 0,
        name: row[1].toString(),
        specialization: row[2].toString(),
        rating: double.tryParse(row[3].toString()) ?? 0.0,
        experience: row[4].toString(),
        monthlyRevenue: int.tryParse(row[5].toString()) ?? 0,
        dailyClasses: int.tryParse(row[6].toString()) ?? 0,
        totalClients: int.tryParse(row[7].toString()) ?? 0,
        successRate: int.tryParse(row[8].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<Trainer>().toList();
  }

  static List<TrainerClient> getTrainerClients() {
    final data = _parsedData['TrainerClients'] ?? [];
    return data.map((row) {
      if (row.length < 8) return null;
      return TrainerClient(
        id: int.tryParse(row[0].toString()) ?? 0,
        name: row[1].toString(),
        status: row[2].toString(),
        joinDate: row[3].toString(),
        plan: row[4].toString(),
        monthlyFee: int.tryParse(row[5].toString()) ?? 0,
        lastSession: row[6].toString(),
        totalSessions: int.tryParse(row[7].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<TrainerClient>().toList();
  }

  static List<RevenueBreakdown> getTrainerRevenueBreakdown() {
    final data = _parsedData['TrainerRevenueBreakdown'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      return RevenueBreakdown(
        category: row[0].toString(),
        amount: int.tryParse(row[1].toString()) ?? 0,
        percentage: int.tryParse(row[2].toString()) ?? 0,
        color: row[3].toString(),
      );
    }).where((item) => item != null).cast<RevenueBreakdown>().toList();
  }

  static List<MonthlyRevenue> getTrainerMonthlyRevenue() {
    final data = _parsedData['TrainerMonthlyRevenue'] ?? [];
    return data.map((row) {
      if (row.length < 2) return null;
      return MonthlyRevenue(
        month: row[0].toString(),
        total: int.tryParse(row[1].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<MonthlyRevenue>().toList();
  }

  static List<TrainerSchedule> getTrainerSchedule() {
    final data = _parsedData['TrainerSchedule'] ?? [];
    return data.map((row) {
      if (row.length < 8) return null;
      return TrainerSchedule(
        id: int.tryParse(row[0].toString()) ?? 0,
        className: row[1].toString(),
        time: row[2].toString(),
        type: row[3].toString(),
        duration: int.tryParse(row[4].toString()) ?? 0,
        participants: int.tryParse(row[5].toString()) ?? 0,
        location: row[6].toString(),
        description: row[7].toString(),
      );
    }).where((item) => item != null).cast<TrainerSchedule>().toList();
  }

  static List<OwnerObjective> getOwnerObjectives() {
    final data = _parsedData['OwnerObjectives'] ?? [];
    return data.map((row) {
      if (row.length < 5) return null;
      return OwnerObjective(
        name: row[0].toString(),
        icon: row[1].toString(),
        current: int.tryParse(row[2].toString()) ?? 0,
        target: int.tryParse(row[3].toString()) ?? 0,
        progress: int.tryParse(row[4].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<OwnerObjective>().toList();
  }

  static List<WorkoutDistribution> getWorkoutDistribution() {
    final data = _parsedData['WorkoutDistribution'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      return WorkoutDistribution(
        type: row[0].toString(),
        icon: row[1].toString(),
        count: int.tryParse(row[2].toString()) ?? 0,
        color: getColorFromHex(row[3].toString()),
      );
    }).where((item) => item != null).cast<WorkoutDistribution>().toList();
  }

  static List<List<int>> getWorkoutHeatmap() {
    final data = _parsedData['WorkoutHeatmap'] ?? [];
    return data.map((row) {
      if (row.length < 8) return <int>[];
      return [
        int.tryParse(row[1].toString()) ?? 0,
        int.tryParse(row[2].toString()) ?? 0,
        int.tryParse(row[3].toString()) ?? 0,
        int.tryParse(row[4].toString()) ?? 0,
        int.tryParse(row[5].toString()) ?? 0,
        int.tryParse(row[6].toString()) ?? 0,
        int.tryParse(row[7].toString()) ?? 0,
      ];
    }).toList();
  }

  static List<TodaysClass> getTodaysClasses() {
    final data = _parsedData['TodaysClasses'] ?? [];
    return data.map((row) {
      if (row.length < 7) return null;
      return TodaysClass(
        name: row[0].toString(),
        icon: row[1].toString(),
        time: row[2].toString(),
        instructor: row[3].toString(),
        duration: int.tryParse(row[4].toString()) ?? 0,
        participants: int.tryParse(row[5].toString()) ?? 0,
        maxParticipants: int.tryParse(row[6].toString()) ?? 0,
      );
    }).where((item) => item != null).cast<TodaysClass>().toList();
  }

  static List<RecentFeedback> getRecentFeedback() {
    final data = _parsedData['RecentFeedback'] ?? [];
    return data.map((row) {
      if (row.length < 5) return null;
      return RecentFeedback(
        trainerName: row[0].toString(),
        comment: row[1].toString(),
        rating: int.tryParse(row[2].toString()) ?? 0,
        workoutType: row[3].toString(),
        date: row[4].toString(),
      );
    }).where((item) => item != null).cast<RecentFeedback>().toList();
  }

  static List<TrainerTask> getTrainerTasks() {
    final data = _parsedData['TrainerTasks'] ?? [];
    return data.map((row) {
      if (row.length < 6) return null;
      return TrainerTask(
        name: row[0].toString(),
        icon: row[1].toString(),
        current: int.tryParse(row[2].toString()) ?? 0,
        target: int.tryParse(row[3].toString()) ?? 0,
        progress: int.tryParse(row[4].toString()) ?? 0,
        status: row[5].toString(),
      );
    }).where((item) => item != null).cast<TrainerTask>().toList();
  }

  static List<MembershipDistribution> getMembershipDistribution() {
    final data = _parsedData['MembershipDistribution'] ?? [];
    return data.map((row) {
      if (row.length < 3) return null;
      return MembershipDistribution(
        name: row[0].toString(),
        value: int.tryParse(row[1].toString()) ?? 0,
        color: getColorFromHex(row[2].toString()),
      );
    }).where((item) => item != null).cast<MembershipDistribution>().toList();
  }

  static List<ClientGoalsDistribution> getClientGoalsDistribution() {
    final data = _parsedData['ClientGoalsDistribution'] ?? [];
    return data.map((row) {
      if (row.length < 3) return null;
      return ClientGoalsDistribution(
        name: row[0].toString(),
        value: int.tryParse(row[1].toString()) ?? 0,
        color: getColorFromHex(row[2].toString()),
      );
    }).where((item) => item != null).cast<ClientGoalsDistribution>().toList();
  }

  static List<RevenueBreakdown> getOwnerRevenueBreakdown() {
    final data = _parsedData['OwnerRevenueBreakdown'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      return RevenueBreakdown(
        category: row[0].toString(),
        amount: int.tryParse(row[1].toString()) ?? 0,
        percentage: int.tryParse(row[2].toString()) ?? 0,
        color: row[3].toString(),
      );
    }).where((item) => item != null).cast<RevenueBreakdown>().toList();
  }

  static List<Map<String, dynamic>> getTrainerMonthlyEarnings() {
    final data = _parsedData['TrainerMonthlyEarnings'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      return {
        'month': row[0].toString(),
        'earnings': int.tryParse(row[1].toString()) ?? 0,
        'sessions': int.tryParse(row[2].toString()) ?? 0,
        'clients': int.tryParse(row[3].toString()) ?? 0,
      };
    }).where((item) => item != null).cast<Map<String, dynamic>>().toList();
  }


  // ... (existing code)

  static List<AttendanceRecord> getAttendanceRecords() {
    final data = _parsedData['AttendanceRecords'] ?? [];
    return data.map((row) {
      if (row.length < 3) return null;
      return AttendanceRecord(
        date: row[0].toString(),
        status: row[1].toString(),
        details: row[2].toString(),
      );
    }).where((item) => item != null).cast<AttendanceRecord>().toList();
  }

// ... (existing code, ensure getColorFromHex is still public)

  static Color getColorFromHex(String hexColor) {
    if (hexColor.isEmpty || hexColor.toLowerCase() == 'null') {
      return const Color(0xFF360167); // Default color
    }
    try {
      hexColor = hexColor.replaceAll('#', '');
      if (hexColor.length == 6) {
        return Color(int.parse('FF$hexColor', radix: 16));
      } else if (hexColor.length == 8) {
        return Color(int.parse(hexColor, radix: 16));
      }
    } catch (e) {
      print('[v0] Error parsing color "$hexColor": $e');
    }
    return const Color(0xFF360167); // Fallback color
  }
}
