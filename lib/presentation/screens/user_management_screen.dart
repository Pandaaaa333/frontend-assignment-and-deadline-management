import 'package:flutter/material.dart';
import 'package:fe_admin_web/domain/entities/user_entity.dart';
import 'package:fe_admin_web/data/repositories/user_repository_impl.dart';
import 'package:fe_admin_web/presentation/widgets/user/add_user_modal.dart';
import 'package:fe_admin_web/presentation/widgets/user/user_list.dart';
import 'package:fe_admin_web/presentation/widgets/user/user_management_header.dart';
import 'package:fe_admin_web/presentation/widgets/user/user_profile_modal.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final UserRepositoryImpl _userRepository = UserRepositoryImpl();
  List<AdminUserModel> _allUsers = [];

  String _searchQuery = '';
  String _selectedFilter = 'Tất cả';

  // Thay đổi logic khởi tạo
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Tạo hàm load riêng để dễ quản lý
  void _loadUsers() async {
    try {
      final users = await _userRepository.getUsers();
      setState(() {
        _allUsers = users;
      });
    } catch (e) {
      // Xử lý lỗi load data nếu cần
    }
  }

  void _toggleUserStatus(String userId) async {
    try {
      // 1. Gọi API xử lý ở server trước
      await _userRepository.toggleUserStatus(userId);

      // 2. Cập nhật state cục bộ
      setState(() {
        // Tìm index của user cần cập nhật
        final userIndex = _allUsers.indexWhere((u) => u.id == userId);
        
        if (userIndex != -1) {
          // Tạo một object mới hoàn toàn thay vì chỉ sửa thuộc tính
          final currentUser = _allUsers[userIndex];
          _allUsers[userIndex] = AdminUserModel(
            id: currentUser.id,
            name: currentUser.name,
            email: currentUser.email,
            major: currentUser.major,
            joinDate: currentUser.joinDate,
            avatarUrl: currentUser.avatarUrl,
            isActive: !currentUser.isActive, // Đảo trạng thái
          );
          
          // Tạo một list mới từ list cũ để Flutter kích hoạt lại hàm build
          _allUsers = List.from(_allUsers);
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã cập nhật trạng thái người dùng!'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.blue
        )
      );
    } catch (e) {
      // Xử lý lỗi nếu API thất bại
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Có lỗi xảy ra!'), backgroundColor: Colors.red)
      );
    }
  }

  void _showUserProfile(AdminUserModel user) {
    showDialog(
      context: context,
      builder: (ctx) => UserProfileModal(user: user),
    );
  }

  void _addUser(String name, String email, String password, String major) async {
    final newUser = AdminUserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      major: major.isEmpty ? 'Chưa cập nhật' : major,
      joinDate: '04/05/2026',
      isActive: true,
      avatarUrl:
          'https://i.pravatar.cc/150?u=${DateTime.now().millisecondsSinceEpoch}',
    );
    await _userRepository.addUser(newUser);
    setState(() {
      _allUsers.insert(0, newUser);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Đã thêm tài khoản thành công!'),
        backgroundColor: Colors.green));
  }

  void _showAddUserModal() {
    showDialog(
      context: context,
      builder: (ctx) => AddUserModal(onAdd: _addUser),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _allUsers.where((user) {
      final matchesSearch = user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.email.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'Tất cả' ||
          (_selectedFilter == 'Hoạt động' && user.isActive) ||
          (_selectedFilter == 'Bị khóa' && !user.isActive);
      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserManagementHeader(
          onSearchChanged: (value) => setState(() => _searchQuery = value),
          onFilterChanged: (value) => setState(() => _selectedFilter = value!),
          onAddUser: _showAddUserModal,
          selectedFilter: _selectedFilter,
        ),
        const SizedBox(height: 24),
        // Fix ở đây: Kiểm tra nếu danh sách gốc rỗng thì hiện loading 
        // (Hoặc thêm một biến bool _isLoading để chính xác hơn)
        Expanded(
          child: _allUsers.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : UserList(
                  filteredUsers: filteredUsers,
                  onShowProfile: _showUserProfile,
                  onToggleStatus: _toggleUserStatus,
                ),
        ),
      ],
    );
  }
}