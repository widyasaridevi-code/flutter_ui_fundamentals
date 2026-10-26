
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  final String baseUrl;

  CourseApiService(this.baseUrl);

  // GET: Mengambil course dari data JSON lokal.
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

  // POST: Menambahkan course.
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

  // PUT: Memperbarui course.
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

  // DELETE: Menghapus course.
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
