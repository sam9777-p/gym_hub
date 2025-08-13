import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:csv/csv.dart';

final dashboardProvider = FutureProvider<List<List<dynamic>>>((ref) async {
  final rawCsv = await rootBundle.loadString('assets/gym_data.csv');
  final fields = const CsvToListConverter().convert(rawCsv, eol: '\n');
  return fields;
});


