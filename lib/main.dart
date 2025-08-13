import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_hub/screens/main_screen.dart';
import 'package:gym_hub/theme/app_theme.dart';

// This is the entry point of the Flutter application.
void main() {
  runApp(const ProviderScope(child: GymHubApp()));
}

// GymHubApp is the root widget of the application.
// It sets up the theme and the main screen.
class GymHubApp extends StatelessWidget {
  const GymHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Hub',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const GymManagementApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
