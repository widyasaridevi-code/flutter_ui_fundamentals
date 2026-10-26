
class Course {
  final int? id;
  final String title;
  final String code;
  final int credits;
  final String status;
  final String category;

  const Course({
    this.id,
    required this.title,
    required this.code,
    required this.credits,
    this.status = 'planned',
    required this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      title: json['title'] as String,
      code: json['code'] as String,
      credits: json['credits'] as int,
      status: (json['status'] as String?) ?? 'planned',
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
      'category': category,
    };
  }
}
