
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  Future<List<Course>> getCourses() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
    );

    debugPrint('HTTP Status: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal memuat data: HTTP ${response.statusCode}',
      );
    }

    final List<dynamic> apiData =
        jsonDecode(response.body) as List<dynamic>;

    debugPrint('Jumlah item API: ${apiData.length}');

    // Data course tetap berasal dari JSON lokal.
    // JSONPlaceholder hanya digunakan untuk latihan HTTP GET.
    final jsonString = await rootBundle.loadString(
      'assets/data/student_data.json',
    );

    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final List<dynamic> coursesJson =
        data['courses'] as List<dynamic>;

    return coursesJson.map((item) {
      return Course.fromJson(
        item as Map<String, dynamic>,
      );
    }).toList();
  }
}
