// Data model for CSV metrics.

class Metric {
  final String role;
  final String metric;
  final String value;
  final String month;

  Metric({
    required this.role,
    required this.metric,
    required this.value,
    required this.month,
  });

  factory Metric.fromCsv(List<dynamic> row) {
    return Metric(
      role: row[0] as String,
      metric: row[1] as String,
      value: row[2].toString(),
      month: row[3].toString(),
    );
  }
}



