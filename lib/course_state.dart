
import 'package:flutter/foundation.dart';

import 'models/course.dart';
import 'services/course_service.dart';

class CourseState extends ChangeNotifier {
  final CourseService _courseService = CourseService();

  final Set<String> favorites = {};

  List<Course> courses = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> loadCourses() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      courses = await _courseService.loadCourses();
    } catch (e) {
      errorMessage = 'Gagal memuat data course: $e';
    } finally {
      isLoading = false;
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
