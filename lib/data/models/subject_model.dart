import 'package:fe_admin_web/domain/entities/subject_entity.dart';

class AdminSubjectModelAdapter extends AdminSubjectModel {
  AdminSubjectModelAdapter({
    required super.id,
    required super.name,
    required super.code,
    required super.themeColor,
    required super.enrolledStudents,
  });

  factory AdminSubjectModelAdapter.fromJson(Map<String, dynamic> json) {
    return AdminSubjectModelAdapter(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      themeColor: json['themeColor'],
      enrolledStudents: json['enrolledStudents'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'themeColor': themeColor,
      'enrolledStudents': enrolledStudents,
    };
  }
}
