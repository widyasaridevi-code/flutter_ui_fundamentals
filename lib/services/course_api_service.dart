
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

    debugPrint('GET HTTP Status: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal memuat course: HTTP ${response.statusCode}',
      );
    }

    final jsonString = await rootBundle.loadString(
      'assets/data/student_data.json',
    );

    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final List<dynamic> list = data['courses'] as List<dynamic>;

    return list.map((item) {
      return Course.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  Future<Course> createCourse(Course course) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    debugPrint('POST HTTP Status: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return Course(
        id: data['id'] as int?,
        code: course.code,
        title: course.title,
        credits: course.credits,
        status: course.status,
        category: course.category,
      );
    }

    throw Exception(
      'Gagal membuat course: HTTP ${response.statusCode}',
    );
  }

  Future<void> updateCourse(int id, Course course) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    debugPrint('PUT HTTP Status: ${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Gagal memperbarui course: HTTP ${response.statusCode}',
      );
    }
  }
}
