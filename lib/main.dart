import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'csv_upload_screen.dart';
import 'theme/app_theme.dart'; // Import the new theme file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GymManagementApp());
}

class GymManagementApp extends StatelessWidget {
  const GymManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Management App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Use the light theme
      darkTheme: AppTheme.darkTheme, // Use the dark theme
      themeMode: ThemeMode.system, // Automatically switch between themes
      home: const CsvUploadScreen(),
    );
  }
}