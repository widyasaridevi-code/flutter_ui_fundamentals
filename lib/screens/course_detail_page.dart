
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_state.dart';
import '../widgets/student_identity.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final String courseCode = course.code;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentIdentity(),
            const SizedBox(height: 32),
            const Center(
              child: Icon(Icons.school, size: 90),
            ),
            const SizedBox(height: 24),
            Text(
              course.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Code: $courseCode',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Credits: ${course.credits} SKS',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${course.status}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              course.category,
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 24),
            Consumer<CourseState>(
              builder: (context, state, child) {
                final isFavorite =
                    state.isFavorite(courseCode);

                return Card(
                  child: ListTile(
                    leading: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    title: const Text('Status Favorite'),
                    subtitle: Text(
                      isFavorite
                          ? 'Course ini sudah menjadi favorite.'
                          : 'Course ini belum menjadi favorite.',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Consumer<CourseState>(
              builder: (context, state, child) {
                final isFavorite =
                    state.isFavorite(courseCode);

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final wasFavorite = context
                          .read<CourseState>()
                          .isFavorite(courseCode);

                      context
                          .read<CourseState>()
                          .toggleFavorite(courseCode);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            wasFavorite
                                ? 'Course dihapus dari favorite.'
                                : 'Course ditambahkan ke favorite.',
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    label: Text(
                      isFavorite
                          ? 'Hapus Favorite'
                          : 'Tambah Favorite',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
