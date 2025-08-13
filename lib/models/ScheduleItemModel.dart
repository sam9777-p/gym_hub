// In a new file, e.g., models/schedule_item_model.dart
import 'package:flutter/material.dart';

class ScheduleItemModel {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String type; // 'Group Class' or 'Personal Training'
  final int participants;
  final int capacity;
  final String location;
  final String difficulty;
  final String equipment;

  ScheduleItemModel({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.participants,
    required this.capacity,
    required this.location,
    required this.difficulty,
    required this.equipment,
  });
}