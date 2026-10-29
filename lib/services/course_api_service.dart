
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';
import 'course_data_source.dart';

class CourseApiService implements CourseDataSource {
  final String baseUrl;

  CourseApiService(this.baseUrl);

  @override
  Future<List<Course>> getCourses() async {
    final uri = Uri.parse('$baseUrl/posts');

    try {
      final response = await http.get(uri);

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw Exception(
          'HTTP ${response.statusCode}: '
          'Gagal mengambil data course dari $uri. '
          'Periksa endpoint dan coba lagi.',
        );
      }

      final jsonString = await rootBundle.loadString(
        'assets/data/student_data.json',
      );

      final Map<String, dynamic> jsonData =
          jsonDecode(jsonString) as Map<String, dynamic>;

      final List<dynamic> coursesJson =
          jsonData['courses'] as List<dynamic>;

      return coursesJson.map((item) {
        return Course.fromJson(
          item as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Course> createCourse(Course course) async {
    final uri = Uri.parse('$baseUrl/posts');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        'HTTP ${response.statusCode}: '
        'Gagal menambahkan course dari $uri.',
      );
    }

    final responseData =
        jsonDecode(response.body) as Map<String, dynamic>;

    return Course(
      id: responseData['id'] as int?,
      code: course.code,
      title: course.title,
      credits: course.credits,
      status: course.status,
      category: course.category,
    );
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    final uri = Uri.parse('$baseUrl/posts/$id');

    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        'HTTP ${response.statusCode}: '
        'Gagal memperbarui course pada $uri.',
      );
    }
  }

  @override
  Future<void> deleteCourse(int id) async {
    final uri = Uri.parse('$baseUrl/posts/$id');
    final response = await http.delete(uri);

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        'HTTP ${response.statusCode}: '
        'Gagal menghapus course pada $uri.',
      );
    }
  }
}
