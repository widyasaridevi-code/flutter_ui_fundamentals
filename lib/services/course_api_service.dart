
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  Future<List<Course>> getCourses() async {
    // TAHAP 4: HTTP GET berada di service layer.
    // JSONPlaceholder digunakan untuk latihan request HTTP.
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
      );

      debugPrint('HTTP Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> apiData =
            jsonDecode(response.body) as List<dynamic>;

        debugPrint('Jumlah item API: ${apiData.length}');
      } else {
        debugPrint(
          'Request API gagal: HTTP ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Gagal mengakses API: $e');
    }

    // Data course tetap menggunakan data lokal agar UI
    // dan daftar course tidak berubah.
    final jsonString = await rootBundle.loadString(
      'assets/data/student_data.json',
    );

    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final List<dynamic> coursesJson =
        data['courses'] as List<dynamic>;

    return coursesJson.map((item) {
      return Course.fromJson(item as Map<String, dynamic>);
    }).toList();
  }
}
