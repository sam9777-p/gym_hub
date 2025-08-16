// lib/providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dashboard_data_service.dart';

final dashboardProvider = FutureProvider<void>((ref) async {
  await DashboardDataService.loadData();
});