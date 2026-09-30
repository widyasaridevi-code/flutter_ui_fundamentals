import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

const String studentName = 'Komang Widyasari Devi';
const String studentId = '2415051078';

Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );

  return jsonDecode(jsonString) as Map<String, dynamic>;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          // LOADING STATE
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ERROR STATE
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Gagal memuat data:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // DATA TIDAK TERSEDIA
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Data tidak tersedia'),
            );
          }

          final data = snapshot.data!;

          final student =
              data['student'] as Map<String, dynamic>;

          final courses =
              data['courses'] as List<dynamic>;

          final totalCredits = courses.fold<int>(
            0,
            (sum, course) =>
                sum + (course['credits'] as int),
          );

          final completedCourses = courses
              .where(
                (course) => course['status'] == 'done',
              )
              .length;

          return Column(
            children: [
              // PROFILE
              buildProfileCard(student),

              // SUMMARY
              buildSummaryRow(
                courses.length,
                totalCredits,
                completedCourses,
              ),

              // CONTOH PERBAIKAN RENDERFLEX OVERFLOW
              buildOverflowSafeRow(),

              const SizedBox(height: 4),

              // COURSE LIST
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course =
                        courses[index] as Map<String, dynamic>;

                    return buildCourseCard(course);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ======================================================
// PROFILE CARD
// ======================================================

Widget buildProfileCard(
  Map<String, dynamic> student,
) {
  return Card(
    margin: const EdgeInsets.all(12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 36,
            child: Icon(
              Icons.person,
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  student['name'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  student['nim'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Mobile Programming Student',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ======================================================
// SUMMARY
// ======================================================

Widget buildSummaryRow(
  int totalCourses,
  int totalCredits,
  int completedCourses,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
    ),
    child: Row(
      children: [
        Expanded(
          child: buildSummaryCard(
            Icons.menu_book,
            '$totalCourses',
            'Courses',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: buildSummaryCard(
            Icons.school,
            '$totalCredits',
            'Total SKS',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: buildSummaryCard(
            Icons.check_circle,
            '$completedCourses',
            'Selesai',
          ),
        ),
      ],
    ),
  );
}

Widget buildSummaryCard(
  IconData icon,
  String value,
  String label,
) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

// ======================================================
// KASUS A - RENDERFLEX OVERFLOW
// ======================================================

Widget buildOverflowSafeRow() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 4,
    ),
    child: Row(
      children: [
        const Icon(Icons.info),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$studentId - $studentName - '
            'Ini adalah teks yang sangat panjang '
            'untuk menguji layout',
          ),
        ),
      ],
    ),
  );
}

// ======================================================
// COURSE CARD
// ======================================================

Widget buildCourseCard(
  Map<String, dynamic> course,
) {
  final String status =
      course['status'] as String;

  final bool isDone = status == 'done';
  final bool isActive = status == 'active';

  final IconData statusIcon = isDone
      ? Icons.check_circle
      : isActive
          ? Icons.play_circle
          : Icons.schedule;

  final String statusText = isDone
      ? 'Selesai'
      : isActive
          ? 'Aktif'
          : 'Belum';

  return Card(
    margin: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
    child: ListTile(
      leading: Icon(statusIcon),
      title: Text(
        course['title'] as String,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          '${course['code']} • '
          '${course['credits']} SKS\n'
          '${course['category']}',
        ),
      ),
      trailing: Text(
        statusText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}