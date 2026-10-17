
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_state.dart';
import '../widgets/student_identity.dart';
import 'course_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseState>();
    final favorites = state.courses
        .where((course) => state.isFavorite(course.code))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: StudentIdentity(),
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : favorites.isEmpty
                    ? const Center(
                        child: Text('Belum ada course favorite.'),
                      )
                    : ListView.builder(
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final course = favorites[index];

                          return Card(
                            child: ListTile(
                              leading: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              title: Text(course.title),
                              subtitle: Text(
                                '${course.code} • ${course.credits} SKS',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CourseDetailPage(
                                      course: course,
                                    ),
                                  ),
                                );
                              },
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.favorite_border,
                                ),
                                tooltip: 'Hapus favorite',
                                onPressed: () {
                                  context
                                      .read<CourseState>()
                                      .toggleFavorite(course.code);
                                },
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
