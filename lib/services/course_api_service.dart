
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
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception('Gagal mengambil data course');
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
  }

  @override
  Future<Course> createCourse(Course course) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception('Gagal menambahkan course');
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
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception('Gagal memperbarui course');
    }
  }

  @override
  Future<void> deleteCourse(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$id'),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception('Gagal menghapus course');
    }
  }
}
