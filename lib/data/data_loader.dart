import 'package:csv/csv.dart';

class DataLoader {
  // The CSV data is hardcoded here for demonstration purposes.
  // Updated with more data and a 'churn_date' column for richer insights.
  // All blank entries have been filled.
  static const String _csvString = """
user_id,user_type,name,email,membership_status,join_date,expiry_date,last_check_in,trainer_id,trainer_name,revenue_date,revenue_amount,revenue_source,class_name,class_date,class_occupancy,class_capacity,feedback_score,feedback_comment,goal_type,goal_target,goal_current,workout_date,workout_duration_min,workout_type,exercise,sets,reps,weight_kg,attendance_date,commission_date,commission_amount,lead_date,signup_date,churn_date

# Owner Transactions
1,owner,Alex Ray,alex.ray@example.com,premium,2023-01-01,2024-01-01,2023-12-31,0,null,2023-10-01,5000,memberships,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,2023-09-15,2023-10-01,0,2023-08-20,2023-09-01,2025-01-01
1,owner,Alex Ray,alex.ray@example.com,premium,2023-01-01,2024-01-01,2023-12-31,0,null,2023-10-01,1500,personal_training,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,2023-09-15,2023-10-01,0,2023-08-20,2023-09-01,2025-01-01
1,owner,Alex Ray,alex.ray@example.com,premium,2023-01-01,2024-01-01,2023-12-31,0,null,2023-10-01,250,merchandise,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,2023-09-15,2023-10-01,0,2023-08-20,2023-09-01,2025-01-01

# Class Feedback
1,owner,Alex Ray,alex.ray@example.com,premium,2023-01-01,2024-01-01,2023-12-15,0,null,2023-12-15,0,feedback,Yoga,2023-12-15,18,20,4.8,Great class!,null,null,null,null,null,null,null,null,null,2023-12-15,2023-12-20,0,2023-11-10,2023-12-01,2025-01-01
1,owner,Alex Ray,alex.ray@example.com,premium,2023-01-01,2024-01-01,2023-12-15,0,null,2023-12-15,0,feedback,HIIT,2023-12-15,25,25,4.6,Loved the energy.,null,null,null,null,null,null,null,null,null,2023-12-15,2023-12-20,0,2023-11-10,2023-12-01,2025-01-01

# Sample Revenue Data
99,revenue,Personal Training Session,pt@example.com,active,2025-08-10,2026-08-10,2025-08-10,8,Ben Carter,2025-08-10,1500,personal_training,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
99,revenue,Group Class Pass,gc@example.com,active,2025-08-10,2026-08-10,2025-08-10,8,Ben Carter,2025-08-10,500,group_classes,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
99,revenue,Nutrition Plan,np@example.com,active,2025-08-10,2026-08-10,2025-08-10,8,Ben Carter,2025-08-10,800,nutrition_consulting,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
99,revenue,Online Session Pack,os@example.com,active,2025-08-10,2026-08-10,2025-08-10,8,Ben Carter,2025-08-11,2200,online_sessions,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null

# Trainers
8,trainer,Ben Carter,ben.carter@example.com,active,2023-02-01,2024-02-01,2023-12-01,8,Ben Carter,null,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,2023-12-01,2023-12-05,1800,2023-01-05,2023-02-01,2025-02-01
17,trainer,Laura King,laura.king@example.com,active,2023-03-01,2024-03-01,2023-12-01,17,Laura King,null,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,2023-12-01,2023-12-05,1750,2023-01-10,2023-03-01,2025-03-01

# Members & Workouts
11,member,Chloe Davis,chloe.davis@example.com,active,2023-10-05,2024-10-05,2023-12-28,8,Ben Carter,null,0,null,null,null,4.2,null,weight_loss,60,65,2023-12-28,60,cardio,Treadmill,1,30,0,2023-12-28,2023-12-29,0,2023-09-28,2023-10-05,2025-04-05
11,member,Chloe Davis,chloe.davis@example.com,active,2023-10-05,2024-10-05,2023-12-26,8,Ben Carter,null,0,null,null,null,4.5,null,weight_loss,60,65,2023-12-26,45,strength,Squats,3,10,50,2023-12-26,2023-12-27,0,2023-09-28,2023-10-05,2025-04-05
13,member,David Evans,david.evans@example.com,active,2023-10-12,2024-10-12,2023-12-27,8,Ben Carter,null,0,null,null,null,4.7,null,muscle_gain,85,83,2023-12-27,75,strength,Bench Press,4,8,80,2023-12-27,2023-12-28,0,2023-10-01,2023-10-12,2025-04-12
15,member,Fiona Green,fiona.green@example.com,expired,2022-12-01,2023-12-01,2023-11-25,8,Ben Carter,null,0,null,null,null,3.8,null,maintenance,70,70,2023-11-25,45,cardio,Rowing,1,20,0,2023-11-25,2023-11-26,0,2022-11-20,2022-12-01,2023-12-02
""";


  static Future<List<List<dynamic>>> loadCsvData() async {
    // Uses the csv package to convert the string into a list of lists.
    final fields = const CsvToListConverter().convert(_csvString, eol: '\n');
    return fields;
  }
}

