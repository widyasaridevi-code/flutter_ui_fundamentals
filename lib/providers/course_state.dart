
import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseState extends ChangeNotifier {
  final CourseRepository repository;

  CourseState({required this.repository});

  final Set<String> favorites = {};

  List<Course> courses = [];

  bool isLoading = false;
  bool isSaving = false;
  String? errorMessage;

  Future<void> loadCourses() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      errorMessage = 'Gagal memuat data course: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Course> createCourse(Course course) async {
    if (isSaving) {
      throw Exception('Course sedang disimpan.');
    }

    isSaving = true;
    notifyListeners();

    try {
      final createdCourse = await repository.createCourse(course);

      // Tambahkan hasil POST ke daftar yang sedang ditampilkan.
      courses = [...courses, createdCourse];

      notifyListeners();

      return createdCourse;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    notifyListeners();
  }

  bool isFavorite(String id) {
    return favorites.contains(id);
  }
}
