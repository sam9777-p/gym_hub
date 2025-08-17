import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'gym_dashboard.dart';
import 'utils/csv_parser.dart';

class CsvUploadScreen extends StatefulWidget {
  const CsvUploadScreen({super.key});

  @override
  State<CsvUploadScreen> createState() => _CsvUploadScreenState();
}

class _CsvUploadScreenState extends State<CsvUploadScreen> {
  String? selectedFilePath;

  Future<void> _pickCsvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      // allowedExtensions: ['csv'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFilePath = result.files.single.path!;
      });

      // Load the CSV into your parser
      await CsvParser.loadDataFromFile(selectedFilePath!);
    }
  }

  Future<void> _useDefaultData() async {
    await CsvParser.loadData(); // loads from assets
    _loadDashboard();
  }

  void _loadDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GymDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Gym Data CSV")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _pickCsvFile,
              icon: const Icon(Icons.upload_file),
              label: const Text("Pick CSV File"),
            ),
            const SizedBox(height: 20),
            if (selectedFilePath != null) ...[
              Text(
                "Selected File:\n$selectedFilePath",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadDashboard,
                child: const Text("Load Dashboard"),
              ),
              const SizedBox(height: 20),
            ],
            const Divider(height: 40, thickness: 1),
            ElevatedButton(
              onPressed: _useDefaultData,
              child: const Text("Use Default Data"),
            ),
          ],
        ),
      ),
    );
  }
}
