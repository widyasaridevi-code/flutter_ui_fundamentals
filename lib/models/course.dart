
class Course {
  final String title;
  final String code;
  final int credits;
  final String status;
  final String description;

  const Course({
    required this.title,
    required this.code,
    required this.credits,
    required this.status,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] as String,
      code: json['code'] as String,
      credits: json['credits'] as int,
      status: json['status'] as String,
      description: json['description'] as String,
    );
  }
}
