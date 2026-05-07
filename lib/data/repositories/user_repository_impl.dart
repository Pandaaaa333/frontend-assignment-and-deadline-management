import 'package:fe_admin_web/domain/entities/user_entity.dart';
import 'package:fe_admin_web/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final List<AdminUserModel> _mockUsers = [
    AdminUserModel(id: 'U001', name: 'Tống Thiên Bảo', email: 'baott@huce.edu.vn', major: 'CNTT', joinDate: '10/04/2026', isActive: true, avatarUrl: 'https://i.pravatar.cc/150?u=me_123'),
    AdminUserModel(id: 'U002', name: 'Nguyễn Đức Anh', email: 'anhnd@huce.edu.vn', major: 'Kiến trúc', joinDate: '12/04/2026', isActive: true, avatarUrl: 'https://i.pravatar.cc/150?u=user_456'),
    AdminUserModel(id: 'U003', name: 'Trần Lan Hương', email: 'huongtl@huce.edu.vn', major: 'Kinh tế XD', joinDate: '15/04/2026', isActive: false, avatarUrl: 'https://i.pravatar.cc/150?u=user_789'),
    AdminUserModel(id: 'U004', name: 'Lê Minh Tuấn', email: 'tuanlm@huce.edu.vn', major: 'Cầu đường', joinDate: '20/04/2026', isActive: true, avatarUrl: 'https://i.pravatar.cc/150?u=user_111'),
    AdminUserModel(id: 'U005', name: 'Phạm Thị Mai', email: 'maipt@huce.edu.vn', major: 'CNTT', joinDate: '22/04/2026', isActive: true, avatarUrl: 'https://i.pravatar.cc/150?u=user_222'),
  ];

  @override
  Future<List<AdminUserModel>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockUsers;
  }

  @override
  Future<void> toggleUserStatus(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final user = _mockUsers.firstWhere((u) => u.id == userId);
    user.isActive = !user.isActive;
  }

  @override
  Future<void> addUser(AdminUserModel user) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockUsers.insert(0, user);
  }
}
