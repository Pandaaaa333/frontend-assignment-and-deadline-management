import 'package:flutter/material.dart';
import 'package:fe_admin_web/domain/entities/admin_post_model.dart';
import 'package:fe_admin_web/presentation/widgets/feed/post_data_table.dart';
import 'package:fe_admin_web/presentation/widgets/feed/post_detail_modal.dart';

class FeedManagementScreen extends StatefulWidget {
  const FeedManagementScreen({super.key});

  @override
  State<FeedManagementScreen> createState() => _FeedManagementScreenState();
}

class _FeedManagementScreenState extends State<FeedManagementScreen> {
  final List<AdminPostModel> _mockPosts = [
    AdminPostModel(id: 'P001', authorName: 'Đức Anh', avatarUrl: 'https://i.pravatar.cc/150?u=user_456', contentSnippet: 'Mọi người cho mình hỏi bài này giải sao với...', fullContent: 'Mọi người cho mình hỏi bài này giải sao với? Mình dùng định lý Pitago mà tính mãi không ra kết quả đúng như đáp án.', likes: 36, commentsCount: 12, postDate: '14:30 - 04/05/2026', isReported: false),
    AdminPostModel(id: 'P002', authorName: 'Lan Hương', avatarUrl: 'https://i.pravatar.cc/150?u=user_789', contentSnippet: 'Có ai đi học nhóm thư viện chiều nay không?', fullContent: 'Có ai đi học nhóm thư viện chiều nay không? Mình đang cần ôn lại phần Cơ kết cấu.', likes: 10, commentsCount: 5, postDate: '09:15 - 04/05/2026', isReported: false),
    AdminPostModel(id: 'P003', authorName: 'Minh Tuấn', avatarUrl: 'https://i.pravatar.cc/150?u=user_111', contentSnippet: 'Đề thi năm nay khó quá, giảng viên cho đề ảo ma...', fullContent: 'Đề thi năm nay khó quá, giảng viên cho đề ảo ma thật sự, học một đằng thi một nẻo, chán không buồn nói!!!', likes: 85, commentsCount: 42, postDate: '20:00 - 03/05/2026', isReported: true),
    AdminPostModel(id: 'P004', authorName: 'Tống Thiên Bảo', avatarUrl: 'https://i.pravatar.cc/150?u=me_123', contentSnippet: 'Chia sẻ tài liệu RAG và LLM cho NCKH...', fullContent: 'Chia sẻ tài liệu RAG và LLM cho NCKH. Các bạn tải về tham khảo nhé, file mình để ở link drive bên dưới.', likes: 120, commentsCount: 18, postDate: '10:00 - 02/05/2026', isReported: false),
  ];

  String _searchQuery = '';
  String _selectedFilter = 'Tất cả';

  void _confirmDeletePost(String postId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa bài viết?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Bạn có chắc chắn muốn xóa bài viết này không? Hành động này không thể hoàn tác.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            onPressed: () {
              setState(() => _mockPosts.removeWhere((p) => p.id == postId));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xóa bài viết khỏi hệ thống!'), backgroundColor: Colors.red));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa ngay', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showPostDetailModal(AdminPostModel post) {
    showDialog(
      context: context,
      builder: (ctx) => PostDetailModal(
        post: post,
        onDelete: () => _confirmDeletePost(post.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts = _mockPosts.where((post) {
      final matchesSearch = post.authorName.toLowerCase().contains(_searchQuery.toLowerCase()) || post.contentSnippet.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'Tất cả' || (_selectedFilter == 'Bị báo cáo' && post.isReported) || (_selectedFilter == 'An toàn' && !post.isReported);
      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 350,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey[300]!)),
              child: TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: const InputDecoration(hintText: 'Tìm theo người đăng hoặc nội dung...', prefixIcon: Icon(Icons.search, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey[300]!)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  items: ['Tất cả', 'An toàn', 'Bị báo cáo'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: e == 'Bị báo cáo' ? Colors.red : Colors.black87, fontWeight: e == 'Bị báo cáo' ? FontWeight.bold : FontWeight.normal)))).toList(),
                  onChanged: (value) => setState(() => _selectedFilter = value!),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: PostDataTable(
            posts: filteredPosts,
            onShowDetail: _showPostDetailModal,
            onDelete: _confirmDeletePost,
          ),
        ),
      ],
    );
  }
}