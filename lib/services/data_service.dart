
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import '../models/metric.dart';

class DataService {
List<Metric> _metrics = [];

Future<void> loadCsv() async {
final raw = await rootBundle.loadString('assets/data/dummy_data.csv');
List<List<dynamic>> rows = const CsvToListConverter().convert(raw, eol: '\n');
_metrics = rows.skip(1).map((r) => Metric.fromCsv(r)).toList();
}

List<Metric> forRole(String role) {
return _metrics.where((m) => m.role == role).toList();
}
}



