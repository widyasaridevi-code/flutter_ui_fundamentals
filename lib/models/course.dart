
class Course {
  final String title;
  final String code;
  final int credits;
  final String status;
  final String category;

  const Course({
    required this.title,
    required this.code,
    required this.credits,
    required this.status,
    required this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] as String,
      code: json['code'] as String,
      credits: json['credits'] as int,
      status: json['status'] as String,
      category: json['category'] as String,
    );
  }
}
