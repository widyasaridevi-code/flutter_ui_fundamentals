
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

      courses = [...courses, createdCourse];

      notifyListeners();

      return createdCourse;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateCourse(Course updatedCourse) async {
    final id = updatedCourse.id;

    if (id == null) {
      throw Exception('ID course tidak ditemukan.');
    }

    if (isSaving) {
      throw Exception('Course sedang disimpan.');
    }

    isSaving = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.updateCourse(id, updatedCourse);

      final index = courses.indexWhere(
        (course) => course.code == updatedCourse.code,
      );

      if (index != -1) {
        final updatedCourses = [...courses];
        updatedCourses[index] = updatedCourse;
        courses = updatedCourses;
      }

      notifyListeners();
    } catch (e) {
      errorMessage = 'Gagal memperbarui course: $e';
      rethrow;
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
