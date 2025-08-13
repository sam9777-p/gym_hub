// models/client_details_model.dart
class ClientDetailsModel {
  final String name;
  final String type;
  final String status;
  final String goal;
  final double progress;
  final int sessionsCompleted;
  final int sessionsTotal;
  final double revenue;

  ClientDetailsModel({
    required this.name,
    required this.type,
    required this.status,
    required this.goal,
    required this.progress,
    required this.sessionsCompleted,
    required this.sessionsTotal,
    required this.revenue,
  });
}
