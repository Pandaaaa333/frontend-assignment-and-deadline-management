import 'package:fe_admin_web/domain/entities/user_entity.dart';

class AdminUserModelAdapter extends AdminUserModel {
  AdminUserModelAdapter({
    required super.id,
    required super.name,
    required super.email,
    required super.major,
    required super.joinDate,
    required super.isActive,
    required super.avatarUrl,
  });

  factory AdminUserModelAdapter.fromJson(Map<String, dynamic> json) {
    return AdminUserModelAdapter(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      major: json['major'],
      joinDate: json['joinDate'],
      isActive: json['isActive'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'major': major,
      'joinDate': joinDate,
      'isActive': isActive,
      'avatarUrl': avatarUrl,
    };
  }
}
