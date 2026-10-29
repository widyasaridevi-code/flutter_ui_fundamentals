
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    return (data as List)
        .map(
          (e) => Course.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();
  }

  @override
  Future<Course> createCourse(Course course) async {
    final payload = course.toJson();
    payload.remove('id');

    final row = await supabase
        .from('courses')
        .insert(payload)
        .select()
        .single();

    return Course.fromJson(
      Map<String, dynamic>.from(row),
    );
  }

  // TAHAP 14: UPDATE course berdasarkan ID
  @override
  Future<void> updateCourse(int id, Course course) async {
    final payload = course.toJson();

    // ID tidak perlu diubah karena dipakai untuk mencari baris.
    payload.remove('id');

    await supabase
        .from('courses')
        .update(payload)
        .eq('id', id);
  }

  @override
  Future<void> deleteCourse(int id) async {
    throw UnimplementedError();
  }
}
