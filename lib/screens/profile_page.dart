
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_state.dart';
import '../student_constants.dart';
import '../widgets/student_identity.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const StudentIdentity(),
            const SizedBox(height: 32),
            const CircleAvatar(
              radius: 55,
              child: Icon(Icons.person, size: 60),
            ),
            const SizedBox(height: 24),
            const Text(
              'Profile Mahasiswa',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Nama'),
                subtitle: Text(studentName),
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                leading: Icon(Icons.badge),
                title: Text('NIM'),
                subtitle: Text(studentId),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Total Favorite'),
                subtitle: Text(
                  '${courseState.favorites.length} course',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
