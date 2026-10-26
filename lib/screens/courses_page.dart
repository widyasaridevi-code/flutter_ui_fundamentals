
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_state.dart';
import '../widgets/student_identity.dart';
import '../widgets/error_view.dart';
import 'course_detail_page.dart';
import 'add_course_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  Future<void> openCourseDetail(
    BuildContext context,
    Course course,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailPage(course: course),
      ),
    );
  }

  Widget buildCourseCard(
    BuildContext context,
    Course course,
    bool isFavorite,
  ) {
    final String courseCode = course.code;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => openCourseDetail(context, course),
        onLongPress: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${course.title} - $courseCode'),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.school),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: isFavorite
                        ? 'Hapus dari favorite'
                        : 'Tambah ke favorite',
                    onPressed: () {
                      context
                          .read<CourseState>()
                          .toggleFavorite(courseCode);
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                course.title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text('$courseCode • ${course.credits} SKS'),
              const SizedBox(height: 8),
              Text(
                course.category,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text('Status Course: ${course.status}'),
              const SizedBox(height: 8),
              Text(
                isFavorite
                    ? 'Status: Favorite'
                    : 'Status: Belum favorite',
                style: TextStyle(
                  color: isFavorite ? Colors.red : null,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();
    final loadedCourses = courseState.courses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),

      // Tombol tambah course berada di sini.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddCoursePage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Course'),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns;

          if (constraints.maxWidth < 600) {
            columns = 1;
          } else if (constraints.maxWidth < 840) {
            columns = 2;
          } else {
            columns = 3;
          }

          Widget stateContent;

          if (courseState.isLoading) {
            stateContent = const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (courseState.errorMessage != null) {
            stateContent = ErrorView(
              message: courseState.errorMessage!,
              onRetry: courseState.loadCourses,
            );
          } else if (loadedCourses.isEmpty) {
            stateContent = const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('Data course belum tersedia.'),
              ),
            );
          } else {
            stateContent = GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: loadedCourses.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.35,
              ),
              itemBuilder: (context, index) {
                final course = loadedCourses[index];

                return buildCourseCard(
                  context,
                  course,
                  courseState.isFavorite(course.code),
                );
              },
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentIdentity(),
                const SizedBox(height: 24),
                const Text(
                  'Daftar Course',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Total favorite: ${courseState.favorites.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: stateContent,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
