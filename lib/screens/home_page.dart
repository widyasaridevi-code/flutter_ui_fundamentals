
import 'package:flutter/material.dart';

import '../widgets/student_identity.dart';
import '../widgets/course_info_card.dart';
import '../widgets/value_notifier_demo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentIdentity(),
            const SizedBox(height: 32),
            const Icon(
              Icons.school,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'Course Explorer',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Aplikasi sederhana untuk menjelajahi '
              'daftar course mahasiswa.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const CourseInfoCard(
              title: 'Responsive',
              description: 'Tampilan menyesuaikan ukuran layar.',
              icon: Icons.devices,
            ),
            const SizedBox(height: 12),
            const CourseInfoCard(
              title: 'Interactive',
              description: 'Course dapat dipilih dan diberi favorite.',
              icon: Icons.touch_app,
            ),
            const SizedBox(height: 12),
            const CourseInfoCard(
              title: 'Feedback',
              description: 'Tersedia form feedback dengan validasi.',
              icon: Icons.feedback,
            ),
            const SizedBox(height: 24),
            const ValueNotifierDemo(),
          ],
        ),
      ),
    );
  }
}
