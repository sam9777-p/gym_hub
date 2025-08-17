import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import '../models/data_models.dart';
import '../colors.dart';

class CsvParser {
  static Map<String, List<List<String>>> _parsedData = {};
  static bool _isLoaded = false;

  static Future<void> loadData() async {
    if (_isLoaded) return;

    try {
      final String csvString = await rootBundle.loadString('assets/gym_data.csv');
      final List<String> lines = csvString.split('\n');

      String currentSection = '';
      bool isHeaderLine = false;

      for (String line in lines) {
        if (line.trim().isEmpty) continue;

        if (line.startsWith('SECTION,')) {
          currentSection = line.split(',')[1];
          _parsedData[currentSection] = [];
          isHeaderLine = true; // Next line will be headers
          continue;
        }

        if (currentSection.isNotEmpty) {
          if (isHeaderLine) {
            // Skip header line
            isHeaderLine = false;
            continue;
          }

          final List<String> values = _parseCSVLine(line);
          if (values.isNotEmpty) {
            _parsedData[currentSection]!.add(values);
          }
        }
      }

      _isLoaded = true;
    } catch (e) {
      print('[v0] Error loading CSV data: $e');
      _isLoaded = false;
    }
  }

  static Future<void> loadDataFromFile(String filePath) async {
    try {
      final String csvString = await File(filePath).readAsString();
      final List<String> lines = csvString.split('\n');

      String currentSection = '';
      bool isHeaderLine = false;

      _parsedData.clear(); // reset old data before parsing new

      for (String line in lines) {
        if (line.trim().isEmpty) continue;

        if (line.startsWith('SECTION,')) {
          currentSection = line.split(',')[1];
          _parsedData[currentSection] = [];
          isHeaderLine = true; // Next line will be headers
          continue;
        }

        if (currentSection.isNotEmpty) {
          if (isHeaderLine) {
            // Skip header line
            isHeaderLine = false;
            continue;
          }

          final List<String> values = _parseCSVLine(line);
          if (values.isNotEmpty) {
            _parsedData[currentSection]!.add(values);
          }
        }
      }

      _isLoaded = true;
    } catch (e) {
      print('[v0] Error loading CSV data from file: $e');
      _isLoaded = false;
    }
  }

  static List<String> _parseCSVLine(String line) {
    List<String> result = [];
    bool inQuotes = false;
    String current = '';

    for (int i = 0; i < line.length; i++) {
      String char = line[i];

      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        result.add(current.trim());
        current = '';
      } else {
        current += char;
      }
    }

    result.add(current.trim());
    return result;
  }

  static List<PersonalMilestone> getPersonalMilestones() {
    final data = _parsedData['PersonalMilestones'] ?? [];
    return data.map((row) {
      if (row.length < 8) return null;
      try {
        return PersonalMilestone(
          name: row[0],
          icon: row[1],
          current: int.parse(row[2]),
          target: int.parse(row[3]),
          progress: int.parse(row[4]),
          gymRank: int.parse(row[5]),
          districtRank: int.parse(row[6]),
          stateRank: int.parse(row[7]),
        );
      } catch (e) {
        print('[v0] Error parsing PersonalMilestone: $e');
        return null;
      }
    }).where((item) => item != null).cast<PersonalMilestone>().toList();
  }

  static List<WorkoutHistory> getWorkoutHistory() {
    final data = _parsedData['WorkoutHistory'] ?? [];
    return data.map((row) {
      if (row.length < 6) return null;
      try {
        return WorkoutHistory(
          date: row[0],
          type: row[1],
          icon: row[2],
          duration: int.parse(row[3]),
          calories: int.parse(row[4]),
          exercises: row[5].split(','),
        );
      } catch (e) {
        print('[v0] Error parsing WorkoutHistory: $e');
        return null;
      }
    }).where((item) => item != null).cast<WorkoutHistory>().toList();
  }

  static List<MemberGoal> getMemberGoals() {
    final data = _parsedData['MemberGoals'] ?? [];
    return data.map((row) {
      if (row.length < 5) return null;
      try {
        return MemberGoal(
          name: row[0],
          icon: row[1],
          current: int.parse(row[2]),
          target: int.parse(row[3]),
          progress: int.parse(row[4]),
        );
      } catch (e) {
        print('[v0] Error parsing MemberGoal: $e');
        return null;
      }
    }).where((item) => item != null).cast<MemberGoal>().toList();
  }

  static List<RevenueBreakdown> getRevenueBreakdown() {
    final data = _parsedData['RevenueBreakdown'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      try {
        return RevenueBreakdown(
          category: row[0],
          amount: int.parse(row[1]),
          percentage: int.parse(row[2]),
          color: row[3],
        );
      } catch (e) {
        print('[v0] Error parsing RevenueBreakdown: $e');
        return null;
      }
    }).where((item) => item != null).cast<RevenueBreakdown>().toList();
  }

  static List<MonthlyRevenue> getMonthlyRevenue() {
    final data = _parsedData['MonthlyRevenue'] ?? [];
    return data.map((row) {
      if (row.length < 2) return null;
      try {
        return MonthlyRevenue(
          month: row[0],
          total: int.parse(row[1]),
        );
      } catch (e) {
        print('[v0] Error parsing MonthlyRevenue: $e');
        return null;
      }
    }).where((item) => item != null).cast<MonthlyRevenue>().toList();
  }

  static List<Member> getMembers() {
    final data = _parsedData['Members'] ?? [];
    return data.map((row) {
      if (row.length < 8) return null;
      try {
        return Member(
          id: int.parse(row[0]),
          name: row[1],
          status: row[2],
          joinDate: row[3],
          plan: row[4],
          monthlyFee: int.parse(row[5]),
          lastVisit: row[6],
          totalVisits: int.parse(row[7]),
        );
      } catch (e) {
        print('[v0] Error parsing Member: $e');
        return null;
      }
    }).where((item) => item != null).cast<Member>().toList();
  }

  static List<Trainer> getTrainers() {
    final data = _parsedData['Trainers'] ?? [];
    return data.map((row) {
      if (row.length < 9) return null;
      try {
        return Trainer(
          id: int.parse(row[0]),
          name: row[1],
          specialization: row[2],
          rating: double.parse(row[3]),
          experience: row[4],
          monthlyRevenue: int.parse(row[5]),
          dailyClasses: int.parse(row[6]),
          totalClients: int.parse(row[7]),
          successRate: int.parse(row[8]),
        );
      } catch (e) {
        print('[v0] Error parsing Trainer: $e');
        return null;
      }
    }).where((item) => item != null).cast<Trainer>().toList();
  }

  static List<TrainerClient> getTrainerClients() {
    final data = _parsedData['TrainerClients'] ?? [];
    return data.map((row) {
      if (row.length < 8) return null;
      try {
        return TrainerClient(
          id: int.parse(row[0]),
          name: row[1],
          status: row[2],
          joinDate: row[3],
          plan: row[4],
          monthlyFee: int.parse(row[5]),
          lastSession: row[6],
          totalSessions: int.parse(row[7]),
        );
      } catch (e) {
        print('[v0] Error parsing TrainerClient: $e');
        return null;
      }
    }).where((item) => item != null).cast<TrainerClient>().toList();
  }

  static List<RevenueBreakdown> getTrainerRevenueBreakdown() {
    final data = _parsedData['TrainerRevenueBreakdown'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      try {
        return RevenueBreakdown(
          category: row[0],
          amount: int.parse(row[1]),
          percentage: int.parse(row[2]),
          color: row[3],
        );
      } catch (e) {
        print('[v0] Error parsing TrainerRevenueBreakdown: $e');
        return null;
      }
    }).where((item) => item != null).cast<RevenueBreakdown>().toList();
  }

  static List<MonthlyRevenue> getTrainerMonthlyRevenue() {
    final data = _parsedData['TrainerMonthlyRevenue'] ?? [];
    return data.map((row) {
      if (row.length < 2) return null;
      try {
        return MonthlyRevenue(
          month: row[0],
          total: int.parse(row[1]),
        );
      } catch (e) {
        print('[v0] Error parsing TrainerMonthlyRevenue: $e');
        return null;
      }
    }).where((item) => item != null).cast<MonthlyRevenue>().toList();
  }

  static List<TrainerSchedule> getTrainerSchedule() {
    final data = _parsedData['TrainerSchedule'] ?? [];
    return data.map((row) {
      if (row.length < 8) return null;
      try {
        return TrainerSchedule(
          id: int.parse(row[0]),
          className: row[1],
          time: row[2],
          type: row[3],
          duration: int.parse(row[4]),
          participants: int.parse(row[5]),
          location: row[6],
          description: row[7],
        );
      } catch (e) {
        print('[v0] Error parsing TrainerSchedule: $e');
        return null;
      }
    }).where((item) => item != null).cast<TrainerSchedule>().toList();
  }

  static List<OwnerObjective> getOwnerObjectives() {
    final data = _parsedData['OwnerObjectives'] ?? [];
    return data.map((row) {
      if (row.length < 5) return null;
      try {
        return OwnerObjective(
          name: row[0],
          icon: row[1],
          current: int.parse(row[2]),
          target: int.parse(row[3]),
          progress: int.parse(row[4]),
        );
      } catch (e) {
        print('[v0] Error parsing OwnerObjective: $e');
        return null;
      }
    }).where((item) => item != null).cast<OwnerObjective>().toList();
  }

  static List<WorkoutDistribution> getWorkoutDistribution() {
    final data = _parsedData['WorkoutDistribution'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      try {
        return WorkoutDistribution(
          type: row[0],
          icon: row[1],
          count: int.parse(row[2]),
          color: _getColorFromHex(row[3]),
        );
      } catch (e) {
        print('[v0] Error parsing WorkoutDistribution: $e');
        return null;
      }
    }).where((item) => item != null).cast<WorkoutDistribution>().toList();
  }

  static List<List<int>> getWorkoutHeatmap() {
    final data = _parsedData['WorkoutHeatmap'] ?? [];
    return data.map((row) {
      if (row.length < 8) return <int>[];
      try {
        return [
          int.parse(row[1]), // day0
          int.parse(row[2]), // day1
          int.parse(row[3]), // day2
          int.parse(row[4]), // day3
          int.parse(row[5]), // day4
          int.parse(row[6]), // day5
          int.parse(row[7]), // day6
        ];
      } catch (e) {
        print('[v0] Error parsing WorkoutHeatmap: $e');
        return <int>[];
      }
    }).where((item) => item.isNotEmpty).toList();
  }

  static List<TodaysClass> getTodaysClasses() {
    final data = _parsedData['TodaysClasses'] ?? [];
    return data.map((row) {
      if (row.length < 7) return null;
      try {
        return TodaysClass(
          name: row[0],
          icon: row[1],
          time: row[2],
          instructor: row[3],
          duration: int.parse(row[4]),
          participants: int.parse(row[5]),
          maxParticipants: int.parse(row[6]),
        );
      } catch (e) {
        print('[v0] Error parsing TodaysClass: $e');
        return null;
      }
    }).where((item) => item != null).cast<TodaysClass>().toList();
  }

  static List<RecentFeedback> getRecentFeedback() {
    final data = _parsedData['RecentFeedback'] ?? [];
    return data.map((row) {
      if (row.length < 5) return null;
      try {
        return RecentFeedback(
          trainerName: row[0],
          comment: row[1],
          rating: int.parse(row[2]),
          workoutType: row[3],
          date: row[4],
        );
      } catch (e) {
        print('[v0] Error parsing RecentFeedback: $e');
        return null;
      }
    }).where((item) => item != null).cast<RecentFeedback>().toList();
  }

  static List<TrainerTask> getTrainerTasks() {
    final data = _parsedData['TrainerTasks'] ?? [];
    return data.map((row) {
      if (row.length < 6) return null;
      try {
        return TrainerTask(
          name: row[0],
          icon: row[1],
          current: int.parse(row[2]),
          target: int.parse(row[3]),
          progress: int.parse(row[4]),
          status: row[5],
        );
      } catch (e) {
        print('[v0] Error parsing TrainerTask: $e');
        return null;
      }
    }).where((item) => item != null).cast<TrainerTask>().toList();
  }

  static List<MembershipDistribution> getMembershipDistribution() {
    final data = _parsedData['MembershipDistribution'] ?? [];
    return data.map((row) {
      if (row.length < 3) return null;
      try {
        return MembershipDistribution(
          name: row[0],
          value: int.parse(row[1]),
          color: _getColorFromHex(row[2]),
        );
      } catch (e) {
        print('[v0] Error parsing MembershipDistribution: $e');
        return null;
      }
    }).where((item) => item != null).cast<MembershipDistribution>().toList();
  }

  static List<ClientGoalsDistribution> getClientGoalsDistribution() {
    final data = _parsedData['ClientGoalsDistribution'] ?? [];
    return data.map((row) {
      if (row.length < 3) return null;
      try {
        return ClientGoalsDistribution(
          name: row[0],
          value: int.parse(row[1]),
          color: _getColorFromHex(row[2]),
        );
      } catch (e) {
        print('[v0] Error parsing ClientGoalsDistribution: $e');
        return null;
      }
    }).where((item) => item != null).cast<ClientGoalsDistribution>().toList();
  }

  static List<RevenueBreakdown> getOwnerRevenueBreakdown() {
    final data = _parsedData['OwnerRevenueBreakdown'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      try {
        return RevenueBreakdown(
          category: row[0],
          amount: int.parse(row[1]),
          percentage: int.parse(row[2]),
          color: row[3],
        );
      } catch (e) {
        print('[v0] Error parsing OwnerRevenueBreakdown: $e');
        return null;
      }
    }).where((item) => item != null).cast<RevenueBreakdown>().toList();
  }

  static List<Map<String, dynamic>> getTrainerMonthlyEarnings() {
    final data = _parsedData['TrainerMonthlyEarnings'] ?? [];
    return data.map((row) {
      if (row.length < 4) return null;
      try {
        return {
          'month': row[0],
          'earnings': int.parse(row[1]),
          'sessions': int.parse(row[2]),
          'clients': int.parse(row[3]),
        };
      } catch (e) {
        print('[v0] Error parsing TrainerMonthlyEarnings: $e');
        return null;
      }
    }).where((item) => item != null).cast<Map<String, dynamic>>().toList();
  }

  static Color _getColorFromHex(String hexColor) {
    try {
      hexColor = hexColor.replaceAll('#', '');
      if (hexColor.length == 6) {
        return Color(int.parse('FF$hexColor', radix: 16));
      } else if (hexColor.length == 8) {
        return Color(int.parse(hexColor, radix: 16));
      }
    } catch (e) {
      print('[v0] Error parsing color $hexColor: $e');
    }
    return const Color(0xFF360167);
  }
}
