import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';
import '../utils/csv_parser.dart';

class AttendanceModal extends StatelessWidget {
  final VoidCallback onClose;

  const AttendanceModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final attendanceRecords = CsvParser.getAttendanceRecords();

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Attendance Details',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (attendanceRecords.isEmpty)
                Text(
                  'No attendance data available.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: attendanceRecords.length,
                    itemBuilder: (context, index) {
                      final record = attendanceRecords[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: Icon(
                            record.status == 'Present' ? Icons.check_circle : Icons.cancel,
                            color: record.status == 'Present' ? AppColors.positiveGreen : AppColors.alertRed,
                          ),
                          title: Text(record.date),
                          subtitle: Text(record.details),
                          trailing: Text(
                            record.status,
                            style: TextStyle(
                              color: record.status == 'Present' ? AppColors.positiveGreen : AppColors.alertRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}