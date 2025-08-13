// models/revenue_category_model.dart
import 'package:flutter/material.dart';

class RevenueCategoryModel {
  final String name;
  final double amount;
  final double percentage;
  final Color color;

  RevenueCategoryModel({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.color,
  });
}