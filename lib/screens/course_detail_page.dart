
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_state.dart';
import '../widgets/student_identity.dart';
import 'edit_course_page.dart';

class CourseDetailPage extends StatefulWidget {
  final Course course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseDetailPage> createState() =>
      _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late Course currentCourse;

  @override
  void initState() {
    super.initState();
    currentCourse = widget.course;
  }

  Future<void> _editCourse() async {
    final updatedCourse = await Navigator.push<Course>(
      context,
      MaterialPageRoute(
        builder: (_) => EditCoursePage(
          course: currentCourse,
        ),
      ),
    );

    if (!mounted || updatedCourse == null) {
      return;
    }

    setState(() {
      currentCourse = updatedCourse;
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseCode = currentCourse.code;

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
              child: Icon(
                Icons.school,
                size: 90,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              currentCourse.title,
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
              'Credits: ${currentCourse.credits} SKS',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${currentCourse.status}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              currentCourse.category,
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
              child: OutlinedButton.icon(
                onPressed: _editCourse,
                icon: const Icon(Icons.edit),
                label: const Text('Edit Course'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
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
