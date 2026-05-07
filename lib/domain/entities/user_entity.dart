class AdminUserModel {
  final String id;
  final String name;
  final String email;
  final String major;
  final String joinDate;
  bool isActive;
  final String avatarUrl;

  AdminUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.major,
    required this.joinDate,
    required this.isActive,
    required this.avatarUrl,
  });
}
