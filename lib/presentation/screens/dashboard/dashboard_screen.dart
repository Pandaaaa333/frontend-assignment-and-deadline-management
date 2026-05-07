import 'package:flutter/material.dart';
import 'dashboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              buildStatCard('Tổng sinh viên', '1,248', Icons.people_rounded, const Color(0xFF4A7DFF)),
              const SizedBox(width: 24),
              buildStatCard('Deadline đang chạy', '856', Icons.access_time_rounded, const Color(0xFF10B981)),
              const SizedBox(width: 24),
              buildStatCard('Bài viết cộng đồng', '320', Icons.article_rounded, const Color(0xFF8B5CF6)),
              const SizedBox(width: 24),
              buildStatCard('Báo cáo cần xử lý', '5', Icons.warning_rounded, const Color(0xFFEF4444)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Lượng tương tác cộng đồng (7 ngày)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24),
                      Expanded(
                        child: CustomPaint(size: const Size(double.infinity, double.infinity), painter: MockLineChartPainter()),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Hoàn thành Deadline', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 32),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 150, width: 150,
                              child: CircularProgressIndicator(value: 0.75, strokeWidth: 12, backgroundColor: Colors.orange[100], color: const Color(0xFF10B981)),
                            ),
                            const Text('75%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildLegendDot(const Color(0xFF10B981), 'Đúng hạn'),
                          const SizedBox(width: 16),
                          buildLegendDot(Colors.orange[100]!, 'Trễ hạn'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hoạt động mới nhất', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                buildActivityRow('Thiên Bảo', 'vừa đăng một bài viết mới trong mục Hỏi đáp.', '2 phút trước'),
                buildActivityRow('Lan Hương', 'vừa hoàn thành bài tập Đồ án Kiến trúc.', '15 phút trước'),
                buildActivityRow('Đức Anh', 'đã báo cáo một bình luận vi phạm.', '1 giờ trước'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
