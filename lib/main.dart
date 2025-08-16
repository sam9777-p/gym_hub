import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'csv_upload_screen.dart';

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
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const CsvUploadScreen(),
    );
  }
}
